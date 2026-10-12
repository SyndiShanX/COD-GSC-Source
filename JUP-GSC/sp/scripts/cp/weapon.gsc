/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\weapon.gsc
***********************************************/



#using script_37257c344663c658;
#using script_737f801e6beb18c7;
#using script_cbb0697de4c5728;
#using scripts\common\ae_utility;
#using scripts\common\ai;
#using scripts\common\utility;
#using scripts\cp\cp_accessories;
#using scripts\cp\cp_agent_utils;
#using scripts\cp\cp_c4;
#using scripts\cp\cp_checkpoint;
#using scripts\cp\cp_claymore;
#using scripts\cp\cp_debug;
#using scripts\cp\cp_hud_message;
#using scripts\cp\cp_loadout;
#using scripts\cp\cp_missilelauncher;
#using scripts\cp\cp_movers;
#using scripts\cp\cp_outline_utility;
#using scripts\cp\cp_player_battlechatter;
#using scripts\cp\cp_weapons;
#using scripts\cp\damage;
#using scripts\cp\damagefeedback;
#using scripts\cp\deployablebox;
#using scripts\cp\equipment;
#using scripts\cp\equipment\cp_adrenaline;
#using scripts\cp\equipment\cp_at_mine;
#using scripts\cp\equipment\cp_gas_grenade;
#using scripts\cp\equipment\cp_javelin;
#using scripts\cp\equipment\cp_snapshot_grenade;
#using scripts\cp\equipment\cp_stinger;
#using scripts\cp\equipment\cp_thermite;
#using scripts\cp\equipment\cp_trophy_system;
#using scripts\cp\equipment\decoy_grenade;
#using scripts\cp\events;
#using scripts\cp\killstreaks\juggernaut_cp;
#using scripts\cp\laststand;
#using scripts\cp\loadout;
#using scripts\cp\perks;
#using scripts\cp\persistence;
#using scripts\cp\pickups;
#using scripts\cp\powers\coop_molotov;
#using scripts\cp\powers\cp_tactical_cover;
#using scripts\cp\utility;
#using scripts\cp\utility\player;
#using scripts\cp\utility\spawn_event_aggregator;
#using scripts\cp\weapon;
#using scripts\cp_mp\challenges;
#using scripts\cp_mp\crossbow;
#using scripts\cp_mp\ent_manager;
#using scripts\cp_mp\equipment;
#using scripts\cp_mp\equipment\bottle;
#using scripts\cp_mp\equipment\breacher_drone;
#using scripts\cp_mp\equipment\bunkerbuster;
#using scripts\cp_mp\equipment\sonar_pulse;
#using scripts\cp_mp\equipment\throwing_knife;
#using scripts\cp_mp\talking_gun;
#using scripts\cp_mp\utility\damage_utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\cp_mp\utility\loot;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\vehicles\vehicle_tracking;
#using scripts\cp_mp\weapon;
#using scripts\cp_mp\xmike109;
#using scripts\engine\trace;
#using scripts\engine\utility;
#namespace weapon;

function weaponsinit() {
  scripts\cp\utility\spawn_event_aggregator::registeronplayerspawncallback(&function_9ba246f8c51923da);
  level.maxperplayerexplosives = max(getintproperty(@ "hash_b62eac49cca8c84b", 2), 4);
  level.riotshieldxpbullets = getintproperty(@ "hash_ecd162ffa953cac1", 15);
  level.build_weapon_name_func = &_buildweaponcustom;
  level.has_weapon_variation = &has_weapon_variation;
  level.get_weapon_level = &get_weapon_level;
  level.can_upgrade = &can_upgrade;
  level.weaponconfigs = [];
  level.pap = [];
  level.dropped_weapons = [];
  level.invalid_drop_weapons = ["iw9_lm_dblmg2_cp"];
  level.wavessurvivedthroughweapon = 0;
  level.weaponobtained = 0;
  level.downswithweapon = 0;
  level.weaponkills = 0;
  level.dropped_weapon_func = &drop_script_weapon_from_ai;
  level.fnbuildweapon = &buildweapon;
  level.fnscriptedweaponassignment = &getscriptedweapon;
  scripts\cp_mp\weapon::function_5238382582ce39fa();
  scripts\cp\weapon::function_2d291cfd98fd0d8e();

  thread function_2778968efa18eb6a();
  thread watchgunsmithdebugui();

  scripts\cp\cp_weapons::cp_weapons_init();
  level.swim_weapon = makeweapon("iw9_me_diveknife_mp");

  if(getdvarint(@ "hash_e6afce2cf5cf7515", 0) == 0) {
    level.climb_fists = buildweapon("iw9_me_climbfists");
  }

  level.bot_smoke_sight_clip_large = getEnt("smoke_grenade_sight_clip_256", "targetname");

  if(!isDefined(level.bot_smoke_sight_clip_large)) {
    println("<dev string:x1c>" + "<dev string:x7e>");
  }

  initeffects();
  setupminesettings();
  setupconfigs();
  level.custom_proj_func = [];
  level thread custom_gl_proj_func_init();
  level thread onplayerconnect();
  iteminits();
  scripts\cp\cp_outline_utility::initoutlineoccluders();
  array_thread(getEntArray("misc_turret", "classname"), &turret_monitoruse);
  thread scripts\cp\powers\coop_molotov::molotov_init();

  if(isDefined(level.custom_initializeweaponpickups)) {
    [[level.custom_initializeweaponpickups]]();
  } else {
    initializeweaponpickups();
  }

  thread scripts\cp\cp_claymore::claymore_init();
  thread scripts\cp\powers\cp_tactical_cover::tac_cover_init();
  thread scripts\cp_mp\equipment\throwing_knife::throwing_knife_init();
  thread scripts\cp_mp\equipment\bottle::bottle_init();
  thread scripts\cp\equipment\cp_at_mine::at_mine_init();
  thread scripts\cp\cp_accessories::init();
  thread scripts\cp\equipment\decoy_grenade::decoy_init();
  thread namespace_e875ad14b292bd61::function_69e63e3462f94600();

  if(getdvarint(@ "hash_e6afce2cf5cf7515", 0) == 0) {
    level thread hackexclusionlist();
  }
}

function hackexclusionlist() {
  laststand_weapon_exclusion = [makeweapon(level.sentrysettings["sentry_turret"].weaponinfo), makeweapon("tur_gun_decho_cp"), makeweapon("iw9_mg_jltv_mp"), makeweapon("jup_mg_jltv_mp"), makeweapon("jup_mg_jltv_dungeons_cp"), makeweapon("iw8_gunless_infil"), makeweapon("deploy_manual_turret_mp"), makeweapon("manual_turret_mp"), makeweapon("deploy_tactical_cover_mp"), makeweapon("tac_cover_mp"), makeweapon("gunship_25mm_mp"), makeweapon("gunship_40mm_mp"), makeweapon("gunship_105mm_mp"), makeweapon("gunship_hellfire_mp"), makeweapon("iw8_ammo_marker_cp"), makeweapon("iw8_armor_marker_cp"), makeweapon("vip_carry_cp"), makeweapon("deploy_sentry_mp"), makeweapon("ks_generic_mp"), makeweapon("ks_remote_gauntlet_mp"), makeweapon("ks_remote_map_cp"), makeweapon("ks_remote_map_mp"), makeweapon("ks_remote_device_mp"), makeweapon("ks_remote_target_mp"), makeweapon("ks_gesture_generic_mp"), makeweapon("ks_gesture_phone_mp"), makeweapon("deploy_dronepackage_mp"), makeweapon("deploy_warden_mp"), makeweapon("deploy_box_marker_mp"), makeweapon("deploy_pac_sentry_mp"), makeweapon("iw8_nukecore_mp"), makeweapon("iw9_mg_light_tank_mp"), makeweapon("iw9_mg_mrap_mp"), makeweapon("iw9_tur_mrap_mp"), makeweapon("iw8_spotter_scope_mp"), makeweapon("iw9_la_mike32_mp"), makeweapon("iw8_green_beam_mp"), makeweapon("iw9_minigunksjugg_mp"), makeweapon("ks_remote_drone_mp"), makeweapon("ks_assault_drone_mp"), makeweapon("ks_assault_drone_cp"), level.swim_weapon, makeweapon("iw9_swimfists_mp"), makeweapon("iw8_gunless"), makeweapon("iw9_me_climbfists"), makeweapon("cluster_spike_mp"), makeweapon("iw9_pi_stimpistol_mp"), makeweapon("deploy_missileturret_jup_mp")];
  level.additional_laststand_weapon_exclusion = scripts\engine\utility::array_combine(level.additional_laststand_weapon_exclusion, laststand_weapon_exclusion);
}

function function_f2525bf18abad733(basename) {
  level.additional_laststand_weapon_exclusion[level.additional_laststand_weapon_exclusion.size] = makeweapon(basename);
}

function blank(power) {}

function initeffects() {
  level._effect["weap_blink_friend"] = loadfx("vfx/core/mp/killstreaks/vfx_detonator_blink_cyan.vfx");
  level._effect["weap_blink_enemy"] = loadfx("vfx/core/mp/killstreaks/vfx_detonator_blink_cyan.vfx");
  level._effect["emp_stun"] = loadfx("vfx/core/mp/equipment/vfx_emp_grenade");
  level._effect["equipment_explode_big"] = loadfx("vfx/core/mp/killstreaks/vfx_ims_explosion");
  level._effect["equipment_smoke"] = loadfx("vfx/core/mp/killstreaks/vfx_sg_damage_blacksmoke");
  level._effect["equipment_sparks"] = loadfx("vfx/core/mp/killstreaks/vfx_sentry_gun_explosion.vfx");
  level.kinetic_pulse_fx["spark"] = loadfx("vfx/iw7/_requests/mp/vfx_kinetic_pulse_shock");
  level._effect["gas_grenade_smoke_enemy"] = loadfx("vfx/iw8_mp/equipment/smoke_grenade/vfx_smoke_gren_mp.vfx");
  level._effect["equipment_smoke"] = loadfx("vfx/core/mp/killstreaks/vfx_sg_damage_blacksmoke");
  level._effect["placeEquipmentFailed"] = loadfx("vfx/iw7/_requests/mp/vfx_generic_equipment_exp.vfx");
  level._effect["penetration_railgun_explosion"] = loadfx("vfx/iw7/core/expl/weap/chargeshot/vfx_expl_chargeshot.vfx");
  level._effect["flash_bang_explode"] = loadfx("vfx/iw8_mp/equipment/flashbang/vfx_flash_bang.vfx");
  level._effect["glsmoke"] = loadfx("vfx/iw8_mp/equipment/smoke_grenade/vfx_smoke_gren_ch.vfx");
  level._effect["xmike109ThermiteBounce"] = loadfx("vfx/iw8_mp/equipment/vfx_xmike109_thermite_bounce");
}

function setupminesettings() {
  claymoredetectionconeangle = 70;
  level.claymoredetectiondot = cos(claymoredetectionconeangle);
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

function setupconfigs() {
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
  ninebangradiusmax = 800;
  ninebangradiusmin = 200;
  config.radius_max_sq = ninebangradiusmax * ninebangradiusmax;
  config.radius_min_sq = ninebangradiusmin * ninebangradiusmin;
  config.onexplodesfx = "iw9_flash_grenade_expl_trans";
  config.vfxradius = 72;
  level.weaponconfigs["flash_grenade_mp"] = config;
}

function iteminits() {
  clustergrenadeinit();
  throwingknifec4init();
}

function throwingknifec4init() {
  level._effect["throwingknifec4_explode"] = loadfx("vfx/iw7/_requests/mp/power/vfx_bio_spike_exp.vfx");
}

function clustergrenadeinit() {
  level._effect["clusterGrenade_explode"] = loadfx("vfx/iw7/_requests/mp/vfx_cluster_gren_single_runner.vfx");
}

function getweapongunsmithattachmenttable(weapon) {
  weaponname = undefined;

  if(isweapon(weapon)) {
    weaponname = weapon.basename;
  } else {
    weaponname = weapon;
  }

  weaponrootname = getweaponrootname(weaponname);
  return "mp/gunsmith/" + getsubstr(weaponrootname, 4) + "_attachments.csv";
}

function getcompletenameforweapon(weapon, var_c44a5d7d1f872568, var_20d38453281f31fc, weaponreticle, weaponvariantid, weaponpaintjobid, weaponcosmeticattachment) {
  weaponname = weapon;
  tokens = strtok(weaponname, "_");
  index = 0;

  if(tokens[0] == "alt") {
    index++;
  }

  if(tokens[index] == "iw7") {
    iprintln("<dev string:x9b>");

    return;
  }

  if(tokens[index] == "iw8") {
    rootname = weapon;

    if(!isDefined(var_c44a5d7d1f872568)) {
      attachments = ["none", "none", "none", "none", "none", "none"];
    } else {
      attachments = var_c44a5d7d1f872568;
    }

    if(!isDefined(var_20d38453281f31fc)) {
      camo = "none";
    } else {
      camo = var_20d38453281f31fc;
    }

    if(!isDefined(weaponreticle)) {
      reticle = "none";
    } else {
      reticle = weaponreticle;
    }

    if(!isDefined(weaponvariantid)) {
      variantid = -1;
    } else {
      variantid = weaponvariantid;
    }

    if(!isDefined(weaponpaintjobid)) {
      paintjobid = 0;
    } else {
      paintjobid = weaponpaintjobid;
    }

    if(!isDefined(weaponcosmeticattachment)) {
      cosmeticattachment = "none";
    } else {
      cosmeticattachment = weaponcosmeticattachment;
    }

    return getcompleteweaponname(buildweapon(rootname, attachments, camo, reticle, variantid, 1, 1, paintjobid, cosmeticattachment));
  }
}

function getcompleteweaponnamenoalt(objweapon) {
  fullname = getcompleteweaponname(objweapon);

  if(istrue(objweapon.isalternate)) {
    fullname = getsubstr(fullname, 4);
  }

  return fullname;
}

function isattachmentselectfire(weapon, attachment) {
  basetype = getattachmentbasetype(weapon, attachment);
  return basetype == "selectfire";
}

function turret_monitoruse() {
  for(;;) {
    self waittill("trigger", player);
    thread turret_playerthread(player);
  }
}

function turret_playerthread(player) {
  player endon("death");
  player endon("disconnect");
  player notify("weapon_change", nullweapon());
  self waittill("turret_deactivate");
  player notify("weapon_change", player getcurrentweapon());
}

function onplayerconnect() {
  for(;;) {
    level waittill("connected", player);
    player.hits = 0;
    player thread onplayerspawned();
    player thread watchmissileusage();
    player thread sniperdustwatcher();
    player thread watchjavelinusage();
    player thread updatelastweapon();
    player thread watchchangeweapon();
    player thread scripts\cp\equipment\cp_stinger::watchlauncherusage();
  }
}

function watchjavelinusage() {
  scripts\cp\equipment\cp_javelin::javelinusageloop();
}

function watchchangeweapon() {
  self endon("disconnect");
  level endon("game_ended");

  while(true) {
    objweapon = self getcurrentweapon();

    if(isDefined(objweapon)) {
      dochangeweapon(objweapon);
    }

    self waittill("weapon_change");
  }
}

function dochangeweapon(objweapon) {
  updateweaponspeed(objweapon);
  updatelastweaponobj(objweapon);
  updatelauncherusage();
  updatedragonsbreath(objweapon);
  updateweaponperks();
  updatedefaultflinchreduction();
  scripts\cp\events::updateweaponchangetime();
  riotshieldonweaponchange(objweapon);
}

function updatedragonsbreath(objweapon) {
  self notify("end_dragBreath");

  if(getweapongroup(objweapon) == "weapon_shotgun") {
    if(isdragonsbreathweapon(objweapon)) {
      thread initdragonsbreathusage(objweapon);
    }
  }
}

function initdragonsbreathusage(objweapon) {
  objweapon.isdragonsbreath = 1;
  thread stopdragonsbreath(objweapon);
}

function stopdragonsbreath(objweapon) {
  self endon("disconnect");
  waittill_any_2("end_dragBreath", "death");

  if(isDefined(objweapon)) {
    objweapon.isdragonsbreath = undefined;
  }
}

function isdragonsbreathweapon(objweapon) {
  ammotype = getweaponammopoolname(objweapon);
  return ammotype == % "hash_2c53556f245be704";
}

function updateweaponspeed(objnewweapon) {
  if(objnewweapon.basename == "none") {
    return;
  } else if(issuperweapon(objnewweapon.basename)) {
    scripts\cp\loadout::updatemovespeedscale();
    return;
  } else if(iskillstreakweapon(objnewweapon.basename)) {
    return;
  } else if(objnewweapon.basename == "iw9_me_fists_mp_ls") {
    scripts\cp\loadout::updatemovespeedscale();
    return;
  } else if(objnewweapon.inventorytype != "primary" && objnewweapon.inventorytype != "altmode") {
    return;
  }

  scripts\cp\loadout::updatemovespeedscale();
}

function updatedefaultflinchreduction() {
  if(isagent(self)) {
    return;
  }

  scale = undefined;
  flinchtype = weapongetflinchtype(self.currentweapon);

  if(flinchtype == 4) {
    scale = 1;
  } else if(flinchtype == 3) {
    scale = 1;
  } else if(flinchtype == 1) {
    scale = 1;
  } else {
    scale = 1;
  }

  updateviewkickscale(scale);
}

function updateviewkickscale(perc) {
  if(isDefined(perc)) {
    self.viewkickscale = perc;
  }

  if(isDefined(self.overchargeviewkickscale)) {
    perc = self.overchargeviewkickscale;
  } else if(isDefined(self.overrideviewkickscale)) {
    perc = self.overrideviewkickscale;
    flinchtype = weapongetflinchtype(self getcurrentweapon());

    if(flinchtype == 1) {
      perc = self.overrideviewkickscalepistol;
    } else if(flinchtype == 3) {
      perc = self.overrideviewkickscaledmr;
    } else if(flinchtype == 4) {
      perc = self.overrideviewkickscalesniper;
    }
  } else if(isDefined(self.viewkickscale)) {
    perc = self.viewkickscale;
  } else {
    perc = 1;
  }

  assertex(perc >= 0 && perc <= 1, "updateViewKickScale() called with value outside of 0.0 - 1.0");
  perc = clamp(perc, 0, 1);
  self setviewkickscale(perc);
}

function weapongetflinchtype(weaponobj) {
  class = "none";
  flinchtype = -1;

  if(isDefined(weaponobj) && !isnullweapon(weaponobj)) {
    class = weaponclass(weaponobj);

    switch (class) {
      case #"hash_719417cb1de832b6":
        flinchtype = 1;
        break;
      case #"hash_6191aaef9f922f96":
        if(getweapongroup(weaponobj) == "weapon_dmr") {
          flinchtype = 3;
        } else {
          flinchtype = 4;
        }

        break;
      default:
        flinchtype = 0;
        break;
    }
  }

  return flinchtype;
}

function updateweaponperks() {
  self.prevweaponobj = doweaponperkupdate(self.prevweaponobj);
}

function doweaponperkupdate(prevweaponobj) {
  currweaponobj = self getcurrentweapon();
  weaponattachmentperkupdate(currweaponobj, prevweaponobj);
  weaponperkupdate(currweaponobj, prevweaponobj);
  return currweaponobj;
}

function weaponperkupdate(currweaponobj, prevweaponobj) {
  if(!isundefinedweapon(prevweaponobj)) {
    var_9586602ebc60b765 = getweaponrootname(prevweaponobj.basename);
    perkremove = weaponperkmap(var_9586602ebc60b765);

    if(isDefined(perkremove)) {
      scripts\cp\perks::removeperk(perkremove);
    }
  }

  if(!isundefinedweapon(currweaponobj)) {
    var_98efd9d21da41d1a = getweaponrootname(currweaponobj.basename);
    perkadd = weaponperkmap(var_98efd9d21da41d1a);

    if(isDefined(perkadd)) {
      giveperk(perkadd);
    }
  }
}

function weaponperkmap(weaponroot) {
  assertex(isDefined(level.weaponmapdata), "weaponPerkMap() called without first calling buildWeaponMap().");

  if(isDefined(level.weaponmapdata[weaponroot]) && isDefined(level.weaponmapdata[weaponroot].perk)) {
    return level.weaponmapdata[weaponroot].perk;
  }

  return undefined;
}

function weaponattachmentperkupdate(currweaponobj, prevweaponobj) {
  newattachments = undefined;
  oldattachments = undefined;

  if(!isundefinedweapon(prevweaponobj)) {
    oldattachments = getweaponattachments(prevweaponobj);

    if(isDefined(oldattachments) && oldattachments.size > 0) {
      foreach(oldattach in oldattachments) {
        perks = scripts\cp_mp\weapon::attachmentperkmap(prevweaponobj, oldattach);

        if(!isDefined(perks)) {
          continue;
        }

        foreach(perk in perks) {
          scripts\cp\perks::removeperk(perk);
        }
      }
    }
  }

  if(!isundefinedweapon(currweaponobj)) {
    newattachments = getweaponattachments(currweaponobj);

    if(isDefined(newattachments) && newattachments.size > 0) {
      foreach(newattach in newattachments) {
        perks = scripts\cp_mp\weapon::attachmentperkmap(currweaponobj, newattach);

        if(!isDefined(perks)) {
          continue;
        }

        foreach(perk in perks) {
          giveperk(perk);
        }
      }
    }
  }
}

function updatelastweaponobj(objnewweapon) {
  noaltweapon = objnewweapon getnoaltweapon();

  if(isnullweapon(noaltweapon)) {
    noaltweapon = objnewweapon;
  }

  self.lastweaponobj = objnewweapon;

  if(isnormallastweapon(objnewweapon)) {
    self.lastnormalweaponobj = objnewweapon;
  }

  if(isdroppableweapon(noaltweapon)) {
    setlastdroppableweaponobj(noaltweapon);
  }

  if(iscacprimaryorsecondary(objnewweapon)) {
    self.lastcacweaponobj = objnewweapon;
  }
}

function setlastdroppableweaponobj(weaponobj) {
  self.lastdroppableweaponobj = weaponobj;

  if(isDefined(level.lastdroppableweaponchanged)) {
    self[[level.lastdroppableweaponchanged]]();
  }
}

function trackriotshield_grenadepullbackforc4() {
  while(true) {
    self waittill("grenade_pullback", grenade);

    if(!isnullweapon(grenade) && grenade.basename == "c4_mp" && isriotshield(self getcurrentweapon())) {
      self.onriotshieldstow_force = 1;
    }
  }
}

function trackriotshield_updateoffhandstowignorec4() {
  if(!istrue(self.onriotshieldstow_force)) {
    weaponobj = self getheldoffhand();

    if(!isnullweapon(weaponobj) && weaponobj.basename != "c4_mp" && isriotshield(self getcurrentweapon()) && istwohandedoffhand(weaponobj)) {
      self.onriotshieldstow_force = 1;
    }
  }
}

function trackriotshield_monitorshieldattach(wasinlaststand) {
  self notify("trackRiotShield_monitorShieldAttach");
  self endon("trackRiotShield_monitorShieldAttach");
  self endon("death_or_disconnect");
  self endon("faux_spawn");
  self endon("riotshield_detach");
  childthread trackriotshield_grenadepullbackforc4();

  if(isDefined(wasinlaststand)) {
    self.wasinlaststand = wasinlaststand;
  } else if(!isDefined(self.wasinlaststand)) {
    self.wasinlaststand = 0;
  }

  while(riotshield_hasweapon()) {
    trackriotshield_updateoffhandstowignorec4();
    isinlaststand = scripts\cp\laststand::player_in_laststand(self);

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

    if(self isonladder()) {
      trackriotshield_tryback();
    } else if(self isinexecutionattack()) {
      trackriotshield_tryback();
    } else if(self isinexecutionvictim()) {
      trackriotshield_trydetach();
    } else if(self isparachuting() || self isskydiving()) {
      trackriotshield_tryback();
    } else if(istrue(self.laststandforceback)) {
      trackriotshield_tryback();
    } else if(istrue(self.onriotshieldstow_force)) {
      if(isnullweapon(self getheldoffhand())) {
        self.onriotshieldstow_force = undefined;
        trackriotshield_tryreset();
      } else {
        trackriotshield_tryback();
      }
    } else {
      trackriotshield_tryreset();
    }

    waitframe();
  }

  trackriotshield_tryreset();
}

function trackriotshield_tryback() {
  onarm = isDefined(self.riotshieldmodel);
  onback = isDefined(self.riotshieldmodelstowed);

  if(!onback) {
    if(onarm) {
      riotshield_move(1);
      return;
    }

    riotshield_attach(0, riotshield_getmodel());
  }
}

function trackriotshield_tryarm() {
  onarm = isDefined(self.riotshieldmodel);
  onback = isDefined(self.riotshieldmodelstowed);

  if(!onarm) {
    if(onback) {
      riotshield_move(0);
      return;
    }

    riotshield_attach(1, riotshield_getmodel());
  }
}

function trackriotshield_trydetach() {
  onarm = isDefined(self.riotshieldmodel);
  onback = isDefined(self.riotshieldmodelstowed);

  if(onarm) {
    riotshield_detach(1);
  }

  if(onback) {
    riotshield_detach(0);
  }
}

function trackriotshield_tryreset() {
  if(riotshield_hasweapon()) {
    holdingshield = isriotshield(self getcurrentweapon());

    if(holdingshield) {
      trackriotshield_tryarm();
    } else {
      trackriotshield_tryback();
    }

    return;
  }

  onarm = isDefined(self.riotshieldmodel);
  onback = isDefined(self.riotshieldmodelstowed);

  if(onarm) {
    riotshield_detach(1);
  }

  if(onback) {
    riotshield_detach(0);
  }
}

function riotshieldonweaponchange(objweapon) {
  if(riotshield_hasweapon()) {
    thread trackriotshield_monitorshieldattach();
    return;
  }

  trackriotshield_tryreset();
  riotshieldclearvars();
  self notify("riotshield_detach");
}

function riotshieldclearvars(fromdeath) {
  self.laststandforceback = undefined;
  self.laststandforcebackendtime = undefined;
  self.wasinlaststand = undefined;

  if(istrue(fromdeath)) {
    self.hasriotshield = undefined;
    self.hasriotshieldequipped = undefined;
    self.riotshieldmodel = undefined;
    self.riotshieldmodelstowed = undefined;
  }
}

function sniperdustwatcher() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");

  for(lastlargeshotfiredtime = undefined;; lastlargeshotfiredtime = gettime()) {
    self waittill("weapon_fired");

    if(self getstance() != "prone") {
      continue;
    }

    weap = self getcurrentweapon();

    if(weap.classname != "weapon_sniper") {
      continue;
    }

    playerforward = anglesToForward(self.angles);

    if(!isDefined(lastlargeshotfiredtime) || gettime() - lastlargeshotfiredtime > 2000) {}
  }
}

function unset_scriptable_part_state_after_time(timer, player) {
  self endon("death");
  wait timer;
  self setscriptablepartstate("projectile", "inactive");
  player notify("ranged_katana_missile_done");

  if(isDefined(self)) {
    self delete();
  }
}

function watchmissileusage() {
  self endon("disconnect");
  thread listen_for_custom_proj_dvar();

  for(;;) {
    missile = waittill_missile_fire();
    missiletarget = undefined;

    switch (missile.weapon_name) {
      case #"hash_3e782fd775b72022":
      case #"hash_6b9700922cc910a9":
      case #"hash_a9e31b8ffd42a67b":
        missiletarget = self.missilelaunchertarget;
        break;
      case #"hash_5cbb3a1a84d47f1d":
        missiletarget = self.javelin.target;
        break;
      case #"hash_a86d4075406d2de4":
        missile thread launch_custom_gl_projectile(missile.owner);
        break;
      case #"hash_9987aeedf4f345b3":
        missile thread grenade_earthquake();
        break;
      case #"hash_b283838fbedf9fb7":
        missile thread smokegrenadeused(1);
        break;
      case #"hash_a057fdb295ad07f3":
        missile thread watchconcussiongrenadeexplode();
        break;
      case #"hash_5b21bf4471535b2c":
        break;
      case #"hash_94b2fc3e696775bc":
        thread scripts\cp\equipment\cp_thermite::thermite_used(missile, 1);
        break;
      case #"hash_b295af524a2cce5a":
        thread scripts\cp\equipment\cp_snapshot_grenade::snapshot_grenade_used(missile, 1);
        break;
      default:
        break;
    }

    if(islockonlauncher(missile.weapon_name) && isDefined(missiletarget)) {
      missile.lockontarget = missiletarget;
      level notify("stinger_fired", self, missile, missiletarget);
      thread watchtargetlockedontobyprojectile(missiletarget, missile);

      if(isDefined(level.var_325647bb596f072c)) {
        level thread[[level.var_325647bb596f072c]](missile);
      }
    }

    if(isPlayer(self) && isDefined(missile)) {
      missile.adsfire = isplayerads();
    }
  }
}

function issmallmissile(weapon) {
  return false;
}

function isexplosivemissile(weapon) {
  baseweaponname = getweaponbasename(weapon);

  switch (baseweaponname) {
    case #"hash_1e6ad4ef0904a0f1":
    case #"hash_1ee2bbd1bc80ea9a":
    case #"hash_4f9064f9a7a4b7d1":
    case #"hash_b833f98278746f9b":
    case #"hash_fe08358bc8f9a34a":
      return false;
  }

  return true;
}

function listen_for_custom_proj_dvar() {
  self endon("disconnect");

  while(true) {
    proj_string = getDvar(@ "hash_25d23f0aaaed8d2e", "none");

    if(proj_string != "none") {
      self.gl_proj_override = proj_string;
    }

    wait 0.1;
  }
}

function launch_custom_gl_projectile(missile_owner) {
  proj_type = get_custom_gl_projectile(missile_owner);

  if(isDefined(proj_type)) {
    self delete();

    if(isDefined(level.custom_proj_func[proj_type])) {
      level thread[[level.custom_proj_func[proj_type]]](missile_owner);
    }
  }
}

function get_custom_gl_projectile(missile_owner) {
  if(isDefined(missile_owner.gl_proj_override)) {
    return missile_owner.gl_proj_override;
  }

  return undefined;
}

function custom_gl_proj_func_init() {
  level.custom_proj_func["concertina"] = &launchconcertinabomb;
  level.custom_proj_func["thermite"] = &launchthermite;
  level.custom_proj_func["molotov"] = &launchmolotov;
  level.custom_proj_func["semtex"] = &launchstickytimedgrenade;
  level.custom_proj_func["c4"] = &launchc4grenade;
}

function create_new_projectile(weapon_name, missile_owner) {
  vec = anglesToForward(missile_owner getplayerangles());
  vec *= 2000;

  if(missile_owner tagexists("tag_flash")) {
    var_435a01fbcdf2d764 = missile_owner gettagorigin("tag_flash");
  } else {
    var_435a01fbcdf2d764 = missile_owner getEye();
  }

  gren = missile_owner launchgrenade(weapon_name, var_435a01fbcdf2d764, vec);
  gren.owner = missile_owner;
  return gren;
}

function launchthermite(missile_owner) {
  gren = create_new_projectile("thermite_proj_cp", missile_owner);
  missile_owner thread scripts\cp\equipment\cp_thermite::thermite_used(gren);
}

function launchmolotov(missile_owner) {
  gren = create_new_projectile("molotov_mp", missile_owner);
  missile_owner thread scripts\cp\powers\coop_molotov::molotov_used(gren);
  self delete();
}

function launchstickytimedgrenade(missile_owner) {
  gren = create_new_projectile("semtex_mp", missile_owner);
  missile_owner thread semtexused(gren);
  self delete();
}

function launchc4grenade(missile_owner) {
  gren = create_new_projectile("c4_mp", missile_owner);
  missile_owner thread scripts\cp\cp_c4::c4_used(gren);
  self delete();
}

function launchexplosivetiplogic(owner) {
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
    curtick = ticks + 1;
    ticks = curtick;
    wait 0.5;
  }

  model thread bolt_destroy();
}

function wait_for_crate_drop_to_ground(dropcrate) {
  ground_pos = drop_to_ground(dropcrate.origin + (0, 0, -100), 0, -5000);
  var_6d3a9738e44f853d = 900;
  var_1a352d2b513c6da9 = 1000;
  time_passed = 0;

  while(true) {
    if(distancesquared(dropcrate.origin, ground_pos) <= var_6d3a9738e44f853d) {
      return ground_pos;
    }

    if(time_passed >= var_1a352d2b513c6da9) {
      return ground_pos;
    }

    time_passed += 50;
    waitframe();
  }
}

function watch_for_thermite_triggered(owner) {
  self endon("end_thermite_trigger");
  self endon("death");

  while(true) {
    self waittill("trigger", victim);

    if(isPlayer(victim)) {
      continue;
    }

    if(!victim is_soldier_agent()) {
      continue;
    }

    if(isalive(victim) && !istrue(victim.marked_for_death)) {
      victim.marked_for_death = 1;
      thread watch_for_victim_death(victim);
      victim thread damage_over_time(victim, owner, 2.5, 100, "MOD_EXPLOSIVE");
    }
  }
}

function watch_for_victim_death(victim) {
  self endon("death");
  victim waittill("death");
  victim.marked_for_death = undefined;
  playFX(level._effect["vfx_thermite_end"], victim.origin);
  self delete();
}

function bolt_destroy() {
  self setscriptablepartstate("effects", "burnEnd", 0);
  self notify("end_thermite_trigger");

  if(isDefined(self.trigger)) {
    self.trigger delete();
  }

  self delete();
}

function waitfortriggernotify(player) {
  self endon("death");

  while(true) {
    self waittill("trigger", victim);

    if(isPlayer(victim)) {
      continue;
    }

    if(!victim is_soldier_agent()) {
      continue;
    }

    if(isalive(victim) && !istrue(victim.marked_for_death)) {
      victim.marked_for_death = 1;
      victim thread damage_over_time(victim, player, 5, 100, "MOD_EXPLOSIVE");
    }
  }
}

function launchconcertinabomb(player) {
  self waittill("missile_stuck", stuckto, stuckpart);
  trigger = spawn("trigger_radius", self.origin, 0, 500, 72);
  trigger thread waitfortriggernotify(player);
  wait 6;
  trigger delete();
}

function removelinkafterdelay(var_c9c04a2e50ed1560, delay) {
  wait delay;

  if(array_contains(level.strrazorlinks, var_c9c04a2e50ed1560)) {
    level.strrazorlinks = array_remove(level.strrazorlinks, var_c9c04a2e50ed1560);
  }
}

function lockonlaunchers_gettargetarray(addcharacters) {
  targets = [];
  var_e688b198aa9a4b3f = 0;

  var_e688b198aa9a4b3f = getdvarint(@ "hash_10368af4dee3ba2c", 0);

  if(level.teambased) {
    if(isDefined(addcharacters) && addcharacters == 1) {
      foreach(char in level.characters) {
        if(isDefined(char) && isalive(char) && (char.team != self.team || var_e688b198aa9a4b3f)) {
          targets[targets.size] = char;
        }
      }
    }

    if(isDefined(level.activekillstreaks)) {
      foreach(streak in level.activekillstreaks) {
        if(isDefined(streak.affectedbylockon) && (streak.team != self.team || var_e688b198aa9a4b3f)) {
          targets[targets.size] = streak;
        }
      }
    }

    if(isDefined(level.special_lockon_target_list)) {
      foreach(special_target in level.special_lockon_target_list) {
        targets[targets.size] = special_target;
      }
    }

    if(isDefined(level.cratedropdata)) {
      if(isDefined(level.cratedropdata.ac130s)) {
        foreach(ac130 in level.cratedropdata.ac130s) {
          if(ac130.team != self.team || var_e688b198aa9a4b3f) {
            targets[targets.size] = ac130;
          }
        }
      }
    }

    foreach(vehicleref in scripts\cp_mp\vehicles\vehicle::function_9005b7fc076293f8()) {
      vehicles = scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_getgameinstances(vehicleref);

      foreach(vehicle in vehicles) {
        if(!scripts\cp_mp\vehicles\vehicle::vehicle_isfriendlytoplayer(vehicle, self) || var_e688b198aa9a4b3f) {
          targets[targets.size] = vehicle;
        }
      }
    }
  } else {
    if(isDefined(addcharacters) && addcharacters == 1) {
      foreach(char in level.characters) {
        if((!isDefined(char) || !isalive(char)) && !var_e688b198aa9a4b3f) {
          continue;
        }

        targets[targets.size] = char;
      }
    }

    if(isDefined(level.activekillstreaks)) {
      foreach(streak in level.activekillstreaks) {
        if(isDefined(streak.affectedbylockon) && (isDefined(streak.owner) && streak.owner != self || var_e688b198aa9a4b3f)) {
          targets[targets.size] = streak;
        }
      }
    }

    if(isDefined(level.cratedropdata)) {
      if(isDefined(level.cratedropdata.ac130s)) {
        foreach(ac130 in level.cratedropdata.ac130s) {
          if(ac130.owner != self || var_e688b198aa9a4b3f) {
            targets[targets.size] = ac130;
          }
        }
      }
    }

    foreach(vehicleref in scripts\cp_mp\vehicles\vehicle::function_9005b7fc076293f8()) {
      vehicles = scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_getgameinstances(vehicleref);

      foreach(vehicle in vehicles) {
        if(!isDefined(vehicle.owner)) {
          targets[targets.size] = vehicle;
          continue;
        }

        if(vehicle.owner != self || var_e688b198aa9a4b3f) {
          targets[targets.size] = vehicle;
        }
      }
    }
  }

  foreach(target in targets) {
    if(!isvector(target.origin)) {
      targets = array_remove(targets, target);
    }
  }

  return targets;
}

function add_to_special_lockon_target_list(target) {
  if(!isDefined(level.special_lockon_target_list)) {
    level.special_lockon_target_list = [];
  }

  if(!scripts\engine\utility::array_contains(level.special_lockon_target_list, target)) {
    level.special_lockon_target_list = scripts\engine\utility::array_add(level.special_lockon_target_list, target);
  }
}

function remove_from_special_lockon_target_list(target) {
  if(!isDefined(level.special_lockon_target_list)) {
    level.special_lockon_target_list = [];
  }

  if(scripts\engine\utility::array_contains(level.special_lockon_target_list, target)) {
    level.special_lockon_target_list = scripts\engine\utility::array_remove(level.special_lockon_target_list, target);
  }
}

function getrandomdirection(startpoint, var_349d8e7cd03aa703) {
  var_a788fb3849c0448 = anglestoup(var_349d8e7cd03aa703);
  var_eb1a50452e343bfd = anglestoright(var_349d8e7cd03aa703);
  var_d2afe6f56551b342 = anglesToForward(var_349d8e7cd03aa703);
  var_9baaaa8b62b09702 = randomint(360);
  var_39ccad51d40f1872 = randomint(360);
  x = cos(var_39ccad51d40f1872) * sin(var_9baaaa8b62b09702);
  y = sin(var_39ccad51d40f1872) * sin(var_9baaaa8b62b09702);
  z = cos(var_9baaaa8b62b09702);
  delta = (x * var_eb1a50452e343bfd + y * var_d2afe6f56551b342 + z * var_a788fb3849c0448) / 0.33;
  return -1 * delta;
}

function waittill_missile_fire() {
  self waittill("missile_fire", missile, objweapon);

  if(isDefined(missile)) {
    if(!isDefined(missile.weapon_name)) {
      if(objweapon.isalternate) {
        missile.weapon_name = objweapon.underbarrel;
      } else {
        missile.weapon_name = objweapon.basename;
      }
    }

    if(!isDefined(missile.owner)) {
      missile.owner = self;
    }

    if(!isDefined(missile.team)) {
      missile.team = self.team;
    }
  }

  return missile;
}

function onplayerspawned() {
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
      self.var_e16d751a51153a7b = 0;
      self.trackingweaponhits = 0;
      self.trackingweaponheadshots = 0;
      self.trackingweapondeaths = 0;
    }

    riotshieldclearvars(1);
    thread watchgrenadeusage();
    thread player_watchweaponclip();
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

function initlauncherlogic() {
  weapon = self getcurrentweapon();

  switch (weapon.basename) {
    case #"hash_3e782fd775b72022":
    case #"hash_a9e31b8ffd42a67b":
      thread scripts\cp\cp_missilelauncher::missilelauncherusageloop();
      break;
    case #"hash_5c272c0617caebf0":
      thread scripts\cp\equipment\cp_javelin::javelinusageloop();
      break;
  }
}

function updatelauncherusage() {
  weapon = self getcurrentweapon();

  switch (weapon.basename) {
    case #"hash_3e782fd775b72022":
    case #"hash_a07a7676714a498f":
    case #"hash_a9e31b8ffd42a67b":
      thread scripts\cp\cp_missilelauncher::initmissilelauncherusage();
      break;
    case #"hash_5c272c0617caebf0":
    case #"hash_5cbb3a1a84d47f1d":
      thread scripts\cp\equipment\cp_javelin::javelin_reset();
      break;
    case #"hash_47a0edaf0798f8c4":
    case #"hash_87262a67e163f7c9":
    case #"hash_8d9ae5e5dd390b4b":
      thread scripts\cp_mp\crossbow::initcrossbowusage();
      break;
    case #"hash_78063db94e7df144":
      thread scripts\cp_mp\xmike109::initusage();
      break;
    default:
      break;
  }

  self notify("end_launcher");

  if(_hasperk("specialty_fastreload_launchers")) {
    islauncher = weaponclass(weapon.basename) == "rocketlauncher";

    if(islauncher && !istrue(self.fastreloadlaunchers)) {
      giveperk("specialty_fastreload");
      self.fastreloadlaunchers = 1;
    } else if(istrue(self.fastreloadlaunchers)) {
      _unsetperk("specialty_fastreload");
      self.fastreloadlaunchers = undefined;
    }
  }

  switch (weapon.basename) {
    case #"hash_87262a67e163f7c9":
    case #"hash_9a855bc1e9e860f6":
      thread scripts\cp_mp\crossbow::crossbowusageloop(weapon);
      break;
    case #"hash_3e782fd775b72022":
    case #"hash_a9e31b8ffd42a67b":
      thread scripts\cp\cp_missilelauncher::missilelauncherusageloop();
      break;
    case #"hash_5c272c0617caebf0":
      thread scripts\cp\equipment\cp_javelin::javelinusageloop();
      break;
    case #"hash_78063db94e7df144":
      thread scripts\cp_mp\xmike109::usageloop(weapon);
      break;
    default:
      break;
  }
}

function watchforweapondropped() {
  self endon("disconnect");
  self notify("watchForWeaponDropped");
  self endon("watchForWeaponDropped");

  while(true) {
    self waittill("weapon_dropped", droppedent, objweapon);

    if(isDefined(droppedent) && isDefined(objweapon)) {
      self.storedweapons[objweapon.basename] = undefined;
    }
  }
}

function monitorlauncherspawnedgrenades() {
  self endon("disconnect");
  self endon("death");
  self endon("faux_spawn");

  for(;;) {
    grenade = waittill_grenade_fire();

    if(isDefined(grenade.weapon_name)) {
      if(glprox_trygetweaponname(grenade.weapon_name) == "stickglprox") {
        semtexused(grenade);
      }

      switch (grenade.weapon_name) {
        case #"hash_4c7de5619284e175":
        case #"hash_7077355e40138b5f":
          thread scripts\cp\equipment\cp_thermite::thermite_used(grenade);
          break;
      }
    }
  }
}

function glprox_trygetweaponname(weapon) {
  if(isweapon(weapon) && isnullweapon(weapon)) {
    return weapon;
  }

  if(isstring(weapon) && weapon == "none") {
    return weapon;
  }

  if(getweaponbasename(weapon) == "iw7_glprox_mp") {
    if(isstring(weapon) && isaltmodeweapon(weapon) || isweapon(weapon) && weapon.isalternate) {
      attachments = getweaponattachments(weapon);
      assertex(attachments.size == 1, "The iw7_glprox_mp should only ever have one attachment that is an underbarrel.");
      weapon = attachments[0];
    } else {
      weapon = getweaponbasename(weapon);
    }
  }

  return weapon;
}

function stancerecoiladjuster() {
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
    waittill_any_3("adjustedStance", "sprint_begin", "weapon_change");
    wait 0.5;

    if(isDefined(self.onhelisniper) && self.onhelisniper) {
      continue;
    }

    stance = self getstance();
    stancerecoilupdate(stance);
  }
}

function stancerecoilupdate(stance) {
  weapon = self getcurrentprimaryweapon();
  sniperreduction = 0;

  if(isrecoilreducingweapon(weapon)) {
    sniperreduction = getrecoilreductionvalue();
  }

  if(stance == "prone") {
    weapclass = weapon.classname;

    if(isDefined(weapclass)) {
      if(weapclass == "weapon_lmg") {
        setrecoilscale(0, 40);
      } else if(weapclass == "weapon_sniper") {
        if(weapon hasattachment("barrelbored")) {
          setrecoilscale(0, 20 + sniperreduction);
        } else {
          setrecoilscale(0, 40 + sniperreduction);
        }
      }
    } else {
      setrecoilscale();
    }

    return;
  }

  if(stance == "crouch") {
    weapclass = weapon.classname;

    if(isDefined(weapclass)) {
      if(weapclass == "weapon_lmg") {
        setrecoilscale(0, 10);
      } else if(weapclass == "weapon_sniper") {
        if(weapon hasattachment("barrelbored")) {
          setrecoilscale(0, 10 + sniperreduction);
        } else {
          setrecoilscale(0, 20 + sniperreduction);
        }
      }
    } else {
      setrecoilscale();
    }

    return;
  }

  if(sniperreduction > 0) {
    setrecoilscale(0, sniperreduction);
    return;
  }

  setrecoilscale();
}

function setrecoilscale(scaler, scaleoverride) {
  if(!isDefined(scaler)) {
    scaler = 0;
  }

  if(!isDefined(self.recoilscale)) {
    self.recoilscale = scaler;
  } else {
    self.recoilscale += scaler;
  }

  if(isDefined(scaleoverride)) {
    if(isDefined(self.recoilscale) && scaleoverride < self.recoilscale) {
      scaleoverride = self.recoilscale;
    }

    scale = 100 - scaleoverride;
  } else {
    scale = 100 - self.recoilscale;
  }

  if(scale < 0) {
    scale = 0;
  }

  if(scale > 100) {
    scale = 100;
  }

  if(scale == 100) {
    self player_recoilscaleoff();
    return;
  }

  self player_recoilscaleon(scale);
}

function isrecoilreducingweapon(weapon) {
  return false;
}

function getrecoilreductionvalue() {
  if(!isDefined(self.pers["recoilReduceKills"])) {
    self.pers["recoilReduceKills"] = 0;
  }

  return self.pers["recoilReduceKills"] * 40;
}

function watchforweaponchange() {
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

    if(isvalidweapon(objweapon)) {
      self.last_valid_weapon = objweapon;
    }

    if(!isDefined(self.storedweapons)) {
      self.storedweapons = [];
    }

    if(!isDefined(self.storedweapons[objweapon.basename])) {
      self.storedweapons[objweapon.basename] = getcompleteweaponname(objweapon);
    }

    thread updatelauncherusage();

    if(iskillstreakweapon(objweapon)) {
      continue;
    }

    if(is_launcher(objweapon) && !is_killstreak_weapon(objweapon)) {
      objweapon = remove_launcher_xmags(objweapon);

      if(isDefined(level.set_relics)) {
        if(isDefined(level.set_relics["relic_rocket_kill_ammo"])) {
          self disableemptyclipweaponswitch(1);
        }
      }

      continue;
    }

    if(isDefined(level.set_relics)) {
      if(isDefined(level.set_relics["relic_rocket_kill_ammo"])) {
        self disableemptyclipweaponswitch(0);
      }
    }
  }
}

function drop_minigun(player) {
  player notify("dropping_minigun");
  miniguns = ["iw9_minigunksjugg_mp", "iw9_lm_dblmg2_cp"];
  minigun_name = "iw9_lm_dblmg2_cp";

  foreach(gun_name in miniguns) {
    if(player hasweapon(gun_name)) {
      minigun_name = gun_name;
    }
  }

  currentweapon = makeweapon(minigun_name);
  droppedgun = player dropitem(currentweapon);
  droppedgun thread watchweaponpickup();
}

function watch_minigun_ammo_depleted(player, objweapon) {
  player endon("death");
  player endon("disconnect");
  player endon("faux_spawn");
  player endon("dropping_minigun");
  player notify("watchMinigunAmmo");
  player endon("watchMinigunAmmo");

  while(true) {
    var_5831ba9bb12b4d9b = player getweaponammoclip(objweapon);

    if(var_5831ba9bb12b4d9b <= 0) {
      player takeweapon(objweapon);
      return;
    }

    waitframe();
  }
}

function picking_up_minigun(objweapon) {
  if(objweapon.basename == "iw9_lm_dblmg2_cp") {
    return true;
  }

  if(objweapon.basename == "iw9_minigunksjugg_mp") {
    return true;
  }

  return false;
}

function switch_weapon_from_minigun(player, objweapon) {
  if(objweapon.basename == "iw9_lm_dblmg2_cp") {
    return 0;
  }

  if(objweapon.basename == "iw9_minigunksjugg_mp") {
    return 0;
  }

  return player_has_minigun(player);
}

function player_has_minigun(player) {
  miniguns = ["iw9_minigunksjugg_mp", "iw9_lm_dblmg2_cp"];

  foreach(gun_name in miniguns) {
    if(player hasweapon(gun_name)) {
      return true;
    }

    if(player getcurrentweapon().basename == gun_name) {
      return true;
    }
  }

  return false;
}

function is_launcher(weapon) {
  class = weaponclass(weapon);

  if(class == "rocketlauncher") {
    return true;
  }

  switch (weapon.basename) {
    case #"hash_3e782fd775b72022":
    case #"hash_5cbb3a1a84d47f1d":
    case #"hash_a9e31b8ffd42a67b":
    case #"hash_e704ecf8710c6f57":
    case #"hash_f55c20924061bd15":
      return true;
  }

  return false;
}

function is_killstreak_weapon(weapon) {
  switch (weapon.basename) {
    case #"hash_1e63c8ef08fe7ddf":
    case #"hash_1ecfb7d1bc71d9c4":
      return 1;
    default:
      return 0;
  }
}

function add_launcher_xmags(weapon) {
  attachment = "xmags_cp_gromeo";

  switch (weapon.basename) {
    case #"hash_3e782fd775b72022":
    case #"hash_a9e31b8ffd42a67b":
      attachment = "xmags_cp_gromeo";
      break;
    case #"hash_5cbb3a1a84d47f1d":
      attachment = "xmags_cp_juliet";
      break;
    case #"hash_e704ecf8710c6f57":
      attachment = "xmags_cp_kgolf";
      break;
    case #"hash_f55c20924061bd15":
      attachment = "xmags_cp_rpapa7";
      break;
    default:
      break;
  }

  if(!weapon hasattachment(attachment)) {
    weapon = addattachmenttoweapon(weapon, attachment, 1);
  }

  return weapon;
}

function remove_launcher_xmags(weapon) {
  attachment = "xmags_cp_gromeo";

  switch (weapon.basename) {
    case #"hash_3e782fd775b72022":
    case #"hash_a9e31b8ffd42a67b":
      attachment = "xmags_cp_gromeo";
      break;
    case #"hash_5cbb3a1a84d47f1d":
      attachment = "xmags_cp_juliet";
      break;
    case #"hash_e704ecf8710c6f57":
      attachment = "xmags_cp_kgolf";
      break;
    case #"hash_f55c20924061bd15":
      attachment = "xmags_cp_rpapa7";
      break;
    default:
      break;
  }

  if(weapon hasattachment(attachment)) {
    remove_attachment(attachment, self, weapon);
  }

  return weapon;
}

function isfistweapon(weapon) {
  weapon = getweaponrootname(weapon);
  return weapon == "iw9_me_fists";
}

function isgunlessweapon(weapon) {
  weapname = undefined;

  if(isweapon(weapon)) {
    if(isnullweapon(weapon)) {
      return false;
    }

    weapname = weapon.basename;
  } else {
    if(weapon == "none") {
      return false;
    }

    weapname = weapon;
  }

  return weapname == "iw8_gunless" || weapname == "iw8_gunless_infil" || weapname == "iw8_gunless_last_stand_enter";
}

function isvalidweapon(newweapon) {
  exclusionlist = level.additional_laststand_weapon_exclusion;
  newweaponobj = undefined;

  if(isweapon(newweapon)) {
    newweaponobj = newweapon;
  } else {
    newweaponobj = makeweaponfromstring(newweapon);
  }

  if(isnullweapon(newweaponobj)) {
    return 0;
  }

  if(isDefined(exclusionlist) && array_contains(exclusionlist, newweaponobj)) {
    return 0;
  }

  if(is_melee_weapon(newweaponobj, 1)) {
    return 0;
  }

  return 1;
}

function ai_offhandfiremanager() {
  self endon("death");

  while(true) {
    self waittill("grenade_fire", grenade, weapon);
    grenade.owner = self;

    switch (weapon.basename) {
      case #"hash_ab3485fa6834de47":
        level thread scripts\cp\powers\coop_molotov::ai_molotov_used(self, grenade);
        break;
      case #"hash_4cd748aa3895508a":
        thread scripts\cp\equipment\cp_gas_grenade::gas_used(grenade);
        break;
      case #"hash_34e7a4cd11aed6bc":
        grenade thread watchconcussiongrenadeexplode();
        break;
      case #"hash_4c7de5619284e175":
        grenade thread scripts\cp\equipment\cp_thermite::thermite_watchstuck();
        break;
    }
  }
}

function watchgrenadeusage() {
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

  while(true) {
    self waittill("grenade_pullback", objweapon);
    var_d9bcccd17a53d67b = self getthrowbackweapon();

    if(!isnullweapon(var_d9bcccd17a53d67b)) {
      continue;
    }

    weaponname = objweapon.basename;
    thread watchoffhandcancel();
    self.throwinggrenade = weaponname;

    if(weaponname == "c4_mp") {
      thread beginc4tracking();
    }

    begingrenadetracking();
    thread scripts\cp\loadout::function_48c0bdf6dd0f6dde();
    self.throwinggrenade = undefined;
  }
}

function watchoffhandcancel() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  self endon("grenade_fire");
  self waittill("offhand_end");

  if(isDefined(self.changingweapon) && self.changingweapon != self getcurrentweapon()) {
    self.changingweapon = undefined;
  }
}

function beginc4tracking() {
  self notify("beginC4Tracking");
  self endon("beginC4Tracking");
  self endon("death");
  self endon("disconnect");
  waittill_any_3("grenade_fire", "weapon_change", "offhand_end");
  self.changingweapon = undefined;
}

function dudgrenadeused(owner) {
  owner endon("disconnect");
  thread ownerdisconnectcleanup(owner);
  thread notifyafterframeend("death", "end_explode");
  self endon("end_explode");
  self waittill("explode", position);

  owner iprintln("<dev string:xe1>");
  wait 1;
  owner iprintln("<dev string:xfc>");

  self delete();
}

function begingrenadetracking() {
  self endon("offhand_end");
  starttime = gettime();
  grenade = waittill_grenade_fire();

  if(!isDefined(grenade)) {
    return;
  }

  if(!isDefined(grenade.weapon_name)) {
    return;
  }

  weaponrootname = grenade.weapon_name;

  if(isDefined(grenade.weapon_object)) {
    weaponrootname = getweaponrootstring(grenade.weapon_object);
  }

  if(!isDefined(weaponrootname)) {
    weaponrootname = grenade.weapon_name;
  }

  self.changingweapon = undefined;

  switch (weaponrootname) {
    case #"hash_42dcb6ce7ecb709c":
    case #"hash_aedcc540fcb8773a":
    case #"hash_aec9c140fca96664":
      thread scripts\cp\equipment\cp_snapshot_grenade::snapshot_grenade_used(grenade);
      break;
    case #"hash_c675eaaa9ab95a7":
    case #"hash_c3b4aaaa988e3e9":
    case #"hash_ab0871fa68122c89":
    case #"hash_ab3485fa6834de47":
    case #"hash_c9a436974fe60919":
    case #"hash_9b7aae34cefc69f2":
      thread scripts\cp\powers\coop_molotov::molotov_used(grenade);
      self.last_molotov_throw_time = gettime();
      break;
    case #"hash_53b56552dcba7edd":
    case #"hash_da7316c483b6c780":
    case #"hash_3847373267d18fbd":
    case #"hash_839f6714e63befbe":
      scripts\cp\deployablebox::throwcrate(grenade);
      break;
    case #"hash_3ffc3493f76d6b47":
    case #"hash_5f4edaea7e49dd41":
      grenade thread dudgrenadeused(self);
      grenade thread grenade_earthquake();
      break;
    case #"hash_5e4ccaa178cac19c":
    case #"hash_dd4d572af14a12c2":
    case #"hash_7c03088193266bc4":
    case #"hash_81b07c7e9a3e0da2":
    case #"hash_5e2ccea178b13002":
    case #"hash_5e7bbfa178ef8124":
    case #"hash_81d0787e9a579f3c":
      if(gettime() - starttime > 1000) {
        grenade.iscooked = 1;
      }

      grenade thread watchfraggrenadeexplode();
      grenade.originalowner = self;
      break;
    case #"hash_a0319e349a692b8f":
    case #"hash_4cf48e05bdc8cd55":
    case #"hash_4cd49205bdaf3bbb":
    case #"hash_4c7de5619284e175":
    case #"hash_4c5de961926b4fdb":
      thread scripts\cp\equipment\cp_thermite::thermite_used(grenade);
      break;
    case #"hash_140bbbbf54acf7c":
    case #"hash_67e9c23b56b755dc":
      grenade.clusterticks = grenade.ticks;

      if(grenade.ticks >= 1) {
        grenade.iscooked = 1;
      }

      grenade.originalowner = self;
      grenade thread clustergrenadeused();
      grenade thread grenade_earthquake();
      break;
    case #"hash_5d11ac1131cddab1":
    case #"hash_37ad8039ea91a8a5":
    case #"hash_4b87af60037f526f":
    case #"hash_4ba3c260039536a7":
      thread semtexused(grenade);
      break;
    case #"hash_8059d93d3568c07":
    case #"hash_fb36696c0708bf42":
    case #"hash_cac2107b8e726d9d":
    case #"hash_cad4f47b8e814c13":
      thread scripts\cp\equipment\cp_gas_grenade::gas_used(grenade);
      break;
    case #"hash_cedad6d52b2b36c2":
    case #"hash_7983828e72e83a3e":
    case #"hash_22f1c67a16accbe":
      if(issharedfuncdefined("super_hb_sensor", "hb_sensor_used")) {
        thread callsharedfunc("super_hb_sensor", "hb_sensor_used", grenade);
      }

      break;
    case #"hash_fa1e80f6bd5b8e72":
    case #"hash_c45a15aa87087124":
    case #"hash_c46d19aa871781fa":
    case #"hash_56ee829cc162271a":
      thread scripts\cp\cp_c4::c4_used(grenade);
      break;
    case #"hash_435258fc47768fa7":
    case #"hash_36b7174a04de8799":
    case #"hash_432644fc4753dde9":
    case #"hash_6a2e4f9c54756dc7":
      thread scripts\cp\cp_claymore::claymore_use(grenade);
      break;
    case #"hash_5e8f81314553dd36":
    case #"hash_9d57562863499a06":
      thread scripts\cp\equipment\cp_at_mine::at_mine_use(grenade);
      break;
    case #"hash_13d1f84d0ae96a5f":
    case #"hash_5e3fa526a48eaaa5":
    case #"hash_5e1fa926a475190b":
      thread scripts\cp\equipment\cp_trophy_system::trophy_used(grenade);
      break;
    case #"hash_a68928468343f517":
    case #"hash_af8ceb5f2fc2f9cd":
      if(issharedfuncdefined("super_tac_insert", "tac_insert_used")) {
        self thread[[getsharedfunc("super_tac_insert", "tac_insert_used")]](grenade);
      }

      break;
    case #"hash_8670ac083666f3a4":
    case #"hash_34e7a4cd11aed6bc":
      grenade thread watchconcussiongrenadeexplode();
      break;
    case #"hash_eeb591a8f50a5869":
    case #"hash_d9cbc629e947d1b7":
      thread mineused(grenade, &spawnmine);
      break;
    case #"hash_34c66d62f0d29ab0":
    case #"hash_2ab98cab4066a74e":
    case #"hash_34f28162f0f54c6e":
    case #"hash_b0e358318ab96277":
      scripts\cp_mp\equipment\throwing_knife::throwing_knife_used(grenade);
      break;
    case #"hash_aa2662d15f62dc87":
      level thread function_756a543a0b8f6670(self, grenade, grenade.weapon_name);
      break;
    case #"hash_23ca89fe3813464":
    case #"hash_7990c79c9b8e6b7c":
      grenade delete();
      break;
    case #"hash_e3575fdd14663ca9":
    case #"hash_e1f6f84e4cd950eb":
      grenade thread smokegrenadeused();
      break;
    case #"hash_eec4a41906598dfc":
    case #"hash_2f4cc7cb802a8be4":
      break;
    case #"hash_e042760d17966848":
    case #"hash_3dbe213ef2fabb76":
    case #"hash_3dc42d3ef2ff4b88":
    case #"hash_d06b94adddd3dd56":
    case #"hash_d072a0adddda0068":
      grenade.ninebangticks = grenade.ticks;
      grenade thread watchflashgrenadeexplode();

      if(grenade.ticks >= 1) {
        grenade.iscooked = 1;
      }

      break;
    case #"hash_d197e38e5fa659dd":
    case #"hash_6d18de18477a4e33":
      thread function_3d5c1674387c936e(grenade);
      break;
    case #"hash_333525cef39d0c66":
    case #"hash_9ca85335d506dad6":
      thread scripts\cp\equipment\decoy_grenade::decoy_used(grenade);
      break;
    case #"hash_7ae0f6243b0109fa":
    case #"hash_954bb5f200a1b95a":
    case #"hash_11a03a12f93f62b2":
      thread namespace_48d31ba9c6709870::function_54655641d3957e3(grenade);
      break;
    case #"hash_4a85ee2b82965fe2":
    case #"hash_64358af9c6c1edea":
      thread scripts\cp_mp\equipment\sonar_pulse::function_2d117eeb564f6ea3(grenade);
      break;
    case #"hash_d6565ec12efca627":
    case #"hash_d9108a0595d7d0b9":
      thread scripts\cp_mp\equipment\bunkerbuster::function_3d78dd516c25ef77(grenade);
      break;
    case #"hash_dcbfe1b308421be9":
    case #"hash_91ae9356f1911e97":
    case #"hash_f29daff1ad509837":
      thread scripts\cp_mp\equipment\bottle::bottle_used(grenade);
      break;
    case #"hash_b4a17c60413030e7":
    case #"hash_6bc36a1e4f485a79":
    case #"hash_7e0a03ed7c4c87be":
    case #"hash_f2e793d6a4fe013e":
      scripts\cp\deployablebox::throwcrate(grenade);
      break;
    case #"hash_17d5fde761fc574b":
    case #"hash_e4aed4089cbf3bc9":
      success = tac_cover_on_fired(undefined, undefined, undefined, 1);

      if(istrue(success)) {
        thread scripts\cp\powers\cp_tactical_cover::tac_cover_used(grenade);

        foreach(player in level.players) {
          player thread scripts\cp\cp_hud_message::showsplash("cp_used_deployable_cover", undefined, self);
        }
      }

      break;
    case #"hash_17c70dc48424ba92":
      thread scripts\cp_mp\equipment\breacher_drone::breacher_drone_used(grenade);
      break;
  }

  if(isDefined(grenade)) {
    grenade thread scripts\cp\cp_player_battlechatter::grenadeproximitytracking();
    scripts\cp\cp_player_battlechatter::ongrenadeuse(grenade);
    scripts\cp_mp\talking_gun::function_ef6885141252869(self, grenade);
  }

  if(isDefined(grenade) && isDefined(grenade.equipmentref)) {
    scripts\cp\equipment::autorefillequipmentammo(grenade.equipmentref);
  }
}

function function_3d5c1674387c936e(grenade) {
  waitframe();

  if(isDefined(grenade)) {
    grenade delete();
  }

  self notify("geigercounter_putaway");
}

function rat_executevisuals(ispeed) {
  level endon("game_ended");
  self endon("disconnect");
  self playlocalsound("eye_pulse_plr_lr");
  self setscriptablepartstate("rat_eye_pulse", "active");
  waittill_any_timeout_2(ispeed, "last_stand", "death");
  self setscriptablepartstate("rat_eye_pulse", "inactive");
}

function placeequipmentfailed(weapon, showfx, position, angles) {
  assert(isDefined(showfx) && isDefined(position) || !isDefined(showfx) && !isDefined(position));

  if(isPlayer(self)) {
    self playlocalsound("scavenger_pack_pickup");
  }

  if(istrue(showfx)) {
    fxent = undefined;

    if(isPlayer(self)) {
      if(isDefined(angles)) {
        fxent = spawnfxforclient(getfx("placeEquipmentFailed"), position, self, anglesToForward(angles), anglestoup(angles));
      } else {
        fxent = spawnfxforclient(getfx("placeEquipmentFailed"), position, self);
      }
    } else {
      fxent = spawnfx(getfx("placeEquipmentFailed"), position);
    }

    triggerfx(fxent);
    thread placeequipmentfailedcleanup(fxent);
  }
}

function placeequipmentfailedcleanup(fxent) {
  wait 2;
  fxent delete();
}

function spawnmine(origin, owner, weaponname, angles) {
  assert(isDefined(owner));

  if(!isDefined(angles)) {
    angles = (0, randomfloat(360), 0);
  }

  config = level.weaponconfigs[weaponname];
  assert(isDefined(config));
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

  if(isDefined(config.mine_beacon)) {
    mine thread doblinkinglight("tag_fx", config.mine_beacon["friendly"], config.mine_beacon["enemy"]);
  }

  movingplatformparent = undefined;

  if(self != level) {
    movingplatformparent = self getlinkedparent();
  }

  mine explosivehandlemovers(movingplatformparent);
  mine thread mineproximitytrigger(movingplatformparent);
  mine thread grenade_earthquake();
  mine thread mineselfdestruct();
  mine thread mineexplodeonnotify();
  level thread monitordisownedequipment(owner, mine);
  return mine;
}

function mineselfdestruct() {
  self endon("mine_triggered");
  self endon("mine_destroyed");
  self endon("death");
  wait level.mineselfdestructtime + randomfloat(0.4);
  self notify("mine_selfdestruct");
  self notify("detonateExplosive");
}

function mineexplodeonnotify() {
  self endon("death");
  level endon("game_ended");
  self waittill("detonateExplosive", attacker);

  if(!isDefined(self) || !isDefined(self.owner)) {
    return;
  }

  if(!isDefined(attacker)) {
    attacker = self.owner;
  }

  config = self.config;
  vfxtag = config.vfxtag;

  if(!isDefined(vfxtag)) {
    vfxtag = "tag_fx";
  }

  tagorigin = self gettagorigin(vfxtag);

  if(!isDefined(tagorigin)) {
    tagorigin = self gettagorigin("tag_origin");
  }

  self notify("explode", tagorigin);
  wait 0.05;

  if(!isDefined(self) || !isDefined(self.owner)) {
    return;
  }

  self hide();

  if(isDefined(config.onexplodefunc)) {
    self thread[[config.onexplodefunc]]();
  }

  if(isDefined(config.onexplodesfx)) {
    self playSound(config.onexplodesfx);
  }

  onexplodevfx = ter_op(isDefined(config.onexplodevfx), config.onexplodevfx, level.mine_explode);
  minedamagemin = ter_op(isDefined(config.minedamagemin), config.minedamagemin, level.minedamagemin);
  minedamagemax = ter_op(isDefined(config.minedamagemax), config.minedamagemax, level.minedamagemax);
  minedamageradius = ter_op(isDefined(config.minedamageradius), config.minedamageradius, level.minedamageradius);
  self radiusdamage(self.origin, minedamageradius, minedamagemax, minedamagemin, attacker, "MOD_EXPLOSIVE", self.weapon_name);
  wait 0.2;
  deleteexplosive();
}

function mineproximitytrigger(movingplatformparent) {
  self endon("mine_destroyed");
  self endon("mine_selfdestruct");
  self endon("death");
  self endon("disabled");
  config = self.config;
  wait config.armtime;

  if(isDefined(config.mine_beacon)) {
    thread doblinkinglight("tag_fx", config.mine_beacon["friendly"], config.mine_beacon["enemy"]);
  }

  trigger = spawn("trigger_radius", self.origin, 0, level.minedetectionradius, level.minedetectionheight);
  trigger.owner = self;
  trigger.team = trigger.owner.team;
  thread minedeletetrigger(trigger);

  if(isDefined(movingplatformparent)) {
    trigger enablelinkTo();
    trigger linkTo(movingplatformparent);
  }

  self.damagearea = trigger;

  while(true) {
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

function minedeletetrigger(trigger) {
  waittill_any_4("mine_triggered", "mine_destroyed", "mine_selfdestruct", "death");

  if(isDefined(trigger)) {
    trigger delete();
  }
}

function doblinkinglight(tagname, friendlyfxsrc, enemyfxsrc) {
  if(!isDefined(friendlyfxsrc)) {
    friendlyfxsrc = getfx("weap_blink_friend");
  }

  if(!isDefined(enemyfxsrc)) {
    enemyfxsrc = getfx("weap_blink_enemy");
  }

  self.blinkinglightfx["friendly"] = friendlyfxsrc;
  self.blinkinglightfx["enemy"] = enemyfxsrc;
  self.blinkinglighttag = tagname;
  thread updateblinkinglight(friendlyfxsrc, enemyfxsrc, tagname);
  self waittill("death");
  stopblinkinglight();
}

function updateblinkinglight(friendlyfxsrc, enemyfxsrc, tagname) {
  self endon("death");
  self endon("carried");
  self endon("emp_damage");
  checkfunc = &checkteam;

  if(!level.teambased) {
    checkfunc = &checkplayer;
  }

  delay = randomfloatrange(0.05, 0.25);
  wait delay;
  childthread onjointeamblinkinglight(friendlyfxsrc, enemyfxsrc, tagname, checkfunc);

  foreach(player in level.players) {
    if(isDefined(player)) {
      if(self.owner[[checkfunc]](player)) {
        playfxontagforclients(friendlyfxsrc, self, tagname, player);
      } else {
        playfxontagforclients(enemyfxsrc, self, tagname, player);
      }

      wait 0.05;
    }
  }
}

function checkplayer(other) {
  return self == other;
}

function checkteam(other) {
  return self.team == other.team;
}

function onjointeamblinkinglight(friendlyfxsrc, enemyfxsrc, tagname, checkfunc) {
  self endon("death");
  level endon("game_ended");
  self endon("emp_damage");

  while(true) {
    level waittill("joined_team", player);

    if(self.owner[[checkfunc]](player)) {
      playfxontagforclients(friendlyfxsrc, self, tagname, player);
      continue;
    }

    playfxontagforclients(enemyfxsrc, self, tagname, player);
  }
}

function stopblinkinglight() {
  if(isalive(self) && isDefined(self.blinkinglightfx)) {
    stopFXOnTag(self.blinkinglightfx["friendly"], self, self.blinkinglighttag);
    stopFXOnTag(self.blinkinglightfx["enemy"], self, self.blinkinglighttag);
    self.blinkinglightfx = undefined;
    self.blinkinglighttag = undefined;
  }
}

function watchfraggrenadeexplode() {
  grenade_owner_name = self.owner.name;
  self waittill("explode", position);
  level notify("grenade_exploded_during_stealth", position, "frag_grenade_mp", grenade_owner_name);
}

function watchflashgrenadeexplode() {
  grenade_owner_name = self.owner.name;
  self waittill("explode", position);
  level notify("grenade_exploded_during_stealth", position, "flash_grenade_mp", grenade_owner_name);
}

function function_756a543a0b8f6670(owner, grenade, weaponname) {
  if(weaponname == "throwingknifec4_mp") {
    grenade makeunusable();
    grenade thread recordthrowingknifetraveldist();
  }

  thread throwingknifedamagedvictim(owner, grenade);
  stuckto = undefined;
  stuckpart = undefined;
  grenade waittill("missile_stuck", stuckto, stuckpart);
  hitshield = isDefined(stuckpart) && stuckpart == "tag_flicker";
  hitweapon = isDefined(stuckpart) && stuckpart == "tag_weapon";

  if(isDefined(stuckto) && (isPlayer(stuckto) || isagent(stuckto)) && hitshield) {
    stuckto notify("shield_hit", grenade);
  }

  if(isDefined(stuckto) && (isPlayer(stuckto) || isagent(stuckto)) && !hitweapon && !hitshield) {
    if(weaponname == "throwingknifec4_mp") {
      throwingknifec4detonate(grenade, stuckto, owner);
    }
  }

  if(isDefined(stuckto) && istrue(stuckto.var_a8622ecf49acda6e)) {
    grenade delete();
    return;
  }

  grenade.equipmentref = "equip_throwing_knife";
  grenade thread watchgrenadedeath();

  grenade thread drawdebugcylinder();
}

function drawdebugcylinder() {
  self endon("<dev string:x107>");

  while(true) {
    if(getdvarint(@ "hash_a8d9e3f367c7effc") > 0) {
      cylinder(self.origin, self.origin + (0, 0, 64), 64);
    }

    waitframe();
  }
}

function throwingknifedamagedvictim(attacker, knife) {
  knife endon("death");
  attacker endon("death");
  attacker endon("disconnect");

  while(true) {
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

function watchgrenadedeath() {
  self waittill("death");

  if(isDefined(self.knife_trigger)) {
    self.knife_trigger delete();
  }
}

function throwingknifeteleport(knife, victim, attacker, lerp) {
  attacker playlocalsound("blinkknife_teleport");
  attacker playsoundonmovingent("blinkknife_teleport_npc");
  playsoundatpos(knife.origin, "blinkknife_impact");
  thread throwingknifeteleport_fxstartburst(attacker, victim);
  corpse = victim getcorpseentity();

  if(isDefined(corpse)) {
    corpse notsolid();
  }

  validenemies = [];

  foreach(char in level.characters) {
    if(!isDefined(char) || !isalive(char) || char == victim || char == attacker || !attacker isenemy(char)) {
      continue;
    }

    validenemies[validenemies.size] = char;
  }

  validenemies = sortbydistance(validenemies, victim.origin);
  var_e898076217b2e8c3 = attacker gettagorigin("TAG_EYE");
  endpos = victim.origin;
  var_8bb380999ecb6bd9 = victim.origin + (0, 0, var_e898076217b2e8c3[2] - attacker.origin[2]);
  endangles = attacker.angles;

  foreach(e in validenemies) {
    var_cc3fa02194191300 = (e.origin[0], e.origin[1], e gettagorigin("TAG_EYE")[2]);

    if(distancesquared(e.origin, victim.origin) < 230400 && sighttracepassed(var_8bb380999ecb6bd9, var_cc3fa02194191300, 0, undefined)) {
      endangles = vectortoangles(var_cc3fa02194191300 - var_8bb380999ecb6bd9);
      break;
    }
  }

  attacker setOrigin(victim.origin, !lerp);
  attacker setplayerangles(endangles);
  throwingknifeteleport_fxendburst(attacker, victim);
}

function throwingknifeteleport_fxstartburst(player, victim) {
  var_825a40a809006091 = victim.origin - player.origin;
  var_a8c3fbfd6c157049 = player.origin + (0, 0, 32);
  forward = vectorNormalize(var_825a40a809006091);
  right = vectorNormalize(vectorcross(var_825a40a809006091, (0, 0, 1)));
  up = vectorcross(right, forward);
  angles = axistoangles(forward, right, up);
  var_8cbee39de74c5db1 = 0;

  if(var_8cbee39de74c5db1) {
    fxent = spawn("script_model", var_a8c3fbfd6c157049);
    fxent.angles = angles;
    fxent setModel("tag_origin");
    fxent hidefromplayer(player);
    waitframe();
    playfxontagforteam(getfx("vfx_knife_tele_start_friendly"), fxent, "tag_origin", player.team);
    wait 3;
    fxent delete();
    return;
  }

  var_348daf7ac25e8901 = spawn("script_model", var_a8c3fbfd6c157049);
  var_348daf7ac25e8901.angles = angles;
  var_348daf7ac25e8901 setModel("tag_origin");
  var_348daf7ac25e8901 hidefromplayer(player);
  waitframe();

  foreach(otherplayer in level.players) {
    var_348daf7ac25e8901 hidefromplayer(otherplayer);
  }

  playFXOnTag(getfx("vfx_tele_start_friendly"), var_348daf7ac25e8901, "tag_origin");
  wait 3;
  var_348daf7ac25e8901 delete();
}

function recordthrowingknifetraveldist() {
  level endon("game_ended");
  self.owner endon("disconnect");
  self.disttravelled = 0;
  lastpos = self.origin;

  while(true) {
    waitresult = waittill_any_timeout_2(0.15, "death", "missile_stuck");

    if(!isDefined(self)) {
      break;
    }

    disttravelled = distance(lastpos, self.origin);
    self.disttravelled += disttravelled;
    lastpos = self.origin;

    if(waitresult != "timeout") {
      break;
    }
  }
}

function throwingknifeteleport_fxendburst(player, victim) {}

function throwingknifec4detonate(knife, victim, attacker) {
  victim playSound("biospike_explode");
  playFX(getfx("throwingknifec4_explode"), knife.origin);
  knife radiusdamage(knife.origin, 180, 1200, 600, attacker, "MOD_EXPLOSIVE", knife.weapon_name);
  knife thread grenade_earthquake();
  knife notify("explode", knife.origin);
  knife delete();
}

function watchconcussiongrenadeexplode() {
  thread endondeath();
  self endon("end_explode");
  grenade_owner_name = self.owner.name;
  self waittill("explode", position);
  level notify("grenade_exploded_during_stealth", position, "concussion_grenade_mp", grenade_owner_name);
  childthread stunenemiesinrange(position, self.owner);
  childthread stunplayersinrange(position, self.owner);
}

function stunplayersinrange(position, owner) {
  players = level.players;
  closestplayers = get_array_of_closest(position, players, undefined, 24, 256);

  foreach(victim in closestplayers) {
    if((is_friendly_damage(victim, owner) && victim != owner) == 0) {
      victim thread stundamageonplayers(victim, owner, position);
    }
  }
}

function stundamageonplayers(victim, owner, position) {
  var_73dc87c72d7f6c03 = 3;
  var_636c8be8a25f3a8 = 3;

  if(victim == owner) {
    var_73dc87c72d7f6c03 = 2;
    var_636c8be8a25f3a8 = 2;
  }

  scale = 1 - distance(victim.origin, position) / 512;

  if(scale < 0) {
    scale = 0;
  }

  time = var_73dc87c72d7f6c03 + var_636c8be8a25f3a8 * scale;
  owner notify("stun_hit");
  victim notify("concussed", owner);
  victim utility::setplayerstunned();
  victim thread cleanupconcussionstun(time);
  victim shellshock("concussion_grenade_mp", time);
  victim.concussionendtime = gettime() + time * 1000;
}

function stunenemiesinrange(position, owner) {
  enemies = array_combine(scripts\cp\cp_agent_utils::getaliveagentsofteam("axis"), scripts\cp\cp_agent_utils::getaliveagentsofteam("team_three"));
  closestenemies = get_array_of_closest(position, enemies, undefined, 24, 500);

  foreach(victim in closestenemies) {
    if(isagent(victim)) {
      victim notify("flashbang", victim.origin, 1, 1, owner, "axis");
    }

    victim thread fx_stun_damage(victim, owner);
  }
}

function fx_stun_damage(victim, eattacker) {
  victim endon("death");

  if(isDefined(victim.stun_hit_time)) {
    if(gettime() > victim.stun_hit_time) {
      victim.allowpain = 1;
      victim.stun_hit_time = gettime() + 1000;
      victim.stunned = 1;
      victim thread reduce_accuracy_while_stunned();
    } else {
      return;
    }
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

function reduce_accuracy_while_stunned() {
  self endon("death");
  self notify("sturn_accuracy_reduction");
  self endon("sturn_accuracy_reduction");

  if(self.baseaccuracy != 0) {
    self.old_accuracy = self.baseaccuracy;
  }

  self.baseaccuracy = 0;

  while(istrue(self.stunned)) {
    waitframe();
  }

  if(isDefined(self.old_accuracy)) {
    self.baseaccuracy = self.old_accuracy;
  }
}

function mineused(grenade, spawnfunc) {
  if(!isalive(self)) {
    grenade delete();
    return;
  }

  grenade thread minethrown(self, grenade.weapon_name, spawnfunc);
}

function minethrown(owner, weaponname, spawnfunc, var_fbf2bd8b1706fe46) {
  self.owner = owner;
  self waittill("missile_stuck", stuckto);

  if(!isDefined(owner)) {
    return;
  }

  if(weaponname != "trip_mine_mp") {
    if(isDefined(stuckto) && isDefined(stuckto.owner)) {
      if(isDefined(var_fbf2bd8b1706fe46)) {
        self.owner[[var_fbf2bd8b1706fe46]](self);
      }

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
  plantangles = vectortoangles(normal);
  plantangles += (90, 0, 0);
  mine = [[spawnfunc]](pos, owner, weaponname, plantangles);
  mine thread minedamagemonitor();
  self delete();
}

function minedamagemonitor() {
  self endon("mine_triggered");
  self endon("mine_selfdestruct");
  self endon("death");
  self setCanDamage(1);
  self.maxhealth = 100000;
  self.health = self.maxhealth;
  attacker = undefined;

  while(true) {
    self waittill("damage", damage, attacker, direction_vec, point, type, modelname, tagname, partname, idflags, objweapon, inflictor);

    if(is_hive_explosion(attacker, type)) {
      break;
    }

    if(!isPlayer(attacker) && !isagent(attacker)) {
      if(!isDefined(attacker.owner) || !isPlayer(attacker.owner)) {
        continue;
      } else {
        attacker = attacker.owner;
      }
    }

    if(isDefined(objweapon) && isendstr(objweapon.basename, "betty_mp")) {
      continue;
    }

    if(!scripts\cp\damage::friendlyfirecheck(self.owner, attacker)) {
      continue;
    }

    if(non_player_should_ignore_damage(attacker, objweapon, inflictor, type)) {
      continue;
    }

    break;
  }

  self notify("mine_destroyed");

  if(isDefined(type) && (issubstr(type, "MOD_GRENADE") || issubstr(type, "MOD_EXPLOSIVE"))) {
    self.waschained = 1;
  }

  if(isDefined(idflags) && idflags & 8) {
    self.wasdamagedfrombulletpenetration = 1;
  }

  self.wasdamaged = 1;

  if(isDefined(attacker)) {
    self.damagedby = attacker;
  }

  self notify("detonateExplosive", attacker);
}

function is_hive_explosion(attacker, type) {
  if(!isDefined(attacker) || !isDefined(attacker.classname)) {
    return false;
  }

  return attacker.classname == "scriptable" && type == "MOD_EXPLOSIVE";
}

function explosivetrigger(target, graceperiod, notifystr) {
  self setscriptablepartstate("arm", "neutral", 0);
  self setscriptablepartstate("trigger", "active", 0);

  if(isPlayer(target) && target _hasperk("specialty_delaymine")) {
    target notify("triggeredExpl", notifystr);
    graceperiod = level.delayminetime;
  }

  wait graceperiod;
}

function shouldaffectclaymore(claymore) {
  if(isDefined(claymore.disabled)) {
    return false;
  }

  pos = self.origin + (0, 0, 32);
  dirtopos = pos - claymore.origin;
  claymoreforward = anglesToForward(claymore.angles);
  dist = vectordot(dirtopos, claymoreforward);

  if(dist < level.claymoredetectionmindist) {
    return false;
  }

  dirtopos = vectorNormalize(dirtopos);
  dot = vectordot(dirtopos, claymoreforward);
  return dot > level.claymoredetectiondot;
}

function deleteondeath(ent) {
  self waittill("death");
  self setscriptablepartstate("destroy", "active", 0);
  wait 0.05;

  if(isDefined(ent)) {
    if(isDefined(ent.trigger)) {
      ent.trigger delete();
    }

    ent delete();
  }
}

function onlethalequipmentplanted(newlethal, powername, var_959103ee6629ea1d) {
  if(self.plantedlethalequip.size) {
    self.plantedlethalequip = array_removeundefined(self.plantedlethalequip);

    if(self.plantedlethalequip.size >= level.maxperplayerexplosives) {
      if(istrue(var_959103ee6629ea1d)) {
        self.plantedlethalequip[0] notify("detonateExplosive");
      } else {
        self.plantedlethalequip[0] deleteexplosive();
      }
    }
  }

  self.plantedlethalequip[self.plantedlethalequip.size] = newlethal;
  entnum = newlethal getentitynumber();
  level.mines[entnum] = newlethal;
  level notify("mine_planted");
}

function add_to_mine_list(newlethal) {
  entnum = newlethal getentitynumber();
  level.mines[entnum] = newlethal;
}

function clustergrenadeused() {
  owner = self.originalowner;
  owner endon("disconnect");
  thread ownerdisconnectcleanup(owner);
  delays = [];

  for(i = 0; i < 4; i++) {
    delays[i] = 0.2;
  }

  var_3faad2422c09b784 = 0;

  foreach(delay in delays) {
    var_3faad2422c09b784 += delay;
  }

  killcament = spawn("script_model", self.origin);
  killcament linkTo(self);
  killcament setModel("tag_origin");
  killcament setscriptmoverkillcam("explosive");
  killcament thread deathdelaycleanup(self, var_3faad2422c09b784 + 5);
  killcament thread ownerdisconnectcleanup(self.owner);
  killcament.threwback = self.threwback;
  var_d5eeaa5b2b8b2f6f = owner _launchgrenade("cluster_grenade_indicator_mp", self.origin, (0, 0, 0));
  var_d5eeaa5b2b8b2f6f linkTo(self);
  var_d5eeaa5b2b8b2f6f thread deathdelaycleanup(self, var_3faad2422c09b784);
  var_d5eeaa5b2b8b2f6f thread ownerdisconnectcleanup(self.owner);
  thread notifyafterframeend("death", "end_explode");
  self endon("end_explode");
  self waittill("explode", position);
  thread clustergrenadeexplode(position, delays, owner, killcament);
}

function clustergrenadeexplode(position, delays, owner, killcament) {
  owner endon("disconnect");
  contents = scripts\engine\trace::create_contents(0, 1, 1, 0, 1, 0, 0);
  var_3234df3086482e07 = 0;
  start = position + (0, 0, 3);
  end = start + (0, 0, -5);
  castresults = physics_raycast(start, end, contents, undefined, 0, "physicsquery_closest");

  if(isDefined(castresults) && castresults.size > 0) {
    var_3234df3086482e07 = 1;
  }

  posoffset = ter_op(var_3234df3086482e07, (0, 0, 32), (0, 0, 2));
  fxposition = position + posoffset;
  var_39a64ef99549e28e = randomint(90) - 45;

  contents = scripts\engine\trace::create_contents(0, 1, 1, 0, 1, 0, 0);

  for(i = 0; i < 4; i++) {
    killcament.shellshockondamage = ter_op(i == 0, 1, undefined);
    killcament radiusdamage(position, 256, 800, 400, owner, "MOD_EXPLOSIVE", "cluster_grenade_zm");
    yaw = ter_op(i < 4, 90 * i + var_39a64ef99549e28e, randomint(360));
    pitchoffset = ter_op(var_3234df3086482e07, 110, 90);
    pitchrange = ter_op(var_3234df3086482e07, 12, 45);
    pitch = pitchoffset + randomint(pitchrange * 2) - pitchrange;
    dist = randomint(60) + 30;
    x = cos(yaw) * sin(pitch);
    y = sin(yaw) * sin(pitch);
    z = cos(pitch);
    offset = (x, y, z) * dist;
    start = fxposition;
    end = fxposition + offset;
    castresults = physics_raycast(start, end, contents, undefined, 0, "physicsquery_closest");

    if(isDefined(castresults) && castresults.size > 0) {
      end = castresults[0]["position"];
    }

    playFX(getfx("clusterGrenade_explode"), end);

    switch (i) {
      case 0:
        playsoundatpos(end, "iw9_frag_grenade_expl_trans");
        break;
      case 3:
        playsoundatpos(end, "cluster_explode_end");
        break;
      default:
        playsoundatpos(end, "cluster_explode_mid");
        break;
    }

    wait delays[i];
  }
}

function deathdelaycleanup(grenade, duration) {
  self endon("death");
  grenade waittill("death");
  wait duration;
  self delete();
}

function ownerdisconnectcleanup(owner) {
  self endon("death");
  owner waittill("disconnect");
  self delete();
}

function semtexused(grenade) {
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

  if(isagent(stuckto)) {
    addbattlechatternotify(stuckto, undefined, "semtex_stuck");
  }

  if(isagent(stuckto) && !istrue(stuckto.var_274d3a7704e351ef)) {
    if(!isDefined(stuckto.var_f8ecc64162438d76)) {
      stuckto.var_f8ecc64162438d76 = [];
    } else {
      stuckto.var_f8ecc64162438d76 = array_removedead(stuckto.var_f8ecc64162438d76);
    }

    stuckto.var_f8ecc64162438d76 = array_add(stuckto.var_f8ecc64162438d76, grenade);
    assertex(stuckto.health > 0, "Agent with a semtex stuck to is dead already.");
    function_60daa23100a2b874(grenade, stuckto);
  }

  level notify("grenade_exploded_during_stealth", grenade.origin, "semtex_mp", grenade_owner_name);
  grenade thread grenade_earthquake();
  grenade explosivehandlemovers(undefined);
}

function semtex_watch_fuse() {
  self endon("death");
  wait 2;
  thread semtex_explode();
}

function semtex_explode() {
  thread semtex_delete(0.1);
}

function semtex_destroy() {
  thread semtex_delete(0.1);
}

function semtex_delete(delay) {
  self notify("death");
  self.exploding = 1;
  wait delay;
  self delete();
}

function semtex_watch_cleanup() {
  self endon("death");
  semtex_watch_cleanup_end_early();

  if(isDefined(self)) {
    thread semtex_destroy();
  }
}

function semtex_watch_cleanup_end_early() {
  self.owner endon("disconnect");
  self.owner endon("joined_team");
  self.owner endon("joined_spectators");
  level endon("game_ended");

  while(true) {
    waitframe();
  }
}

function attachmentisdefault(attachmentbasename) {
  return isDefined(attachmentbasename) && (string_starts_with(attachmentbasename, "rec") || string_starts_with(attachmentbasename, "front") || string_starts_with(attachmentbasename, "back") || string_starts_with(attachmentbasename, "mag") || string_starts_with(attachmentbasename, "guard") || string_starts_with(attachmentbasename, "triggrip") || string_starts_with(attachmentbasename, "toprail"));
}

function remove_attachment(attachment, player, weapon) {
  if(!isDefined(attachment) && !isDefined(player)) {
    return;
  }

  weapons = [];
  var_ceb40e0d9504f27a = undefined;
  objnewweapon = undefined;

  if(isDefined(weapon)) {
    if(isweapon(weapon)) {
      weapons[weapons.size] = weapon;
    } else {
      weapons[weapons.size] = makeweaponfromstring(weapon);
    }
  } else {
    weapons = player getweaponslistall();
  }

  foreach(item in weapons) {
    if(item hasattachment(attachment)) {
      var_62e770ea80d43309 = getrawbaseweaponname(item);
      baseweapon = getweaponbasename(item);
      player takeweapon(item);
      attachments = getweaponattachments(item);

      foreach(piece in attachments) {
        if(issubstr(piece, attachment)) {
          attachments = array_remove(attachments, piece);
          break;
        }
      }

      if(isDefined(level.build_weapon_name_func)) {
        objnewweapon = player[[level.build_weapon_name_func]](baseweapon, attachments);
      }

      if(isDefined(objnewweapon)) {
        weapons = self getweaponslistprimaries();

        foreach(weapon in weapons) {
          if(issubstr(weapon.basename, objnewweapon.basename)) {
            if(weapon.isalternate) {
              baseweapon = getweaponbasename(weapon);

              if(isDefined(level.alt_mode_weapons_allowed) && array_contains(level.alt_mode_weapons_allowed, baseweapon)) {
                objnewweapon = objnewweapon getaltweapon();
                break;
              }
            }
          }
        }

        player _giveweapon(objnewweapon, -1, -1, 1);
        player switchtoweapon(objnewweapon);
      }
    }
  }
}

function has_weapon_variation(weapon) {
  primaries = self getweaponslistall();
  weaponname = undefined;

  if(isweapon(weapon)) {
    weaponname = weapon.basename;
  } else {
    weaponname = weapon;
  }

  foreach(primaryweapon in primaries) {
    baseweapon = getrawbaseweaponname(weaponname);
    var_442713efdf839b74 = getrawbaseweaponname(primaryweapon);

    if(baseweapon == var_442713efdf839b74) {
      return true;
    }
  }

  return false;
}

function get_weapon_variation_obj(weapon) {
  primaries = self getweaponslistall();
  result = [];
  weaponname = undefined;

  if(isweapon(weapon)) {
    weaponname = weapon.basename;
  } else {
    weaponname = weapon;
  }

  foreach(primaryweapon in primaries) {
    baseweapon = getrawbaseweaponname(weaponname);
    var_442713efdf839b74 = getrawbaseweaponname(primaryweapon);

    if(baseweapon == var_442713efdf839b74) {
      result[result.size] = primaryweapon;
    }
  }

  return result;
}

function grenade_earthquake(var_7bb0eac0599aa23d) {
  self notify("grenade_earthQuake");
  self endon("grenade_earthQuake");
  thread endondeath();
  self endon("end_explode");
  position = undefined;

  if(!isDefined(var_7bb0eac0599aa23d) || var_7bb0eac0599aa23d) {
    self waittill("explode", position);
  } else {
    position = self.origin;
  }

  playrumbleonposition("grenade_rumble", position);
  earthquake(0.5, 0.75, position, 800);

  foreach(player in level.players) {
    if(player isusingremote()) {
      continue;
    }

    if(distancesquared(position, player.origin) > 360000) {
      continue;
    }

    if(player damageconetrace(position)) {
      player thread dirteffect(position);
    }

    player setclientomnvar("ui_hud_shake", 1);
  }
}

function endondeath() {
  self waittill("death");
  waittillframeend();
  self notify("end_explode");
}

function dirteffect(position) {
  self notify("dirtEffect");
  self endon("dirtEffect");
  self endon("disconnect");

  if(!scripts\cp_mp\utility\player_utility::_isalive()) {
    return;
  }

  forwardvec = vectorNormalize(anglesToForward(self.angles));
  rightvec = vectorNormalize(anglestoright(self.angles));
  var_2281000002d7b901 = vectorNormalize(position - self.origin);
  fdot = vectordot(var_2281000002d7b901, forwardvec);
  rdot = vectordot(var_2281000002d7b901, rightvec);
  string_array = ["death", "damage"];
  currentweapon = self getcurrentweapon();

  if(fdot > 0 && fdot > 0.5 && currentweapon.basename != "iw6_riotshield_mp") {
    waittill_any_in_array_or_timeout(string_array, 2);
    return;
  }

  if(abs(fdot) < 0.866) {
    if(rdot > 0) {
      waittill_any_in_array_or_timeout(string_array, 2);
      return;
    }

    waittill_any_in_array_or_timeout(string_array, 2);
  }
}

function shellshockondamage(cause, damage) {
  if(isflashbanged()) {
    return;
  }

  if(cause == "MOD_EXPLOSIVE" || cause == "MOD_GRENADE" || cause == "MOD_GRENADE_SPLASH" || cause == "MOD_PROJECTILE" || cause == "MOD_PROJECTILE_SPLASH") {
    if(damage > 10) {
      if(isDefined(self.shellshockreduction) && self.shellshockreduction) {
        self shellshock("damage_cp", self.shellshockreduction);
        return;
      }

      self shellshock("damage_cp", 0.5);
    }
  }
}

function isflashbanged() {
  return isDefined(self.flashendtime) && gettime() < self.flashendtime;
}

function isakimbo(weapon) {
  if(isDefined(weapon.others)) {
    foreach(attachment in weapon.others) {
      if(issubstr(attachment, "akimbo")) {
        return true;
      }
    }
  }

  return false;
}

function waittill_grenade_fire() {
  while(true) {
    self waittill("grenade_fire", grenade, objweapon, tickpercent, originalowner);

    if(isDefined(self.throwinggrenade) && objweapon.basename != self.throwinggrenade) {
      continue;
    }

    if(isDefined(grenade)) {
      if(!isDefined(grenade.weapon_obj)) {
        grenade.weapon_obj = objweapon;
      }

      if(!isDefined(grenade.weapon_name)) {
        grenade.weapon_name = objweapon.basename;
      }

      if(!isDefined(grenade.owner)) {
        grenade.owner = self;
      }

      if(!isDefined(grenade.team)) {
        grenade.team = self.team;
      }

      if(!isDefined(grenade.ticks) && isDefined(self.throwinggrenade)) {
        grenade.ticks = roundup(4 * tickpercent);
      }
    }

    grenadeinitialize(grenade, objweapon, tickpercent, originalowner);

    if(!scripts\cp_mp\utility\player_utility::_isalive() && !isDefined(self.throwndyinggrenade)) {
      self notify("grenade_fire_dead", grenade, objweapon.basename);
      self.throwndyinggrenade = 1;
    }

    if(istrue(grenade.threwback)) {
      if(isDefined(scripts\cp\pickups::getcurrentequipment("primary"))) {
        if(scripts\cp_mp\equipment::getequipmentslotammo("primary") >= 1) {
          scripts\cp_mp\equipment::function_91bd2a98062313cb("primary", 1);
        }
      }
    }

    return grenade;
  }
}

function grenadestuckto(grenade, stuckto, ignoresplash) {
  if(!isDefined(self)) {
    grenade.stuckenemyentity = stuckto;
    stuckto.stuckbygrenade = grenade;
    return;
  }

  if(level.teambased && is_equal(stuckto.team, self.team)) {
    grenade.isstuck = "friendly";
    return;
  }

  var_d658f0b6bc4fd513 = undefined;
  var_d5f11d86f917656 = undefined;

  if(!isDefined(grenade.weapon_name)) {
    return;
  }

  switch (grenade.weapon_name) {
    case #"hash_4b87af60037f526f":
      var_d658f0b6bc4fd513 = "semtex_stuck";
      var_d5f11d86f917656 = #"bc_flavor_player_surprise";
      break;
    case #"hash_ab3485fa6834de47":
      var_d658f0b6bc4fd513 = "molotov_stuck";
      var_d5f11d86f917656 = #"bc_flavor_player_surprise";
      break;
    case #"hash_b833f98278746f9b":
      var_d658f0b6bc4fd513 = "flare_gun_attacker_stuck";
      break;
    case #"hash_4c7de5619284e175":
      var_d658f0b6bc4fd513 = "thermite_attacker_stuck";
      var_d5f11d86f917656 = #"bc_flavor_player_surprise";
      break;
    case #"hash_4a85ee2b82965fe2":
      var_d658f0b6bc4fd513 = "sonar_pulse_stuck";
      break;
    case #"hash_954bb5f200a1b95a":
      var_d658f0b6bc4fd513 = "shock_stick_stuck";
      var_d5f11d86f917656 = #"bc_flavor_player_surprise";
      break;
    case #"hash_d6565ec12efca627":
      var_d658f0b6bc4fd513 = "bunkerbuster_stuck";
      var_d5f11d86f917656 = #"bc_flavor_player_surprise";
      break;
  }

  grenade.isstuck = "enemy";
  grenade.stuckenemyentity = stuckto;
  stuckto.stuckbygrenade = grenade;
  self notify("grenade_stuck_enemy");
}

function grenadestucktosplash(var_d658f0b6bc4fd513, stuckto) {
  player = self;

  if(isPlayer(stuckto) && isDefined(var_d658f0b6bc4fd513)) {
    if(isDefined(player.owner)) {
      player = player.owner;
    }

    player scripts\cp\cp_hud_message::showsplash(var_d658f0b6bc4fd513);
  }
}

function get_possible_attachments_by_weaponclass(weapclass, weapon, var_effb4ae1788a8b10) {
  if(!isDefined(weapclass)) {
    return false;
  }

  if(!isDefined(weapon)) {
    return false;
  }

  if(!isDefined(var_effb4ae1788a8b10)) {
    return false;
  }

  return true;
}

function getattachmenttypeslist(weaponname, var_2fbd0e943f095064) {
  attachments = getweaponattachmentarrayfromstats(weaponname);
  list = [];

  foreach(attachment in attachments) {
    attachmenttype = getattachmenttype(attachment);

    if(isDefined(var_2fbd0e943f095064) && listhasattachment(var_2fbd0e943f095064, attachment)) {
      continue;
    }

    if(!isDefined(list[attachmenttype])) {
      list[attachmenttype] = [];
    }

    attachmentlist = list[attachmenttype];
    attachmentlist[attachmentlist.size] = attachment;
    list[attachmenttype] = attachmentlist;
  }

  return list;
}

function getattachmentlistbasenames() {
  attachmentlist = [];
  tables = ["mp/attachmenttable.csv", "cp/cp_attachmenttable.csv"];

  foreach(table in tables) {
    numrows = tablelookupgetnumrows(table);

    for(index = 0; index < numrows; index++) {
      attachmentname = tablelookupbyrow(table, index, 5);
      group = tablelookupbyrow(table, index, 2);

      if(attachmentname != "" && group != "none" && !array_contains(attachmentlist, attachmentname)) {
        attachmentlist[attachmentlist.size] = attachmentname;
      }
    }
  }

  return attachmentlist;
}

function function_9ba246f8c51923da() {
  thread setweaponlaser_internal();
}

function setweaponlaser_internal() {
  self endon("death_or_disconnect");
  self endon("unsetWeaponLaser");
  self.perkweaponlaseron = 0;
  weapon = self getcurrentweapon();

  while(true) {
    setweaponlaser_waitforlaserweapon(weapon);

    if(self.perkweaponlaseron == 0) {
      self.perkweaponlaseron = 1;
      enableweaponlaser();
    }

    childthread setweaponlaser_monitorads();
    childthread setweaponlaser_monitorweaponswitchstart(1);
    self.perkweaponlaseroffforswitchstart = undefined;
    self waittill("weapon_change", weapon);

    if(self.perkweaponlaseron == 1) {
      self.perkweaponlaseron = 0;
      disableweaponlaser();
    }
  }
}

function setweaponlaser_waitforlaserweapon(weapon) {
  while(true) {
    assert(isweapon(weapon));

    if(isDefined(weapon) && (weapon.basename == "iw6_kac_mp" || weapon.basename == "iw6_arx160_mp")) {
      break;
    }

    self waittill("weapon_change", weapon);
  }
}

function setweaponlaser_monitorads() {
  self endon("weapon_change");

  while(true) {
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

function setweaponlaser_monitorweaponswitchstart(offtime) {
  self endon("weapon_change");

  while(true) {
    self waittill("weapon_switch_started");
    childthread setweaponlaser_onweaponswitchstart(offtime);
  }
}

function setweaponlaser_onweaponswitchstart(offtime) {
  self notify("setWeaponLaser_onWeaponSwitchStart");
  self endon("setWeaponLaser_onWeaponSwitchStart");

  if(self.perkweaponlaseron == 1) {
    self.perkweaponlaseroffforswitchstart = 1;
    self.perkweaponlaseron = 0;
    disableweaponlaser();
  }

  wait offtime;
  self.perkweaponlaseroffforswitchstart = undefined;

  if(self.perkweaponlaseron == 0 && self playerads() <= 0.6) {
    self.perkweaponlaseron = 1;
    enableweaponlaser();
  }
}

function enableweaponlaser() {
  if(!isDefined(self.weaponlasercalls)) {
    self.weaponlasercalls = 0;
  }

  self.weaponlasercalls++;
  self laseron();
}

function disableweaponlaser() {
  assertex(isDefined(self.weaponlasercalls), "disableWeaponLaser() called before at least one enableWeaponLaser() call.");
  self.weaponlasercalls--;
  assertex(self.weaponlasercalls >= 0, "disableWeaponLaser() called at least one more time than enableWeaponLaser() causing a negative call count.");

  if(self.weaponlasercalls == 0) {
    self laseroff();
    self.weaponlasercalls = undefined;
  }
}

function ondetonateexplosive(notifystring) {
  self endon("death");
  level endon("game_ended");
  thread cleanupexplosivesondeath();
  self waittill("detonateExplosive");

  if(isDefined(notifystring)) {
    self.owner notify(notifystring, 1);
  } else {
    self.owner notify("powers_c4_used", 1);
  }

  self detonate(self.owner);
}

function cleanupexplosivesondeath() {
  self endon("deleted_equipment");
  level endon("game_ended");
  equipnum = self getentitynumber();
  equipkillcament = self.killcament;
  equiptrigger = self.trigger;
  equipsensor = self.sensor;
  self waittill("death");
  cleanupequipment(equipnum, equipkillcament, equiptrigger, equipsensor);
}

function cleanupequipment(equipnum, equipkillcament, equiptrigger, equipsensor) {
  if(isDefined(self.weapon_name)) {
    if(self.weapon_name == "c4_mp") {
      self.owner notify("c4_update", 0);
    } else if(self.weapon_name == "bouncing_betty_mp") {
      self.owner notify("bouncing_betty_update", 0);
    } else if(self.weapon_name == "sticky_mine_mp") {
      self.owner notify("sticky_mine_update", 0);
    } else if(self.weapon_name == "trip_mine_mp") {
      self.owner notify("trip_mine_update", 0);
    } else if(self.weapon_name == "cryo_grenade_mp") {
      self.owner notify("restart_cryo_grenade_cooldown", 0);
    }
  }

  if(isDefined(equipnum)) {
    level.mines[equipnum] = undefined;
  }

  if(isDefined(equipkillcament)) {
    equipkillcament delete();
  }

  if(isDefined(equiptrigger)) {
    equiptrigger delete();
  }

  if(isDefined(equipsensor)) {
    equipsensor delete();
  }
}

function monitordamage(maxhealth, damagefeedback, ondeathfunc, modifydamagefunc, biskillstreak, rumble) {
  self endon("death");
  level endon("game_ended");

  if(!isDefined(rumble)) {
    rumble = 0;
  }

  self setCanDamage(1);
  self.health = 9999999;
  self.maxhealth = maxhealth;
  self.damagetaken = 0;

  if(!isDefined(biskillstreak)) {
    biskillstreak = 0;
  }

  for(running = 1; running; running = monitordamageoneshot(damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, objweapon, inflictor, damagefeedback, ondeathfunc, modifydamagefunc, biskillstreak)) {
    self waittill("damage", damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor);

    if(rumble) {
      self playRumbleOnEntity("damage_light");
    }

    if(isDefined(self.helitype) && self.helitype == "littlebird") {
      if(!isDefined(self.attackers)) {
        self.attackers = [];
      }

      uniqueid = "";

      if(isDefined(attacker) && isPlayer(attacker)) {
        uniqueid = attacker getuniqueid();
      }

      if(isDefined(self.attackers[uniqueid])) {
        self.attackers[uniqueid] += damage;
        continue;
      }

      self.attackers[uniqueid] = damage;
    }
  }
}

function monitordamageend() {
  self notify("monitorDamageEnd");
  self.damagetaken = undefined;
  self.attackers = undefined;
  self.wasdamaged = undefined;
  self.wasdamagedfrombulletpenetration = undefined;
  self.wasdamagedfrombulletricochet = undefined;
  self setCanDamage(0);
}

function monitordamageoneshot(damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, objweapon, inflictor, damagefeedback, ondeathfunc, modifydamagefunc, biskillstreak) {
  if(!isDefined(self)) {
    return false;
  }

  if(isDefined(attacker) && !scripts\cp\damage::friendlyfirecheck(self.owner, attacker)) {
    if(isDefined(self.equipmentref) && self.equipmentref == "equip_tac_cover") {} else {
      return true;
    }
  }

  modifieddamage = damage;

  if(isDefined(objweapon)) {
    if(non_player_should_ignore_damage(attacker, objweapon, inflictor, meansofdeath)) {
      return true;
    }
  }

  damagedata = scripts\cp_mp\utility\damage_utility::packdamagedata(attacker, self, damage, objweapon, meansofdeath, inflictor, point, direction_vec, modelname, partname, tagname, idflags);

  if(!isDefined(modifydamagefunc)) {
    modifydamagefunc = &scripts\cp\damage::modifydamage;
  }

  modifieddamage = self[[modifydamagefunc]](damagedata);

  if(modifieddamage <= 0) {
    return true;
  }

  self.wasdamaged = 1;
  self.damagetaken += modifieddamage;
  self.health = 2147483647;

  if(istrue(biskillstreak)) {
    scripts\cp\utility::killstreakhit(attacker, objweapon, self, meansofdeath, modifieddamage);
  }

  if(isDefined(attacker)) {
    if(isPlayer(attacker)) {
      attacker scripts\cp\damagefeedback::updatedamagefeedback(damagefeedback);
    }
  }

  if(self.damagetaken >= self.maxhealth) {
    damagedata = scripts\cp_mp\utility\damage_utility::packdamagedata(attacker, self, damage, objweapon, meansofdeath, inflictor, point, direction_vec, modelname, partname, tagname, idflags);
    self thread[[ondeathfunc]](damagedata);
    return false;
  }

  return true;
}

function non_player_should_ignore_damage(attacker, objweapon, inflictor, meansofdeath) {
  if(non_player_should_ignore_damage_signature(attacker, objweapon, inflictor, meansofdeath)) {
    return true;
  }

  if(isDefined(objweapon) && isDefined(objweapon.basename)) {
    var_e36d0c5378e4855b = objweapon.basename;
    var_e36d0c5378e4855b = strip_suffix(var_e36d0c5378e4855b, "_mp");
    var_e36d0c5378e4855b = strip_suffix(var_e36d0c5378e4855b, "_cp");

    if(meansofdeath != "MOD_MELEE") {
      switch (var_e36d0c5378e4855b) {
        case #"hash_7a7616547d22d1d4":
        case #"hash_cf4e7cba76f5287f":
        case #"hash_ec99c59936c1a84a":
          return true;
      }
    }

    if(meansofdeath == "MOD_IMPACT") {
      switch (var_e36d0c5378e4855b) {
        case #"hash_36b7174a04de8799":
        case #"hash_3b51e79b2c293f51":
        case #"hash_5d11ac1131cddab1":
        case #"hash_9d57562863499a06":
        case #"hash_a0319e349a692b8f":
        case #"hash_d60cefc9485f062f":
        case #"hash_d9108a0595d7d0b9":
        case #"hash_f29476a8c0915592":
        case #"hash_fa1e80f6bd5b8e72":
        case #"hash_fe5ec41137ca1d39":
          return true;
      }
    } else {
      switch (var_e36d0c5378e4855b) {
        case #"hash_1768b8fe4480e4b":
        case #"hash_8059d93d3568c07":
        case #"hash_1b4881cfd42bb6d8":
        case #"hash_42dcb6ce7ecb709c":
        case #"hash_45125a8f171b4fb9":
        case #"hash_4c57dd619266bfc9":
        case #"hash_63d44e71602ef0a0":
        case #"hash_752a9051bc22d228":
        case #"hash_8670ac083666f3a4":
        case #"hash_e042760d17966848":
        case #"hash_e1f6f84e4cd950eb":
        case #"hash_fb36696c0708bf42":
          return true;
      }
    }
  }

  return false;
}

function non_player_should_ignore_damage_signature(attacker, objweapon, inflictor, meansofdeath) {
  if(!isDefined(self.ignoredamagesignatures)) {
    return false;
  }

  if(isDefined(objweapon) && isstring(objweapon)) {
    objweapon = makeweapon(objweapon);
  }

  foreach(signature in self.ignoredamagesignatures) {
    if(!isDefined(signature)) {
      return false;
    }

    if(signature.checkattacker) {
      if(!isDefined(signature.attacker)) {
        non_player_remove_ignore_damage_signature(signature.id);
        continue;
      } else if(!isDefined(attacker)) {
        continue;
      } else if(attacker != signature.attacker) {
        continue;
      }
    }

    if(signature.checkobjweapon) {
      if(!isDefined(objweapon) || isnullweapon(objweapon)) {
        continue;
      } else if(objweapon != signature.objweapon) {
        continue;
      }
    }

    if(signature.checkinflictor) {
      if(!isDefined(signature.inflictor)) {
        non_player_remove_ignore_damage_signature(signature.id);
        continue;
      } else if(!isDefined(inflictor)) {
        continue;
      } else if(inflictor != signature.inflictor) {
        continue;
      }
    }

    if(signature.checkmeansofdeath) {
      if(!isDefined(meansofdeath)) {
        continue;
      } else if(meansofdeath != signature.meansofdeath) {
        continue;
      }
    }

    return true;
  }

  return false;
}

function non_player_remove_ignore_damage_signature(id) {
  if(!isDefined(self.ignoredamagesignatures)) {
    return;
  }

  self.ignoredamagesignatures[id] = undefined;
}

function non_player_add_ignore_damage_signature(attacker, objweapon, inflictor, meansofdeath) {
  if(!isDefined(self.ignoredamageid)) {
    self.ignoredamageid = 0;
  }

  if(!isDefined(self.ignoredamagesignatures)) {
    self.ignoredamagesignatures = [];
  }

  id = self.ignoredamageid;
  self.ignoredamageid++;

  if(isDefined(objweapon) && isstring(objweapon)) {
    objweapon = makeweapon(objweapon);
  }

  signature = spawnStruct();
  signature.id = id;
  signature.attacker = attacker;
  signature.objweapon = objweapon;
  signature.inflictor = inflictor;
  signature.meansofdeath = meansofdeath;
  signature.checkattacker = isDefined(attacker);
  signature.checkobjweapon = isDefined(objweapon) && !isnullweapon(objweapon);
  signature.checkinflictor = isDefined(inflictor);
  signature.checkmeansofdeath = isDefined(meansofdeath);
  self.ignoredamagesignatures[id] = signature;
  return id;
}

function explosivehandlemovers(parent, usedefaultinvalidparentcallback) {
  data = spawnStruct();
  data.linkparent = parent;
  data.deathoverridecallback = &movingplatformdetonate;
  data.endonstring = "death";

  if(!isDefined(usedefaultinvalidparentcallback) || !usedefaultinvalidparentcallback) {
    data.invalidparentoverridecallback = &scripts\cp\cp_movers::moving_platform_empty_func;
  }

  thread scripts\cp\cp_movers::handle_moving_platforms(data);
}

function movingplatformdetonate(data) {
  if(!isDefined(data.lasttouchedplatform) || !isDefined(data.lasttouchedplatform.destroyexplosiveoncollision) || data.lasttouchedplatform.destroyexplosiveoncollision) {
    self notify("detonateExplosive");
  }
}

function makeexplosiveusable() {
  if(self.owner scripts\cp_mp\utility\player_utility::_isalive()) {
    self setotherent(self.owner);
    self.trigger = spawn("script_origin", self.origin + getexplosiveusableoffset());
    self.trigger.owner = self;
    thread equipmentwatchuse(self.owner, 1);
  }
}

function isplantedequipment(ent) {
  return isDefined(level.mines[ent getentitynumber()]) || istrue(ent.planted);
}

function equipmentwatchuse(owner, updateposition) {
  self notify("equipmentWatchUse");
  self endon("spawned_player");
  self endon("disconnect");
  self endon("equipmentWatchUse");
  self.trigger setCursorHint("HINT_NOICON");
  self.trigger scripts\cp\equipment::setexplosiveusablehintstring(self.weapon_name);
  self.trigger setselfusable(owner);
  self.trigger thread notusableforjoiningplayers(owner);

  if(isDefined(updateposition) && updateposition) {
    thread updatetriggerposition();
  }

  for(;;) {
    self.trigger waittill("trigger", owner);
    owner notify("pickup_equipment", self.weapon_name);
    owner setweaponammostock(self.weapon_name, owner getweaponammostock(self.weapon_name) + 1);
    deleteexplosive();
    self notify("death");
  }
}

function updatetriggerposition() {
  self endon("death");

  for(;;) {
    if(isDefined(self) && isDefined(self.trigger)) {
      self.trigger.origin = self.origin + getexplosiveusableoffset();

      if(isDefined(self.bombsquadmodel)) {
        self.bombsquadmodel.origin = self.origin;
      }
    } else {
      return;
    }

    wait 0.05;
  }
}

function deleteexplosive(pickedup) {
  if(isDefined(self)) {
    if(isDefined(self.deletefunc)) {
      self thread[[self.deletefunc]]();
      self notify("deleted_equipment");
      return;
    }

    equipnum = self getentitynumber();
    equipkillcament = self.killcament;
    equiptrigger = self.trigger;
    equipsensor = self.sensor;
    cleanupequipment(equipnum, equipkillcament, equiptrigger, equipsensor);
    self notify("deleted_equipment");
    self delete();
  }
}

function ontacticalequipmentplanted(newtactical, equipmentref, deletefunc) {
  newtactical.equipmentref = equipmentref;
  newtactical.deletefunc = deletefunc;
  newtactical.planted = 1;

  if(!istrue(newtactical.issuper)) {
    if(self.plantedtacticalequip.size) {
      self.plantedtacticalequip = array_removeundefined(self.plantedtacticalequip);

      if(self.plantedtacticalequip.size && self.plantedtacticalequip.size >= getmaxplantedtacticalequip(self)) {
        self.plantedtacticalequip[0] deleteexplosive();
      }
    }

    self.plantedtacticalequip[self.plantedtacticalequip.size] = newtactical;
  }

  entnum = newtactical getentitynumber();
  level.mines[entnum] = newtactical;
  level notify("mine_planted");
}

function getmaxplantedtacticalequip(player) {
  var_30dc1c5e4b8568b0 = 0;
  var_30dc1c5e4b8568b0 = 4;
  return var_30dc1c5e4b8568b0;
}

function equipmentdeathvfx(sfx) {
  fxent = spawnfx(getfx("equipment_sparks"), self.origin);
  triggerfx(fxent);

  if(!isDefined(sfx) || sfx == 0) {
    self playSound("sentry_explode");
  }

  fxent thread delayentdelete(1);
}

function equipmentdeletevfx() {
  fxent = spawnfx(getfx("placeEquipmentFailed"), self.origin);
  triggerfx(fxent);
  self playSound("mp_killstreak_disappear");
  fxent thread delayentdelete(1);
}

function monitordisownedequipment(player, equipment, var_93494d8d17d67d84) {
  level endon("game_ended");
  equipment endon("death");
  equipment notify("monitorDisownedEquipment()");
  equipment endon("monitorDisownedEquipment()");

  if(istrue(var_93494d8d17d67d84)) {
    player waittill_any_2("joined_team", "disconnect");
  } else {
    player waittill_any_3("joined_team", "joined_spectators", "disconnect");
  }

  equipment deleteexplosive();
}

function isprimaryweapon(weapon) {
  if(isweapon(weapon) && isnullweapon(weapon)) {
    return 0;
  }

  if(isstring(weapon) && weapon == "none") {
    return 0;
  }

  if(weaponinventorytype(weapon) != "primary") {
    return 0;
  }

  switch (weaponclass(weapon)) {
    case #"hash_690c0d6a821b42e":
    case #"hash_6191aaef9f922f96":
    case #"hash_61e969dacaaf9881":
    case #"hash_719417cb1de832b6":
    case #"hash_8cdaf2e4ecfe5b51":
    case #"hash_900cb96c552c5e8e":
    case #"hash_fa24dff6bd60a12d":
      return 1;
    default:
      return 0;
  }
}

function getexplosiveusableoffset() {
  upvec = anglestoup(self.angles);
  return 10 * upvec;
}

function is_incompatible_weapon(weapon) {
  weaponname = undefined;

  if(isweapon(weapon)) {
    weaponname = weapon.basename;
  } else {
    weaponname = weapon;
  }

  if(isDefined(level.ammoincompatibleweaponslist)) {
    if(array_contains(level.ammoincompatibleweaponslist, weaponname)) {
      return true;
    }
  }

  return false;
}

function get_weapon_level(weapon) {
  if(!isPlayer(self)) {
    return int(1);
  }

  weaponname = undefined;

  if(isweapon(weapon)) {
    weaponname = weapon.basename;
  } else {
    weaponname = weapon;
  }

  if(isDefined(self.pap[weaponname])) {
    return self.pap[weaponname].lvl;
  }

  var_9211cdaadb7bca55 = getrawbaseweaponname(weaponname);

  if(isDefined(self.pap[var_9211cdaadb7bca55])) {
    return self.pap[var_9211cdaadb7bca55].lvl;
  }

  return int(1);
}

function can_upgrade(weapon, var_eb2e85b24c206ea5) {
  return false;
}

function get_pap_camo(var_ceb40e0d9504f27a, baseweapon, currentweapon) {
  camo = undefined;
  return camo;
}

function validate_current_weapon(var_ceb40e0d9504f27a, baseweapon, currentweapon) {
  if(isDefined(level.weapon_upgrade_path) && isDefined(level.weapon_upgrade_path[getweaponbasename(currentweapon)])) {
    currentweapon = level.weapon_upgrade_path[getweaponbasename(currentweapon)];
  }

  return currentweapon;
}

function getitemweaponname() {
  classname = self.classname;
  assert(getsubstr(classname, 0, 7) == "weapon_");
  weapname = getsubstr(classname, 7);
  return weapname;
}

function watchweaponpickup(clip, stockammo) {
  level endon("game_ended");
  weapname = getitemweaponname();

  while(true) {
    self waittill("trigger", player, droppeditem);

    if(isDefined(player) && istestclient(player)) {
      continue;
    }

    currweapon = player getcurrentweapon();
    player thread watchpickupcomplete(weapname, currweapon, clip, stockammo);
    player notify("weapon_pickup", weapname);
    dirty = scripts\cp_mp\weapon::fixupplayerweapons(player, weapname);

    if(isDefined(droppeditem) || dirty) {
      break;
    }
  }

  assert(isDefined(player.tookweaponfrom));

  if(isDefined(droppeditem)) {
    player notify("manual_switch_from_minigun");
    droppedweaponname = droppeditem getitemweaponname();
    objweapon = makeweaponfromstring(droppedweaponname);

    if(isDefined(player.tookweaponfrom[droppedweaponname])) {
      droppeditem.owner = player.tookweaponfrom[droppedweaponname];
      player.tookweaponfrom[droppedweaponname] = undefined;
    }

    droppeditem.objweapon = objweapon.basename;
    droppeditem.targetname = "dropped_weapon";

    if(istrue(level.clearstockondrop)) {
      stockammo = 0;
    } else {
      stockammo = weaponstartammo(droppeditem);
    }

    weaponbasename = getweaponbasename(objweapon);

    if(isDefined(player.var_7aa597d25db76e44[weaponbasename])) {
      clip = player.var_7aa597d25db76e44[weaponbasename];
      player.var_7aa597d25db76e44[weaponbasename] = undefined;
    } else {
      clip = weaponclipsize(droppeditem);
    }

    droppeditem itemweaponsetammo(clip, stockammo);
    droppeditem thread watchweaponpickup(clip, stockammo);
  }

  player.tookweaponfrom[weapname] = self.owner;
}

function watchpickupcomplete(desiredweapon, previousweapon, clip, stockammo) {
  self endon("death");
  self endon("disconnect");
  self notify("watchPickupComplete()");
  self endon("watchPickupComplete()");
  startingweapon = self.currentweapon;
  success = 0;

  if(isstring(desiredweapon)) {
    desiredweapon = makeweaponfromstring(desiredweapon);
  }

  if(startingweapon == desiredweapon) {
    success = 1;
  } else {
    while(true) {
      waitframe();
      currentweapon = self.currentweapon;

      if(issameweapon(startingweapon, currentweapon, 0)) {
        continue;
      }

      if(issameweapon(desiredweapon, currentweapon, 0)) {
        success = 1;
      } else {
        success = 0;
      }

      break;
    }
  }

  if(success) {
    ammotype = scripts\cp\pickups::br_ammo_type_for_weapon(desiredweapon);

    if(isDefined(ammotype)) {
      if(isDefined(stockammo)) {
        stock = stockammo + get_int_or_0(self.br_ammo[ammotype]);
      } else {
        stock = get_int_or_0(self.br_ammo[ammotype]);
      }

      self.br_ammo[ammotype] = stock;
      self setweaponammostock(desiredweapon, stock);
    }

    if(desiredweapon.basename == "iw9_lm_dblmg2_cp") {
      scripts\cp\killstreaks\juggernaut_cp::juggernautweaponpickedup(desiredweapon, previousweapon);
    }

    checkpoint = scripts\cp\cp_checkpoint::checkpoint_get();

    if(isDefined(checkpoint) && checkpoint != "" && isDefined(self.pers["last_checkpoint"]) && self.pers["last_checkpoint"] != checkpoint) {
      thread scripts\cp\loadout::function_7da7bd24b280d295();
    }

    weaponbasename = getweaponbasename(desiredweapon);
    self.var_7aa597d25db76e44[weaponbasename] = self getweaponammoclip(desiredweapon);
    thread notifyuiofpickedupweapon();
    self notify("finish_pickup_of_weapon", desiredweapon, previousweapon);
  }
}

function notifyuiofpickedupweapon() {
  self setclientomnvar("ui_weapon_pickup", 0);
}

function player_watchweaponclip() {
  self endon("death_or_disconnect");
  self endon("faux_spawn");
  level endon("game_ended");
  self notify("player_watchWeaponClip");
  self endon("player_watchWeaponClip");
  self.var_7aa597d25db76e44 = [];

  for(;;) {
    self waittill("weapon_fired", objweapon);
    currentweapon = self getcurrentweapon();

    if(!isDefined(currentweapon) || isnullweapon(currentweapon)) {
      continue;
    }

    if(!isinventoryprimaryweapon(currentweapon)) {
      continue;
    }

    weaponbasename = getweaponbasename(currentweapon);
    self.var_7aa597d25db76e44[weaponbasename] = self getweaponammoclip(currentweapon);
  }
}

function watchweaponusage(weaponhand) {
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

    if(!isinventoryprimaryweapon(currentweapon)) {
      continue;
    }

    if(isDefined(level.updateonusepassivesfunc)) {
      thread[[level.updateonusepassivesfunc]](self, getcompleteweaponname(currentweapon));
    }

    curtime = gettime();

    if(!isDefined(self.lastshotfiredtime)) {
      self.lastshotfiredtime = 0;
    }

    var_d6df3d735d181a6e = gettime() - self.lastshotfiredtime;
    self.lastshotfiredtime = curtime;

    if(isai(self)) {
      continue;
    }

    weaponbasename = getweaponbasename(currentweapon);

    if(!isDefined(self.shotsfiredwithweapon[weaponbasename])) {
      self.shotsfiredwithweapon[weaponbasename] = 1;
    } else {
      self.shotsfiredwithweapon[weaponbasename]++;
    }

    self.var_7aa597d25db76e44[weaponbasename] = self getweaponammoclip(currentweapon);

    if(!isDefined(self.accuracy_shots_fired)) {
      self.accuracy_shots_fired = 1;
    } else {
      self.accuracy_shots_fired++;
    }

    scripts\cp\persistence::increment_player_career_shots_fired(self);

    if(isDefined(weaponbasename)) {
      if(isDefined(self.hitsthismag[weaponbasename])) {
        thread hitsthismag_update(weaponbasename, currentweapon);
      }
    }
  }
}

function hitsthismag_update(baseweaponname, objweapon) {
  assert(isweapon(objweapon));
  self endon("death");
  self endon("disconnect");
  baseweaponname = objweapon.basename;
  self endon("updateMagShots_" + baseweaponname);
  self.hitsthismag[baseweaponname]--;
  wait 0.1;
  self notify("shot_missed", objweapon);
  self.consecutivehitsperweapon[baseweaponname] = 0;
  self.hitsthismag[baseweaponname] = weaponclipsize(objweapon);
}

function watchweaponchange() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  self notify("watchWeaponChange");
  self endon("watchWeaponChange");
  self.hitsthismag = [];
  weaponname = getweaponbasename(self getcurrentweapon());
  hitsthismag_init(weaponname);

  while(true) {
    self waittill("weapon_change", objweapon);
    weaponname = objweapon.basename;
    weapontracking_init(weaponname);

    if(isDefined(self.weapon_passives[objweapon.basename])) {}

    hitsthismag_init(weaponname);
  }
}

function harpoon_impale_additional_func(weapon, eattacker, victim, vpoint, vdir, shitloc, spartname, var_19f6f25777706f34) {
  if(!issubstr(weapon, "harpoon")) {
    return;
  }

  victim startragdoll();
  contents = physics_createcontents(["physicscontents_solid", "physicscontents_glass", "physicscontents_missileclip", "physicscontents_vehicle"]);
  endpoint = vpoint + vdir * 4096;
  trace = scripts\engine\trace::ray_trace_detail(vpoint, endpoint, undefined, contents, undefined, 1);
  endpoint = trace["position"] - vdir * 12;
  flightdist = length(endpoint - vpoint);
  flighttime = flightdist / 1250;
  flighttime = clamp(flighttime, 0.05, 1);
  wait 0.05;
  var_a0480a10ee4e345f = vdir;
  var_c323f0cb880a051f = anglestoup(eattacker.angles);
  var_c1148ff802be2880 = vectorcross(var_a0480a10ee4e345f, var_c323f0cb880a051f);
  railent = spawn_tag_origin(vpoint, axistoangles(var_a0480a10ee4e345f, var_c1148ff802be2880, var_c323f0cb880a051f));
  railent moveTo(endpoint, flighttime);
  constraint = spawnragdollconstraint(victim, shitloc, spartname, var_19f6f25777706f34);
  constraint.origin = railent.origin;
  constraint.angles = railent.angles;
  constraint linkTo(railent);
  thread play_explosion_post_impale(endpoint, eattacker);
  thread impale_cleanup(victim, railent, flighttime + 0.05, constraint);
}

function impale_cleanup(evictim, railent, time, constraint) {
  evictim waittill_any_timeout_2(time, "death", "disconnect");
  constraint delete();
  railent delete();
}

function play_explosion_post_impale(explosion_location, player) {
  wait 2;
  player radiusdamage(explosion_location, 500, 1000, 500, player, "MOD_EXPLOSIVE");
  playFX(level._effect["penetration_railgun_explosion"], explosion_location);
}

function weapontracking_init(weaponname) {
  if(!isDefined(weaponname) || weaponname == "none") {
    return;
  }

  if(!isDefined(self.shotsfiredwithweapon[weaponname])) {
    self.shotsfiredwithweapon[weaponname] = 0;
  }

  if(!isDefined(self.shotsontargetwithweapon[weaponname])) {
    self.shotsontargetwithweapon[weaponname] = 0;
  }

  if(!isDefined(self.headshots[weaponname])) {
    self.headshots[weaponname] = 0;
  }

  if(!isDefined(self.wavesheldwithweapon[weaponname])) {
    self.wavesheldwithweapon[weaponname] = 1;
  }

  if(!isDefined(self.downsperweaponlog[weaponname])) {
    self.downsperweaponlog[weaponname] = 0;
  }

  if(!isDefined(self.killsperweaponlog[weaponname])) {
    self.killsperweaponlog[weaponname] = 0;
  }
}

function hitsthismag_init(weaponname) {
  if(!isDefined(weaponname) || weaponname == "none") {
    return;
  }

  if(isinventoryprimaryweapon(weaponname) && !isDefined(self.hitsthismag[weaponname])) {
    self.hitsthismag[weaponname] = weaponclipsize(weaponname);
  }
}

function addattachmenttoweapon(newweapon, var_effb4ae1788a8b10, maxammo) {
  currentweapon = self.currentweapon;
  weaponobj = currentweapon;
  newweapon = undefined;
  var_1c1a1a6f472d6e7a = 0;

  if(currentweapon.attachments.size == 0) {
    if(weaponobj canuseattachment(var_effb4ae1788a8b10)) {
      var_1c1a1a6f472d6e7a = 1;
    } else {
      var_1c1a1a6f472d6e7a = 0;
    }
  } else {
    for(j = 0; j < currentweapon.attachments.size; j++) {
      if(weaponobj canuseattachment(var_effb4ae1788a8b10) && attachmentsconflict(currentweapon.attachments[j], var_effb4ae1788a8b10, weaponobj) == "") {
        var_1c1a1a6f472d6e7a = 1;
        continue;
      }

      var_1c1a1a6f472d6e7a = 0;
      break;
    }
  }

  if(var_1c1a1a6f472d6e7a) {
    newweapon = weaponobj withattachment(var_effb4ae1788a8b10);
  }

  if(!isDefined(newweapon)) {
    if(!isbot(self)) {
      self iprintlnbold("<dev string:x10d>" + var_effb4ae1788a8b10);
    }

    return undefined;
  }

  clip_ammo = self getweaponammoclip(newweapon);
  stock_ammo = self getweaponammostock(newweapon);

  if(istrue(maxammo)) {
    clip_ammo = weaponclipsize(newweapon);
    stock_ammo = scripts\cp\utility::function_ed18a118c6fa5c4f(newweapon);
  }

  scripts\cp_mp\utility\inventory_utility::_takeweapon(currentweapon);
  self giveweapon(newweapon);
  self setweaponammoclip(newweapon, clip_ammo);
  self setweaponammostock(newweapon, stock_ammo);
  scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate(newweapon);
  scripts\cp_mp\weapon::fixupplayerweapons(self, newweapon);
  return newweapon;
}

function _buildweaponcustom(weapon, attachments, camo, reticle, variantid, attachmentids, cosmeticattachment, stickers, hasnvg) {
  weaponname = weapon;
  tokens = strtok(weaponname, "_");
  index = 0;

  if(tokens[0] == "alt") {
    index++;
  }

  if(tokens[index] == "iw7") {
    self iprintln("<dev string:x9b>");

    return;
  }

  if(tokens[index] == "iw8") {
    rootname = weapon;

    if(!isDefined(attachments)) {
      attachments = [];
    }

    if(!isDefined(camo)) {
      camo = "none";
    }

    if(!isDefined(reticle)) {
      reticle = "none";
    }

    if(!isDefined(variantid)) {
      variantid = -1;
    }

    if(!isDefined(attachmentids)) {
      attachmentids = [];
    }

    if(!isDefined(cosmeticattachment)) {
      cosmeticattachment = "none";
    }

    if(!isDefined(stickers)) {
      stickers = [];
    }

    if(!isDefined(hasnvg)) {
      hasnvg = 0;
    }

    if(!isPlayer(self)) {
      return buildweapon(rootname, attachments, camo, reticle, variantid, attachmentids, cosmeticattachment, stickers, hasnvg);
    }

    return buildweapon(rootname, attachments, camo, reticle, variantid, attachmentids, cosmeticattachment, stickers, hasnvg);
  }
}

function checkforinvalidattachments(attachments, weaponassetname) {
  weaponobj = makeweapon(weaponassetname);
  newattachments = [];

  foreach(attachment in attachments) {
    if(weaponobj canuseattachment(attachment)) {
      newattachments[newattachments.size] = attachment;
      continue;
    }

    thread invalidattachmentwarning(attachment, weaponassetname);
  }

  return newattachments;
}

function function_29ba39c7e2adb57b(rootname, attachments, variantid) {
  if(isDefined(variantid) && variantid < 0) {
    variantid = undefined;
  }

  attachments = scripts\cp_mp\weapon::weaponattachremoveextraattachments(attachments);
  attachments = array_remove(attachments, "none");
  assertex(attachments.size <= 12, "buildWeapon() passed attachment array that was too large. Weapons only support up to 8 attachments.");
  attachdefaults = weaponattachdefaultmap(rootname);
  allattachments = array_combine_unique(attachments, attachdefaults);
  weaponassetname = weaponassetnamemap(rootname, variantid);

  if(allattachments.size > 0) {
    allattachments = filterattachments(allattachments);
  }

  attachmentsextra = [];

  foreach(a in allattachments) {
    extra = attachmentmap_toextra(a);

    if(isDefined(extra)) {
      foreach(extraattach in extra) {
        attachmentsextra[attachmentsextra.size] = extraattach;
      }
    }
  }

  if(attachmentsextra.size > 0) {
    allattachments = array_combine_unique(allattachments, attachmentsextra);
  }

  assertex(allattachments.size <= 12, "buildWeapon() ended up with over 12 attachments after mods and defaults were added.");

  if(isDefined(variantid)) {
    variantattachments = getweaponvariantattachments(weaponassetname, variantid);

    foreach(var_9aa34a1fe21f66ff in variantattachments) {
      allattachments[allattachments.size] = var_9aa34a1fe21f66ff;
    }
  }

  var_580837ba9de8f3d4 = undefined;
  return allattachments;
}

function debug_circle(center, radius, duration, color, startdelay, fillcenter) {
  circle_sides = 16;
  anglefrac = 360 / circle_sides;
  circlepoints = [];

  for(i = 0; i < circle_sides; i++) {
    angle = anglefrac * i;
    xadd = cos(angle) * radius;
    yadd = sin(angle) * radius;
    x = center[0] + xadd;
    y = center[1] + yadd;
    z = center[2];
    circlepoints[circlepoints.size] = (x, y, z);
  }

  if(isDefined(startdelay)) {
    wait startdelay;
  }

  thread debug_circle_drawlines(circlepoints, duration, color, fillcenter, center);
}

function debug_circle_drawlines(circlepoints, duration, color, fillcenter, center) {
  if(!isDefined(fillcenter)) {
    fillcenter = 0;
  }

  if(!isDefined(center)) {
    fillcenter = 0;
  }

  for(i = 0; i < circlepoints.size; i++) {
    start = circlepoints[i];

    if(i + 1 >= circlepoints.size) {
      end = circlepoints[0];
    } else {
      end = circlepoints[i + 1];
    }

    thread scripts\cp\cp_debug::debug_line(start, end, duration, color);

    if(fillcenter) {
      thread scripts\cp\cp_debug::debug_line(center, start, duration, color);
    }
  }
}

function function_2778968efa18eb6a() {
  level endon("<dev string:x13f>");
  flag_init("<dev string:x14a>");

  while(true) {
    flag_wait("<dev string:x14a>");
    flag_clear("<dev string:x14a>");
    cosmetics = setDvar(@ "hash_2e8bd550ed0544cd", 1);
    camos = setDvar(@ "hash_900dcba8cdf5e65c", 1);
    attachments = setDvar(@ "hash_99387041680b1bdf", 1);
    variants = setDvar(@ "hash_ca742b19bf89b13d", 1);
    var_c2ffa607013ba4b2 = setDvar(@ "hash_a473ce988b9649e", "<dev string:x15d>");
  }
}

function function_f81df2bd8c245b4e(var_66acbb61c1a9e1e, var_c2ffa607013ba4b2) {
  weapontokens = strtok(var_c2ffa607013ba4b2, "<dev string:x15e>");

  foreach(token in weapontokens) {
    if(issubstr(var_66acbb61c1a9e1e, token)) {
      return 1;
    }
  }

  return 0;
}

function applyflashfromdamage(victim, attacker, origin, var_73c2061b38dc4d56) {
  victim endon("death");

  if(isDefined(victim.usingremote)) {
    return false;
  }

  if(isDefined(victim.vehicle)) {
    return false;
  }

  if(!victim scripts\cp_mp\utility\player_utility::_isalive()) {
    return false;
  }

  if(is_friendly_damage(victim, attacker) && victim != attacker) {
    return false;
  }

  dist = distance(origin, victim.origin);
  var_cb2d2cdf15da89ff = 0;

  if(attacker == victim) {
    if(dist > 384) {
      return false;
    } else {
      var_cb2d2cdf15da89ff = 1;
    }
  }

  var_782c6796f4c5a826 = 0;
  var_3baba845edbbe939 = 0;
  var_4447761ae0fff3f = isagent(attacker) || isPlayer(attacker);

  if(dist >= 512 || var_4447761ae0fff3f && !scripts\engine\utility::within_fov(attacker.origin, attacker getplayerangles(), origin, 0.5)) {
    var_782c6796f4c5a826 = 3;
    var_3baba845edbbe939 = 0.25;
  } else if(dist <= 256) {
    var_782c6796f4c5a826 = 5;
    var_3baba845edbbe939 = 0.75;
  } else {
    ratio = 1 - (dist - 256) / 256;
    var_782c6796f4c5a826 = 3 + ratio * 2;
    var_3baba845edbbe939 = 0.25 + ratio * 0.5;
  }

  if(var_73c2061b38dc4d56) {
    victim = attacker;
    var_782c6796f4c5a826 = max(3, var_782c6796f4c5a826 * 0.75);
    var_3baba845edbbe939 = max(0.25, var_3baba845edbbe939 * 0.75);
  } else if(var_cb2d2cdf15da89ff) {
    var_782c6796f4c5a826 = max(3, var_782c6796f4c5a826 * 0.75);
    var_3baba845edbbe939 = max(0.25, var_3baba845edbbe939 * 0.75);
  }

  if(isPlayer(victim)) {
    victim shellshock("flashbang_mp", var_782c6796f4c5a826);
    victim.flashendtime = gettime() + int(var_782c6796f4c5a826 * 1000);
    victim thread flashrumbleloop(var_3baba845edbbe939);
  } else if(victim is_zombie_agent() || victim.agent_type == "soldier_agent" || victim.unittype == "soldier") {
    stunenemiesinrange(origin, attacker);
  } else {
    victim shellshock("flashbang_mp", var_782c6796f4c5a826);
    victim.flashendtime = gettime() + int(var_782c6796f4c5a826 * 1000);
    victim thread flashrumbleloop(var_3baba845edbbe939);
  }

  return true;
}

function isflashgrenadedamage(objweapon, smeansofdeath) {
  var_a62c0688fcaa530d = objweapon.basename == "flash_grenade_mp" || objweapon.basename == "flash_grenade_cp" || objweapon.basename == "jup_flash_grenade_cp";
  return var_a62c0688fcaa530d && smeansofdeath != "MOD_IMPACT";
}

function flashrumbleloop(duration) {
  self endon("stop_monitoring_flash");
  self endon("flash_rumble_loop");
  self notify("flash_rumble_loop");
  goaltime = gettime() + duration * 1000;

  while(gettime() < goaltime) {
    self playRumbleOnEntity("damage_heavy");
    wait 0.05;
  }
}

function giveequipmentasaweapon(equipmentname) {
  switch (equipmentname) {
    case #"hash_c9a436974fe60919":
      self.last_weapon = self getcurrentweapon();
      self giveweapon("iw8_molotov_zm");
      self switchtoweapon("iw8_molotov_zm");
      break;
    case #"hash_abe1faf5b315f711":
      self.last_weapon = self getcurrentweapon();
      self giveweapon("c4_mp");
      self switchtoweapon("c4_mp");
      break;
  }
}

function watch_for_dropped_weapons() {
  while(true) {
    level waittill("ai_weapon_dropped");
    dropped_weapons = getweaponarray();

    foreach(weap in dropped_weapons) {
      weap setusepriority(1, 1);
    }
  }
}

function drop_script_weapon_from_ai(droppedweapon, position) {
  if(istrue(level.var_624ba233506a543e) && !istrue(self.var_ced8415aaad3ff6d) || istrue(self.var_a0cb39f1fce66086)) {
    return;
  }

  name = droppedweapon.basename;

  if(isDefined(self.var_857ff4a1e09042d4)) {
    name = self.var_857ff4a1e09042d4.basename;
  }

  if(array_contains(level.invalid_drop_weapons, name)) {
    return;
  }

  attachments = droppedweapon.attachments;

  if(scripts\cp_mp\utility\game_utility::function_d2d2b803a7b741a4()) {
    if(droppedweapon canuseattachment("laserir_box")) {
      droppedweapon = droppedweapon withattachment("laserir_box");
    }

    if(droppedweapon canuseattachment("laserir_pstl")) {
      droppedweapon = droppedweapon withattachment("laserir_pstl");
    }

    if(droppedweapon canuseattachment("laserir_cyl")) {
      droppedweapon = droppedweapon withattachment("laserir_cyl");
    }
  }

  dvar = getDvar(@ "hash_f12ca0fa2674622f", "");

  if(dvar != "") {
    if(name == "iw8_sn_xmike109_mp") {} else {
      attachments = array_add(attachments, dvar);
    }
  }

  if(player_has_nvg()) {
    var_6e9bbc4d48f38065 = 1;
  } else {
    var_6e9bbc4d48f38065 = undefined;
  }

  if(utility::iscp()) {
    var_3ace5ac9c7d6fa44 = undefined;

    if(isagent(self) && self isinexecutionvictim()) {
      var_3ace5ac9c7d6fa44 = 1;
    }

    weapon = scripts\cp\pickups::function_8a9c22c541e0dd5b(droppedweapon, var_3ace5ac9c7d6fa44);
    return;
  }

  weapon = scripts\cp\pickups::createspawnweaponatpos(self.origin + (0, 0, 32), self.angles, droppedweapon);
}

function player_has_nvg() {
  if(istrue(level.nightmap)) {
    return true;
  }

  if(level.script == "cp_so_estate" || level.script == "cp_mission_bads") {
    return true;
  }

  return false;
}

function delete_weapon_after_time() {
  level endon("game_ended");
  self endon("death");
  self endon("entitydeleted");

  if(getdvarint(@ "hash_c564069ec13375cb", 0) != 0) {
    return;
  }

  if(isDefined(level.var_4b47eedac44a48)) {
    wait level.var_4b47eedac44a48;
  } else {
    wait 30;
  }

  remove_from_weapon_array(self);
  self delete();
}

function update_dropped_weapon_priorities() {
  self setusepriority(1, 1);
  self setuserange(72);
}

function initializeweaponpickups() {
  if(isDefined(level.custom_allowedweaponnames)) {
    allowedweaponnames = level.custom_allowedweaponnames;
  } else {
    allowedweaponnames = ["iw8_ar_falpha", "iw8_sm_papa90", "iw8_sm_augolf", "iw8_lm_pkilo", "iw8_sn_alpha50", "iw8_pi_mike1911", "iw8_ar_mike4", "iw8_ar_akilo47", "iw8_sm_mpapa5", "iw8_sh_dpapa12", "iw8_lm_kilo121", "iw8_sn_mike14", "iw8_sn_kilo98", "iw8_pi_golf21", "iw8_sn_crossbow"];
  }

  var_bf8fe275eba37cc1 = getStructArray("weapon_pickup", "script_noteworthy");

  foreach(st in var_bf8fe275eba37cc1) {
    if(isDefined(st.script_parameters)) {
      name = getcompletenameforweapon(st.script_parameters + "_mp");
      println("<dev string:x160>" + name);
      weapon = spawn("weapon_" + name, st.origin);
      weapon itemweaponsetammo(weaponclipsize(name), scripts\cp\utility::function_ed18a118c6fa5c4f(name));
      weapon thread watchweaponpickup();
      var_bf8fe275eba37cc1 = array_remove(var_bf8fe275eba37cc1, st);
    }
  }

  weapons = [];
  attachmentsarray = [];

  foreach(root, data in level.weaponmapdata) {
    foreach(name in allowedweaponnames) {
      if(root == name) {
        var_52222e4fa76f795e = strtok(root, "_");

        if(var_52222e4fa76f795e[0] == "iw8") {
          weapons[weapons.size] = root;
          level.attachmentmap[root] = pullattachmentsforweapon(root);
        }
      }
    }
  }

  weapons = eliminatenullweapons(weapons);
  weaponindex = 0;
  counter = 0;
  var_ca5370d04fce3797 = var_bf8fe275eba37cc1.size;

  while(counter < var_ca5370d04fce3797) {
    weaponindex = randomintrange(0, weapons.size);
    attachments = attachmentroll(weapons[weaponindex]);

    foreach(attachment in attachments) {
      foreach(att in attachments) {
        if(attachment == att) {
          continue;
        }

        if(attachmentsconflict(attachment, att, weapons[weaponindex])) {
          attachments = array_remove(attachments, att);
        }
      }
    }

    name = getcompletenameforweapon(weapons[weaponindex]);
    println("<dev string:x160>" + weapons[weaponindex]);
    weapon = spawn("weapon_" + name, var_bf8fe275eba37cc1[counter].origin);

    if(isDefined(var_bf8fe275eba37cc1[counter].angles)) {
      weapon.angles = var_bf8fe275eba37cc1[counter].angles;
    } else {
      weapon.angles = (0, 0, 0);
    }

    weapon itemweaponsetammo(weaponclipsize(name), scripts\cp\utility::function_ed18a118c6fa5c4f(name));
    weapon thread watchweaponpickup();
    counter++;
  }
}

function attachmentroll(rootname) {
  attachments = [];

  if(isDefined(level.attachmentmap[rootname])) {
    var_d7af4ffcc6535706 = array_randomize(level.attachmentmap[rootname]);
    maxattach = attachmentrollcount();

    for(idx = 0; idx < maxattach && idx < var_d7af4ffcc6535706.size; idx++) {
      attachments[attachments.size] = var_d7af4ffcc6535706[idx];
    }
  }

  return attachments;
}

function attachmentrollcount() {
  roll = randomint(80 + 15 + 5);

  if(roll < 50) {
    return 0;
  } else if(roll < 80) {
    return 1;
  } else if(roll < 80 + 15) {
    return 2;
  } else if(roll < 80 + 15 + 5) {
    return 3;
  }

  assertmsg("attachmentRollCount() has a rolled value greater than it's max possible value. Recheck the Weight Rolls");
  return 0;
}

function pullattachmentsforweapon(weaponname) {
  assertex(isDefined(weaponname), "Please pass a defined value for weaponName");
  attachmentslots = scripts\cp_mp\weapon::function_c471a035d22df5eb();
  rootname = getweaponrootname(weaponname);
  weaponassetname = weaponassetnamemap(rootname);

  foreach(attachmentslot in attachmentslots) {
    var_800dfe719bf87a3f = function_75b035199842693d(weaponassetname, attachmentslot);
    return returnarraywithoutdefaults(var_800dfe719bf87a3f, weaponname);
  }
}

function returnarraywithoutdefaults(attachmentarray, weaponname) {
  assertex(isDefined(weaponname), "Please pass a defined value for weaponName");
  assertex(isDefined(attachmentarray), "Please pass a defined value for attachmentArray");
  assertex(attachmentarray.size > 0, "Please pass a NON-EMPTY attachmentArray");

  foreach(struct in level.weaponmapdata) {
    if(weaponname == rootname) {
      if(array_contains(attachmentarray, "doubletap")) {
        attachmentarray = array_remove(attachmentarray, "doubletap");
      }

      if(array_contains(attachmentarray, "reconsilencer_cp")) {
        attachmentarray = array_remove(attachmentarray, "reconsilencer_cp");
      }

      if(isDefined(struct.attachdefaults)) {
        return array_remove_array(attachmentarray, struct.attachdefaults);
      }
    }
  }
}

function eliminatenullweapons(weaponsarray) {
  array = ["iw8_knife", "iw9_me_fists", "iw9_knifestab", "none", "speciality_null", "iw8_ar_dummycp", "iw8_ar_dummycs", "iw8_me_riotshield"];
  newarray = [];

  if(isstruct(random(weaponsarray))) {
    foreach(basename, struct in weaponsarray) {
      if(!array_contains(array, basename)) {
        newarray[basename] = struct;
      }
    }

    return newarray;
  }

  return array_remove_array(weaponsarray, array);
}

function choosepassive() {
  while(true) {
    var_a6af9f073d6e07c2 = random(level.lootpassivesstructs);

    foreach(struct in level.cp_weapon_passives) {
      if(var_a6af9f073d6e07c2.name == passive) {
        return var_a6af9f073d6e07c2;
      }
    }

    waitframe();
  }
}

function grenadeinpullback() {
  return !isnullweapon(self getheldoffhand());
}

function grenadeinitialize(grenade, weapon_object, tickpercent, originalowner) {
  assert(isDefined(self), "grenadeInitialize called on undefined entity");
  assert(isDefined(grenade), "grenadeInitialize called with undefined param: grenade");

  if(!isDefined(grenade.weapon_object)) {
    grenade.weapon_object = weapon_object;
  }

  if(!isDefined(grenade.weapon_name)) {
    grenade.weapon_name = weapon_object.basename;
  }

  if(!isDefined(grenade.owner)) {
    grenade.owner = self;
  }

  if(!isDefined(grenade.team)) {
    grenade.team = self.team;
  }

  if(!isDefined(grenade.tickpercent)) {
    grenade.tickpercent = tickpercent;
  }

  if(!isDefined(grenade.ticks) && isDefined(grenade.tickpercent)) {
    grenade.ticks = roundup(4 * tickpercent);
  }

  equipmentref = scripts\cp_mp\equipment::getequipmentreffromweapon(weapon_object);

  if(isDefined(equipmentref)) {
    grenade.equipmentref = equipmentref;
    grenade.isequipment = 1;
    grenade.bundle = scripts\cp_mp\equipment::getequipmentbundlefromweaponname(grenade.weapon_name);
  }

  grenade.threwback = isDefined(originalowner);
}

function function_f69ed22535d90b78() {
  self endon("death");
  level endon("game_ended");
  stuckdata = spawnStruct();
  childthread function_bdde0931accf955b(stuckdata);
  childthread function_449e67a68fa04968(stuckdata);
  self waittill("missile_impact");
  return stuckdata;
}

function function_bdde0931accf955b(stuckdata) {
  self endon("missile_impact");
  self waittill("missile_stuck", stuckto);

  if(isDefined(stuckto)) {
    stuckdata.stuckto = stuckto;
  }

  self notify("missile_impact");
}

function function_449e67a68fa04968(stuckdata) {
  self endon("missile_impact");
  self waittill("missile_water_impact");
  stuckdata.isunderwater = 1;
  self notify("missile_impact");
}

function function_4af015619e2534ba(stuckto, destroyfunc, isimmediate) {
  level endon("game_ended");
  self endon("death");

  if(isDefined(self.owner)) {
    self.owner endon("disconnect");
  }

  stuckto waittill_any_2("death", "destroy");
  self thread[[destroyfunc]](isimmediate);
}

function updatelastweapon() {
  self endon("disconnect");
  self endon("faux_spawn");
  self.lastnormalweaponobj = ter_op(isDefined(self.spawnweaponobj), self.spawnweaponobj, nullweapon());
  self.lastweaponobj = ter_op(isDefined(self.spawnweaponobj), self.spawnweaponobj, nullweapon());
  self.lastdroppableweaponobj = ter_op(isDefined(self.spawnweaponobj), self.spawnweaponobj, nullweapon());
  self.lastcacweaponobj = ter_op(isDefined(self.spawnweaponobj) && iscacprimaryorsecondary(self.spawnweaponobj), self.spawnweaponobj, nullweapon());

  while(true) {
    self waittill("weapon_change", objnewweapon);
    self.lastweaponobj = objnewweapon;

    if(isnormallastweapon(objnewweapon)) {
      self.lastnormalweaponobj = objnewweapon;
    }

    if(isdroppableweapon(objnewweapon)) {
      self.lastdroppableweaponobj = objnewweapon;
    }

    if(iscacprimaryorsecondary(objnewweapon)) {
      self.lastcacweaponobj = objnewweapon;
    }
  }
}

function isnormallastweapon(objweapon) {
  if(objweapon.basename == "none") {
    return false;
  }

  if(objweapon.classname == "turret") {
    return false;
  }

  if(issuperweapon(objweapon.basename)) {
    return false;
  }

  if(iskillstreakweapon(objweapon.basename)) {
    return false;
  }

  if(objweapon.inventorytype != "primary" && objweapon.inventorytype != "altmode") {
    return false;
  }

  return true;
}

function getweapontype(weapon) {
  if(!isDefined(weapon)) {
    assertmsg("getWeaponType called without a weapon name passed in");
    return;
  }

  if(iscacprimaryweapon(weapon)) {
    return "primary";
  }

  if(iscacsecondaryweapon(weapon)) {
    return "secondary";
  }

  if(iskillstreakweapon(weapon)) {
    return "killstreak";
  }

  if(issuperweapon(weapon)) {
    return "super";
  }

  if(isDefined(level.weaponattachments[weapon])) {
    return "attachment";
  }

  if(weapon == "iw8_turret_50cal_mp") {
    return "turret";
  }

  if(weapon == "rock_mp") {
    return "rock";
  }

  if(string_starts_with(weapon, "destructible_")) {
    return "destructible";
  }

  if(isvehicleweapon(weapon)) {
    return "vehicle";
  }

  if(isspecialmeleeweapon(weapon) || weapon == "iw8_defibrillator_mp") {
    return "special_melee";
  }

  if(isenvironmentweapon(weapon)) {
    return "environment";
  }

  equipmenttype = getequipmenttype(weapon);

  if(isDefined(equipmenttype)) {
    return equipmenttype;
  }

  if(weapon == "none") {
    return "worldspawn";
  }

  if(weapon == "bomb_site_mp") {
    return weapon;
  }

  if(weapon == "iw9_racecar_mp") {
    return weapon;
  }

  if(weapon == "iw8_gunless") {
    return "gunless";
  }

  if(isstring(weapon) && (weapon == "iw8_armor_marker_cp" || weapon == "ks_assault_drone_mp" || weapon == "ks_assault_drone_cp" || weapon == "sonar_pulse_mp" || weapon == "ks_remote_drone_mp" || weapon == "deploy_sentry_mp")) {
    return "super";
  }

  assertmsg("unknown weapon type: " + weapon);
}

function iscacprimaryweapon(weapon) {
  switch (getweapongroup(weapon)) {
    case #"hash_bef5ec0b3e197ae":
    case #"hash_16cf6289ab06bd30":
    case #"hash_47368bc0d2ef1565":
    case #"hash_86b11ac21f992552":
    case #"hash_8af0086b038622b5":
    case #"hash_ab10f9c080fe4faf":
    case #"hash_c095d67337b1f5a1":
    case #"hash_dd616da0b395a0b0":
      return 1;
    default:
      return 0;
  }
}

function isspecialmeleeweapon(weapon) {
  if(ismeleeoverrideweapon(weapon)) {
    return true;
  }

  weapname = undefined;

  if(isweapon(weapon)) {
    if(isnullweapon(weapon)) {
      return false;
    }

    weapname = weapon.basename;
  } else {
    if(weapon == "none") {
      return false;
    }

    weapname = weapon;
  }

  return weapname == "iw9_me_fists_mp_ls";
}

function ismeleeoverrideweapon(weapon) {
  if(isweapon(weapon)) {
    weaponname = weapon.basename;
  } else {
    weaponname = weapon;
  }

  return weaponname == "iw9_knifestab_mp" || weaponname == "iw9_me_climbfists" || weaponname == "iw9_knifestab_mp" || weaponname == "iw8_throwingknife_fire_melee_mp" || weaponname == "iw8_throwingknife_electric_melee_mp";
}

function getweapongroup(weapon) {
  if(!isDefined(weapon)) {
    return "other";
  }

  if(isweapon(weapon) && isnullweapon(weapon)) {
    return "other";
  }

  if(isstring(weapon) && (weapon == "none" || weapon == "alt_none")) {
    return "other";
  }

  rootname = getweaponrootname(weapon);
  group = weapongroupmap(rootname);

  if(!isDefined(group)) {
    if(issuperweapon(weapon)) {
      group = "super";
    } else if(isenvironmentweapon(weapon)) {
      group = "weapon_mg";
    } else if(iskillstreakweapon(weapon)) {
      group = "killstreak";
    } else {
      group = "other";
    }
  }

  return group;
}

function iscacsecondaryweapon(weapon) {
  switch (getweapongroup(weapon)) {
    case #"hash_6f796b5c69cec63":
    case #"hash_34340d457a63e7f1":
    case #"hash_46b22b021532342e":
    case #"hash_9d18adab1b65a661":
    case #"hash_a1f27f97be15d620":
    case #"hash_c9c190665b9c4a1d":
      return 1;
    default:
      return 0;
  }
}

function iscacprimaryorsecondary(weapon) {
  return iscacprimaryweapon(weapon) || iscacsecondaryweapon(weapon);
}

function isdroppableweapon(objweapon) {
  if(objweapon.basename == "none") {
    return false;
  }

  if(isfistweapon(objweapon.basename)) {
    return false;
  }

  if(isDefined(self) && istrue(self.inlaststand)) {
    return false;
  }

  if(iskillstreakweapon(objweapon.basename)) {
    return false;
  }

  if(issuperweapon(objweapon.basename)) {
    return false;
  }

  if(objweapon.inventorytype != "primary") {
    return false;
  }

  if(objweapon.classname == "turret") {
    return false;
  }

  if(!iscacprimaryweapon(objweapon.basename) && !iscacsecondaryweapon(objweapon.basename)) {
    return false;
  }

  return true;
}

function gui_giveattachment() {
  var_effb4ae1788a8b10 = getDvar(@ "hash_c87017f600b49447");

  if(isDefined(var_effb4ae1788a8b10)) {
    foreach(player in level.players) {
      gui_giveattachment_internal(player, var_effb4ae1788a8b10);
    }
  }

  setdevdvar(@ "hash_c87017f600b49447", "<dev string:x15d>");
}

function gui_giveattachment_internal(player, var_effb4ae1788a8b10) {
  newweapon = player.currentweapon;
  player dropitem(newweapon);
  newweapon = newweapon getnoaltweapon();
  var_be36140d4ad4c0b5 = getweaponattachments(newweapon);
  var_a3a475e000c0fa3f = 0;

  if(array_contains(var_be36140d4ad4c0b5, var_effb4ae1788a8b10)) {
    var_a3a475e000c0fa3f = 1;
  } else if(!newweapon canuseattachment(var_effb4ae1788a8b10)) {
    if(!isbot(player)) {
      player iprintlnbold("Invalid attachment for this weapon: " + var_effb4ae1788a8b10);
    }

    var_a3a475e000c0fa3f = 1;
  }

  if(var_a3a475e000c0fa3f) {
    player giveweapon(newweapon);
    return;
  }

  newattachments = var_be36140d4ad4c0b5;
  newattachments[newattachments.size] = var_effb4ae1788a8b10;
  var_98efd9d21da41d1a = getweaponrootname(newweapon.basename);
  var_16d54486f31e87bb = function_29ba39c7e2adb57b(var_98efd9d21da41d1a, newattachments, -1);

  if(isDefined(newweapon.attachments)) {
    foreach(attachment in newweapon.attachments) {
      newweapon = newweapon withoutattachment(attachment);
    }
  }

  foreach(var_b75325027baaf52f in var_16d54486f31e87bb) {
    newweapon = newweapon withattachment(var_b75325027baaf52f);
  }

  attachments = getweaponattachments(newweapon);

  if(attachments.size > 12) {
    player iprintlnbold("Player / Bot already has 12 attachments: " + getcompleteweaponname(newweapon));
    return;
  }

  player giveweapon(newweapon);
  player setweaponammoclip(newweapon, weaponclipsize(newweapon));
  player setweaponammostock(newweapon, scripts\cp\utility::function_ed18a118c6fa5c4f(newweapon));
  player scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate(newweapon);
  scripts\cp_mp\weapon::fixupplayerweapons(player, newweapon);
}

function watchgunsmithdebugui() {
  while(true) {
    level waittill("connected", player);
    player thread watchplayergunsmithdebugui();
  }
}

function watchplayergunsmithdebugui() {
  self endon("disconnect");

  while(true) {
    self waittill("luinotifyserver", message, lootid);

    if(message == "debug_attach_select") {
      ref = scripts\cp_mp\utility\loot::function_793e8a72cedb8ef3(lootid);
      gui_giveattachment_internal(self, ref);
    }
  }
}

function create_weapon_pickups() {
  pickup_structs = getStructArray("weapon_pickup", "targetname");

  for(i = 0; i < pickup_structs.size; i++) {
    toks = strtok(pickup_structs[i].script_noteworthy, "+");
    weapon = toks[0];
    attachments = [];

    if(toks.size > 1) {
      attachments_toks = strtok(toks[1], " ");

      for(j = 0; j < attachments_toks.size; j++) {
        attachments[attachments.size] = attachments_toks[j];
      }
    }

    weapon = spawn_script_weapon(weapon, attachments, pickup_structs[i].origin, pickup_structs[i].angles);
  }
}

function spawn_script_weapon(weapon_name, attachments, spawn_origin, spawn_angles, var_6e9bbc4d48f38065) {
  if(!isDefined(attachments)) {
    attachments = [];
  }

  if(!isarray(attachments)) {
    attachments = [attachments];
  }

  weapon_obj = undefined;

  if(getdvarint(@ "hash_4ca94ec2dbfb6d2f", 0) != 0) {
    weapon_obj = buildweaponwithrandomattachments(weapon_name, attachments);
  } else {
    weapon_obj = buildweapon(weapon_name, attachments, "none", "none", -1, undefined, undefined, undefined, var_6e9bbc4d48f38065);
  }

  name = getcompleteweaponname(weapon_obj);
  weapon = spawn("weapon_" + name, spawn_origin);

  if(isDefined(weapon)) {
    if(is_wave_gametype()) {
      weapon itemweaponsetammo(weaponclipsize(weapon), 0);
    } else {
      weapon itemweaponsetammo(weaponclipsize(weapon), weaponclipsize(weapon));
    }

    weapon.angles = spawn_angles;
    add_to_weapon_array(weapon);
    weapon thread thread_on_notify_no_endon_death("death", &remove_from_weapon_array);
  }

  return weapon;
}

function add_to_weapon_array(weapon) {
  level.dropped_weapons[level.dropped_weapons.size] = weapon;
}

function remove_from_weapon_array(weapon) {
  if(isDefined(weapon)) {
    if(array_contains(level.dropped_weapons, weapon)) {
      level.dropped_weapons = array_remove(level.dropped_weapons, weapon);
    }
  }
}

function smokegrenadeused(isgl) {
  thread notifyafterframeend("death", "end_explode");
  self endon("end_explode");
  thread function_e4f6e856495dbafb();

  if(istrue(isgl)) {
    self waittill("missile_stuck", stuckto, hitent, surfacetype, velocity, position, normal);
    thread smokeglvfx(position);
  } else {
    self waittill("explode", position);
  }

  if(getdvarint(@ "hash_abe45e35ef030a56") == 0) {
    thread create_smoke_occluder(position);
  }

  thread smokegrenadeexplode(position);
  thread sfx_smoke_grenade_smoke(position);

  if(isDefined(self) && isDefined(self.owner)) {
    self.owner thread monitorsmokeactive();
    scripts\cp_mp\challenges::function_b0f754c8a379154e("equip_smoke", self.owner, undefined, function_e2ff8f4b4e94f723(#"hash_83a2d67994d7e295", #"use"));
  }
}

function create_smoke_occluder(origin) {
  if(isDefined(level.bot_smoke_sight_clip_large)) {
    occluder = spawn("script_model", origin);
    occluder show();
    wait 1;
    occluder clonebrushmodeltoscriptmodel(level.bot_smoke_sight_clip_large);
    occluder setmovertransparentvolume();
    wait 8.75;
    occluder delete();
    return;
  }

  occluder = spawn("script_model", origin);
  occluder setModel("ainosight256x256x256");
  occluder show();
  origin = occluder gettagorigin("tag_origin");
  thread draw_line_for_time(origin, origin + (0, 0, 128), 1, 0, 0, 8.75);
  wait 1;
  occluder setmovertransparentvolume();
  wait 8.75;
  occluder delete();
}

function private function_e4f6e856495dbafb() {
  self endon("explode");
  self endon("death");
  self waittill("missile_water_impact", impactdata);
  self notify("end_explode");
  thread function_9e58baa59719d027();
}

function private function_9e58baa59719d027() {
  self endon("explode");
  self endon("death");
  self waittill("missile_stuck", stuckdata);
  position = self.origin;
  thread smokegrenadeexplode(position);
  thread sfx_smoke_grenade_smoke(position);

  if(isDefined(self) && isDefined(self.owner)) {
    self.owner thread monitorsmokeactive();
  }
}

function smokegrenadeexplode(position) {
  level endon("game_ended");
  wait 1;
  thread smokegrenadegiveblindeye(position);

  if(getdvarint(@ "hash_abe45e35ef030a56") == 1) {
    function_8a09c0e5fa78a48c(position);
  }

  id = scripts\cp\cp_outline_utility::addoutlineoccluder(position, 330);
  wait 8.25;
  scripts\cp\cp_outline_utility::removeoutlineoccluder(id);
}

function smokegrenadegiveblindeye(position) {
  level endon("game_ended");
  struct = spawnStruct();
  struct.blindeyerecipients = [];
  smokegrenademonitorblindeyerecipients(struct, position);

  foreach(recipient in struct.blindeyerecipients) {
    if(isDefined(recipient) && scripts\cp\utility\player::isreallyalive(recipient)) {
      recipient scripts\cp\perks::removeperk("specialty_blindeye");
    }
  }
}

function smokegrenademonitorblindeyerecipients(struct, position) {
  level endon("game_ended");
  endtime = gettime() + 8.25 * 1000;
  players = [];

  while(gettime() < endtime) {
    players = getplayersinradius(position, 330);

    foreach(var_6758a6f2fd1b6491, recipient in struct.blindeyerecipients) {
      if(!isDefined(recipient)) {
        struct.blindeyerecipients[var_6758a6f2fd1b6491] = undefined;
        continue;
      }

      playersid = array_find(players, recipient);

      if(!isDefined(playersid) || !scripts\cp\utility\player::isreallyalive(recipient)) {
        recipient scripts\cp\perks::removeperk("specialty_blindeye");
        struct.blindeyerecipients[var_6758a6f2fd1b6491] = undefined;
      }

      if(isDefined(playersid)) {
        players[playersid] = undefined;
      }
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

      player giveperk("specialty_blindeye");

      if(isDefined(self) && isDefined(self.owner)) {}

      struct.blindeyerecipients[player getentitynumber()] = player;
    }

    waitframe();
  }
}

function sfx_smoke_grenade_smoke(position) {
  wait 0.2;
  soundorg = spawn("script_origin", position);
  soundorg playLoopSound("smoke_grenade_smoke_lp");
  soundorg scripts\cp_mp\ent_manager::registerspawncount(1);
  wait 5.25;
  thread play_sound_in_space("smoke_grenade_smoke_tail", position);
  wait 0.3;

  if(isDefined(soundorg)) {
    soundorg stoploopsound();
  }

  soundorg scripts\cp_mp\ent_manager::deregisterspawn();
  soundorg delete();
}

function smokeglvfx(position, normal) {
  playFX(getfx("glsmoke"), position, anglestoup((0, 90, 0)));
}

function monitorsmokeactive() {
  self endon("disconnect");
  level endon("game_ended");
  self notify("monitorSmokeActive()");
  self endon("monitorSmokeActive()");
  printgameaction("smoke grenade activated", self);
  self.hasactivesmokegrenade = 1;
  result = waittill_any_timeout_1(9.25, "death");
  self.hasactivesmokegrenade = 0;
  printgameaction("smoke grenade deactivated", self);
}

function buildweaponwithrandomattachments(rootname, attachments, camo, reticle, variantid, var_d1fd16429ab57618, var_fd85da04b063943, paintjobid, cosmeticattachment, hasnvg, var_341394bbceb99516) {
  basename = getweaponrootname(rootname);

  if((!isDefined(var_341394bbceb99516) || var_341394bbceb99516) && !!isai(self)) {
    return;
  }

  return getweapon(basename, weaponclass(rootname));
}

function getweapon(weaponname, weapontype) {
  weaponarray = [];

  if(isarray(weaponname)) {
    weaponarray = weaponname;
    weaponname = weaponname[randomint(weaponname.size)];
  } else {
    weaponarray = [weaponname];
  }

  if(true) {
    return getweapon_aq(weapontype, weaponname, weaponarray);
  }

  if(issubstr(tolower(self.classname), "_alq_")) {
    return getweapon_aq(weapontype, weaponname, weaponarray);
  } else {
    return buildweapon(weaponname);
  }

  return weaponname;
}

function getweapon_hero(weaponname, weaponarray) {
  if(issubstr(tolower(self.classname), "_hero_alex")) {
    switch (weaponname) {
      case #"hash_fbeff8fdb669137d":
        return make_weapon_special("alex_sniper");
    }
  } else if(issubstr(tolower(self.classname), "_hero_kyle")) {
    switch (weaponname) {
      case #"hash_73c7376a3c1f158c":
        return make_weapon_special("iw9_ar_mcharlie_v2_cp");
    }
  } else if(issubstr(tolower(self.classname), "_hero_price")) {
    switch (weaponname) {
      case #"hash_aa7128e54a430c9":
        return make_weapon_special("iw9_ar_mike4_v1_cp");
    }
  } else if(issubstr(tolower(self.classname), "_hero_farah")) {
    switch (weaponname) {
      case #"hash_a8cf45756fcfd951":
        return make_weapon_special("iw9_ar_akilo_v4_cp");
    }
  } else if(issubstr(tolower(self.classname), "_hero_ghost")) {
    switch (weaponname) {
      case #"hash_b4bf8f1d146067f9":
        return make_weapon_special("iw9_ar_mcbravo_v1_cp");
    }
  } else if(issubstr(tolower(self.classname), "_villain_makarov")) {} else if(issubstr(tolower(self.classname), "_villain_nolan")) {} else if(issubstr(tolower(self.classname), "_villain_resort")) {}

  if(getdvarint(@ "hash_45281f93550798")) {
    iprintln("not whitelisted!skipping scripted build.");
  }

  return make_weapon(weaponname, []);
}

function getweapon_aq(type, weaponname, weaponarray) {
  possibilities = [];
  attachment_combos = [];

  switch (type) {
    case #"hash_8cdaf2e4ecfe5b51":
    case #"hash_fa18d2f6bd57925a":
      break;
    case #"hash_f4b0076c03d93738":
      break;
    case #"hash_9196025f8ae8e51e":
      return "iw8_lm_dblmg";
    case #"hash_ba39cac9c099d4f1":
      return "iw8_la_rpapa7";
    case #"hash_2f2d546c2247838f":
      break;
    case #"hash_719417cb1de832b6":
      break;
    case #"hash_23209741b93850b5":
      break;
    case #"hash_900cb96c552c5e8e":
      break;
    case #"hash_6191aaef9f922f96":
      break;
  }

  return randomize_weapon(weaponname, possibilities, attachment_combos);
}

function make_weapon_special(weapon) {
  assertex(isDefined(weapon), "Must specify a string/weapon");
  var_21d502659c8814 = [];
  weap_attach = [];
  var_d9706f4f3cf9777f = [];

  switch (weapon) {
    case #"hash_c1fc89a8ac555a73":
      var_21d502659c8814 = ["rec_mcbravo", "bar_ar_light_p08", "grip_vertshort03", "lasercyl_ads01", "mag_ar_heavy_p08", "reflex07_tall", "stock_ar_tactical_p08_mcbravo"];
      var_d9706f4f3cf9777f = [1, 1, 1, 2, 1, 0, 2];
      weapon = scripts\cp_mp\weapon::buildweapon("iw9_ar_mcbravo_mp", var_21d502659c8814, undefined, undefined, undefined, var_d9706f4f3cf9777f);
      break;
    case #"hash_bbb27740720fed58":
      var_21d502659c8814 = ["bar_ar_hvyshort_p04_akilo", "mag_ar_p04_akilo", "pgrip_aim_p04", "rec_akilo", "reflex03_tall", "stock_ar_light_p04_akilo"];
      var_d9706f4f3cf9777f = [1, 1, 1, 1, 1, 1];
      weapon = scripts\cp_mp\weapon::buildweapon("iw9_ar_akilo_mp", var_21d502659c8814, undefined, undefined, undefined, var_d9706f4f3cf9777f);
      break;
    case #"hash_b99458d5c4578fd":
      var_21d502659c8814 = ["bar_ar_short_p01_mike4", "grip_vert02", "iw9_rec_mike4", "laserbox_ads01", "mag_ar_p01", "pgrip_p01", "reflex02_tall", "silencer07_ar", "stock_ar_p01_mike4"];
      var_d9706f4f3cf9777f = [2, 1, 1, 1, 1, 2, 2, 1, 4];
      weapon = scripts\cp_mp\weapon::buildweapon("iw9_ar_mike4_mp", var_21d502659c8814, undefined, undefined, undefined, var_d9706f4f3cf9777f);
      break;
    case #"hash_71e1f4484078683e":
      var_21d502659c8814 = ["arscope_vz02", "bar_dm_p18_mike14", "grip_vertshort03", "iw9_rec_mike14", "mag_sn_large_p18", "pgrip_dm_p18", "stock_dm_light_p18_mike14"];
      var_d9706f4f3cf9777f = [1, 1, 2, 1, 1, 1, 1];
      weapon = scripts\cp_mp\weapon::buildweapon("iw9_dm_mike14_mp", var_21d502659c8814, undefined, undefined, undefined, var_d9706f4f3cf9777f);
      break;
    case #"hash_61884231066b896a":
      var_21d502659c8814 = ["bar_sn_light_p20_xmike2010", "bipod01", "bolt_p20", "mike24_scope", "pgrip_p20_xmike2010", "rec_xmike2010", "stock_sn_heavy_p20"];
      var_d9706f4f3cf9777f = [1, 3, 1, 1, 1, 1, 1];
      weapon = scripts\cp_mp\weapon::buildweapon("iw9_dm_xmike2010_mp", var_21d502659c8814, undefined, undefined, undefined, var_d9706f4f3cf9777f);
      break;
    case #"hash_d4a3fd9a177df455":
      var_21d502659c8814 = ["bar_ar_short_p08", "grip_angled01", "holo01", "iw9_rec_mcharlie", "mag_ar_p08", "pgrip_ar_p08", "stock_sm_p08_mcharlie"];
      var_d9706f4f3cf9777f = [1, 1, 0, 1, 1, 1, 1];
      weapon = scripts\cp_mp\weapon::buildweapon("iw9_ar_mcharlie_mp", var_21d502659c8814, undefined, undefined, undefined, var_d9706f4f3cf9777f);
      break;
    default:
      println("<dev string:x17d>" + weapon + "<dev string:x186>");
      weapon = undefined;
      break;
  }

  return weapon;
}

function make_weapon(basename, attachments, reticle, camo, lootid, alt_mode) {
  if(!isDefined(level._weapons)) {
    level._weapons = spawnStruct();
  }

  if(!isDefined(attachments)) {
    attachments = [];
  }

  if(!isweapon(basename)) {
    tok = strtok(basename, "+");

    if(tok.size > 1) {
      basename = tok[0];
      attachments = array_combine(attachments, array_remove(tok, tok[0]));
    }
  } else {
    if(isnullweapon(basename)) {
      return basename;
    }

    basename = getweaponbasename(basename);
  }

  if(istrue(alt_mode)) {
    var_8b5443598fc587bf = &makealtweapon;
  } else {
    var_8b5443598fc587bf = &makeweapon;
  }

  rootname = basename;

  if(issubstr(basename, "_mp")) {
    rootname = getweaponrootname(basename);
  }

  defaults = scripts\cp_mp\weapon::getweaponattachmentdefaultattachments(basename);
  defaults = utility::removeconflictingattachments(attachments, defaults, rootname);
  attachments = array_combine(attachments, defaults);
  weaponassetname = weaponassetnamemap(rootname, lootid);
  attachment_variants = [];

  foreach(attachment in attachments) {
    if(issubstr(attachment, "|")) {
      attachments = array_remove(attachments, attachment);
      attachments[attachments.size] = strtok(attachment, "|")[0];
      attachment_variants[attachment_variants.size] = attachment;
    }
  }

  var_5b3be55212a58ff = function_29ba39c7e2adb57b(rootname, attachments, lootid);
  var_5b3be55212a58ff = checkforinvalidattachments(var_5b3be55212a58ff, weaponassetname);
  attachments = var_5b3be55212a58ff;

  if(isDefined(lootid)) {
    weapon = builtin[[var_8b5443598fc587bf]](weaponassetname, attachments, reticle, camo, lootid);
  } else if(isDefined(camo)) {
    weapon = builtin[[var_8b5443598fc587bf]](weaponassetname, attachments, reticle, camo);
  } else if(isDefined(reticle)) {
    weapon = builtin[[var_8b5443598fc587bf]](weaponassetname, attachments, reticle);
  } else if(isDefined(attachments)) {
    weapon = builtin[[var_8b5443598fc587bf]](weaponassetname, attachments);
  } else {
    weapon = builtin[[var_8b5443598fc587bf]](weaponassetname);
  }

  foreach(attachment in attachment_variants) {
    tok = strtok(attachment, "|");
    weapon = weapon withattachment(tok[0], int(tok[1]));
  }

  return weapon;
}

function randomize_weapon(weaponname, possibilities, attachment_combos) {
  attachments = utility::get_random_attachments(possibilities, attachment_combos);
  weapon = make_weapon(weaponname, attachments);

  if(getdvarint(@ "hash_45281f93550798")) {
    if(!isDefined(weapon)) {
      complete_weapon = weaponname;

      foreach(attachment in attachments) {
        complete_weapon += "<dev string:x196>" + attachment;
      }

      iprintlnbold(complete_weapon + "<dev string:x198>");
      return [[level.fnbuildweapon]](weaponname);
    }

    var_84dc1762e26a54bb = undefined;
    attachment_models = getweaponattachmentworldmodels(weapon);

    foreach(attachment_model in attachment_models) {
      part_num = getnumparts(attachment_model);

      for(i = 0; i < part_num; i++) {
        if(getpartname(attachment_model, i) == "<dev string:x1a9>") {
          var_84dc1762e26a54bb = 1;
          break;
        }
      }
    }

    if(!isDefined(var_84dc1762e26a54bb) && !issubstr(weaponname, "<dev string:x1b2>") && !issubstr(weaponname, "<dev string:x1b7>") && !issubstr(weaponname, "<dev string:x1bc>")) {
      iprintlnbold(getcompleteweaponname(weapon) + "<dev string:x1c1>");
    }

    var_a1b938aeb3589f83 = 1;

    foreach(possibility in possibilities) {
      probability_100 = 0;

      if(isint(possibility[0]) && possibility[0] == 100) {
        probability_100 = -1;
      }

      var_a1b938aeb3589f83 *= possibility.size + probability_100;
    }

    println("<dev string:x1d9>" + weaponname + "<dev string:x1e5>" + var_a1b938aeb3589f83);
  }

  return weapon;
}

function getscriptedweapon(weaponname, weaponposition) {
  setdvarifuninitialized(@ "hash_45281f93550798", 0);

  if(!isDefined(weaponname)) {
    return nullweapon();
  }

  if(!isarray(weaponname) && weaponname == "") {
    return nullweapon();
  }

  if(isDefined(weaponposition) && weaponposition == "sidearm") {
    weapon = getweapon(weaponname, "pistol");
  } else {
    weapon = getweapon(weaponname, self.scriptedweaponclassprimary);
  }

  if(getdvarint(@ "hash_45281f93550798")) {
    if(!isstring(weapon)) {
      thread printweapon();
    }
  }

  return weapon;
}

function printweapon() {
  self notify("stop printWeapon");
  self endon("death");
  self endon("stop printWeapon");

  for(;;) {
    start_height = 72;

    if(isDefined(self) && isDefined(self.weapon)) {
      print3d(self.origin + (0, 0, 0), self.classname, (1, 1, 1), 1, 0.1, 1, 1);

      if(isDefined(self.weapon.basename)) {
        print3d(self.origin + (0, 0, start_height), self.weapon.basename, (1, 0, 0), 1, 0.15, 1);
      }

      if(isDefined(self.weapon.attachments)) {
        attach_height = start_height - 1.5;

        foreach(attachment in self.weapon.attachments) {
          print3d(self.origin + (0, 0, attach_height), "<dev string:x1f5>" + attachment, (1, 1, 1), 1, 0.1, 1);

          attach_height -= 1.4;
        }
      }
    }

    waitframe();
  }
}

function monitordisownedgrenade(player, grenade) {
  level endon("game_ended");
  grenade endon("death");
  grenade endon("mine_planted");
  player waittill_any_3("joined_team", "joined_spectators", "disconnect");

  if(isDefined(grenade)) {
    grenade delete();
  }
}

function riotshield_getmodel() {
  weaponlist = self getweaponslistprimaries();

  foreach(weapon in weaponlist) {
    switch (weapon.basename) {
      case #"hash_decd8473cdd1b5a9":
        return "weapon_wm_riotshield_p34";
      case #"hash_c8526723dbf948fb":
        return "weapon_wm_riotshield_v7";
      case #"hash_c8526623dbf94768":
        return "weapon_wm_riotshield_v6";
      case #"hash_c8526923dbf94c21":
        return "weapon_wm_riotshield_v5";
      case #"hash_c8526823dbf94a8e":
        return "weapon_wm_riotshield_v4";
      case #"hash_c8526b23dbf94f47":
        return "weapon_wm_riotshield_v3";
      case #"hash_c8526a23dbf94db4":
        return "weapon_wm_riotshield_v2";
      case #"hash_f8aa17c22c36cdcc":
        return "weapon_wm_riotshield";
    }
  }
}

function setignoreriotshieldxp() {
  self.ignoreriotshieldxp = 1;
}

function clearignoreriotshieldxp() {
  self.ignoreriotshieldxp = undefined;
}

function ispickedupweapon(weapon) {
  if(iscacprimaryweapon(weapon) || iscacsecondaryweapon(weapon)) {
    weapname = undefined;

    if(isweapon(weapon)) {
      weapname = getcompleteweaponname(weapon getnoaltweapon());
    } else if(isstring(weapon)) {
      weapname = weapon;

      if(issubstr(weapname, "alt_")) {
        weapname = getsubstr(weapname, 4, weapon.size);
      }
    }

    var_d721c63a9570d5c = isDefined(self.pers["primaryWeapon"]) && self.pers["primaryWeapon"] == weapname;
    var_7df1c1394810bf14 = isDefined(self.pers["secondaryWeapon"]) && self.pers["secondaryWeapon"] == weapname;

    if(!var_d721c63a9570d5c && !var_7df1c1394810bf14) {
      return true;
    }
  }

  return false;
}

function isvehicleweapon(weapon) {
  weaponname = undefined;

  if(isweapon(weapon)) {
    weaponname = weapon.basename;
  } else {
    weaponname = weapon;
  }

  switch (weaponname) {
    case #"hash_79ee9dd492804fa":
    case #"hash_996455d7b14b362":
    case #"hash_12a2863ecf2eeecd":
    case #"hash_1ba6982534c8d1d6":
    case #"hash_1cb3f2dbe85b8540":
    case #"hash_20305144649233ed":
    case #"hash_254b6e155434f84d":
    case #"hash_259ae6e25d936c3e":
    case #"hash_25fc06d658620968":
    case #"hash_2f1a9d8e2f127205":
    case #"hash_3226ebed78234b14":
    case #"hash_33aef56fb95396fd":
    case #"hash_359ac460bda5f9b8":
    case #"hash_3eff7af9e42baade":
    case #"hash_3f2944fd91792508":
    case #"hash_471c36daeb2a655a":
    case #"hash_4e213f6d3f76b400":
    case #"hash_4fd5d83c1a7f06a7":
    case #"hash_51f4f5345b01f136":
    case #"hash_62a9688b69906271":
    case #"hash_6ac8f418ee829465":
    case #"hash_708fb6e22f87a3a4":
    case #"hash_73b4956c8f4b5217":
    case #"hash_806bdb595fd497d7":
    case #"hash_82a5b9368f3f35ae":
    case #"hash_85af56f5faab2a04":
    case #"hash_892911bfe6164871":
    case #"hash_8d7aa4b158a0e9a9":
    case #"hash_9386cafe3d8d6d59":
    case #"hash_9a70af630b5b1849":
    case #"hash_a0bfc30978e56904":
    case #"hash_a622e958420b92a0":
    case #"hash_a9e5050965551dca":
    case #"hash_acaf314732f4c8e4":
    case #"hash_aef479d2af969a2d":
    case #"hash_af540b603005b109":
    case #"hash_b1d4d0d68c2b0c0f":
    case #"hash_bac656916e53b91c":
    case #"hash_badacfdae124cc01":
    case #"hash_bb463b7f255eafce":
    case #"hash_be853f8547df0df3":
    case #"hash_cd6b1f03c24c25ff":
    case #"hash_cf8515f17748a7d2":
    case #"hash_d1ffad9819388638":
    case #"hash_d30fa952a74e1642":
    case #"hash_d4532f8e0fa86548":
    case #"hash_d6d8360ddf1f4d6b":
    case #"hash_d7f368cf53337cfd":
    case #"hash_e9ee40174ddfa406":
    case #"hash_ec580a77ee20c7bd":
    case #"hash_edf51f8e5118b630":
    case #"hash_f003a3dc14dbdf3f":
    case #"hash_f1450013ec0ad0d5":
    case #"hash_f816d2efb1dcbed0":
    case #"hash_fbca161190fca27d":
    case #"hash_fc4c0a8ee31549bb":
    case #"hash_fd79e0693da4a728":
    case #"hash_fd9c279f85990dad":
      return 1;
    default:
      return 0;
  }
}

function attachmentlogsstats(var_e3f6cca91074060e, weapon) {
  if(attachmentiscosmetic(var_e3f6cca91074060e)) {
    return false;
  }

  if(!attachmentisselectable(weapon, var_e3f6cca91074060e)) {
    return false;
  }

  if(string_starts_with(var_e3f6cca91074060e, "laststand_")) {
    return false;
  }

  return true;
}

function attachmentisselectable(weaponobj, attachment) {
  rootname = getweaponrootname(weaponobj);
  return scripts\cp\cp_loadout::attachmentisselectablerootname(rootname, attachment);
}

function mapweapon(objweapon, inflictor, var_a2c7a399ae430eb) {
  var_eef5ad438e5fa0c2 = objweapon;

  if(!isDefined(objweapon)) {
    var_eef5ad438e5fa0c2 = makeweapon("none");
  }

  var_ea958bd2fa62a2fa = 0;

  if(var_eef5ad438e5fa0c2.basename != "none") {
    switch (var_eef5ad438e5fa0c2.basename) {
      case #"hash_b833f98278746f9b":
        var_eef5ad438e5fa0c2 = makeweapon("pop_rocket_mp");
        break;
      case #"hash_9a3452323e288ff3":
      case #"hash_c05ea160f6d9bb25":
        var_eef5ad438e5fa0c2 = makeweapon("iw8_turret_50cal_mp");
        break;
      case #"hash_5f2ad7140f378ee1":
        var_eef5ad438e5fa0c2 = makeweapon("none");
        break;
    }
  } else if(isDefined(inflictor)) {
    if(isDefined(inflictor.objweapon)) {
      var_eef5ad438e5fa0c2 = makeweapon(inflictor.objweapon.basename);
      var_ea958bd2fa62a2fa = 1;
    } else if(isDefined(inflictor.weapon_name)) {
      var_eef5ad438e5fa0c2 = makeweapon(inflictor.weapon_name);
      var_ea958bd2fa62a2fa = 1;
    }
  }

  if(var_ea958bd2fa62a2fa && !istrue(var_a2c7a399ae430eb)) {
    var_eef5ad438e5fa0c2 = mapweapon(var_eef5ad438e5fa0c2, inflictor, 1);
  }

  return var_eef5ad438e5fa0c2;
}

function makeexplosiveunusuabletag() {
  self notify("makeExplosiveUnusable");
  self makeunusable();
}

function attachmentsfilterforstats(attachments, weapon) {
  filtered = [];

  if(isDefined(attachments) && isarray(attachments)) {
    foreach(a in attachments) {
      if(attachmentlogsstats(a, weapon)) {
        filtered[filtered.size] = a;
      }
    }
  }

  return filtered;
}

function function_2f4d1cda9bc48e6a(weaponobj) {
  var_6e92bbbc0d0d8c94 = 0;
  currentweapon = weaponobj;
  newweapon = undefined;
  var_59f6b815c04d4e52 = function_dde0cce873a8c5a2(getcompleteweaponname(currentweapon), "silencer")[0];

  for(j = 0; j < currentweapon.attachments.size; j++) {
    if(isDefined(var_59f6b815c04d4e52) && weaponobj canuseattachment(var_59f6b815c04d4e52) && scripts\cp_mp\weapon::attachmentsconflict(currentweapon.attachments[j], var_59f6b815c04d4e52, weaponobj) == "") {
      var_6e92bbbc0d0d8c94 = 1;
      continue;
    }

    var_6e92bbbc0d0d8c94 = 0;
    break;
  }

  if(var_6e92bbbc0d0d8c94) {
    newweapon = weaponobj withattachment(var_59f6b815c04d4e52);
  }

  if(!isDefined(newweapon)) {
    return weaponobj;
  }

  return newweapon;
}

function add_attachment(attachment) {
  can_equip = 0;
  currentweapon = self;
  newweaponobj = undefined;

  if(self canuseattachment(attachment)) {
    can_equip = 1;

    for(i = 0; i < currentweapon.attachments.size; i++) {
      if(scripts\cp_mp\weapon::attachmentsconflict(currentweapon.attachments[i], attachment, self) != "") {
        newweaponobj = self withoutattachment(currentweapon.attachments[i]);
      }
    }

    newweaponobj = self withattachment(attachment);
  }

  if(!isDefined(newweaponobj)) {
    return self;
  }

  return newweaponobj;
}

function function_2d291cfd98fd0d8e() {
  level endon("game_ended");
  level.var_bcd25cd23011249 = [];

  if(getdvarint(@ "hash_e6afce2cf5cf7515", 0)) {
    return;
  }

  if(getdvarint(@ "hash_742caa13b3c2e685", 0)) {
    return;
  }

  thread function_a5ad598dd7668b55();

  keys = getarraykeys(level.weapongroupdata);

  for(i = 0; i < keys.size; i++) {
    for(j = 0; j < level.weapongroupdata[keys[i]].size; j++) {
      function_41f42cde8798905f(level.weapongroupdata[keys[i]][j] + "_mp", keys[i]);
    }
  }

  function_41f42cde8798905f("iw9_ar_golf3_mp", undefined, 1);
  function_41f42cde8798905f("iw9_ar_kilo53_mp", undefined, 1);
  function_41f42cde8798905f("iw9_ar_mike4_mp", undefined, 1);
  function_41f42cde8798905f("iw9_ar_mike16_mp", undefined, 1);
  function_41f42cde8798905f("iw9_ar_akilo_mp", undefined, 1);
  function_41f42cde8798905f("iw9_ar_akilo105_mp", undefined, 1);
  function_41f42cde8798905f("iw9_ar_akilo74_mp", undefined, 1);
  function_41f42cde8798905f("iw9_ar_schotel_mp", undefined, 1);
  function_41f42cde8798905f("iw9_ar_augolf_mp", undefined, 1);
  function_41f42cde8798905f("iw9_ar_mcharlie_mp", undefined, 1);
  function_41f42cde8798905f("iw9_ar_scharlie_mp", undefined, 1);
  function_41f42cde8798905f("iw9_ar_mcbravo_mp", undefined, 1);
  function_41f42cde8798905f("iw9_br_msecho_mp", undefined, 1);
  function_41f42cde8798905f("iw9_br_soscar14_mp", undefined, 1);
  function_41f42cde8798905f("iw9_sm_aviktor_mp", undefined, 1);
  function_41f42cde8798905f("iw9_sm_alpha57_mp", undefined, 1);
  function_41f42cde8798905f("iw9_sm_mpapa5_mp", undefined, 1);
  function_41f42cde8798905f("iw9_sm_mpapa7_mp", undefined, 1);
  function_41f42cde8798905f("iw9_sm_beta_mp", undefined, 1);
  function_41f42cde8798905f("iw9_sm_victor_mp", undefined, 1);
  function_41f42cde8798905f("iw9_sm_apapa_mp", undefined, 1);
  function_41f42cde8798905f("iw9_sm_papa90_mp", undefined, 1);
  function_41f42cde8798905f("iw9_pi_decho_mp", undefined, 1);
  function_41f42cde8798905f("iw9_pi_papa220_mp", undefined, 1);
  function_41f42cde8798905f("iw9_pi_golf17_mp", undefined, 1);
  function_41f42cde8798905f("iw9_pi_golf18_mp", undefined, 1);
  function_41f42cde8798905f("iw9_sn_mromeo_mp", undefined, 1);
  function_41f42cde8798905f("iw9_sn_limax_mp", undefined, 1);
  function_41f42cde8798905f("iw9_sn_india_mp", undefined, 1);
  function_41f42cde8798905f("iw9_lm_kilo21_mp", undefined, 1);
  function_41f42cde8798905f("iw9_lm_slima_mp", undefined, 1);
  function_41f42cde8798905f("iw9_lm_foxtrot_mp", undefined, 1);
  function_41f42cde8798905f("iw9_lm_rkilo_mp", undefined, 1);
  function_41f42cde8798905f("iw9_lm_ahotel_mp", undefined, 1);
  function_41f42cde8798905f("iw9_lm_ngolf7_mp", undefined, 1);
  function_41f42cde8798905f("iw9_sh_mbravo_mp", undefined, 1);
  function_41f42cde8798905f("iw9_sh_charlie725_mp", undefined, 1);
  function_41f42cde8798905f("iw9_sh_mike1014_mp", undefined, 1);
  function_41f42cde8798905f("iw9_sh_mviktor_mp", undefined, 1);
  function_41f42cde8798905f("iw9_dm_mike24_mp", undefined, 1);
  function_41f42cde8798905f("iw9_dm_sa700_mp", undefined, 1);
  function_41f42cde8798905f("iw9_dm_la700_mp", undefined, 1);
  function_41f42cde8798905f("iw9_dm_pgolf1_mp", undefined, 1);
  function_41f42cde8798905f("iw9_dm_xmike2010_mp", undefined, 1);
  function_41f42cde8798905f("iw9_dm_sbeta_mp", undefined, 1);
  function_41f42cde8798905f("iw9_dm_mike14_mp", undefined, 1);
  function_41f42cde8798905f("iw9_dm_scromeo_mp", undefined, 1);
  function_41f42cde8798905f("iw9_la_rpapa7_mp", undefined, 1);
  function_41f42cde8798905f("iw9_la_juliet_mp", undefined, 1);
  function_41f42cde8798905f("iw9_la_mike32_mp", undefined, 1);
  function_41f42cde8798905f("iw9_la_gromeo_mp", undefined, 1);
  function_41f42cde8798905f("iw9_la_kgolf_mp", undefined, 1);
  function_41f42cde8798905f("iw9_pi_stimpistol_mp", undefined, 1);
  level.var_bcd25cd23011249["akilo"] = level.var_bcd25cd23011249["iw9_ar_akilo_mp"];
  level.var_bcd25cd23011249["mike4"] = level.var_bcd25cd23011249["iw9_ar_mike4_mp"];
  level.var_bcd25cd23011249["akilo105"] = level.var_bcd25cd23011249["iw9_ar_akilo105_mp"];
  level.var_bcd25cd23011249["akilo74"] = level.var_bcd25cd23011249["iw9_ar_akilo74_mp"];
  level.var_bcd25cd23011249["augolf"] = level.var_bcd25cd23011249["iw9_ar_augolf_mp"];
  level.var_bcd25cd23011249["kilo53"] = level.var_bcd25cd23011249["iw9_ar_kilo53_mp"];
  level.var_bcd25cd23011249["scharlie"] = level.var_bcd25cd23011249["iw9_ar_scharlie_mp"];
  level.var_bcd25cd23011249["mcharlie"] = level.var_bcd25cd23011249["iw9_ar_mcharlie_mp"];
  level.var_bcd25cd23011249["schotel"] = level.var_bcd25cd23011249["iw9_ar_schotel_mp"];
  level.var_bcd25cd23011249["decho"] = level.var_bcd25cd23011249["iw9_pi_decho_mp"];
  level.var_bcd25cd23011249["golf17"] = level.var_bcd25cd23011249["iw9_pi_golf17_mp"];
  level.var_bcd25cd23011249["golf18"] = level.var_bcd25cd23011249["iw9_pi_golf18_mp"];
  level.var_bcd25cd23011249["papa220"] = level.var_bcd25cd23011249["iw9_pi_papa220_mp"];
  level.var_bcd25cd23011249["aviktor"] = level.var_bcd25cd23011249["iw9_sm_aviktor_mp"];
  level.var_bcd25cd23011249["beta"] = level.var_bcd25cd23011249["iw9_sm_beta_mp"];
  level.var_bcd25cd23011249["mpapa5"] = level.var_bcd25cd23011249["iw9_sm_mpapa5_mp"];
  level.var_bcd25cd23011249["mpapa7"] = level.var_bcd25cd23011249["iw9_sm_mpapa7_mp"];
  level.var_bcd25cd23011249["victor"] = level.var_bcd25cd23011249["iw9_sm_victor_mp"];
  level.var_bcd25cd23011249["alpha57"] = level.var_bcd25cd23011249["iw9_sm_alpha57_mp"];
  level.var_bcd25cd23011249["charlie725"] = level.var_bcd25cd23011249["iw9_sh_charlie725_mp"];
  level.var_bcd25cd23011249["mbravo"] = level.var_bcd25cd23011249["iw9_sh_mbravo_mp"];
  level.var_bcd25cd23011249["mike1014"] = level.var_bcd25cd23011249["iw9_sh_mike1014_mp"];
  level.var_bcd25cd23011249["kilo21"] = level.var_bcd25cd23011249["iw9_lm_kilo21_mp"];
  level.var_bcd25cd23011249["slima"] = level.var_bcd25cd23011249["iw9_lm_slima_mp"];
  level.var_bcd25cd23011249["ngolf7"] = level.var_bcd25cd23011249["iw9_lm_ngolf7_mp"];
  level.var_bcd25cd23011249["la700"] = level.var_bcd25cd23011249["iw9_dm_la700_mp"];
  level.var_bcd25cd23011249["mike24"] = level.var_bcd25cd23011249["iw9_dm_mike24_mp"];
  level.var_bcd25cd23011249["mike14"] = level.var_bcd25cd23011249["iw9_dm_mike14_mp"];
  level.var_bcd25cd23011249["pgolf1"] = level.var_bcd25cd23011249["iw9_dm_pgolf1_mp"];
  level.var_bcd25cd23011249["sa700"] = level.var_bcd25cd23011249["iw9_dm_sa700_mp"];
  level.var_bcd25cd23011249["sbeta"] = level.var_bcd25cd23011249["iw9_dm_sbeta_mp"];
  level.var_bcd25cd23011249["xmike2010"] = level.var_bcd25cd23011249["iw9_dm_xmike2010_mp"];
  level.var_bcd25cd23011249["alpha50"] = level.var_bcd25cd23011249["iw9_sn_alpha50_mp"];
  level.var_bcd25cd23011249["limax"] = level.var_bcd25cd23011249["iw9_sn_limax_mp"];
  level.var_bcd25cd23011249["india"] = level.var_bcd25cd23011249["iw9_sn_india_mp"];
  level.var_bcd25cd23011249["mromeo"] = level.var_bcd25cd23011249["iw9_sn_mromeo_mp"];
  level.var_bcd25cd23011249["rpapa7"] = level.var_bcd25cd23011249["iw9_la_rpapa7_mp"];
  level.var_bcd25cd23011249["kgolf"] = level.var_bcd25cd23011249["iw9_la_kgolf_mp"];
  level.var_bcd25cd23011249["gromeo"] = level.var_bcd25cd23011249["iw9_la_gromeo_mp"];
  level.var_bcd25cd23011249["mike32"] = level.var_bcd25cd23011249["iw9_la_mike32_mp"];
  level.var_bcd25cd23011249["knife"] = makeweaponfromstring("iw9_me_knife_mp+iw9_me_knife");
  level.var_bcd25cd23011249["super_stimpistol"] = makeweaponfromstring("iw9_pi_stimpistol_mp");
  level.var_bcd25cd23011249["fists"] = makeweaponfromstring("iw9_me_fists_mp");

  if(getdvarint(@ "hash_7e7d59df2e5dc031", 0)) {
    println("<dev string:x1f9>");
    keys = getarraykeys(level.var_bcd25cd23011249);

    for(i = 0; i < keys.size; i++) {
      println(keys[i] + "<dev string:x240>" + getcompleteweaponname(level.var_bcd25cd23011249[keys[i]]) + "<dev string:x245>");
    }

    println("<dev string:x1f9>");
  }
}

function function_6c30de47f7befbac() {
  level endon("game_ended");
  flag_wait("level_ready_for_script");
  level.var_bd8c1f8f6677e0ef = getStructArray("perm_wall_weapon", "targetname");
  flag_wait("default_weapons_created");
  keys = getarraykeys(level.var_bcd25cd23011249);

  for(i = 0; i < level.var_bd8c1f8f6677e0ef.size; i++) {}
}

function function_7544739099d55631() {}

function function_41f42cde8798905f(weapon_string, weapon_class, var_22c173e9283d2e0d, var_7064974a67473784) {
  starting_string = weapon_string;
  objweapon = scripts\cp_mp\utility\weapon_utility::function_eeaa22f0cd1ff845(weapon_string);

  if(!istrue(var_7064974a67473784)) {
    objweapon = objweapon scripts\cp\weapon::function_dcb52bcbbcb80b00("silencer");
  }

  if(!isDefined(weapon_class)) {
    weapon_class = "No Class Assigned";
  }

  if(weapon_class == "weapon_pistol") {
    weaponobj = objweapon scripts\cp\weapon::function_dcb52bcbbcb80b00("pgrip_tac");
  }

  level.var_bcd25cd23011249[starting_string] = objweapon;

  if(istrue(var_22c173e9283d2e0d)) {
    return;
  }

  thread function_8cffc9416e0ab766(starting_string, weapon_class);
  path = weapon_class + "/" + starting_string + "/Default";
  cmd = "devgui_cmd \"CP Debug:2 / Weapons /" + path + "\" \"set scr_debug debugGiveWeapon_+" + starting_string + "\" \n";
  addentrytodevgui(cmd);
}

function function_a5ad598dd7668b55() {
  level endon("game_ended");

  if(!getdvarint(@ "hash_cdff493fb526772c", 0)) {
    return;
  }

  flag_wait("level_ready_for_script");

  if(!isDefined(level.var_6e48aedc6bc2557f)) {
    level.var_6e48aedc6bc2557f = getStructArray("perm_wall_weapon", "targetname");
  }

  struct_array = level.var_6e48aedc6bc2557f;
  keys = getarraykeys(level.var_bcd25cd23011249);

  for(i = 0; i < struct_array.size; i++) {
    struct = struct_array[i];
    weaponobj = level.var_bcd25cd23011249[keys[i]];
    weapon = scripts\cp\pickups::createspawnweaponatpos(struct.origin + (5, 0, 0), (0, -90, -90), weaponobj, 1);

    if(isDefined(weapon)) {
      weapon scripts\cp\pickups::function_86321fc8f45c2a9b(1);
      weapon scripts\cp\pickups::function_b10ee40ed82d45c9(1);
      continue;
    }

    if(isDefined(weaponobj)) {
      test = 1;
    }
  }
}

function function_8cffc9416e0ab766(default_weapon, weapon_class) {
  weaponroot = getweaponrootname(default_weapon);
  index = 0;
  weaponvariantkey = weaponroot + "|" + index;
  exclude_list = [];
  exclude_list["iw9_lm_mkilo3"] = [2];
  exclude_list["iw9_ar_akilo"] = [2];
  exclude_list["iw9_pi_papa220"] = [2];

  for(variant_found = 1; variant_found; variant_found = 0) {
    waitframe();

    if(isDefined(level.weaponlootmapdata[weaponvariantkey])) {
      var_6eeaeb3717f8724c = 0;

      if(isDefined(exclude_list[weaponroot])) {
        for(i = 0; i < exclude_list[weaponroot].size; i++) {
          if(exclude_list[weaponroot][i] == index) {
            var_6eeaeb3717f8724c = 1;
            break;
          }
        }
      }

      if(var_6eeaeb3717f8724c) {
        index++;
        weaponvariantkey = weaponroot + "|" + index;
        continue;
      }

      weaponobj = scripts\cp_mp\weapon::buildweapon_blueprint(weaponroot, "none", "none", index, undefined, undefined, 1);

      if(!isDefined(weaponobj)) {
        println("<dev string:x248>" + weaponroot + "<dev string:x258>" + index + "<dev string:x261>");
      }

      level.var_bcd25cd23011249[default_weapon + "|" + index] = weaponobj;
      path = weapon_class + "/" + default_weapon + "/Variants/" + index;
      cmd = "devgui_cmd \"CP Debug:2 / Weapons /" + path + "\" \"set scr_debug debugGiveWeapon_+" + default_weapon + "|" + index + "\" \n";
      addentrytodevgui(cmd);
      index++;
      weaponvariantkey = weaponroot + "|" + index;
      continue;
    }
  }
}

function function_f123cc18b09056d1(weapon) {
  silencers = [];
  attachments = function_75b035199842693d(weapon, "frontpiece");

  for(i = 0; i < attachments.size; i++) {
    if(scripts\cp_mp\weapon::issilencerattach(weapon, attachments[i])) {
      silencers[silencers.size] = attachments[i];
    }
  }

  return silencers;
}

function function_b65ad646eb126204(weapon_key) {
  level endon("game_ended");
  flag_wait("level_ready_for_script");
  weapon_obj = level.var_bcd25cd23011249[weapon_key];

  if(isDefined(weapon_obj)) {
    currentweapon = self getcurrentprimaryweapon();
    scripts\cp_mp\utility\inventory_utility::_takeweapon(currentweapon);
    scripts\cp_mp\utility\inventory_utility::_giveweapon(weapon_obj);
    scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate(weapon_obj);
  }
}

function function_768c9a047aed19f4(weapon_key) {
  weapon_obj = level.var_bcd25cd23011249[weapon_key];

  if(isDefined(weapon_obj)) {
    return weapon_obj;
  }

  return undefined;
}

function function_9b46467a26f087ea(weapon_key) {
  weapon_obj = level.var_bcd25cd23011249[weapon_key];

  if(isDefined(weapon_obj)) {
    return getcompleteweaponname(weapon_obj);
  }

  return undefined;
}

function function_dcb52bcbbcb80b00(var_c4d6b4cfa2d186c) {
  if(isDefined(var_c4d6b4cfa2d186c) && isstring(var_c4d6b4cfa2d186c)) {
    var_c4d6b4cfa2d186c = [var_c4d6b4cfa2d186c];
  }

  weaponobj = self;
  var_539cfff6632d4fce = scripts\cp_mp\weapon::function_c471a035d22df5eb();
  attachments = scripts\cp_mp\weapon::function_91d352b50d9a0630(weaponobj);
  var_be5b251708f24afd = getarraykeys(attachments);
  var_952f1674fa8d734f = [];
  returnweapon = scripts\cp_mp\weapon::buildweapon(scripts\cp_mp\weapon::getweaponrootname(weaponobj), undefined, undefined, undefined, undefined, undefined, undefined, undefined, 1);

  foreach(var_121b7c7197b1c746 in var_539cfff6632d4fce) {
    var_7ad9eba0904383b1 = function_75b035199842693d(weaponobj, var_121b7c7197b1c746);
    var_2c68a0515f3ce810 = undefined;

    if(var_7ad9eba0904383b1.size == 0) {
      continue;
    }

    if(isDefined(var_c4d6b4cfa2d186c)) {
      foreach(var_d9fdb7f121a35197 in var_c4d6b4cfa2d186c) {
        for(i = 0; i < var_7ad9eba0904383b1.size; i++) {
          if(issubstr(var_7ad9eba0904383b1[i], var_d9fdb7f121a35197)) {
            var_2c68a0515f3ce810 = i;
            break;
          }
        }

        if(isDefined(var_2c68a0515f3ce810)) {
          break;
        }
      }
    }

    if(isDefined(var_2c68a0515f3ce810) && isDefined(var_7ad9eba0904383b1[var_2c68a0515f3ce810])) {
      var_effb4ae1788a8b10 = var_7ad9eba0904383b1[var_2c68a0515f3ce810];

      if(isDefined(var_effb4ae1788a8b10)) {
        var_952f1674fa8d734f[var_952f1674fa8d734f.size] = var_effb4ae1788a8b10;
      }
    }
  }

  foreach(var_931fb1b8d01470ec in var_952f1674fa8d734f) {
    returnweapon = returnweapon withattachment(var_931fb1b8d01470ec);
  }

  return returnweapon;
}

function ismeleeonly(weapon) {
  if(isstring(weapon)) {
    assertmsg("<isMeleeOnly> requires an objweapon, <" + weapon + "> is a string");
  }

  return weapon.ismelee;
}

function getammooverride(weaponobj) {
  baseweapon = weaponobj getbaseweapon();
  baseclipsize = weaponclipsize(baseweapon);
  var_2be3302e3767cc7d = weaponclipsize(weaponobj);
  clipsize = baseclipsize;

  switch (weaponobj.basename) {
    case #"hash_19ebb23fa0a07e22":
    case #"hash_3940f50aabe54489":
    case #"hash_dcb334c6ac945942":
      break;
    default:
      clipsize = int(min(baseclipsize, var_2be3302e3767cc7d));
      break;
  }

  rootname = getweaponrootname(weaponobj);
  ammooverride = 30;

  if(weaponobj.isalternate) {} else {
    switch (weaponobj.classname) {
      case #"hash_690c0d6a821b42e":
        switch (rootname) {
          case #"hash_30551216cbfc3a26":
            ammooverride = 6;
            break;
          case #"hash_68a11d587d71608f":
            ammooverride = 8;
            break;
          default:
            ammooverride = int(min(clipsize, 30));
            break;
        }

        break;
      case #"hash_6191aaef9f922f96":
        switch (rootname) {
          case #"hash_92c6f0344e086ec6":
            ammooverride = 3;
            break;
          default:
            ammooverride = int(min(clipsize, 30));
            break;
        }

        break;
      default:
        ammooverride = int(min(clipsize, 30));
        break;
    }
  }

  return ammooverride;
}

function onequipmentplanted(newequipment, equipmentref, deletefunc) {
  newequipment.equipmentref = equipmentref;
  newequipment.deletefunc = deletefunc;
  newequipment.planted = 1;
  entnum = newequipment getentitynumber();
  level.mines[entnum] = newequipment;

  if(equipmentref != "equip_tac_cover") {
    newequipment enableplayermarks("equipment");

    if(level.teambased) {
      newequipment filteroutplayermarks(self.team);
    } else {
      newequipment filteroutplayermarks(self);
    }
  }

  newequipment notify("mine_planted");
}

function issmallsplashdamage(objweapon) {
  if(objweapon.basename == "semtex_xmike109_splash_mp" || objweapon.basename == "thermite_xmike109_radius_mp" || objweapon.basename == "semtex_bolt_splash_mp" || objweapon.basename == "thermite_bolt_radius_mp") {
    return 1;
  }

  return 0;
}

function getweaponvariantids(weaponroot, blockedids) {
  assertex(isDefined(level.weaponlootmapdata), "getWeaponValidVariantIDs() called without level.weaponLootMapData being populated.");

  if(!isDefined(blockedids)) {
    blockedids = [];
  }

  id = 1;
  variantids = [];

  while(true) {
    variantkey = weaponroot + "|" + id;

    if(!isDefined(level.weaponlootmapdata[variantkey])) {
      break;
    }

    if(!level.weaponlootmapdata[variantkey].islocked && !array_contains(blockedids, id)) {
      variantids[variantids.size] = id;
    }

    id++;
  }

  return variantids;
}

function getweaponrandomvariantid(weaponroot, blockedids) {
  assertex(isDefined(level.weaponlootmapdata), "getWeaponRandomValidVariantID() called without level.weaponLootMapData being populated.");

  if(!isDefined(blockedids)) {
    blockedids = [];
  }

  id = 0;
  validids = getweaponvariantids(weaponroot, blockedids);

  if(validids.size > 0) {
    id = validids[randomint(validids.size)];
  }

  return id;
}

function weaponisValid(weaponroot, variantid) {
  validroot = weaponexistsinstatstable(weaponroot);
  validvariant = 1;

  if(validroot) {
    if(isDefined(isDefined(variantid)) && variantid > 0) {
      variantkey = weaponroot + "|" + variantid;
      validvariant = isDefined(level.weaponlootmapdata[variantkey]) && !level.weaponlootmapdata[variantkey].islocked;
    }
  }

  return validroot && validvariant;
}

function weaponexistsinstatstable(weaponroot) {
  return isDefined(level.weaponmapdata[weaponroot]);
}

function getallselectableattachments(weapon) {
  weaponname = getweaponrootname(weapon);
  attachments = level.weaponattachments[weaponname];

  if(!isDefined(attachments)) {
    attachments = [];
  }

  return attachments;
}

function issinglehitweapon(weaponname) {
  weaponname = getweaponbasenamescript(weaponname);

  switch (weaponname) {
    case #"hash_1717a0115ff7a1c4":
    case #"hash_172aa4116006b29a":
    case #"hash_3e782fd775b72022":
    case #"hash_3e982bd775d0b1bc":
    case #"hash_986ff62872c35e67":
    case #"hash_a86d4075406d2de4":
    case #"hash_a8804475407c3eba":
    case #"hash_d2d2f2854b7d8b7d":
    case #"hash_d5c469762100543e":
      return 1;
    default:
      return 0;
  }
}

function getweaponbasenamescript(weapon) {
  if(isweapon(weapon)) {
    return weapon.basename;
  }

  if(isstring(weapon) && weapon == "none") {
    return "none";
  }

  return getweaponbasename(weapon);
}