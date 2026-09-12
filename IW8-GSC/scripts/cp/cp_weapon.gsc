/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_weapon.gsc
***********************************************/

function weaponsinit() {
  level.maxperplayerexplosives = max(scripts\cp\utility::getintproperty("scr_maxPerPlayerExplosives", 2), 4);
  level.riotshieldxpbullets = scripts\cp\utility::getintproperty("scr_riotShieldXPBullets", 15);
  level.build_weapon_name_func = &_buildweaponcustom;
  level.has_weapon_variation = &has_weapon_variation;
  level.get_weapon_level = &get_weapon_level;
  level.can_upgrade = &can_upgrade;
  level.weaponconfigs = [];
  level.pap = [];
  level.dropped_weapons = [];
  level.invalid_drop_weapons = [];
  level.wavessurvivedthroughweapon = 0;
  level.weaponobtained = 0;
  level.downswithweapon = 0;
  level.weaponkills = 0;
  level.weaponrootcache = [];
  level.dropped_weapon_func = &drop_script_weapon_from_ai;
  level.fnbuildweapon = &buildweapon;
  level.fnscriptedweaponassignment = &getscriptedweapon;
  buildweaponmap();
  buildattachmentmaps();
  scripts\cp\cp_weapons::cp_weapons_init();
  initeffects();
  setupminesettings();
  setupconfigs();
  level.custom_proj_func = [];
  thread custom_gl_proj_func_init();
  thread onplayerconnect();
  iteminits();
  scripts\cp\cp_outline_utility::initoutlineoccluders();
  scripts\engine\utility::array_thread(getEntArray("misc_turret", "classname"), &turret_monitoruse);
  thread scripts\cp\powers\coop_molotov::molotov_init();

  if(isDefined(level.custom_initializeweaponpickups)) {
    [[level.custom_initializeweaponpickups]]();
  } else {
    initializeweaponpickups();
  }

  thread scripts\cp\cp_claymore::claymore_init();
  thread scripts\cp\powers\cp_tactical_cover::tac_cover_init();
  thread scripts\cp_mp\equipment\throwing_knife::throwing_knife_init();
  thread scripts\cp\cp_accessories::init();
  thread scripts\mp\trials\trial_jugg::decoy_init();
  thread hackexclusionlist();
}

function hackexclusionlist() {
  wait 10;
  var_0 = [getcompleteweaponname(level.sentrysettings["sentry_turret"].weaponinfo), getcompleteweaponname("tur_gun_decho_cp"), getcompleteweaponname("iw8_gunless_infil"), getcompleteweaponname("deploy_manual_turret_mp"), getcompleteweaponname("manual_turret_mp"), getcompleteweaponname("deploy_tactical_cover_mp"), getcompleteweaponname("tac_cover_mp"), getcompleteweaponname("ac130_25mm_mp"), getcompleteweaponname("ac130_40mm_mp"), getcompleteweaponname("ac130_105mm_mp"), getcompleteweaponname("iw8_ammo_marker_cp"), getcompleteweaponname("iw8_armor_marker_cp"), getcompleteweaponname("iw8_adrenaline_marker_cp"), getcompleteweaponname("iw8_health_marker_cp"), getcompleteweaponname("vip_carry_cp"), getcompleteweaponname("iw8_health_marker_cp"), getcompleteweaponname("deploy_sentry_mp"), getcompleteweaponname("ks_generic_mp"), getcompleteweaponname("ks_remote_gauntlet_mp"), getcompleteweaponname("ks_remote_map_cp"), getcompleteweaponname("ks_remote_device_mp"), getcompleteweaponname("ks_remote_target_mp"), getcompleteweaponname("ks_gesture_generic_mp"), getcompleteweaponname("deploy_dronepackage_mp"), getcompleteweaponname("deploy_warden_mp"), getcompleteweaponname("deploy_box_marker_mp"), getcompleteweaponname("ks_manual_turret_marker_mp"), getcompleteweaponname("ks_marker_mp"), getcompleteweaponname("deploy_pac_sentry_mp"), getcompleteweaponname("intel_put_usb_in_tablet"), getcompleteweaponname("intel_call_phone"), getcompleteweaponname("intel_take_photo"), getcompleteweaponname("intel_found_usb"), getcompleteweaponname("iw8_nukecore_mp"), getcompleteweaponname("tur_gun_lighttank_mp"), getcompleteweaponname("tur_gun_cargo_truck_mp"), getcompleteweaponname("tur_gun_little_bird_right_mp"), getcompleteweaponname("tur_gun_little_bird_left_mp"), getcompleteweaponname("intel_pickup_phone"), getcompleteweaponname("iw8_spotter_scope_mp"), getcompleteweaponname("iw8_la_mike32_mp"), getcompleteweaponname("iw8_green_beam_mp"), getcompleteweaponname("iw8_minigunksjugg_mp"), getcompleteweaponname("ks_remote_drone_mp"), getcompleteweaponname("iw8_gunless")];
  level.additional_laststand_weapon_exclusion = scripts\engine\utility::array_combine(level.additional_laststand_weapon_exclusion, var_0);
}

function blank(var_0) {}

function initeffects() {
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
  level._effect["aalpha12_explo"] = loadfx("vfx/iw8_mp/equipment/vfx_aalpha12_projectile_explo");
}

function setupminesettings() {
  var_0 = 70;
  level.claymoredetectiondot = cos(var_0);
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
  var_0 = spawnStruct();
  var_0.mine_beacon["enemy"] = loadfx("vfx/core/equipment/light_c4_blink.vfx");
  var_0.mine_beacon["friendly"] = loadfx("vfx/misc/light_mine_blink_friendly");
  level.weaponconfigs["c4_mp_p"] = var_0;
  var_0 = spawnStruct();
  var_0.armingdelay = 1.5;
  var_0.detectionradius = 232;
  var_0.detectionheight = 512;
  var_0.detectiongraceperiod = 1;
  var_0.headiconoffset = 20;
  var_0.killcamoffset = 12;
  level.weaponconfigs["proximity_explosive_mp"] = var_0;
  var_0 = spawnStruct();
  var_1 = 800;
  var_2 = 200;
  var_0.radius_max_sq = var_1 * var_1;
  var_0.radius_min_sq = var_2 * var_2;
  var_0.onexplodesfx = "flash_grenade_expl_trans";
  var_0.vfxradius = 72;
  level.weaponconfigs["flash_grenade_mp"] = var_0;
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

function getweapongunsmithattachmenttable(var_0) {
  var_1 = undefined;

  if(issameweapon(var_0)) {
    var_1 = var_0.basename;
  } else {
    var_1 = var_0;
  }

  var_2 = scripts\cp\utility::getweaponrootname(var_1);
  return "mp/gunsmith/" + getsubstr(var_2, 4) + "_attachments.csv";
}

function getcompletenameforweapon(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = var_0;
  var_8 = strtok(var_7, "_");
  var_9 = 0;

  if(var_8[0] == "alt") {
    var_9++;
  }

  if(var_8[var_9] == "iw7") {
    return;
  }

  if(var_8[var_9] == "iw8") {
    var_10 = var_0;

    if(!isDefined(var_1)) {
      var_11 = ["none", "none", "none", "none", "none", "none"];
    } else {
      var_11 = var_2;
    }

    if(!isDefined(var_3)) {
      var_12 = "none";
    } else {
      var_12 = var_4;
    }

    if(!isDefined(var_5)) {
      var_13 = "none";
    } else {
      var_13 = var_6;
    }

    if(!isDefined(var_7)) {
      var_14 = -1;
    } else {
      var_14 = var_8;
    }

    if(!isDefined(var_9)) {
      var_15 = 0;
    } else {
      var_15 = var_10;
    }

    if(!isDefined(var_11)) {
      var_16 = "none";
    } else {
      var_16 = var_11;
    }

    return createheadicon(buildweapon(var_13, var_14, var_14, var_15, var_15, 1, 1, var_16, var_16));
  }
}

function turret_monitoruse() {
  for(;;) {
    self waittill("trigger", var_0);
    thread turret_playerthread(var_0);
  }
}

function turret_playerthread(var_0) {
  var_0 endon("death");
  var_0 endon("disconnect");
  var_0 notify("weapon_change", isundefinedweapon());
  self waittill("turret_deactivate");
  var_0 notify("weapon_change", var_0 getcurrentweapon());
}

function onplayerconnect() {
  for(;;) {
    level waittill("connected", var_0);
    var_0.hits = 0;
    thread onplayerspawned();
    thread watchmissileusage();
    thread sniperdustwatcher();
    thread watchjavelinusage();
    thread updatelastweapon();
    thread watchchangeweapon();
    var_0 thread scripts\cp\equipment\cp_stinger::watchlauncherusage();
  }
}

function watchjavelinusage() {
  scripts\cp\equipment\cp_javelin::javelinusageloop();
}

function watchchangeweapon() {
  self endon("disconnect");
  level endon("game_ended");

  for(;;) {
    var_0 = self getcurrentweapon();

    if(isDefined(var_0)) {
      dochangeweapon(var_0);

      if(scripts\cp\utility::turn_off_sniper_laser()) {
        for(var_1 = 0; var_1 < self.primaryweapons.size; var_1++) {
          var_2 = self.primaryweapons[var_1].basename;
          var_3 = scripts\cp\utility::strip_suffix(var_2, "_mp");

          if(var_1 < 2) {
            self setplayerdata("cp", "waveSurvivalWeapon", var_1, var_3);
          }
        }
      }
    }

    self waittill("weapon_change");
  }
}

function dochangeweapon(var_0) {
  updateweaponspeed(var_0);
  updatelastweaponobj(var_0);
  updatelauncherusage();
  ref_13FD2(var_0);
  ref_12F87(var_0);
  updateweaponperks();
  updatedefaultflinchreduction();
  scripts\mp\mp_agent_damage::updateweaponchangetime();
  riotshieldonweaponchange(var_0);

  if(isDefined(self.suit) && self.suit == "iw8_suit_cp") {
    thread scripts\cp_mp\gestures::ref_13E1A();
    return;
  }
}

function ref_12F87(var_0) {
  if(istrue(level.loadout_updateammo)) {
    return;
  }

  if(ref_132F2(var_0)) {
    scripts\common\utility::allow_mount_top(0, "scriptedMountDisable");
    scripts\common\utility::allow_mount_side(0, "scriptedMountDisable");
    thread ref_12F88();
    return;
  }
}

function ref_12F88() {
  scripts\engine\utility::ref_143A5("death_or_disconnect", "weapon_change");
  scripts\common\utility::allow_mount_top(1, "scriptedMountDisable");
  scripts\common\utility::allow_mount_side(1, "scriptedMountDisable");
}

function ref_132F2(var_0) {
  var_1 = scripts\cp\utility::getweaponrootname(var_0);

  if(var_1 == "iw8_lm_sierrax" && var_0 hasattachment("stocksaw_sierrax")) {
    return true;
  }

  return false;
}

function ref_13FD2(var_0) {
  self notify("end_dragBreath");

  if(getweapongroup(var_0) == "weapon_shotgun") {
    if(unlockables(var_0)) {
      thread terminal_pusher_approach_array(var_0);
      return;
    }

    return;
  }
}

function terminal_pusher_approach_array(var_0) {
  var_0.unlockableindex = 1;
  thread ref_138DA(var_0);
}

function ref_138DA(var_0) {
  self endon("disconnect");
  scripts\engine\utility::ref_143A5("end_dragBreath", "death");

  if(isDefined(var_0)) {
    var_0.unlockableindex = undefined;
    return;
  }
}

function unlockables(var_0) {
  var_1 = getweaponammopoolname(var_0);
  return var_1 == "WEAPON/AMMO_DB";
}

function updateweaponspeed(var_0) {
  if(var_0.basename == "none") {
    return;
  } else if(scripts\cp\utility::issuperweapon(var_0.basename)) {
    scripts\cp\cp_loadout::updatemovespeedscale();
    return;
  } else if(scripts\cp\utility::iskillstreakweapon(var_0.basename)) {
    return;
  } else if(var_0.basename == "iw8_fists_mp_ls") {
    scripts\cp\cp_loadout::updatemovespeedscale();
    return;
  } else if(var_0.inventorytype != "primary" && var_0.inventorytype != "altmode") {
    return;
  }

  scripts\cp\cp_loadout::updatemovespeedscale();
}

function updatedefaultflinchreduction() {
  if(isagent(self)) {
    return;
  }

  var_0 = undefined;
  var_1 = ref_14584(self.currentweapon);

  if(var_1 == 4) {
    var_0 = 0.85;
  } else if(var_1 == 3) {
    var_0 = 0.2;
  } else if(var_1 == 2) {
    var_0 = 0.08;
  } else if(var_1 == 1) {
    var_0 = 0.25;
  } else {
    var_0 = 0.05;
  }

  updateviewkickscale(var_0);
}

function updateviewkickscale(var_0) {
  if(isDefined(var_0)) {
    self.viewkickscale = var_0;
  }

  if(isDefined(self.overchargeviewkickscale)) {
    var_0 = self.overchargeviewkickscale;
  } else if(isDefined(self.overrideviewkickscale)) {
    var_0 = self.overrideviewkickscale;
    var_1 = ref_14584(self getcurrentweapon());

    if(var_1 == 1) {
      var_0 = self.overrideviewkickscalepistol;
    } else if(var_1 == 3) {
      var_0 = self.ref_1218D;
    } else if(var_1 == 2) {
      var_0 = self.ref_1218E;
    } else if(var_1 == 4) {
      var_0 = self.overrideviewkickscalesniper;
    }
  } else if(isDefined(self.viewkickscale)) {
    var_0 = self.viewkickscale;
  } else {
    var_0 = 1;
  }

  var_0 = clamp(var_0, 0, 1);
  self setviewkickscale(var_0);
}

function ref_14584(var_0) {
  var_1 = "none";
  var_2 = -1;

  if(isDefined(var_0) && !nullweapon(var_0)) {
    var_1 = weaponclass(var_0);

    switch (var_1) {
      case "pistol":
        var_2 = 1;
        break;
      case "sniper":
        if(getweapongroup(var_0) == "weapon_dmr") {
          if(var_0.basename == "iw8_sn_kilo98_mp") {
            var_2 = 2;
          } else {
            var_2 = 3;
          }
        } else {
          var_2 = 4;
        }

        break;
      default:
        var_2 = 0;
        break;
    }
  }

  return var_2;
}

function updateweaponperks() {
  self.prevweaponobj = doweaponperkupdate(self.prevweaponobj);
}

function doweaponperkupdate(var_0) {
  var_1 = self getcurrentweapon();
  weaponattachmentperkupdate(var_1, var_0);
  weaponperkupdate(var_1, var_0);
  return var_1;
}

function weaponperkupdate(var_0, var_1) {
  if(!getqueuedspleveltransients(var_1)) {
    var_2 = scripts\cp\utility::getweaponrootname(var_1.basename);
    var_3 = weaponperkmap(var_2);

    if(isDefined(var_3)) {
      scripts\cp\perks\cp_perks::removeperk(var_3);
    }
  }

  if(!getqueuedspleveltransients(var_0)) {
    var_4 = scripts\cp\utility::getweaponrootname(var_0.basename);
    var_5 = weaponperkmap(var_4);

    if(isDefined(var_5)) {
      scripts\cp\utility::giveperk(var_5);
      return;
    }

    return;
  }
}

function weaponperkmap(var_0) {
  if(isDefined(level.weaponmapdata[var_0]) && isDefined(level.weaponmapdata[var_0].perk)) {
    return level.weaponmapdata[var_0].perk;
  }

  return undefined;
}

function weaponattachmentperkupdate(var_0, var_1) {
  var_2 = undefined;
  var_3 = undefined;

  if(!getqueuedspleveltransients(var_1)) {
    var_3 = getweaponattachments(var_1);

    if(isDefined(var_3) && var_3.size > 0) {
      foreach(var_5 in var_3) {
        var_6 = attachmentperkmap(var_5);

        if(!isDefined(var_6)) {
          continue;
        }

        scripts\cp\perks\cp_perks::removeperk(var_6);
      }
    }
  }

  if(!getqueuedspleveltransients(var_0)) {
    var_2 = getweaponattachments(var_0);

    if(isDefined(var_2) && var_2.size > 0) {
      foreach(var_9 in var_2) {
        var_6 = attachmentperkmap(var_9);

        if(!isDefined(var_6)) {
          continue;
        }

        scripts\cp\utility::giveperk(var_6);
      }

      return;
    }

    return;
  }
}

function attachmentperkmap(var_0) {
  if(isDefined(level.attachmentmap_attachtoperk[var_0])) {
    return level.attachmentmap_attachtoperk[var_0];
  }

  return undefined;
}

function updatelastweaponobj(var_0) {
  self.lastweaponobj = var_0;

  if(isnormallastweapon(var_0)) {
    self.lastnormalweaponobj = var_0;
  }

  if(isdroppableweapon(var_0)) {
    self.lastdroppableweaponobj = var_0;
  }

  if(iscacprimaryorsecondary(var_0)) {
    self.lastcacweaponobj = var_0;
    return;
  }
}

function ref_13C57() {
  for(;;) {
    self waittill("grenade_pullback", var_0);

    if(!nullweapon(var_0) && var_0.basename == "c4_mp_p" && scripts\cp\utility::isriotshield(self getcurrentweapon())) {
      self.ref_1207E = 1;
    }
  }
}

function ref_13C5D() {
  if(!istrue(self.ref_1207E)) {
    var_0 = self getheldoffhand();

    if(!nullweapon(var_0) && var_0.basename != "c4_mp_p" && scripts\cp\utility::isriotshield(self getcurrentweapon()) && scripts\cp\utility::valuehud(var_0)) {
      self.ref_1207E = 1;
      return;
    }

    return;
  }
}

function ref_13C58(var_0) {
  self notify("trackRiotShield_monitorShieldAttach");
  self endon("trackRiotShield_monitorShieldAttach");
  self endon("death_or_disconnect");
  self endon("faux_spawn");
  self endon("riotshield_detach");
  GscBinSkip4(0x35);
}

function ref_13C5A() {
  var_0 = isDefined(self.riotshieldmodel);
  var_1 = isDefined(self.riotshieldmodelstowed);

  if(!var_1) {
    if(var_0) {
      scripts\cp\utility::riotshield_move(1);
      return;
    }

    scripts\cp\utility::riotshield_attach(0, riotshield_getmodel());
    return;
  }
}

function ref_13C59() {
  var_0 = isDefined(self.riotshieldmodel);
  var_1 = isDefined(self.riotshieldmodelstowed);

  if(!var_0) {
    if(var_1) {
      scripts\cp\utility::riotshield_move(0);
      return;
    }

    scripts\cp\utility::riotshield_attach(1, riotshield_getmodel());
    return;
  }
}

function ref_13C5B() {
  var_0 = isDefined(self.riotshieldmodel);
  var_1 = isDefined(self.riotshieldmodelstowed);

  if(var_0) {
    scripts\cp\utility::riotshield_detach(1);
  }

  if(var_1) {
    scripts\cp\utility::riotshield_detach(0);
    return;
  }
}

function ref_13C5C() {
  if(scripts\cp\utility::riotshield_hasweapon()) {
    var_0 = scripts\cp\utility::isriotshield(self getcurrentweapon());

    if(var_0) {
      ref_13C59();
      return;
    }

    ref_13C5A();
    return;
  }

  var_1 = isDefined(self.riotshieldmodel);
  var_2 = isDefined(self.riotshieldmodelstowed);

  if(var_1) {
    scripts\cp\utility::riotshield_detach(1);
  }

  if(var_2) {
    scripts\cp\utility::riotshield_detach(0);
    return;
  }
}

function riotshieldonweaponchange(var_0) {
  if(scripts\cp\utility::riotshield_hasweapon()) {
    thread ref_13C58();
    return;
  }

  ref_13C5C();
  ref_12D4E();
  self notify("riotshield_detach");
}

function ref_12D4E(var_0) {
  self.watch_for_heli_bosses_dead = undefined;
  self.watch_for_heli_death = undefined;
  self.ref_1443A = undefined;

  if(istrue(var_0)) {
    self.hasriotshield = undefined;
    self.hasriotshieldequipped = undefined;
    self.riotshieldmodel = undefined;
    self.riotshieldmodelstowed = undefined;
    return;
  }
}

function get_enemies_in_range(var_0, var_1, var_2, var_3) {
  var_4 = cos(var_3);
  var_5 = var_1 * var_1;
  var_6 = [];

  foreach(var_8 in level.spawned_enemies) {
    if(distancesquared(var_0, var_8.origin) < var_5) {
      if(scripts\engine\utility::within_fov(var_0, var_2.angles, var_8.origin, var_4)) {
        var_6 = var_8;
      }
    }
  }

  return var_6;
}

function sniperdustwatcher() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");

  for(var_0 = undefined;; var_0 = gettime()) {
    self waittill("weapon_fired");

    if(self getstance() != "prone") {
      continue;
    }

    var_1 = self getcurrentweapon();

    if(var_1.classname != "weapon_sniper") {
      continue;
    }

    var_2 = anglesToForward(self.angles);

    if(!isDefined(var_0) || gettime() - var_0 > 2000) {}
  }
}

function unset_scriptable_part_state_after_time(var_0, var_1) {
  self endon("death");
  wait var_0;
  self setscriptablepartstate("projectile", "inactive");
  var_1 notify("ranged_katana_missile_done");

  if(isDefined(self)) {
    self delete();
    return;
  }
}

function watchmissileusage() {
  self endon("disconnect");
  thread listen_for_custom_proj_dvar();

  for(;;) {
    var_0 = waittill_missile_fire();
    var_1 = undefined;

    switch (var_0.weapon_name) {
      case "iw8_la_gromeo_mp":
      case "iw8_la_gromeoks_mp":
        var_1 = self.missilelaunchertarget;
        break;
      case "iw8_la_juliet_mp":
        var_1 = self.javelin.target;
        break;
      case "iw8_la_mike32_mp":
        thread launch_custom_gl_projectile(var_0);
        break;
      case "remotemissile_projectile_mp":
        thread grenade_earthquake();
        break;
      case "glsmoke":
        thread smokegrenadeused(var_0);
        break;
      case "glconc":
        thread watchconcussiongrenadeexplode();
        break;
      case "glflash":
        break;
      case "glincendiary":
        thread scripts\cp\equipment\cp_thermite::thermite_used(var_0, 1);
        break;
      case "glsnap":
        thread scripts\cp\equipment\cp_snapshot_grenade::snapshot_grenade_used(var_0, 1);
        break;
      default:
        break;
    }

    if(scripts\cp_mp\utility\weapon_utility::islockonlauncher(var_0.weapon_name) && isDefined(var_1)) {
      var_0.ref_119A0 = var_1;
      level notify("stinger_fired", self, var_0, var_1);
      thread scripts\cp_mp\utility\weapon_utility::watchtargetlockedontobyprojectile(var_1, var_0);
    }

    if(isPlayer(self) && isDefined(var_0)) {
      var_0.adsfire = scripts\cp\utility::isplayerads();
    }
  }
}

function issmallmissile(var_0) {
  return false;
}

function isexplosivemissile(var_0) {
  var_1 = getweaponbasename(var_0);

  switch (var_1) {
    case "pop_rocket_proj_mp":
    case "ac130_105mm_mp":
    case "ac130_40mm_mp":
    case "ac130_25mm_mp":
      return false;
  }

  return true;
}

function listen_for_custom_proj_dvar() {
  self endon("disconnect");

  for(;;) {
    var_0 = getDvar("scr_gl_proj", "none");

    if(var_0 != "none") {
      self.gl_proj_override = var_0;
    }

    wait 0.1;
  }
}

function launch_custom_gl_projectile(var_0) {
  var_1 = get_custom_gl_projectile(var_0);

  if(isDefined(var_1)) {
    self delete();

    if(isDefined(level.custom_proj_func[var_1])) {
      level thread[[level.custom_proj_func[var_1]]](var_0);
      return;
    }

    return;
  }
}

function get_custom_gl_projectile(var_0) {
  if(isDefined(var_0.gl_proj_override)) {
    return var_0.gl_proj_override;
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

function create_new_projectile(var_0, var_1) {
  var_2 = anglesToForward(var_1 getplayerangles());
  var_2 *= 2000;

  if(var_1 tagexists("tag_flash")) {
    var_3 = var_1 gettagorigin("tag_flash");
  } else {
    var_3 = var_2 getEye();
  }

  var_4 = var_2 launchgrenade(var_1, var_3, var_3);
  var_4.owner = var_2;
  return var_4;
}

function launchthermite(var_0) {
  var_1 = create_new_projectile("thermite_proj_cp", var_0);
  var_0 thread scripts\cp\equipment\cp_thermite::thermite_used(var_1);
}

function launchmolotov(var_0) {
  var_1 = create_new_projectile("molotov_mp", var_0);
  var_0 thread scripts\cp\powers\coop_molotov::molotov_used(var_1);
  self delete();
}

function launchstickytimedgrenade(var_0) {
  var_1 = create_new_projectile("semtex_mp", var_0);
  thread semtexused(var_0);
  self delete();
}

function launchc4grenade(var_0) {
  var_1 = create_new_projectile("c4_mp_p", var_0);
  var_0 thread scripts\cp\cp_c4::c4_used(var_1);
  self delete();
}

function launchexplosivetiplogic(var_0) {
  self waittill("explode", var_1, var_2, var_3, var_4);
  var_0 endon("disconnect");
  var_0 endon("joined_team");
  var_0 endon("joined_spectators");
  var_5 = spawn("script_model", var_1);
  var_5 setModel("offhand_wm_grenade_thermite");
  var_5 setscriptablepartstate("effects", "impact", 0);
  var_5.trigger = spawn("trigger_radius", var_5.origin, 0, 125, 72);
  thread watch_for_thermite_triggered(var_5.trigger);
  wait 0.5;
  var_6 = 1;

  while(var_6 <= 10) {
    var_7 = var_6 + 1;
    var_6 = var_7;
    wait 0.5;
  }

  thread bolt_destroy();
}

function wait_for_crate_drop_to_ground(var_0) {
  var_1 = scripts\engine\utility::drop_to_ground(var_0.origin + (0, 0, -100), 0, -5000);
  var_2 = 900;
  var_3 = 1000;
  var_4 = 0;

  for(;;) {
    if(distancesquared(var_0.origin, var_1) <= var_2) {
      return var_1;
    }

    if(var_4 >= var_3) {
      return var_1;
    }

    var_4 += 50;
    waitframe();
  }
}

function watch_for_thermite_triggered(var_0) {
  self endon("end_thermite_trigger");
  self endon("death");

  for(;;) {
    self waittill("trigger", var_1);

    if(isPlayer(var_1)) {
      continue;
    }

    if(!var_1 scripts\cp\utility::is_soldier_agent()) {
      continue;
    }

    if(isalive(var_1) && !istrue(var_1.marked_for_death)) {
      var_1.marked_for_death = 1;
      thread watch_for_victim_death(var_1);
      var_1 thread scripts\cp\utility::damage_over_time(var_1, var_0, 2.5, 100, "MOD_EXPLOSIVE");
    }
  }
}

function watch_for_victim_death(var_0) {
  self endon("death");
  var_0 waittill("death");
  var_0.marked_for_death = undefined;
  playFX(level._effect["vfx_thermite_end"], var_0.origin);
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

function waitfortriggernotify(var_0) {
  self endon("death");

  for(;;) {
    self waittill("trigger", var_1);

    if(isPlayer(var_1)) {
      continue;
    }

    if(!var_1 scripts\cp\utility::is_soldier_agent()) {
      continue;
    }

    if(isalive(var_1) && !istrue(var_1.marked_for_death)) {
      var_1.marked_for_death = 1;
      var_1 thread scripts\cp\utility::damage_over_time(var_1, var_0, 5, 100, "MOD_EXPLOSIVE");
    }
  }
}

function launchconcertinabomb(var_0) {
  self waittill("missile_stuck", var_1, var_2);
  var_3 = spawn("trigger_radius", self.origin, 0, 500, 72);
  thread waitfortriggernotify(var_3);
  wait 6;
  var_3 delete();
}

function removelinkafterdelay(var_0, var_1) {
  wait var_1;

  if(scripts\engine\utility::array_contains(level.strrazorlinks, var_0)) {
    level.strrazorlinks = scripts\engine\utility::array_remove(level.strrazorlinks, var_0);
    return;
  }
}

function lockonlaunchers_gettargetarray(var_0) {
  var_1 = [];
  var_2 = 0;
  var_3 = lockonlaunchers_gettargetvehiclerefs();

  if(level.teambased) {
    if(isDefined(var_0) && var_0 == 1) {
      foreach(var_5 in level.characters) {
        if(isDefined(var_5) && isalive(var_5) && (var_5.team != self.team || var_2)) {
          var_1 = var_5;
        }
      }
    }

    if(isDefined(level.activekillstreaks)) {
      foreach(var_8 in level.activekillstreaks) {
        if(isDefined(var_8.affectedbylockon) && (var_8.team != self.team || var_2)) {
          var_1 = var_8;
        }
      }
    }

    if(isDefined(level.special_lockon_target_list)) {
      foreach(var_11 in level.special_lockon_target_list) {
        var_1 = var_11;
      }
    }

    jumpiffalse(isDefined(level.cratedropdata)) LOC_0000015d;
    jumpiffalse(isDefined(level.cratedropdata.ac130s)) LOC_0000015d;

    foreach(var_14 in level.cratedropdata.ac130s) {
      if(var_14.team != self.team || var_2) {
        var_1 = var_14;
      }
    }

    foreach(var_17 in var_3) {
      var_18 = scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_getgameinstances(var_17);

      foreach(var_20 in var_18) {
        if(!scripts\cp_mp\vehicles\vehicle::ref_141B9(var_20, self) || var_2) {
          var_1 = var_20;
        }
      }
    }
  } else {
    if(isDefined(var_3) && var_3 == 1) {
      foreach(var_5 in level.characters) {
        if((!isDefined(var_5) || !isalive(var_5)) && !var_18) {
          continue;
        }

        var_17 = var_5;
      }
    }

    if(isDefined(level.activekillstreaks)) {
      foreach(var_8 in level.activekillstreaks) {
        if(isDefined(var_8.affectedbylockon) && (isDefined(var_8.owner) && var_8.owner != self || var_18)) {
          var_17 = var_8;
        }
      }
    }

    jumpiffalse(isDefined(level.cratedropdata)) LOC_000002d9;
    jumpiffalse(isDefined(level.cratedropdata.ac130s)) LOC_000002d9;

    foreach(var_14 in level.cratedropdata.ac130s) {
      if(var_14.owner != self || var_18) {
        var_17 = var_14;
      }
    }

    foreach(var_17 in var_20) {
      var_18 = scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_getgameinstances(var_17);

      foreach(var_20 in var_18) {
        if(!isDefined(var_20.owner)) {
          var_17 = var_20;
          continue;
        }

        if(var_20.owner != self || var_18) {
          var_17 = var_20;
        }
      }
    }
  }

  foreach(var_34 in var_17) {
    if(!isvector(var_34.origin)) {
      var_17 = scripts\engine\utility::array_remove(var_17, var_34);
    }
  }

  return var_17;
}

function lockonlaunchers_gettargetvehiclerefs() {
  return ["apc_russian", "atv", "big_bird", "cargo_truck", "cargo_truck_mg", "cop_car", "hoopty", "hoopty_truck", "jeep", "large_transport", "light_tank", "little_bird", "little_bird_mg", "medium_transport", "pickup_truck", "tac_rover", "technical", "van"];
}

function add_to_special_lockon_target_list(var_0) {
  if(!isDefined(level.special_lockon_target_list)) {
    level.special_lockon_target_list = [];
  }

  if(!scripts\engine\utility::array_contains(level.special_lockon_target_list, var_0)) {
    level.special_lockon_target_list = scripts\engine\utility::array_add(level.special_lockon_target_list, var_0);
    return;
  }
}

function remove_from_special_lockon_target_list(var_0) {
  if(!isDefined(level.special_lockon_target_list)) {
    level.special_lockon_target_list = [];
  }

  if(scripts\engine\utility::array_contains(level.special_lockon_target_list, var_0)) {
    level.special_lockon_target_list = scripts\engine\utility::array_remove(level.special_lockon_target_list, var_0);
    return;
  }
}

function getrandomdirection(var_0, var_1) {
  var_2 = anglestoup(var_1);
  var_3 = anglestoright(var_1);
  var_4 = anglesToForward(var_1);
  var_5 = randomint(360);
  var_6 = randomint(360);
  var_7 = cos(var_6) * sin(var_5);
  var_8 = sin(var_6) * sin(var_5);
  var_9 = cos(var_5);
  var_10 = (var_7 * var_3 + var_8 * var_4 + var_9 * var_2) / 0.33;
  return -1 * var_10;
}

function waittill_missile_fire() {
  self waittill("missile_fire", var_0, var_1);

  if(isDefined(var_0)) {
    if(!isDefined(var_0.weapon_name)) {
      if(var_1.isalternate) {
        var_2 = scripts\cp\utility::attachmentmap_tobase(var_1.underbarrel);

        switch (var_2) {
          case "glconc":
            var_0.weapon_name = "glconc";
            break;
          case "glflash":
            var_0.weapon_name = "glflash";
            break;
          case "glincendiary":
            var_0.weapon_name = "glincendiary";
            break;
          case "glsnap":
            var_0.weapon_name = "glsnap";
            break;
          case "glsmoke":
            var_0.weapon_name = "glsmoke";
            break;
          case "gl":
          default:
            var_0.weapon_name = "gl";
            break;
        }
      } else {
        var_0.weapon_name = var_1.basename;
      }
    }

    if(!isDefined(var_0.owner)) {
      var_0.owner = self;
    }

    if(!isDefined(var_0.team)) {
      var_0.team = self.team;
    }
  }

  return var_0;
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
      self.trackingweapon = isundefinedweapon();
      self.trackingweaponshots = 0;
      self.trackingweaponkills = 0;
      self.trackingweaponhits = 0;
      self.trackingweaponheadshots = 0;
      self.trackingweapondeaths = 0;
    }

    ref_12D4E(1);
    thread watchgrenadeusage();
    thread scripts\mp\trials\trial_gun_course::x1ops3();
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
  var_0 = self getcurrentweapon();

  switch (var_0.basename) {
    case "iw8_la_gromeo_mp":
      thread scripts\cp\agents\gametype_cp_specops::missilelauncherusageloop();
      break;
    case "iw8_la_juliet_mp":
      thread scripts\cp\equipment\cp_javelin::javelinusageloop();
      break;
  }
}

function updatelauncherusage() {
  var_0 = self getcurrentweapon();
  var_1 = scripts\cp\utility::getweaponrootname(var_0.basename);

  switch (var_1) {
    default:
      break;
    case "iw8_la_gromeo":
      thread scripts\cp\agents\gametype_cp_specops::initmissilelauncherusage();
      break;
    case "iw8_la_juliet":
      thread scripts\cp\equipment\cp_javelin::javelin_reset();
      break;
    case "iw8_sn_crossbow":
      thread scripts\cp\vehicles\vehicle_damage_cp::teleport_text_updated();
      break;
    case "iw8_sn_xmike109":
      thread scripts\cp_mp\utility\omnvar_utility::tr_vis_facing_dist_add_override();
      break;
    case "iw8_sh_aalpha12":
      thread scripts\cp\utility\cp_safehouse_util::tr_vis_facing_dist_add_override();
      break;
  }

  self notify("end_launcher");

  if(scripts\cp\utility::_hasperk("specialty_fastreload_launchers")) {
    var_2 = weaponclass(var_0.basename) == "rocketlauncher";

    if(var_2 && !istrue(self.fastreloadlaunchers)) {
      scripts\cp\utility::giveperk("specialty_fastreload");
      self.fastreloadlaunchers = 1;
    } else if(istrue(self.fastreloadlaunchers)) {
      scripts\cp\utility::_unsetperk("specialty_fastreload");
      self.fastreloadlaunchers = undefined;
    }
  }

  switch (var_1) {
    default:
      break;
    case "iw8_sn_crossbow":
      thread scripts\cp\vehicles\vehicle_damage_cp::initarmor(var_0);
      break;
    case "iw8_la_gromeo":
      thread scripts\cp\agents\gametype_cp_specops::missilelauncherusageloop();
      break;
    case "iw8_la_juliet":
      thread scripts\cp\equipment\cp_javelin::javelinusageloop();
      break;
    case "iw8_sn_xmike109":
      thread scripts\cp_mp\utility\omnvar_utility::ref_1403E(var_0);
      break;
    case "iw8_sh_aalpha12":
      thread scripts\cp\utility\cp_safehouse_util::ref_1403E(var_0);
      break;
  }
}

function watchforweapondropped() {
  self endon("disconnect");
  self notify("watchForWeaponDropped");
  self endon("watchForWeaponDropped");

  for(;;) {
    self waittill("weapon_dropped", var_0, var_1);

    if(isDefined(var_0) && isDefined(var_1)) {
      self.storedweapons[var_1.basename] = undefined;
    }
  }
}

function monitorlauncherspawnedgrenades() {
  self endon("disconnect");
  self endon("death");
  self endon("faux_spawn");

  for(;;) {
    var_0 = waittill_grenade_fire();

    if(isDefined(var_0.weapon_name)) {
      if(glprox_trygetweaponname(var_0.weapon_name) == "stickglprox") {
        semtexused(var_0);
      }

      switch (var_0.weapon_name) {
        case "thermite_proj_cp":
        case "thermite_mp":
          thread scripts\cp\equipment\cp_thermite::thermite_used(var_0);
          break;
        case "throwingknife_drill_mp":
        case "throwingknife_electric_mp":
        case "throwingknife_fire_mp":
        case "throwingknife_mp":
          scripts\cp_mp\equipment\throwing_knife::throwing_knife_used(var_0);
          break;
      }
    }
  }
}

function glprox_trygetweaponname(var_0) {
  if(issameweapon(var_0) && nullweapon(var_0)) {
    return var_0;
  }

  if(isstring(var_0) && var_0 == "none") {
    return var_0;
  }

  if(getweaponbasename(var_0) == "iw7_glprox_mp") {
    if(isstring(var_0) && scripts\cp\utility::isaltmodeweapon(var_0) || issameweapon(var_0) && var_0.isalternate) {
      var_1 = getweaponattachments(var_0);
      var_0 = var_1[0];
    } else {
      var_0 = getweaponbasename(var_0);
    }
  }

  return var_0;
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
  jumpiffalse(!self isconsoleplayer() && !isai(self)) LOC_000000a6;
  self notifyonplayercommand("adjustedStance", "+togglecrouch");
  self notifyonplayercommand("adjustedStance", "toggleprone");
  self notifyonplayercommand("adjustedStance", "+movedown");
  self notifyonplayercommand("adjustedStance", "-movedown");
  self notifyonplayercommand("adjustedStance", "+prone");
  self notifyonplayercommand("adjustedStance", "-prone");

  for(;;) {
    scripts\engine\utility::ref_143A6("adjustedStance", "sprint_begin", "weapon_change");
    wait 0.5;

    if(isDefined(self.onhelisniper) && self.onhelisniper) {
      continue;
    }

    var_0 = self getstance();
    stancerecoilupdate(var_0);
  }
}

function stancerecoilupdate(var_0) {
  var_1 = self getcurrentprimaryweapon();
  var_2 = 0;

  if(isrecoilreducingweapon(var_1)) {
    var_2 = getrecoilreductionvalue();
  }

  if(var_0 == "prone") {
    var_3 = var_1.classname;

    if(isDefined(var_3)) {
      if(var_3 == "weapon_lmg") {
        setrecoilscale(0, 40);
        return;
      }

      if(var_3 == "weapon_sniper") {
        if(var_1 hasattachment("barrelbored", 1)) {
          setrecoilscale(0, 20 + var_2);
          return;
        }

        setrecoilscale(0, 40 + var_2);
        return;
      }

      return;
    }

    setrecoilscale();
    return;
  }

  if(var_0 == "crouch") {
    var_3 = var_1.classname;

    if(isDefined(var_3)) {
      if(var_3 == "weapon_lmg") {
        setrecoilscale(0, 10);
        return;
      }

      if(var_3 == "weapon_sniper") {
        if(var_1 hasattachment("barrelbored", 1)) {
          setrecoilscale(0, 10 + var_2);
          return;
        }

        setrecoilscale(0, 20 + var_2);
        return;
      }

      return;
    }

    setrecoilscale();
    return;
  }

  if(var_2 > 0) {
    setrecoilscale(0, var_2);
    return;
  }

  setrecoilscale();
}

function setrecoilscale(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  if(!isDefined(self.recoilscale)) {
    self.recoilscale = var_0;
  } else {
    self.recoilscale += var_0;
  }

  if(isDefined(var_1)) {
    if(isDefined(self.recoilscale) && var_1 < self.recoilscale) {
      var_1 = self.recoilscale;
    }

    var_2 = 100 - var_1;
  } else {
    var_2 = 100 - self.recoilscale;
  }

  if(var_2 < 0) {
    var_2 = 0;
  }

  if(var_2 > 100) {
    var_2 = 100;
  }

  if(var_2 == 100) {
    self player_recoilscaleoff();
    return;
  }

  self player_recoilscaleon(var_2);
}

function isrecoilreducingweapon(var_0) {
  if(nullweapon(var_0)) {
    return 0;
  }

  var_1 = 0;

  if(var_0 hasattachment("kbsscope", 1) || var_0 hasattachment("m8scope_zm", 1) || var_0 hasattachment("cheytacscope", 1)) {
    var_1 = 1;
  }

  return var_1;
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
    self waittill("weapon_change", var_0);

    if(nullweapon(var_0)) {
      continue;
    }

    if(isvalidweapon(var_0)) {
      self.last_valid_weapon = var_0;
    }

    if(!isDefined(self.storedweapons)) {
      self.storedweapons = [];
    }

    if(!isDefined(self.storedweapons[var_0.basename])) {
      self.storedweapons[var_0.basename] = createheadicon(var_0);
    }

    thread updatelauncherusage();

    if(scripts\cp\utility::iskillstreakweapon(var_0)) {
      continue;
    }

    if(is_launcher(var_0) && !is_killstreak_weapon(var_0)) {
      if(self.class == "tank") {
        var_0 = add_launcher_xmags(var_0);
      } else {
        var_0 = ref_12BDA(var_0);
      }

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

function minigamefinishcount(var_0) {
  var_0 notify("dropping_minigun");
  var_1 = ["iw8_minigunksjugg_mp", "iw8_lm_dblmg_mp"];
  var_2 = "iw8_lm_dblmg_mp";

  foreach(var_4 in var_1) {
    if(var_0 hasweapon(var_4)) {
      var_2 = var_4;
    }
  }

  var_6 = getcompleteweaponname(var_2);
  var_7 = var_0 dropitem(var_6);
  thread watchweaponpickup();
}

function ref_1447D(var_0, var_1) {
  var_0 endon("death");
  var_0 endon("disconnect");
  var_0 endon("faux_spawn");
  var_0 endon("dropping_minigun");
  var_0 notify("watchMinigunAmmo");
  var_0 endon("watchMinigunAmmo");

  for(;;) {
    var_2 = var_0 getweaponammoclip(var_1);

    if(var_2 <= 0) {
      var_0 takeweapon(var_1);
      return;
    }

    waitframe();
  }
}

function ref_12349(var_0) {
  if(var_0.basename == "iw8_lm_dblmg_mp") {
    return true;
  }

  if(var_0.basename == "iw8_minigunksjugg_mp") {
    return true;
  }

  return false;
}

function ref_139CF(var_0, var_1) {
  if(var_1.basename == "iw8_lm_dblmg_mp") {
    return 0;
  }

  if(var_1.basename == "iw8_minigunksjugg_mp") {
    return 0;
  }

  return ref_124AD(var_0);
}

function ref_124AD(var_0) {
  var_1 = ["iw8_minigunksjugg_mp", "iw8_lm_dblmg_mp"];

  foreach(var_3 in var_1) {
    if(var_0 hasweapon(var_3)) {
      return true;
    }
  }

  return false;
}

function is_launcher(var_0) {
  var_1 = weaponclass(var_0);

  if(var_1 == "rocketlauncher") {
    return true;
  }

  switch (var_0.basename) {
    case "iw8_la_rpapa7_mp":
    case "iw8_la_kgolf_mp":
    case "iw8_la_juliet_mp":
    case "iw8_la_gromeo_mp":
      return true;
  }

  return false;
}

function is_killstreak_weapon(var_0) {
  switch (var_0.basename) {
    case "ac130_25mm_cp":
    case "ac130_40mm_cp":
      return 1;
    default:
      return 0;
  }
}

function add_launcher_xmags(var_0) {
  var_1 = "xmags_cp_gromeo";

  switch (var_0.basename) {
    case "iw8_la_gromeo_mp":
      var_1 = "xmags_cp_gromeo";
      break;
    case "iw8_la_juliet_mp":
      var_1 = "xmags_cp_juliet";
      break;
    case "iw8_la_kgolf_mp":
      var_1 = "xmags_cp_kgolf";
      break;
    case "iw8_la_rpapa7_mp":
      var_1 = "xmags_cp_rpapa7";
      break;
    default:
      break;
  }

  if(!var_0 hasattachment(var_1)) {
    var_0 = addattachmenttoweapon(var_0, var_1, 1);
  }

  return var_0;
}

function ref_12BDA(var_0) {
  var_1 = "xmags_cp_gromeo";

  switch (var_0.basename) {
    case "iw8_la_gromeo_mp":
      var_1 = "xmags_cp_gromeo";
      break;
    case "iw8_la_juliet_mp":
      var_1 = "xmags_cp_juliet";
      break;
    case "iw8_la_kgolf_mp":
      var_1 = "xmags_cp_kgolf";
      break;
    case "iw8_la_rpapa7_mp":
      var_1 = "xmags_cp_rpapa7";
      break;
    default:
      break;
  }

  if(var_0 hasattachment(var_1)) {
    remove_attachment(var_1, self, var_0);
  }

  return var_0;
}

function isfistweapon(var_0) {
  var_0 = scripts\cp\utility::getweaponrootname(var_0);
  return var_0 == "iw8_fists";
}

function isvalidweapon(var_0) {
  var_1 = level.additional_laststand_weapon_exclusion;
  var_2 = undefined;

  if(issameweapon(var_0)) {
    var_2 = var_0;
  } else {
    var_2 = asmdevgetallstates(var_0);
  }

  if(nullweapon(var_2)) {
    return 0;
  }

  if(isDefined(var_1) && scripts\engine\utility::array_contains(var_1, var_2)) {
    return 0;
  }

  if(scripts\cp\utility::is_melee_weapon(var_2, 1)) {
    return 0;
  }

  return 1;
}

function updatesavedlastweapon() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  var_0 = self.currentweaponatspawn;

  if(isDefined(self.saved_lastweaponhack)) {
    var_0 = self.saved_lastweaponhack;
  }

  self.saved_lastweapon = var_0;

  for(;;) {
    self waittill("weapon_change", var_1);

    if(nullweapon(var_1)) {
      self.saved_lastweapon = var_0;
      continue;
    }

    var_2 = weaponinventorytype(var_1);
    self[[level.move_speed_scale]]();
    self.saved_lastweapon = var_0;

    if(isdroppableweapon(self.saved_lastweapon)) {
      self.lastdroppableweaponobj = self.saved_lastweapon;
    }

    var_0 = var_1;
  }
}

function bomber_spawn_origin_array_init() {
  self endon("death");

  for(;;) {
    self waittill("grenade_fire", var_0, var_1);
    var_0.owner = self;

    switch (var_1.basename) {
      case "molotov_mp":
        level thread scripts\cp\powers\coop_molotov::bomber_shouldusetraversals(self, var_0);
        break;
      case "gas_mp":
        thread scripts\cp\equipment\cp_gas_grenade::gas_used(var_0);
        break;
      case "concussion_grenade_mp":
        thread watchconcussiongrenadeexplode();
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
  jumpiftrue(isDefined(self.plantedlethalequip)) LOC_00000046;
  self.plantedlethalequip = [];
  self.plantedtacticalequip = [];

  for(;;) {
    self waittill("grenade_pullback", var_0);
    var_1 = self getthrowbackweapon();

    if(!nullweapon(var_1)) {
      continue;
    }

    var_2 = var_0.basename;
    thread watchoffhandcancel();
    self.throwinggrenade = var_2;

    if(var_2 == "c4_mp_p") {
      thread beginc4tracking();
    }

    begingrenadetracking();
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
    return;
  }
}

function beginc4tracking() {
  self notify("beginC4Tracking");
  self endon("beginC4Tracking");
  self endon("death");
  self endon("disconnect");
  scripts\engine\utility::ref_143A6("grenade_fire", "weapon_change", "offhand_end");
  self.changingweapon = undefined;
}

function dudgrenadeused(var_0) {
  var_0 endon("disconnect");
  thread ownerdisconnectcleanup(var_0);
  thread scripts\cp\utility::notifyafterframeend("death", "end_explode");
  self endon("end_explode");
  self waittill("explode", var_1);
  self delete();
}

function begingrenadetracking() {
  self endon("offhand_end");
  var_0 = gettime();
  var_1 = waittill_grenade_fire();

  if(!isDefined(var_1)) {
    return;
  }

  if(!isDefined(var_1.weapon_name)) {
    return;
  }

  self.changingweapon = undefined;

  switch (var_1.weapon_name) {
    case "snapshot_grenade_mp":
      thread scripts\cp\equipment\cp_snapshot_grenade::snapshot_grenade_used(var_1);
      break;
    case "iw8_molotov_zm":
    case "molotov_mp":
      thread scripts\cp\powers\coop_molotov::molotov_used(var_1);
      self.waittill_any_timeout_no_endon_death_4 = gettime();
      break;
    case "iw8_health_marker_cp":
    case "iw8_adrenaline_marker_cp":
    case "iw8_armor_marker_cp":
    case "iw8_ammo_marker_cp":
      scripts\cp\crafting_system::throwcrate(var_1);
      break;
    case "dud_grenade_zm":
      thread dudgrenadeused(var_1);
      thread grenade_earthquake();
      break;
    case "thermobaric_grenade_mp":
    case "frag_grenade_zm":
    case "frag_grenade_mp":
      if(gettime() - var_0 > 1000) {
        var_1.iscooked = 1;
      }

      thread ref_144D9();
      var_1.originalowner = self;
      break;
    case "cluster_grenade_zm":
      var_1.clusterticks = var_1.ticks;

      if(var_1.ticks >= 1) {
        var_1.iscooked = 1;
      }

      var_1.originalowner = self;
      thread clustergrenadeused();
      thread grenade_earthquake();
      break;
    case "zfreeze_semtex_mp":
    case "semtex_mp":
    case "semtex_zm":
      thread semtexused(var_1);
      break;
    case "gas_mp":
      thread scripts\cp\equipment\cp_gas_grenade::gas_used(var_1);
      break;
    case "hb_sensor_mp":
      thread scripts\mp\equipment\hb_sensor::hb_sensor_used(var_1);
      break;
    case "c4_mp_p":
      thread scripts\cp\cp_c4::c4_used(var_1);
      break;
    case "claymore_mp":
      thread scripts\cp\cp_claymore::claymore_use(var_1);
      break;
    case "at_mine_mp":
      thread scripts\cp\equipment\cp_at_mine::at_mine_use(var_1);
      break;
    case "trophy_mp":
      thread scripts\cp\equipment\cp_trophy_system::trophy_used(var_1);
      break;
    case "flare_mp":
      thread scripts\cp\crafting_system::ref_12C8B(var_1);
      break;
    case "concussion_grenade_mp":
      thread watchconcussiongrenadeexplode();
      break;
    case "bouncing_betty_mp":
      thread mineused(var_1, &spawnmine);
      break;
    case "throwingknifec4_mp":
    case "throwingknifejugg_mp":
    case "throwingknife_mp":
      thread throwingknifeused(level, self, var_1);
      break;
    case "zom_repulsor_mp":
      var_1 delete();
      break;
    case "smoke_grenade_mp":
      thread smokegrenadeused();
      break;
    case "gas_grenade_mp":
      thread watchgasgrenadeexplode();
      break;
    case "trip_mine_mp":
      break;
    case "flash_grenade_mp":
      var_1.ninebangticks = var_1.ticks;
      thread ref_144A9();

      if(var_1.ticks >= 1) {
        var_1.iscooked = 1;
      }

      break;
    case "decoy_grenade_mp":
      thread scripts\mp\trials\trial_jugg::decoy_used(var_1);
      break;
  }

  if(isDefined(var_1)) {
    var_1 thread scripts\cp\cp_player_battlechatter::grenadeproximitytracking();
    scripts\cp\cp_player_battlechatter::ongrenadeuse(var_1);
    return;
  }
}

function extinguishonexplode(var_0) {
  thread scripts\cp\utility::notifyafterframeend("death", "end_explode");
  self endon("end_explode");
  var_1 = self.owner;
  self waittill("explode", var_2);
  level notify("explosion_extinguish", var_2, var_0, var_1);
}

function ninebangexplodewaiter() {
  thread scripts\cp\utility::notifyafterframeend("death", "end_explode");
  self endon("end_explode");
  self waittill("explode", var_0);
  thread doninebang(var_0, self.owner, self.ninebangticks);
  ninebangdoempdamage(var_0, self.owner, self.ninebangticks);
}

function ninebangdoempdamage(var_0, var_1, var_2) {
  if(var_2 >= 5) {
    playsoundatpos(var_0, "emp_grenade_explode_default");
    var_3 = level.players;

    foreach(var_5 in var_3) {
      var_5 notify("emp_damage", self.owner, 8);
    }

    return;
  }
}

function doninebang(var_0, var_1, var_2) {
  level endon("game_ended");
  var_3 = level.weaponconfigs[self.weapon_name];
  wait randomfloatrange(0.25, 0.5);

  for(var_4 = 1; var_4 < var_2; var_4++) {
    var_5 = getninebangsubexplosionpos(var_0, var_3.vfxradius);
    playFX(var_3.onexplodevfx, var_5);

    foreach(var_7 in level.players) {
      if(!var_7 scripts\cp_mp\utility\player_utility::_isalive() || var_7.sessionstate != "playing") {
        continue;
      }

      var_8 = var_7 getEye();
      var_9 = distancesquared(var_0, var_8);

      if(var_9 > var_3.radius_max_sq) {
        continue;
      }

      if(!scripts\engine\trace::_bullet_trace_passed(var_0, var_8, 0, var_7)) {
        continue;
      }

      if(var_9 <= var_3.radius_min_sq) {
        var_10 = 1;
      } else {
        var_10 = 1 - (var_9 - var_3.radius_min_sq) / (var_3.radius_max_sq - var_3.radius_min_sq);
      }

      var_11 = anglesToForward(var_7 getplayerangles());
      var_12 = var_0 - var_8;
      var_12 = vectorNormalize(var_12);
      var_13 = 0.5 * (1 + vectordot(var_11, var_12));
      var_14 = 1;
      var_7 notify("flashbang", var_0, var_10, var_13, var_1, var_14);
    }

    wait randomfloatrange(0.25, 0.5);
  }
}

function getninebangsubexplosionpos(var_0, var_1) {
  var_2 = (randomfloatrange(-1 * var_1, var_1), randomfloatrange(-1 * var_1, var_1), 0);
  var_3 = var_0 + var_2;
  var_4 = scripts\engine\trace::_bullet_trace(var_0, var_3, 0, undefined, 0, 0, 0, 0, 0);

  if(var_4["fraction"] < 1) {
    var_3 = var_0 + var_4["fraction"] * var_2;
  }

  return var_3;
}

function rat_executevisuals(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  self playlocalsound("eye_pulse_plr_lr");
  self setscriptablepartstate("rat_eye_pulse", "active");
  scripts\engine\utility::ref_143BA(var_0, "last_stand", "death");
  self setscriptablepartstate("rat_eye_pulse", "inactive");
}

function handleratvisionburst(var_0) {
  level endon("game_ended");
  var_0 endon("disconnect");
  var_0 endon("last_stand");
  var_0 endon("death");
  thread rat_executevisuals(var_0);
}

function isinvalidzone(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = getEntArray("power_exclusion_volume", "targetname");

  if(isDefined(var_5)) {
    if(isDefined(level.neil) && isDefined(level.neil.upper_body)) {
      if(var_5 == level.neil || var_5 == level.neil.upper_body) {
        return false;
      }
    }

    if(isDefined(level.boat_vehicle)) {
      if(var_5 == level.boat_vehicle) {
        return false;
      }
    }

    if(isDefined(var_5.targetname) && var_5.targetname == "beginning_area_balloons") {
      return false;
    }
  }

  if(isDefined(var_1)) {
    var_6 = scripts\engine\utility::array_combine(var_6, var_1);
  }

  foreach(var_8 in var_6) {
    if(ispointinvolume(var_0, var_8)) {
      return false;
    }
  }

  if(istrue(var_4) && !ispointonnavmesh(var_0)) {
    return false;
  }

  if(istrue(var_3)) {
    if(navtrace(var_2.origin, var_0)) {
      return false;
    }
  }

  return true;
}

function placeequipmentfailed(var_0, var_1, var_2, var_3) {
  if(isPlayer(self)) {
    self playlocalsound("scavenger_pack_pickup");
  }

  if(istrue(var_1)) {
    var_4 = undefined;

    if(isPlayer(self)) {
      if(isDefined(var_3)) {
        var_4 = spawnfxforclient(scripts\engine\utility::getfx("placeEquipmentFailed"), var_2, self, anglesToForward(var_3), anglestoup(var_3));
      } else {
        var_4 = spawnfxforclient(scripts\engine\utility::getfx("placeEquipmentFailed"), var_2, self);
      }
    } else {
      var_4 = spawnfx(scripts\engine\utility::getfx("placeEquipmentFailed"), var_2);
    }

    triggerfx(var_4);
    thread placeequipmentfailedcleanup(var_4);
    return;
  }
}

function placeequipmentfailedcleanup(var_0) {
  wait 2;
  var_0 delete();
}

function spawnmine(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3)) {
    var_3 = (0, randomfloat(360), 0);
  }

  var_4 = level.weaponconfigs[var_2];
  var_5 = spawn("script_model", var_0);
  var_5.angles = var_3;
  var_5.owner = var_1;
  var_5.weapon_name = var_2;
  var_5.config = var_4;
  var_5 setModel(var_4.model);
  var_5 setotherent(var_1);
  var_5.killcamoffset = (0, 0, 4);
  var_5.killcament = spawn("script_model", var_5.origin + var_5.killcamoffset);
  var_5.killcament setscriptmoverkillcam("explosive");
  onlethalequipmentplanted(var_1, var_5);

  if(isDefined(var_4.mine_beacon)) {
    thread doblinkinglight(var_5, "tag_fx", var_4.mine_beacon["friendly"]);
  }

  var_6 = undefined;

  if(self != level) {
    var_6 = self getlinkedparent();
  }

  explosivehandlemovers(var_5, var_6);
  thread mineproximitytrigger(var_5);
  thread grenade_earthquake();
  thread mineselfdestruct();
  thread mineexplodeonnotify();
  thread monitordisownedequipment(level, var_1);
  return var_5;
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
  self waittill("detonateExplosive", var_0);

  if(!isDefined(self) || !isDefined(self.owner)) {
    return;
  }

  if(!isDefined(var_0)) {
    var_0 = self.owner;
  }

  var_1 = self.config;
  var_2 = var_1.vfxtag;

  if(!isDefined(var_2)) {
    var_2 = "tag_fx";
  }

  var_3 = self gettagorigin(var_2);

  if(!isDefined(var_3)) {
    var_3 = self gettagorigin("tag_origin");
  }

  self notify("explode", var_3);
  wait 0.05;

  if(!isDefined(self) || !isDefined(self.owner)) {
    return;
  }

  self hide();

  if(isDefined(var_1.onexplodefunc)) {
    self thread[[var_1.onexplodefunc]]();
  }

  if(isDefined(var_1.onexplodesfx)) {
    self playSound(var_1.onexplodesfx);
  }

  var_4 = scripts\engine\utility::ter_op(isDefined(var_1.onexplodevfx), var_1.onexplodevfx, level.mine_explode);
  var_5 = scripts\engine\utility::ter_op(isDefined(var_1.minedamagemin), var_1.minedamagemin, level.minedamagemin);
  var_6 = scripts\engine\utility::ter_op(isDefined(var_1.minedamagemax), var_1.minedamagemax, level.minedamagemax);
  var_7 = scripts\engine\utility::ter_op(isDefined(var_1.minedamageradius), var_1.minedamageradius, level.minedamageradius);
  self radiusdamage(self.origin, var_7, var_6, var_5, var_0, "MOD_EXPLOSIVE", self.weapon_name);
  wait 0.2;
  deleteexplosive();
}

function mineproximitytrigger(var_0) {
  self endon("mine_destroyed");
  self endon("mine_selfdestruct");
  self endon("death");
  self endon("disabled");
  var_1 = self.config;
  wait var_1.armtime;

  if(isDefined(var_1.mine_beacon)) {
    thread doblinkinglight("tag_fx", var_1.mine_beacon["friendly"], var_1.mine_beacon["enemy"]);
  }

  var_2 = spawn("trigger_radius", self.origin, 0, level.minedetectionradius, level.minedetectionheight);
  var_2.owner = self;
  var_2.team = var_2.owner.team;
  thread minedeletetrigger(var_2);

  if(isDefined(var_0)) {
    var_2 enablelinkTo();
    var_2 linkTo(var_0);
  }

  self.damagearea = var_2;

  for(;;) {
    var_2 waittill("trigger", var_3);

    if(isPlayer(var_3)) {
      wait 0.05;
      continue;
    }

    if(var_3 damageconetrace(self.origin, self) > 0) {
      break;
    }
  }

  self notify("mine_triggered");
  self playSound(self.config.ontriggeredsfx);
  explosivetrigger(var_3, level.minedetectiongraceperiod, "mine");
  self thread[[self.config.ontriggeredfunc]]();
}

function minedeletetrigger(var_0) {
  scripts\engine\utility::ref_143A7("mine_triggered", "mine_destroyed", "mine_selfdestruct", "death");

  if(isDefined(var_0)) {
    var_0 delete();
    return;
  }
}

function doblinkinglight(var_0, var_1, var_2) {
  if(!isDefined(var_1)) {
    var_1 = scripts\engine\utility::getfx("weap_blink_friend");
  }

  if(!isDefined(var_2)) {
    var_2 = scripts\engine\utility::getfx("weap_blink_enemy");
  }

  self.blinkinglightfx["friendly"] = var_1;
  self.blinkinglightfx["enemy"] = var_2;
  self.blinkinglighttag = var_0;
  thread updateblinkinglight(var_1, var_2, var_0);
  self waittill("death");
  stopblinkinglight();
}

function updateblinkinglight(var_0, var_1, var_2) {
  self endon("death");
  self endon("carried");
  self endon("emp_damage");
  var_3 = &checkteam;

  if(!level.teambased) {
    var_3 = &checkplayer;
  }

  var_4 = randomfloatrange(0.05, 0.25);
  wait var_4;
  GscBinSkip4(0x35, var_0, var_1, var_2, var_3);
}

function checkplayer(var_0) {
  return self == var_0;
}

function checkteam(var_0) {
  return self.team == var_0.team;
}

function onjointeamblinkinglight(var_0, var_1, var_2, var_3) {
  self endon("death");
  level endon("game_ended");
  self endon("emp_damage");

  for(;;) {
    level waittill("joined_team", var_4);

    if(self.owner[[var_3]](var_4)) {
      playfxontagforclients(var_0, self, var_2, var_4);
      continue;
    }

    playfxontagforclients(var_1, self, var_2, var_4);
  }
}

function stopblinkinglight() {
  if(isalive(self) && isDefined(self.blinkinglightfx)) {
    stopFXOnTag(self.blinkinglightfx["friendly"], self, self.blinkinglighttag);
    stopFXOnTag(self.blinkinglightfx["enemy"], self, self.blinkinglighttag);
    self.blinkinglightfx = undefined;
    self.blinkinglighttag = undefined;
    return;
  }
}

function ref_144D9() {
  var_0 = self.owner.name;
  self waittill("explode", var_1);
  level notify("grenade_exploded_during_stealth", var_1, "frag_grenade_mp", var_0);
}

function ref_144A9() {
  var_0 = self.owner.name;
  self waittill("explode", var_1);
  level notify("grenade_exploded_during_stealth", var_1, "flash_grenade_mp", var_0);
}

function watchgasgrenadeexplode() {
  var_0 = self.owner;
  var_0 endon("disconnect");
  self waittill("explode", var_1);
  thread ongasgrenadeimpact(var_0, var_1);
}

function ongasgrenadeimpact(var_0, var_1) {
  var_2 = spawn("trigger_radius", var_1, 0, 128, 160);
  var_2.owner = var_0;
  var_3 = 128;
  var_4 = spawnfx(scripts\engine\utility::getfx("gas_grenade_smoke_enemy"), var_1);
  triggerfx(var_4);
  wait 1;
  var_5 = 8;

  while(var_5 > 0) {
    var_6 = undefined;

    if(isDefined(level.spawned_enemies)) {
      var_6 = level.spawned_enemies;
    } else {
      var_6 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
    }

    foreach(var_8 in var_6) {
      if(isDefined(var_8.agent_type) && (var_8.agent_type == "zombie_brute" || var_8.agent_type == "superslasher" || var_8.agent_type == "slasher" || var_8.agent_type == "zombie_grey")) {
        continue;
      }

      var_9 = getdamagefromzombietype(var_8);

      if(isalive(var_8)) {
        applygaseffect(var_8, var_0, var_1, var_2, var_2, int(var_9));
      }
    }

    wait 0.2;
    var_5 -= 0.2;
  }

  var_4 delete();
  wait 2;
  var_2 delete();

  foreach(var_8 in scripts\cp\cp_agent_utils::getaliveagentsofteam("axis")) {
    if(isalive(var_8)) {
      var_8.flame_damage_time = undefined;
    }
  }
}

function getdamagefromzombietype(var_0) {
  if(isalive(var_0)) {
    if(istrue(var_0.is_suicide_bomber)) {
      return int(min(1000, var_0.maxhealth * 0.25));
    }

    return int(min(1000, var_0.maxhealth * 0.1));
  }

  return 150;
}

function applygaseffect(var_0, var_1, var_2, var_3, var_4) {
  if(isalive(self) && self istouching(var_2)) {
    if(var_0 scripts\cp\utility::isenemy(self)) {
      var_3 radiusdamage(self.origin, 1, var_4, var_4, var_0, "MOD_GRENADE_SPLASH", "gas_grenade_mp");
      self.flame_damage_time = gettime() + 200;
      return;
    }

    return;
  }
}

function throwingknifeused(var_0, var_1, var_2) {
  if(var_2 == "throwingknifec4_mp") {
    var_1 makeunusable();
    thread recordthrowingknifetraveldist();
  }

  thread throwingknifedamagedvictim(var_0, var_1);
  var_3 = undefined;
  var_4 = undefined;
  var_1 waittill("missile_stuck", var_3, var_4);
  var_5 = isDefined(var_4) && var_4 == "tag_flicker";
  var_6 = isDefined(var_4) && var_4 == "tag_weapon";

  if(isDefined(var_3) && (isPlayer(var_3) || isagent(var_3)) && var_5) {
    var_3 notify("shield_hit", var_1);
  }

  if(isDefined(var_3) && (isPlayer(var_3) || isagent(var_3)) && !var_6 && !var_5) {
    if(var_2 == "throwingknifec4_mp") {
      throwingknifec4detonate(var_1, var_3, var_0);
    }
  }

  var_1.equipmentref = "equip_throwing_knife";
  thread watchgrenadedeath();

  for(;;) {
    var_1 waittill("trigger", var_7);
    var_7 scripts\cp\cp_powers::power_adjustcharges(1, "primary");
  }
}

function throwingknifedamagedvictim(var_0, var_1) {
  var_1 endon("death");
  var_0 endon("death");
  var_0 endon("disconnect");

  for(;;) {
    var_0 waittill("victim_damaged", var_2, var_3, var_4, var_5, var_6, var_7);

    if(isDefined(var_3) && var_3 == var_1) {
      if(var_7 == "throwingknifeteleport_mp" && !isDefined(var_1.knifeteleownerinvalid)) {
        throwingknifeteleport(var_1, var_2, var_0, 1);
        var_1.giveknifeback = 1;
      }

      break;
    }
  }
}

function watchgrenadedeath() {
  self waittill("death");

  if(isDefined(self.knife_trigger)) {
    self.knife_trigger delete();
    return;
  }
}

function throwingknifeused_trygiveknife(var_0, var_1, var_2) {
  var_3 = var_0 getweaponammoclip(var_2);
  var_4 = 2;
  var_5 = undefined;

  if(var_3 >= var_4) {
    var_5 = 0;
  } else {
    var_0 setweaponammoclip(var_2, var_3 + 1);
    var_0 thread scripts\cp\cp_damagefeedback::hudicontype("throwingknife");
    var_5 = 1;
  }

  return var_5;
}

function throwingknifeteleport(var_0, var_1, var_2, var_3) {
  var_2 playlocalsound("blinkknife_teleport");
  var_2 playsoundonmovingent("blinkknife_teleport_npc");
  playsoundatpos(var_0.origin, "blinkknife_impact");
  thread throwingknifeteleport_fxstartburst(var_2, var_1);
  var_4 = var_1 getcorpseentity();

  if(isDefined(var_4)) {
    var_4 notsolid();
  }

  var_5 = [];

  foreach(var_7 in level.characters) {
    if(!isDefined(var_7) || !isalive(var_7) || var_7 == var_1 || var_7 == var_2 || !var_2 scripts\cp\utility::isenemy(var_7)) {
      continue;
    }

    var_5 = var_7;
  }

  var_5 = sortbydistance(var_5, var_1.origin);
  var_9 = var_2 gettagorigin("TAG_EYE");
  var_10 = var_1.origin;
  var_11 = var_1.origin + (0, 0, var_9[2] - var_2.origin[2]);
  var_12 = var_2.angles;

  foreach(var_14 in var_5) {
    var_15 = (var_14.origin[0], var_14.origin[1], var_14 gettagorigin("TAG_EYE")[2]);

    if(distancesquared(var_14.origin, var_1.origin) < 230400 && sighttracepassed(var_11, var_15, 0, undefined)) {
      var_12 = vectortoangles(var_15 - var_11);
      break;
    }
  }

  var_2 setOrigin(var_1.origin, !var_3);
  var_2 setplayerangles(var_12);
  throwingknifeteleport_fxendburst(var_2, var_1);
}

function throwingknifeteleport_fxstartburst(var_0, var_1) {
  var_2 = var_1.origin - var_0.origin;
  var_3 = var_0.origin + (0, 0, 32);
  var_4 = vectorNormalize(var_2);
  var_5 = vectorNormalize(vectorcross(var_2, (0, 0, 1)));
  var_6 = vectorcross(var_5, var_4);
  var_7 = axistoangles(var_4, var_5, var_6);
  var_8 = 0;

  if(var_8) {
    var_9 = spawn("script_model", var_3);
    var_9.angles = var_7;
    var_9 setModel("tag_origin");
    var_9 hidefromplayer(var_0);
    waitframe();
    playfxontagforteam(scripts\engine\utility::getfx("vfx_knife_tele_start_friendly"), var_9, "tag_origin", var_0.team);
    wait 3;
    var_9 delete();
    return;
  }

  var_10 = spawn("script_model", var_3);
  var_10.angles = var_7;
  var_10 setModel("tag_origin");
  var_10 hidefromplayer(var_0);
  waitframe();

  foreach(var_12 in level.players) {
    var_10 hidefromplayer(var_12);
  }

  playFXOnTag(scripts\engine\utility::getfx("vfx_tele_start_friendly"), var_10, "tag_origin");
  wait 3;
  var_10 delete();
}

function recordthrowingknifetraveldist() {
  level endon("game_ended");
  self.owner endon("disconnect");
  self.disttravelled = 0;
  var_0 = self.origin;

  for(;;) {
    var_1 = scripts\engine\utility::ref_143BA(0.15, "death", "missile_stuck");

    if(!isDefined(self)) {
      break;
    }

    var_2 = distance(var_0, self.origin);
    self.disttravelled += var_2;
    var_0 = self.origin;

    if(var_1 != "timeout") {
      break;
    }
  }
}

function throwingknifeteleport_fxendburst(var_0, var_1) {}

function throwingknifec4detonate(var_0, var_1, var_2) {
  var_1 playSound("biospike_explode");
  playFX(scripts\engine\utility::getfx("throwingknifec4_explode"), var_0.origin);
  var_0 radiusdamage(var_0.origin, 180, 1200, 600, var_2, "MOD_EXPLOSIVE", var_0.weapon_name);
  thread grenade_earthquake();
  var_0 notify("explode", var_0.origin);
  var_0 delete();
}

function throwingknifeused_recordownerinvalid(var_0, var_1) {
  var_1 endon("missile_stuck");
  var_1 endon("death");
  var_0 scripts\engine\utility::ref_143A5("death", "disconnect");
  var_1.knifeteleownerinvalid = 1;
}

function watchconcussiongrenadeexplode() {
  thread endondeath();
  self endon("end_explode");
  var_0 = self.owner.name;
  self waittill("explode", var_1);
  level notify("grenade_exploded_during_stealth", var_1, "concussion_grenade_mp", var_0);
  GscBinSkip4(0x35, var_1, self.owner);
}

function stunplayersinrange(var_0, var_1) {
  var_2 = level.players;
  var_3 = scripts\engine\utility::get_array_of_closest(var_0, var_2, undefined, 24, 256);

  foreach(var_5 in var_3) {
    if((scripts\cp\utility::is_friendly_damage(var_5, var_1) && var_5 != var_1) == 0) {
      thread stundamageonplayers(var_5, var_5, var_1);
    }
  }
}

function stundamageonplayers(var_0, var_1, var_2) {
  var_3 = 3;
  var_4 = 3;

  if(var_0 == var_1) {
    var_3 = 2;
    var_4 = 2;
  }

  var_5 = 1 - distance(var_0.origin, var_2) / 512;

  if(var_5 < 0) {
    var_5 = 0;
  }

  var_6 = var_3 + var_4 * var_5;
  var_1 notify("stun_hit");
  var_0 notify("concussed", var_1);
  var_0 scripts\cp\utility::setplayerstunned();
  thread cleanupconcussionstun(var_0);
  var_0 shellshock("concussion_grenade_mp", var_6);
  var_0.concussionendtime = gettime() + var_6 * 1000;
}

function cleanupconcussionstun(var_0) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  wait var_0;
  scripts\cp\utility::setplayerunstunned();
}

function stunenemiesinrange(var_0, var_1) {
  var_2 = scripts\engine\utility::array_combine(scripts\cp\cp_agent_utils::getaliveagentsofteam("axis"), scripts\cp\cp_agent_utils::getaliveagentsofteam("team_three"));
  var_3 = scripts\engine\utility::get_array_of_closest(var_0, var_2, undefined, 24, 500);

  foreach(var_5 in var_3) {
    thread fx_stun_damage(var_5, var_5);
  }
}

function fx_stun_damage(var_0, var_1) {
  var_0 endon("death");

  if(isDefined(var_0.stun_hit_time)) {
    if(gettime() > var_0.stun_hit_time) {
      var_0.allowpain = 1;
      var_0.stun_hit_time = gettime() + 1000;
      var_0.stunned = 1;
      thread ref_12ABB();
    } else {
      return;
    }
  } else {
    var_0.allowpain = 1;
    var_0.stun_hit_time = gettime() + 1000;
    var_0.stunned = 1;
    thread ref_12ABB();
  }

  var_0 dodamage(1, var_0.origin, var_1, var_1, "MOD_GRENADE_SPLASH", "concussion_grenade_mp");
  wait 10;
  var_0.allowpain = 0;
  var_0.stunned = undefined;
}

function ref_12ABB() {
  self endon("death");
  self notify("sturn_accuracy_reduction");
  self endon("sturn_accuracy_reduction");

  if(self.baseaccuracy != 0) {
    self.ref_11FBD = self.baseaccuracy;
  }

  self.baseaccuracy = 0;

  while(istrue(self.stunned)) {
    waitframe();
  }

  if(isDefined(self.ref_11FBD)) {
    self.baseaccuracy = self.ref_11FBD;
    return;
  }
}

function mineused(var_0, var_1) {
  if(!isalive(self)) {
    var_0 delete();
    return;
  }

  thread minethrown(var_0, self, var_0.weapon_name);
}

function minethrown(var_0, var_1, var_2, var_3) {
  self.owner = var_0;
  self waittill("missile_stuck", var_4);

  if(!isDefined(var_0)) {
    return;
  }

  if(var_1 != "trip_mine_mp") {
    if(isDefined(var_4) && isDefined(var_4.owner)) {
      if(isDefined(var_3)) {
        self.owner[[var_3]](self);
      }

      self delete();
      return;
    }
  }

  var_5 = scripts\engine\trace::_bullet_trace(self.origin + (0, 0, 4), self.origin - (0, 0, 4), 0, self);
  var_6 = var_5["position"];

  if(var_5["fraction"] == 1) {
    var_6 = getgroundposition(self.origin, 12, 0, 32);
    var_5 = var_5["normal"] * -1;
  }

  var_7 = vectorNormalize(var_5["normal"]);
  var_8 = vectortoangles(var_7);
  var_8 += (90, 0, 0);
  var_9 = [[var_2]](var_6, var_0, var_1, var_8);
  thread minedamagemonitor();
  self delete();
}

function minedamagemonitor() {
  self endon("mine_triggered");
  self endon("mine_selfdestruct");
  self endon("death");
  self setCanDamage(1);
  self.maxhealth = 100000;
  self.health = self.maxhealth;
  var_0 = undefined;

  for(;;) {
    self waittill("damage", var_1, var_0, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

    if(!isPlayer(var_0) && !isagent(var_0)) {
      continue;
    }

    if(isDefined(var_9) && isendstr(var_9.basename, "betty_mp")) {
      continue;
    }

    if(isDefined(self.owner) && var_0 != self.owner && !scripts\cp\cp_damage::friendlyfirecheck(self.owner, var_0)) {
      continue;
    }

    if(isDefined(var_9)) {
      switch (var_9.basename) {
        case "concussion_grenade_mp":
        case "smoke_grenadejugg_mp":
        case "smoke_grenade_mp":
        case "flash_grenade_mp":
          continue;
      }
    }

    break;
  }

  self notify("mine_destroyed");

  if(isDefined(var_4) && (issubstr(var_4, "MOD_GRENADE") || issubstr(var_4, "MOD_EXPLOSIVE"))) {
    self.waschained = 1;
  }

  if(isDefined(var_8) && var_8 &level.idflags_penetration) {
    self.wasdamagedfrombulletpenetration = 1;
  }

  self.wasdamaged = 1;

  if(isDefined(var_0)) {
    self.damagedby = var_0;
  }

  self notify("detonateExplosive", var_0);
}

function is_hive_explosion(var_0, var_1) {
  if(!isDefined(var_0) || !isDefined(var_0.classname)) {
    return false;
  }

  return var_0.classname == "scriptable" && var_1 == "MOD_EXPLOSIVE";
}

function claymoredetonation(var_0) {
  self endon("death");
  var_1 = spawn("trigger_radius", self.origin + (0, 0, 0 - level.claymoredetonateradius), 0, level.claymoredetonateradius, level.claymoredetonateradius * 2);

  if(isDefined(var_0)) {
    var_1 enablelinkTo();
    var_1 linkTo(var_0);
  }

  thread deleteondeath(var_1);

  for(;;) {
    var_1 waittill("trigger", var_2);

    if(getdvarint("scr_claymoredebug") != 1) {
      if(isDefined(self.owner)) {
        if(var_2 == self.owner) {
          continue;
        }

        if(isDefined(var_2.owner) && var_2.owner == self.owner) {
          continue;
        }
      }

      if(!scripts\cp\cp_damage::friendlyfirecheck(self.owner, var_2, 0)) {
        continue;
      }
    }

    if(lengthsquared(var_2 getentityvelocity()) < 10) {
      continue;
    }

    var_3 = abs(var_2.origin[2] - self.origin[2]);

    if(var_3 > 128) {
      continue;
    }

    if(!shouldaffectclaymore(var_2, self)) {
      continue;
    }

    if(var_2 damageconetrace(self.origin, self) > 0) {
      break;
    }
  }

  explosivetrigger(var_2, level.claymoredetectiongraceperiod, "claymore");
  self notify("detonateExplosive");
}

function explosivetrigger(var_0, var_1, var_2) {
  self setscriptablepartstate("arm", "neutral", 0);
  self setscriptablepartstate("trigger", "active", 0);

  if(isPlayer(var_0) && var_0 scripts\cp\utility::_hasperk("specialty_delaymine")) {
    var_0 notify("triggeredExpl", var_2);
    var_1 = level.delayminetime;
  }

  wait var_1;
}

function shouldaffectclaymore(var_0) {
  if(isDefined(var_0.disabled)) {
    return false;
  }

  var_1 = self.origin + (0, 0, 32);
  var_2 = var_1 - var_0.origin;
  var_3 = anglesToForward(var_0.angles);
  var_4 = vectordot(var_2, var_3);

  if(var_4 < level.claymoredetectionmindist) {
    return false;
  }

  var_2 = vectorNormalize(var_2);
  var_5 = vectordot(var_2, var_3);
  return var_5 > level.claymoredetectiondot;
}

function deleteondeath(var_0) {
  self waittill("death");
  self setscriptablepartstate("destroy", "active", 0);
  wait 0.05;

  if(isDefined(var_0)) {
    if(isDefined(var_0.trigger)) {
      var_0.trigger delete();
    }

    var_0 delete();
    return;
  }
}

function c4empdamage() {
  self endon("death");

  for(;;) {
    self waittill("emp_damage", var_0, var_1);
    equipmentempstunvfx();
    self.disabled = 1;
    self notify("disabled");
    wait var_1;
    self.disabled = undefined;
    self notify("enabled");
  }
}

function equipmentempstunvfx() {
  playFXOnTag(scripts\engine\utility::getfx("emp_stun"), self, "tag_origin");
}

function c4implode(var_0, var_1, var_2) {
  var_1 endon("disconnect");
  wait 0.5;
  var_2 radiusdamage(var_0, 256, 1200, 600, var_1, "MOD_EXPLOSIVE", "c4_mp_p");
  thread c4_earthquake();
}

function resetc4explodethisframe() {
  wait 0.05;
  level.c4explodethisframe = 0;
}

function onlethalequipmentplanted(var_0, var_1, var_2) {
  if(self.plantedlethalequip.size) {
    self.plantedlethalequip = scripts\engine\utility::array_removeundefined(self.plantedlethalequip);

    if(self.plantedlethalequip.size >= level.maxperplayerexplosives) {
      if(istrue(var_2)) {
        self.plantedlethalequip[0] notify("detonateExplosive");
      } else {
        deleteexplosive(self.plantedlethalequip[0]);
      }
    }
  }

  self.plantedlethalequip[self.plantedlethalequip.size] = var_0;
  var_3 = var_0 getentitynumber();
  level.mines[var_3] = var_0;
  level notify("mine_planted");
}

function bankingoverlimitwillendot(var_0) {
  var_1 = var_0 getentitynumber();
  level.mines[var_1] = var_0;
}

function watchc4altdetonate(var_0) {
  self notify("watchC4AltDetonate");
  self endon("watchC4AltDetonate");
  self endon("death");
  self endon("disconnect");
  self endon("detonated");
  level endon("game_ended");
  var_1 = 0;

  for(;;) {
    if(self useButtonPressed()) {
      var_1 = 0;

      while(self useButtonPressed()) {
        var_1 += 0.05;
        wait 0.05;
      }

      if(var_1 >= 0.5) {
        continue;
      }

      var_1 = 0;

      while(!self useButtonPressed() && var_1 < 0.5) {
        var_1 += 0.05;
        wait 0.05;
      }

      if(var_1 >= 0.5) {
        continue;
      }

      if(!self.plantedlethalequip.size) {
        return;
      }

      self notify("alt_detonate");
    }

    wait 0.05;
  }
}

function watchc4altdetonation() {
  self notify("watchC4AltDetonation");
  self endon("watchC4AltDetonation");
  self endon("death");
  self endon("disconnect");

  for(;;) {
    self waittill("alt_detonate");
    var_0 = self getcurrentweapon();

    if(var_0.basename != "c4_mp_p") {
      c4detonateallcharges();
    }
  }
}

function watchc4detonation() {
  self notify("watchC4Detonation");
  self endon("watchC4Detonation");
  self endon("death");
  self endon("disconnect");
  var_0 = getcompleteweaponname("c4_mp_p");

  for(;;) {
    self waittillmatch("detonate", var_0);
    c4detonateallcharges();
  }
}

function c4detonateallcharges() {
  foreach(var_1 in self.plantedlethalequip) {
    if(isDefined(var_1) && var_1.weapon_name == "c4_mp_p") {
      thread waitanddetonate(var_1);
      scripts\engine\utility::array_remove(self.plantedlethalequip, var_1);
    }
  }

  self notify("c4_update", 0);
  waittillframeend();
  self notify("detonated");
}

function waitanddetonate(var_0) {
  self endon("death");
  wait var_0;
  waittillenabled();
  self notify("detonateExplosive");
}

function waittillenabled() {
  if(!isDefined(self.disabled)) {
    return;
  }

  self waittill("enabled");
}

function clustergrenadeused() {
  var_0 = self.originalowner;
  var_0 endon("disconnect");
  thread ownerdisconnectcleanup(var_0);
  var_1 = [];

  for(var_2 = 0; var_2 < 4; var_2++) {
    var_1 = 0.2;
  }

  var_3 = 0;

  foreach(var_5 in var_1) {
    var_3 += var_5;
  }

  var_7 = spawn("script_model", self.origin);
  var_7 linkTo(self);
  var_7 setModel("tag_origin");
  var_7 setscriptmoverkillcam("explosive");
  thread deathdelaycleanup(var_7, self);
  thread ownerdisconnectcleanup(var_7);
  var_7.threwback = self.threwback;
  var_8 = var_0 scripts\cp\utility::_launchgrenade("cluster_grenade_indicator_mp", self.origin, (0, 0, 0));
  var_8 linkTo(self);
  thread deathdelaycleanup(var_8, self);
  thread ownerdisconnectcleanup(var_8);
  thread scripts\cp\utility::notifyafterframeend("death", "end_explode");
  self endon("end_explode");
  self waittill("explode", var_9);
  thread clustergrenadeexplode(var_9, var_1, var_0, var_7);
}

function clustergrenadeexplode(var_0, var_1, var_2, var_3) {
  var_2 endon("disconnect");
  var_4 = scripts\engine\trace::create_contents(0, 1, 1, 0, 1, 0, 0);
  var_5 = 0;
  var_6 = var_0 + (0, 0, 3);
  var_7 = var_6 + (0, 0, -5);
  var_8 = physics_raycast(var_6, var_7, var_4, undefined, 0, "physicsquery_closest");

  if(isDefined(var_8) && var_8.size > 0) {
    var_5 = 1;
  }

  var_9 = scripts\engine\utility::ter_op(var_5, (0, 0, 32), (0, 0, 2));
  var_10 = var_0 + var_9;
  var_11 = randomint(90) - 45;
  var_4 = scripts\engine\trace::create_contents(0, 1, 1, 0, 1, 0, 0);

  for(var_12 = 0; var_12 < 4; var_12++) {
    var_3.shellshockondamage = scripts\engine\utility::ter_op(var_12 == 0, 1, undefined);
    var_3 radiusdamage(var_0, 256, 800, 400, var_2, "MOD_EXPLOSIVE", "cluster_grenade_zm");
    var_13 = scripts\engine\utility::ter_op(var_12 < 4, 90 * var_12 + var_11, randomint(360));
    var_14 = scripts\engine\utility::ter_op(var_5, 110, 90);
    var_15 = scripts\engine\utility::ter_op(var_5, 12, 45);
    var_16 = var_14 + randomint(var_15 * 2) - var_15;
    var_17 = randomint(60) + 30;
    var_18 = cos(var_13) * sin(var_16);
    var_19 = sin(var_13) * sin(var_16);
    var_20 = cos(var_16);
    var_21 = (var_18, var_19, var_20) * var_17;
    var_6 = var_10;
    var_7 = var_10 + var_21;
    var_8 = physics_raycast(var_6, var_7, var_4, undefined, 0, "physicsquery_closest");

    if(isDefined(var_8) && var_8.size > 0) {
      var_7 = var_8[0]["position"];
    }

    playFX(scripts\engine\utility::getfx("clusterGrenade_explode"), var_7);

    switch (var_12) {
      case 0:
        playsoundatpos(var_7, "frag_grenade_expl_trans");
        break;
      case 3:
        playsoundatpos(var_7, "cluster_explode_end");
        break;
      default:
        playsoundatpos(var_7, "cluster_explode_mid");
        break;
    }

    wait var_1[var_12];
  }
}

function deathdelaycleanup(var_0, var_1) {
  self endon("death");
  var_0 waittill("death");
  wait var_1;
  self delete();
}

function ownerdisconnectcleanup(var_0) {
  self endon("death");
  var_0 waittill("disconnect");
  self delete();
}

function semtexused(var_0) {
  if(!isDefined(var_0)) {
    return;
  }

  var_0.originalowner = self;
  var_0 setentityowner(self);
  var_0 setotherent(self);
  thread semtex_watch_cleanup();
  thread semtex_watch_fuse();
  var_1 = var_0.owner.name;
  var_0 waittill("missile_stuck", var_2);
  level notify("grenade_exploded_during_stealth", var_0.origin, "semtex_mp", var_1);
  thread grenade_earthquake();
  explosivehandlemovers(var_0, undefined);
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

function semtex_delete(var_0) {
  self notify("death");
  self.exploding = 1;
  wait var_0;
  self delete();
}

function semtex_watch_cleanup() {
  self endon("death");
  semtex_watch_cleanup_end_early();

  if(isDefined(self)) {
    thread semtex_destroy();
    return;
  }
}

function semtex_watch_cleanup_end_early() {
  self.owner endon("disconnect");
  self.owner endon("joined_team");
  self.owner endon("joined_spectators");
  level endon("game_ended");

  for(;;) {
    waitframe();
  }
}

function canweaponhaveattachment(var_0, var_1) {
  var_2 = scripts\cp\utility::getweaponattachmentsbasenames(var_0);

  foreach(var_1 in var_2) {}
}

function doesattachmentconflict(var_0, var_1) {
  foreach(var_3 in level.br_pickups.br_pickupconflicts[var_1]) {
    if(attachmentisdefault(var_0)) {
      continue;
    }

    var_4 = scripts\cp\utility::attachmentmap_tobase(var_0);

    if(var_4 == var_3) {
      return true;
    }
  }

  return false;
}

function attachmentisdefault(var_0) {
  return isDefined(var_0) && (scripts\engine\utility::string_starts_with(var_0, "rec") || scripts\engine\utility::string_starts_with(var_0, "front") || scripts\engine\utility::string_starts_with(var_0, "back") || scripts\engine\utility::string_starts_with(var_0, "mag") || scripts\engine\utility::string_starts_with(var_0, "guard") || scripts\engine\utility::string_starts_with(var_0, "triggrip") || scripts\engine\utility::string_starts_with(var_0, "toprail"));
}

function hasattachmentconflictwithweapon(var_0, var_1) {
  return hasattachmentconflict(getweaponattachments(var_0), var_1);
}

function hasattachmentconflict(var_0, var_1) {
  if(var_1 == -1) {
    return true;
  }

  foreach(var_3 in var_0) {
    if(doesattachmentconflict(var_3, var_1)) {
      return true;
    }
  }

  return false;
}

function removeattachmentsandgiveweapon(var_0, var_1) {
  if(!isDefined(var_0) || !isDefined(self) || !isPlayer(self)) {
    return;
  }

  var_2 = var_1;
  var_3 = self getweaponammoclip(var_2);
  var_4 = self getweaponammostock(var_2);
  var_5 = scripts\cp\utility::getweaponattachmentsbasenames(var_2);

  for(var_6 = 0; var_6 < var_0.size; var_6++) {
    if(scripts\engine\utility::array_contains(var_5, var_0[var_6])) {
      var_5 = scripts\engine\utility::array_remove(var_5, var_0[var_6]);
    }
  }

  scripts\cp\cp_weapons::_takeweapon(var_2);
  var_7 = scripts\cp\utility::getweaponrootname(var_2.basename);
  var_8 = buildweaponuniqueattachments(var_7, var_5, -1);

  if(isDefined(var_2.attachments)) {
    foreach(var_10 in var_2.attachments) {
      var_2 = var_2 withoutattachment(var_10);
    }
  }

  foreach(var_13 in var_8) {
    var_2 = var_2 withattachment(var_13);
  }

  self giveweapon(var_2);
  self setweaponammoclip(var_2, var_3);
  self setweaponammostock(var_2, var_4);
  self switchtoweapon(var_2);
}

function remove_attachment(var_0, var_1, var_2) {
  if(!isDefined(var_0) && !isDefined(var_1)) {
    return;
  }

  var_3 = [];
  var_4 = undefined;
  var_5 = undefined;

  if(isDefined(var_2)) {
    if(issameweapon(var_2)) {
      var_3 = var_2;
    } else {
      var_3 = asmdevgetallstates(var_2);
    }
  } else {
    var_3 = var_1 getweaponslistall();
  }

  foreach(var_7 in var_3) {
    if(var_7 hasattachment(var_0, 1)) {
      var_8 = scripts\cp\utility::getrawbaseweaponname(var_7);
      var_9 = getweaponbasename(var_7);
      var_1 takeweapon(var_7);
      var_10 = getweaponattachments(var_7);

      foreach(var_12 in var_10) {
        if(issubstr(var_12, var_0)) {
          var_10 = scripts\engine\utility::array_remove(var_10, var_12);
          break;
        }
      }

      if(isDefined(level.build_weapon_name_func)) {
        var_5 = var_1[[level.build_weapon_name_func]](var_9, var_10);
      }

      if(isDefined(var_5)) {
        var_3 = self getweaponslistprimaries();

        foreach(var_2 in var_3) {
          if(issubstr(var_2.basename, var_5.basename)) {
            if(var_2.isalternate) {
              var_9 = getweaponbasename(var_2);

              if(isDefined(level.alt_mode_weapons_allowed) && scripts\engine\utility::array_contains(level.alt_mode_weapons_allowed, var_9)) {
                var_5 = var_5 getaltweapon();
                break;
              }
            }
          }
        }

        var_1 scripts\cp\utility::_giveweapon(var_5, -1, -1, 1);
        var_1 switchtoweapon(var_5);
      }
    }
  }
}

function has_weapon_variation(var_0) {
  var_1 = self getweaponslistall();
  var_2 = undefined;

  if(issameweapon(var_0)) {
    var_2 = var_0.basename;
  } else {
    var_2 = var_0;
  }

  foreach(var_4 in var_1) {
    var_5 = scripts\cp\utility::getrawbaseweaponname(var_2);
    var_6 = scripts\cp\utility::getrawbaseweaponname(var_4);

    if(var_5 == var_6) {
      return true;
    }
  }

  return false;
}

function has_weapon_variation_without_attachments(var_0, var_1) {
  var_2 = self getweaponslistall();

  foreach(var_4 in var_2) {
    if(var_1 == var_4.basename) {
      var_5 = [];

      foreach(var_7 in var_4.attachments) {
        var_5 = scripts\cp\utility::attachmentmap_tobase(var_7);
      }

      foreach(var_10 in var_0) {
        if(scripts\engine\utility::array_contains(var_5, var_10)) {
          return false;
        }

        return true;
      }

      var_10 = undefined;
    }
  }

  var_4 = undefined;
  var_5 = undefined;
  return false;
}

function get_weapon_variation_obj(var_0) {
  var_1 = self getweaponslistall();
  var_2 = [];
  var_3 = undefined;

  if(issameweapon(var_0)) {
    var_3 = var_0.basename;
  } else {
    var_3 = var_0;
  }

  foreach(var_5 in var_1) {
    var_6 = scripts\cp\utility::getrawbaseweaponname(var_3);
    var_7 = scripts\cp\utility::getrawbaseweaponname(var_5);

    if(var_6 == var_7) {
      var_2 = var_5;
    }
  }

  return var_2;
}

function buildattachmentmaps() {
  level.attachmentmap_uniquetobase = [];
  level.attachmentmap_uniquetoextra = [];
  level.weaponattachments = [];
  var_0 = [];
  var_1 = 1;

  for(var_2 = tablelookupbyrow("mp/attachmentmap.csv", var_1, 0); var_2 != ""; var_2 = tablelookupbyrow("mp/attachmentmap.csv", var_1, 0)) {
    if(scripts\cp_mp\utility\weapon_utility::vehicle_ai_script_models(var_2)) {
      var_0 = var_2;
    }

    var_1++;
  }

  var_3 = [];
  var_4 = 1;

  for(var_5 = tablelookupbyrow("mp/attachmentmap.csv", 0, var_4); var_5 != ""; var_5 = tablelookupbyrow("mp/attachmentmap.csv", 0, var_4)) {
    var_3 = var_4;
    var_4++;
  }

  level.attachmentmap_basetounique = [];

  foreach(var_2 in var_0) {
    foreach(var_10, var_8 in var_3) {
      var_9 = tablelookup("mp/attachmentmap.csv", 0, var_2, var_8);

      if(var_9 == "") {
        continue;
      }

      if(!isDefined(level.attachmentmap_basetounique[var_2])) {
        level.attachmentmap_basetounique[var_2] = [];
      }

      level.attachmentmap_basetounique[var_2][var_10] = var_9;

      if(!isDefined(level.attachmentmap_uniquetobase[var_9])) {
        level.attachmentmap_uniquetobase[var_9] = var_10;
        continue;
      }

      if(level.attachmentmap_uniquetobase[var_9] != var_10) {}
    }
  }

  foreach(var_20, var_13 in level.weaponmapdata) {
    var_14 = getsubstr(var_20, 4);
    var_15 = "mp/gunsmith/" + var_14 + "_progression.csv";

    if(!tableexists(var_15)) {
      continue;
    }

    level.weaponattachments[var_20] = [];
    var_1 = 1;
    var_16 = tablelookupbyrow(var_15, var_1, 0);
    var_17 = tablelookupbyrow(var_15, var_1, 1);
    var_18 = "loot/iw8_" + var_14 + "_attachment_ids.csv";

    while(var_16 != "") {
      if(var_17 != "") {
        var_19 = tablelookup(var_18, 0, var_17, 1);

        if(var_19 != "") {
          level.weaponattachments[var_20][var_19] = var_19;
        }
      }

      var_1++;
      var_16 = tablelookupbyrow(var_15, var_1, 0);
      var_17 = tablelookupbyrow(var_15, var_1, 1);
    }
  }

  level.attachmentmap_attachtoperk = [];
  level.carrier_remove_carriable_weapon = [];
  level.carry_ref = [];
  level.carryobjects_onjuggernaut = [];
  var_21 = getattachmentlistuniquenames();

  foreach(var_23 in var_21) {
    var_24 = tablelookup("mp/attachmenttable.csv", 4, var_23, 2);
    var_25 = scripts\cp\utility::attachmentmap_tobase(var_23);

    if(var_24 != "" && isDefined(var_25)) {
      var_26 = level.carry_ref[var_25];

      if(!isDefined(var_26)) {
        level.carry_ref[var_25] = var_24;
      } else if(var_24 != var_26) {
        level.carryobjects_onjuggernaut[var_23] = var_24;
      }
    }

    var_27 = tablelookup("mp/attachmenttable.csv", 4, var_23, 12);

    if(var_27 != "") {
      level.attachmentmap_attachtoperk[var_23] = var_27;
    }

    var_28 = tablelookup("mp/attachmenttable.csv", 4, var_23, 13);

    if(var_28 != "") {
      level.attachmentmap_uniquetoextra[var_23] = var_28;
    }

    var_29 = tablelookup("mp/attachmenttable.csv", 4, var_23, 9);

    if(var_29 != "") {
      level.carrier_remove_carriable_weapon[var_23] = var_29;
    }
  }

  level.attachmentmap_conflicts = [];
  var_31 = 1;

  for(var_32 = tablelookupbyrow("mp/attachmentcombos.csv", var_31, 0); var_32 != ""; var_32 = tablelookupbyrow("mp/attachmentcombos.csv", var_31, 0)) {
    var_33 = 1;

    for(var_34 = tablelookupbyrow("mp/attachmentcombos.csv", 0, var_33); var_34 != ""; var_34 = tablelookupbyrow("mp/attachmentcombos.csv", 0, var_33)) {
      if(var_32 != var_34) {
        var_35 = tablelookupbyrow("mp/attachmentcombos.csv", var_31, var_33);
        var_36 = scripts\engine\utility::alphabetize([var_32, var_34]);
        var_37 = var_36[0] + "_" + var_36[1];

        if(var_35 == "no" && !isDefined(level.attachmentmap_conflicts[var_37])) {
          level.attachmentmap_conflicts[var_37] = 1;
        } else if(var_35 != "") {
          level.attachmentmap_conflicts[var_37] = var_35;
        }
      }

      var_33++;
    }

    var_31++;
  }
}

function getattachmentlistuniquenames() {
  var_0 = [];
  var_1 = 0;

  for(var_2 = tablelookup("mp/attachmenttable.csv", 0, var_1, 4); var_2 != ""; var_2 = tablelookup("mp/attachmenttable.csv", 0, var_1, 4)) {
    var_0 = var_2;
    var_1++;
  }

  return var_0;
}

function create_zombie_base_to_unique_map(var_0, var_1, var_2, var_3) {
  if(var_0 == "zombie") {
    foreach(var_5 in var_1) {
      foreach(var_9, var_7 in var_2) {
        var_8 = tablelookup(var_3, 0, var_5, var_7);

        if(var_8 == "") {
          continue;
        }

        if(!isDefined(level.attachmentmap_basetounique[var_5])) {
          level.attachmentmap_basetounique[var_5] = [];
        }

        if(var_8 == "none") {
          level.attachmentmap_basetounique[var_5][var_9] = undefined;
          continue;
        }

        level.attachmentmap_basetounique[var_5][var_9] = var_8;
      }
    }

    return;
  }
}

function grenade_earthquake(var_0) {
  self notify("grenade_earthQuake");
  self endon("grenade_earthQuake");
  thread endondeath();
  self endon("end_explode");
  var_1 = undefined;

  if(!isDefined(var_0) || var_0) {
    self waittill("explode", var_1);
  } else {
    var_1 = self.origin;
  }

  playrumbleonposition("grenade_rumble", var_1);
  earthquake(0.5, 0.75, var_1, 800);

  foreach(var_3 in level.players) {
    if(var_3 scripts\cp\utility::isusingremote()) {
      continue;
    }

    if(distancesquared(var_1, var_3.origin) > 360000) {
      continue;
    }

    if(var_3 damageconetrace(var_1)) {
      thread dirteffect(var_3);
    }

    var_3 setclientomnvar("ui_hud_shake", 1);
  }
}

function c4_earthquake() {
  thread endondeath();
  self endon("end_explode");
  self waittill("explode", var_0);
  playrumbleonposition("grenade_rumble", var_0);
  earthquake(0.4, 0.75, var_0, 512);

  foreach(var_2 in level.players) {
    if(var_2 scripts\cp\utility::isusingremote()) {
      continue;
    }

    if(distance(var_0, var_2.origin) > 512) {
      continue;
    }

    if(var_2 damageconetrace(var_0)) {
      thread dirteffect(var_2);
    }

    var_2 setclientomnvar("ui_hud_shake", 1);
  }
}

function endondeath() {
  self waittill("death");
  waittillframeend();
  self notify("end_explode");
}

function dirteffect(var_0) {
  self notify("dirtEffect");
  self endon("dirtEffect");
  self endon("disconnect");

  if(!scripts\cp_mp\utility\player_utility::_isalive()) {
    return;
  }

  var_1 = vectorNormalize(anglesToForward(self.angles));
  var_2 = vectorNormalize(anglestoright(self.angles));
  var_3 = vectorNormalize(var_0 - self.origin);
  var_4 = vectordot(var_3, var_1);
  var_5 = vectordot(var_3, var_2);
  var_6 = ["death", "damage"];
  var_7 = self getcurrentweapon();

  if(var_4 > 0 && var_4 > 0.5 && var_7.basename != "iw6_riotshield_mp") {
    scripts\engine\utility::waittill_any_in_array_or_timeout(var_6, 2);
    return;
  }

  if(abs(var_4) < 0.866) {
    if(var_5 > 0) {
      scripts\engine\utility::waittill_any_in_array_or_timeout(var_6, 2);
      return;
    }

    scripts\engine\utility::waittill_any_in_array_or_timeout(var_6, 2);
    return;
  }
}

function shellshockondamage(var_0, var_1) {
  if(isflashbanged()) {
    return;
  }

  if(var_0 == "MOD_EXPLOSIVE" || var_0 == "MOD_GRENADE" || var_0 == "MOD_GRENADE_SPLASH" || var_0 == "MOD_PROJECTILE" || var_0 == "MOD_PROJECTILE_SPLASH") {
    if(var_1 > 10) {
      if(isDefined(self.shellshockreduction) && self.shellshockreduction) {
        self shellshock("damage_cp", self.shellshockreduction);
        return;
      }

      self shellshock("damage_cp", 0.5);
      return;
    }

    return;
  }
}

function isflashbanged() {
  return isDefined(self.flashendtime) && gettime() < self.flashendtime;
}

function waittill_grenade_fire() {
  for(;;) {
    self waittill("grenade_fire", var_0, var_1, var_2, var_3);

    if(isDefined(self.throwinggrenade) && var_1.basename != self.throwinggrenade) {
      continue;
    }

    if(isDefined(var_0)) {
      if(!isDefined(var_0.weapon_obj)) {
        var_0.weapon_obj = var_1;
      }

      if(!isDefined(var_0.weapon_name)) {
        var_0.weapon_name = var_1.basename;
      }

      if(!isDefined(var_0.owner)) {
        var_0.owner = self;
      }

      if(!isDefined(var_0.team)) {
        var_0.team = self.team;
      }

      if(!isDefined(var_0.ticks) && isDefined(self.throwinggrenade)) {
        var_0.ticks = scripts\cp\utility::roundup(4 * var_2);
      }
    }

    grenadeinitialize(var_0, var_1, var_2, var_3);

    if(!scripts\cp_mp\utility\player_utility::_isalive() && !isDefined(self.throwndyinggrenade)) {
      self notify("grenade_fire_dead", var_0, var_1.basename);
      self.throwndyinggrenade = 1;
    }

    if(istrue(var_0.threwback)) {
      scripts\cp\cp_powers::power_adjustcharges(1, "primary");
    }

    return var_0;
  }
}

function grenadestuckto(var_0, var_1, var_2) {
  if(!isDefined(self)) {
    var_0.stuckenemyentity = var_1;
    var_1.stuckbygrenade = var_0;
    return;
  }

  if(level.teambased && scripts\engine\utility::is_equal(var_1.team, self.team)) {
    var_0.isstuck = "friendly";
    return;
  }

  var_3 = undefined;

  if(!isDefined(var_0.weapon_name)) {
    return;
  }

  switch (var_0.weapon_name) {
    case "semtex_mp":
      var_3 = "semtex_stuck";
      break;
    case "molotov_mp":
      var_3 = "molotov_stuck";
      break;
    case "pop_rocket_proj_mp":
      var_3 = "flare_gun_attacker_stuck";
      break;
    case "thermite_mp":
      var_3 = "thermite_attacker_stuck";
      break;
  }

  var_0.isstuck = "enemy";
  var_0.stuckenemyentity = var_1;
  var_1.stuckbygrenade = var_0;
  self notify("grenade_stuck_enemy");

  if(isPlayer(var_1)) {
    level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(var_1, "incoming_stuck");
    return;
  }
}

function grenadestucktosplash(var_0, var_1) {
  var_2 = self;

  if(isPlayer(var_1) && isDefined(var_0)) {
    if(isDefined(var_2.owner)) {
      var_2 = var_2.owner;
    }

    var_2 scripts\cp\cp_hud_message::showsplash(var_0);
    return;
  }
}

function can_use_attachment(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = self getcurrentweapon();
  }

  var_2 = getweaponbasename(var_1);
  var_3 = var_1.classname;
  var_4 = get_possible_attachments_by_weaponclass(var_3, var_2, var_0);

  if(!var_4) {
    return false;
  }

  return true;
}

function add_attachment_to_weapon(var_0, var_1, var_2, var_3) {
  var_4 = undefined;

  if(isDefined(var_1)) {
    if(issameweapon(var_1)) {
      var_4 = var_1;
    } else {
      var_4 = asmdevgetallstates(var_1);
    }
  } else {
    var_4 = scripts\cp\utility::getvalidtakeweapon();
  }

  var_5 = getweaponbasename(var_4);
  var_6 = 0;
  var_7 = getweaponattachments(var_4);
  var_8 = scripts\cp\utility::getcurrentcamoname(var_4);
  var_9 = return_weapon_name_with_like_attachments(var_4, var_0, var_7, undefined, var_8);

  if(!isDefined(var_9)) {
    return false;
  }

  var_10 = asmdevgetallstates(var_9);

  if(nullweapon(var_10)) {
    return false;
  }

  var_11 = var_4.isalternate;

  if(var_10 hasattachment("xmags", 1)) {
    var_6 = 1;
  }

  if(isDefined(var_0)) {
    if(!issubstr(var_0, "pap")) {
      var_12 = self getweaponammoclip(var_4);
      var_13 = self getweaponammostock(var_4);

      if(var_10 hasattachment("akimbo", 1)) {
        var_14 = self getweaponammoclip(var_4, "left");
      } else {
        var_14 = undefined;
      }

      self takeweapon(var_5);
      scripts\cp\utility::_giveweapon(var_11, undefined, undefined, 1);

      if(var_11 hasattachment("xmags", 1) && !var_7) {
        var_13 = weaponclipsize(var_11);
      }

      self setweaponammoclip(var_11, var_13);
      self setweaponammostock(var_11, var_14);

      if(isDefined(var_14)) {
        self setweaponammoclip(var_11, var_14, "left");
      }
    } else {
      self takeweapon(var_5);
      scripts\cp\utility::_giveweapon(var_11, undefined, undefined, 0);
      self givemaxammo(var_11);
    }
  }

  self playlocalsound("weap_raise_large_plr");
  var_15 = self getweaponslistprimaries();

  foreach(var_2 in var_15) {
    if(issubstr(var_2.basename, var_11.basename)) {
      if(var_2.isalternate) {
        var_17 = getweaponbasename(var_2);

        if(isDefined(level.alt_mode_weapons_allowed) && scripts\engine\utility::array_contains(level.alt_mode_weapons_allowed, var_17) || var_12) {
          var_11 = var_11 getaltweapon();
          break;
        }
      }
    }
  }

  var_15 = undefined;
  var_16 = undefined;

  if(istrue(var_3)) {
    return true;
  }

  if(istrue(var_2)) {
    self switchtoweaponimmediate(var_10);
  } else {
    self switchtoweapon(var_10);
  }

  return true;
}

function isforgefreezeweapon(var_0) {
  if(!isDefined(var_0)) {
    return false;
  }

  if(isDefined(var_0)) {
    if(var_0 == "iw7_forgefreeze_zm" || var_0 == "iw7_forgefreeze_zm_pap1" || var_0 == "iw7_forgefreeze_zm_pap2" || var_0 == "zfreeze_semtex_mp") {
      return true;
    }
  }

  return false;
}

function issteeldragon(var_0) {
  var_1 = getweaponbasename(var_0);

  if(!isDefined(var_1)) {
    return false;
  }

  return var_1 == "iw7_steeldragon_zm";
}

function is_perk_attachment(var_0) {
  if(!isDefined(var_0)) {
    return false;
  }

  if(var_0 == "doubletap") {
    return true;
  }

  return false;
}

function is_arcane_attachment(var_0) {
  if(!isDefined(var_0)) {
    return false;
  }

  if(issubstr(var_0, "ark")) {
    return true;
  }

  if(issubstr(var_0, "arcane")) {
    return true;
  }

  return false;
}

function is_mod_attachment(var_0) {
  if(!isDefined(var_0)) {
    return false;
  }

  if(issubstr(var_0, "mod")) {
    return true;
  }

  return false;
}

function is_default_attachment(var_0, var_1) {
  var_2 = scripts\cp\utility::weaponattachdefaultmap(var_1);

  if(!isDefined(var_2) || var_2.size < 1) {
    return false;
  }

  foreach(var_4 in var_2) {
    if(var_0 == var_4) {
      return true;
    }
  }

  return false;
}

function is_pap_attachment(var_0) {
  if(!isDefined(var_0)) {
    return false;
  }

  if(issubstr(var_0, "pap")) {
    return true;
  }

  return false;
}

function get_possible_attachments_by_weaponclass(var_0, var_1, var_2) {
  if(!isDefined(var_0)) {
    return false;
  }

  if(!isDefined(var_1)) {
    return false;
  }

  if(!isDefined(var_2)) {
    return false;
  }

  var_3 = [];
  var_4 = scripts\cp\utility::getbaseweaponname(var_1);

  if(isDefined(level.attachmentmap_basetounique[var_4])) {
    if(isDefined(level.attachmentmap_basetounique[var_4][var_2])) {
      if(level.attachmentmap_basetounique[var_4][var_2] != "none") {
        return true;
      } else {
        return false;
      }
    }
  }

  if(isDefined(level.attachmentmap_basetounique[var_0])) {
    if(isDefined(level.attachmentmap_basetounique[var_0][var_2])) {
      if(level.attachmentmap_basetounique[var_0][var_2] != "none") {
        return true;
      } else {
        return false;
      }
    }
  }

  if(isDefined(level.attachmentmap_basetounique[var_4])) {
    var_5 = getarraykeys(level.attachmentmap_basetounique[var_4]);

    foreach(var_7 in var_5) {
      if(level.attachmentmap_basetounique[var_4][var_7] == var_2) {
        if(level.attachmentmap_basetounique[var_4][var_7] != "none") {
          return true;
        }

        return false;
      }
    }
  }

  if(isDefined(level.attachmentmap_basetounique[var_0])) {
    var_5 = getarraykeys(level.attachmentmap_basetounique[var_0]);

    foreach(var_7 in var_5) {
      if(level.attachmentmap_basetounique[var_0][var_7] == var_2) {
        if(level.attachmentmap_basetounique[var_0][var_7] != "none") {
          return true;
        }

        return false;
      }
    }
  }

  return false;
}

function return_weapon_name_with_like_attachments(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_0)) {
    if(issameweapon(var_0)) {
      var_5 = var_0;
    } else {
      var_5 = asmdevgetallstates(var_1);
    }
  } else {
    var_5 = self getcurrentweapon();
  }

  var_6 = getweaponbasename(var_5);
  var_7 = scripts\cp\utility::get_weapon_variant_id(self, var_5);
  var_8 = 0;
  var_9 = 0;
  var_10 = 0;
  var_11 = 0;
  var_12 = undefined;
  var_13 = [];
  var_14 = 7;
  var_15 = [];
  var_16 = 1;
  var_17 = [];
  var_18 = 1;
  var_19 = [];
  var_20 = 1;
  var_21 = [];
  var_22 = 1;
  var_23 = [];
  var_24 = 1;
  var_25 = [];
  var_26 = 12;
  var_27 = var_5.classname;

  if(var_5 hasattachment("xmags", 1)) {
    var_9 = 1;
  }

  var_28 = get_possible_attachments_by_weaponclass(var_27, var_6, var_3);

  if(!var_28 && isDefined(var_3)) {
    if(!istrue(var_5)) {
      scripts\cp\utility::setlowermessage("cant_attach", &"COOP_PILLAGE/CANT_USE", 3);
    }

    return undefined;
  }

  if(!isDefined(var_4)) {
    var_4 = getweaponattachments(var_5);
  }

  if(scripts\cp\utility::has_zombie_perk("perk_machine_rat_a_tat")) {
    if(get_possible_attachments_by_weaponclass(var_27, var_6, "doubletap")) {
      var_4 = "doubletap";
    }
  }

  if(isDefined(var_3)) {
    if(weaponclass(var_2) == "spread") {
      if(issubstr(var_3, "arkyellow")) {
        foreach(var_30 in var_4) {
          if(issubstr(var_30, "smart")) {
            var_4 = scripts\engine\utility::array_remove(var_4, var_30);
          }
        }
      }
    }
  }

  var_4 = scripts\engine\utility::array_remove_duplicates(var_4);
  var_4 = scripts\engine\utility::array_removeundefined(var_4);

  if(var_4.size > 0 && var_4.size <= var_26) {
    foreach(var_33 in var_4) {
      if(is_pap_attachment(var_33)) {
        if(var_17.size < var_18) {
          var_17 = var_33;
          var_25 = var_33;
        } else {
          continue;
        }

        continue;
      }

      if(is_arcane_attachment(var_33)) {
        if(var_23.size < var_24) {
          var_23 = var_33;
          var_25 = var_33;
        } else {
          continue;
        }

        continue;
      }

      if(is_mod_attachment(var_33)) {
        if(var_19.size < var_20) {
          var_19 = var_33;
          var_25 = var_33;
        } else {
          continue;
        }

        continue;
      }

      if(is_default_attachment(var_33, scripts\cp\utility::getweaponrootname(var_6))) {
        if(var_21.size < var_22) {
          var_21 = var_33;
          var_25 = var_33;
        } else {
          continue;
        }

        continue;
      }

      if(is_perk_attachment(var_33)) {
        if(var_15.size < var_16) {
          var_15 = var_33;
          var_25 = var_33;
        } else {
          continue;
        }

        continue;
      }

      if(var_13.size < var_14) {
        var_13 = var_33;
        var_25 = var_33;
        continue;
      }
    }
  }

  if(isDefined(var_3)) {
    var_35 = scripts\cp\utility::attachmentmap_tobase(var_3);

    if(isDefined(var_35) && var_35 != "none") {
      for(var_36 = 0; var_36 < var_25.size; var_36++) {
        var_37 = scripts\cp\utility::attachmentmap_tobase(var_25[var_36]);

        if(var_37 == var_35) {
          var_25 = var_3;
          var_8 = 1;
          break;
        }
      }
    }

    var_38 = scripts\cp\utility::getattachmenttype(var_3);

    if(isDefined(var_38) && var_38 != "none") {
      if(!var_8) {
        if(is_pap_attachment(var_3)) {
          if(var_17.size < var_18) {
            var_17 = var_3;
            var_25 = var_3;
          } else {
            for(var_36 = 0; var_36 < var_25.size; var_36++) {
              var_39 = scripts\cp\utility::getattachmenttype(var_25[var_36]);

              if(var_39 == var_38) {
                var_17 = var_3;
                var_25 = var_3;
                var_8 = 1;
                break;
              }
            }
          }
        } else if(is_arcane_attachment(var_3)) {
          if(var_23.size < var_24) {
            var_23 = var_3;
            var_25 = var_3;
          } else {
            for(var_36 = 0; var_36 < var_25.size; var_36++) {
              var_39 = scripts\cp\utility::getattachmenttype(var_25[var_36]);

              if(var_39 == var_38) {
                var_23 = var_3;
                var_25 = var_3;
                var_8 = 1;
                break;
              }
            }
          }
        } else if(is_perk_attachment(var_3)) {
          if(var_15.size < var_16) {
            var_15 = var_3;
            var_25 = var_3;
          } else {
            for(var_36 = 0; var_36 < var_25.size; var_36++) {
              var_39 = scripts\cp\utility::getattachmenttype(var_25[var_36]);

              if(var_39 == var_38) {
                var_15 = var_3;
                var_25 = var_3;
                var_8 = 1;
                break;
              }
            }
          }
        } else if(var_13.size < var_14) {
          var_13 = var_3;
          var_25 = var_3;
        } else {
          for(var_36 = 0; var_36 < var_25.size; var_36++) {
            var_39 = scripts\cp\utility::getattachmenttype(var_25[var_36]);

            if(var_39 == var_38) {
              var_13 = var_3;
              var_25 = var_3;
              var_8 = 1;
              break;
            }
          }

          if(!var_8) {
            return undefined;
          }
        }
      } else if(is_perk_attachment(var_3)) {
        var_17 = var_3;
        var_25 = var_3;
      } else if(is_pap_attachment(var_3)) {
        var_15 = var_3;
        var_25 = var_3;
      } else if(is_arcane_attachment(var_3)) {
        var_23 = var_3;
        var_25 = var_3;
      } else {
        var_13 = var_3;
        var_25 = var_3;
      }
    } else if(isDefined(var_3)) {
      if(is_perk_attachment(var_3)) {
        var_15 = var_3;
        var_25 = var_3;
      } else if(is_pap_attachment(var_3)) {
        var_17 = var_3;
        var_25 = var_3;
      } else if(is_arcane_attachment(var_3)) {
        var_23 = var_3;
        var_25 = var_3;
      } else {
        var_13 = var_3;
        var_25 = var_3;
      }
    }
  }

  var_40 = scripts\cp\utility::getweaponrootname(var_6);
  var_41 = isDefined(self.weapon_build_models[scripts\cp\utility::getrawbaseweaponname(var_5)]);

  if(!isDefined(var_5) && var_41) {
    var_10 = scripts\cp\utility::getweaponcamo(var_40);
  } else {
    var_10 = var_5;
  }

  if(var_41) {
    var_42 = 0;

    foreach(var_30 in var_25) {
      if(issubstr(var_30, "cos_")) {
        var_42 = 1;
        var_12 = undefined;
        break;
      }
    }

    if(!var_42) {
      var_12 = scripts\cp\utility::getweaponcosmeticattachment(var_40);
    }

    var_11 = scripts\cp\utility::getweaponreticle(var_40);
    var_45 = scripts\cp\utility::getweaponpaintjobid(var_40);
  } else {
    var_13 = undefined;
    var_12 = undefined;
    var_45 = undefined;
  }

  foreach(var_30 in var_26) {
    if(issubstr(var_30, "arcane") || issubstr(var_30, "ark")) {
      foreach(var_48 in var_26) {
        if(var_30 == var_48) {
          continue;
        }

        if(issubstr(var_48, "cos_")) {
          var_26 = scripts\engine\utility::array_remove(var_26, var_48);
        }
      }

      var_13 = undefined;
    }
  }

  var_51 = scripts\cp\utility::mpbuildweaponname(var_41, var_26, var_11, var_12, var_8, self getentitynumber(), self.clientid, var_45, var_13);

  if(isDefined(var_51)) {
    return var_51;
  }

  return createheadicon(var_6);
}

function getattachmenttypeslist(var_0, var_1) {
  var_2 = scripts\cp\utility::getweaponattachmentarrayfromstats(var_0);
  var_3 = [];

  foreach(var_5 in var_2) {
    var_6 = scripts\cp\utility::getattachmenttype(var_5);

    if(isDefined(var_1) && scripts\cp\utility::listhasattachment(var_1, var_5)) {
      continue;
    }

    if(!isDefined(var_3[var_6])) {
      var_3 = [];
    }

    var_7 = var_3[var_6];
    var_7 = var_5;
    var_3 = var_7;
  }

  return var_3;
}

function getattachmentlistbasenames() {
  var_0 = [];
  var_1 = ["mp/attachmenttable.csv", "cp/cp_attachmenttable.csv"];

  foreach(var_3 in var_1) {
    var_4 = 0;

    for(var_5 = tablelookup(var_3, 0, var_4, 5); var_5 != ""; var_5 = tablelookup(var_3, 0, var_4, 5)) {
      var_6 = tablelookup(var_3, 0, var_4, 2);

      if(var_6 != "none" && !scripts\engine\utility::array_contains(var_0, var_5)) {
        var_0 = var_5;
      }

      var_4++;
    }
  }

  return var_0;
}

function getweaponattachmentarray(var_0) {
  var_1 = [];
  var_2 = scripts\cp\utility::getbaseweaponname(var_0);
  var_3 = scripts\cp\utility::coop_getweaponclass(var_0);

  if(isDefined(level.attachmentmap_basetounique[var_2])) {
    var_1 = scripts\engine\utility::array_combine(var_1, level.attachmentmap_basetounique[var_2]);
  }

  if(isDefined(level.attachmentmap_basetounique[var_3])) {
    var_1 = scripts\engine\utility::array_combine(var_1, level.attachmentmap_basetounique[var_3]);
  }

  return var_1;
}

function isvalidzombieweapon(var_0) {
  if(!isDefined(level.weaponrefs)) {
    level.weaponrefs = [];

    foreach(var_2 in level.weaponlist) {
      level.weaponrefs[createheadicon(var_2)] = 1;
    }
  }

  if(isDefined(level.weaponrefs[var_0])) {
    return true;
  }

  return false;
}

function setweaponlaser_internal() {
  self endon("death");
  self endon("disconnect");
  self endon("unsetWeaponLaser");
  self.perkweaponlaseron = 0;
  var_0 = self getcurrentweapon();
  setweaponlaser_waitforlaserweapon(var_0);

  if(self.perkweaponlaseron == 0) {
    self.perkweaponlaseron = 1;
    enableweaponlaser();
  }

  GscBinSkip4(0x35);
}

function setweaponlaser_waitforlaserweapon(var_0) {
  for(;;) {
    if(isDefined(var_0) && (var_0.basename == "iw6_kac_mp" || var_0.basename == "iw6_arx160_mp")) {
      break;
    }

    self waittill("weapon_change", var_0);
  }
}

function setweaponlaser_monitorads() {
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

function setweaponlaser_monitorweaponswitchstart(var_0) {
  self endon("weapon_change");
  self waittill("weapon_switch_started");
  GscBinSkip4(0x35, var_0);
}

function setweaponlaser_onweaponswitchstart(var_0) {
  self notify("setWeaponLaser_onWeaponSwitchStart");
  self endon("setWeaponLaser_onWeaponSwitchStart");

  if(self.perkweaponlaseron == 1) {
    self.perkweaponlaseroffforswitchstart = 1;
    self.perkweaponlaseron = 0;
    disableweaponlaser();
  }

  wait var_0;
  self.perkweaponlaseroffforswitchstart = undefined;

  if(self.perkweaponlaseron == 0 && self playerads() <= 0.6) {
    self.perkweaponlaseron = 1;
    enableweaponlaser();
    return;
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
  self.weaponlasercalls--;

  if(self.weaponlasercalls == 0) {
    self laseroff();
    self.weaponlasercalls = undefined;
    return;
  }
}

function ondetonateexplosive(var_0) {
  self endon("death");
  level endon("game_ended");
  thread cleanupexplosivesondeath();
  self waittill("detonateExplosive");

  if(isDefined(var_0)) {
    self.owner notify(var_0, 1);
  } else {
    self.owner notify("powers_c4_used", 1);
  }

  self detonate(self.owner);
}

function cleanupexplosivesondeath() {
  self endon("deleted_equipment");
  level endon("game_ended");
  var_0 = self getentitynumber();
  var_1 = self.killcament;
  var_2 = self.trigger;
  var_3 = self.sensor;
  self waittill("death");
  cleanupequipment(var_0, var_1, var_2, var_3);
}

function cleanupequipment(var_0, var_1, var_2, var_3) {
  if(isDefined(self.weapon_name)) {
    if(self.weapon_name == "c4_mp_p") {
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

  if(isDefined(var_0)) {
    level.mines[var_0] = undefined;
  }

  if(isDefined(var_1)) {
    var_1 delete();
  }

  if(isDefined(var_2)) {
    var_2 delete();
  }

  if(isDefined(var_3)) {
    var_3 delete();
    return;
  }
}

function monitordamage(var_0, var_1, var_2, var_3, var_4, var_5) {
  self endon("death");
  level endon("game_ended");

  if(!isDefined(var_5)) {
    var_5 = 0;
  }

  self setCanDamage(1);
  self.health = 9999999;
  self.maxhealth = var_0;
  self.damagetaken = 0;

  if(!isDefined(var_4)) {
    var_4 = 0;
  }

  for(var_6 = 1; var_6; var_6 = monitordamageoneshot(var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14, var_15, var_16, var_20, var_1, var_2, var_3, var_4)) {
    self waittill("damage", var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14, var_15, var_16, var_17, var_18, var_19, var_20);

    if(var_5) {
      self playRumbleOnEntity("damage_light");
    }

    if(isDefined(self.helitype) && self.helitype == "littlebird") {
      if(!isDefined(self.attackers)) {
        self.attackers = [];
      }

      var_21 = "";

      if(isDefined(var_8) && isPlayer(var_8)) {
        var_21 = var_8 scripts\cp\utility::getuniqueid();
      }

      if(isDefined(self.attackers[var_21])) {
        self.attackers[var_21] += var_7;
      } else {
        self.attackers[var_21] = var_7;
      }
    }
  }
}

function monitordamageoneshot(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14) {
  if(!isDefined(self)) {
    return false;
  }

  if(isDefined(var_1) && !scripts\cp\cp_damage::friendlyfirecheck(self.owner, var_1)) {
    if(isDefined(self.equipmentref) && self.equipmentref == "equip_tac_cover") {} else {
      return true;
    }
  }

  var_15 = var_0;

  if(isDefined(var_9)) {
    if(non_player_should_ignore_damage(var_1, var_9, var_10, var_4)) {
      return true;
    }
  }

  var_16 = scripts\cp_mp\utility\damage_utility::packdamagedata(var_1, self, var_0, var_9, var_4, var_10, var_3, var_2, var_5, var_7, var_6, var_8);

  if(!isDefined(var_13)) {
    var_13 = &scripts\cp\cp_damage::modifydamage;
  }

  var_15 = self[[var_13]](var_16);

  if(var_15 <= 0) {
    return true;
  }

  self.wasdamaged = 1;
  self.damagetaken += var_15;
  self.health = 2147483647;

  if(istrue(var_14)) {
    scripts\cp\utility::killstreakhit(var_1, var_9, self, var_4, var_15);
  }

  if(isDefined(var_1)) {
    if(isPlayer(var_1)) {
      var_1 scripts\cp\cp_damagefeedback::updatedamagefeedback(var_11);
    }
  }

  if(self.damagetaken >= self.maxhealth) {
    var_16 = scripts\cp_mp\utility\damage_utility::packdamagedata(var_1, self, var_0, var_9, var_4, var_10, var_3, var_2, var_5, var_7, var_6, var_8);
    self thread[[var_12]](var_16);
    return false;
  }

  return true;
}

function non_player_should_ignore_damage(var_0, var_1, var_2, var_3) {
  if(non_player_should_ignore_damage_signature(var_0, var_1, var_2, var_3)) {
    return true;
  }

  if(isDefined(var_1.basename)) {
    if(var_3 != "MOD_MELEE") {
      switch (var_1.basename) {
        case "iw8_green_beam_mp":
        case "iw8_spotter_scope_mp":
          return true;
      }
    }

    if(var_3 == "MOD_IMPACT") {
      switch (var_1.basename) {
        case "at_mine_mp":
        case "claymore_mp":
        case "c4_mp_p":
        case "thermite_mp":
        case "semtex_mp":
          return true;
      }
    } else {
      switch (var_1.basename) {
        case "claymore_radial_mp":
        case "emp_drone_player_mp":
        case "thermite_ap_mp":
        case "snapshot_grenade_mp":
        case "concussion_grenade_mp":
        case "flash_grenade_mp":
        case "gas_mp":
          return true;
      }
    }
  }

  return false;
}

function non_player_should_ignore_damage_signature(var_0, var_1, var_2, var_3) {
  if(!isDefined(self.ignoredamagesignatures)) {
    return false;
  }

  if(isDefined(var_1) && isstring(var_1)) {
    var_1 = getcompleteweaponname(var_1);
  }

  foreach(var_5 in self.ignoredamagesignatures) {
    if(!isDefined(var_5)) {
      return false;
    }

    if(var_5.checkattacker) {
      if(!isDefined(var_5.attacker)) {
        non_player_remove_ignore_damage_signature(var_5.id);
        continue;
      } else if(!isDefined(var_0)) {
        continue;
      } else if(var_0 != var_5.attacker) {
        continue;
      }
    }

    if(var_5.checkobjweapon) {
      if(!isDefined(var_1) || nullweapon(var_1)) {
        continue;
      } else if(var_1 != var_5.objweapon) {
        continue;
      }
    }

    if(var_5.checkinflictor) {
      if(!isDefined(var_5.inflictor)) {
        non_player_remove_ignore_damage_signature(var_5.id);
        continue;
      } else if(!isDefined(var_2)) {
        continue;
      } else if(var_2 != var_5.inflictor) {
        continue;
      }
    }

    if(var_5.checkmeansofdeath) {
      if(!isDefined(var_3)) {
        continue;
      } else if(var_3 != var_5.meansofdeath) {
        continue;
      }
    }

    return true;
  }

  return false;
}

function non_player_remove_ignore_damage_signature(var_0) {
  if(!isDefined(self.ignoredamagesignatures)) {
    return;
  }

  self.ignoredamagesignatures[var_0] = undefined;
}

function non_player_add_ignore_damage_signature(var_0, var_1, var_2, var_3) {
  if(!isDefined(self.ignoredamageid)) {
    self.ignoredamageid = 0;
  }

  if(!isDefined(self.ignoredamagesignatures)) {
    self.ignoredamagesignatures = [];
  }

  var_4 = self.ignoredamageid;
  self.ignoredamageid++;

  if(isDefined(var_1) && isstring(var_1)) {
    var_1 = getcompleteweaponname(var_1);
  }

  var_5 = spawnStruct();
  var_5.id = var_4;
  var_5.attacker = var_0;
  var_5.objweapon = var_1;
  var_5.inflictor = var_2;
  var_5.meansofdeath = var_3;
  var_5.checkattacker = isDefined(var_0);
  var_5.checkobjweapon = isDefined(var_1) && !nullweapon(var_1);
  var_5.checkinflictor = isDefined(var_2);
  var_5.checkmeansofdeath = isDefined(var_3);
  self.ignoredamagesignatures[var_4] = var_5;
  return var_4;
}

function explosivehandlemovers(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.linkparent = var_0;
  var_2.deathoverridecallback = &movingplatformdetonate;
  var_2.endonstring = "death";

  if(!isDefined(var_1) || !var_1) {
    var_2.invalidparentoverridecallback = &scripts\cp\cp_movers::moving_platform_empty_func;
  }

  thread scripts\cp\cp_movers::handle_moving_platforms(var_2);
}

function movingplatformdetonate(var_0) {
  if(!isDefined(var_0.lasttouchedplatform) || !isDefined(var_0.lasttouchedplatform.destroyexplosiveoncollision) || var_0.lasttouchedplatform.destroyexplosiveoncollision) {
    self notify("detonateExplosive");
    return;
  }
}

function makeexplosiveusable() {
  if(self.owner scripts\cp_mp\utility\player_utility::_isalive()) {
    self setotherent(self.owner);
    self.trigger = spawn("script_origin", self.origin + getexplosiveusableoffset());
    self.trigger.owner = self;
    thread equipmentwatchuse(self.owner, 1);
    return;
  }
}

function equipmentwatchuse(var_0, var_1) {
  self notify("equipmentWatchUse");
  self endon("spawned_player");
  self endon("disconnect");
  self endon("equipmentWatchUse");
  self.trigger setCursorHint("HINT_NOICON");
  self.trigger scripts\cp\cp_equipment::setexplosiveusablehintstring(self.weapon_name);
  self.trigger scripts\cp\utility::setselfusable(var_0);
  self.trigger thread scripts\cp\utility::notusableforjoiningplayers(var_0);

  if(isDefined(var_1) && var_1) {
    thread updatetriggerposition();
  }

  for(;;) {
    self.trigger waittill("trigger", var_0);
    var_0 notify("pickup_equipment", self.weapon_name);
    var_0 setweaponammostock(self.weapon_name, var_0 getweaponammostock(self.weapon_name) + 1);
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

function deleteexplosive(var_0) {
  if(isDefined(self)) {
    if(isDefined(self.deletefunc)) {
      self thread[[self.deletefunc]]();
      self notify("deleted_equipment");
      return;
    }

    var_1 = self getentitynumber();
    var_2 = self.killcament;
    var_3 = self.trigger;
    var_4 = self.sensor;
    cleanupequipment(var_1, var_2, var_3, var_4);
    self notify("deleted_equipment");
    self delete();
    return;
  }
}

function ontacticalequipmentplanted(var_0, var_1, var_2) {
  var_0.equipmentref = var_1;
  var_0.deletefunc = var_2;
  var_0.planted = 1;

  if(!istrue(var_0.issuper)) {
    if(self.plantedtacticalequip.size) {
      self.plantedtacticalequip = scripts\engine\utility::array_removeundefined(self.plantedtacticalequip);

      if(self.plantedtacticalequip.size && self.plantedtacticalequip.size >= getmaxplantedtacticalequip(self)) {
        deleteexplosive(self.plantedtacticalequip[0]);
      }
    }

    self.plantedtacticalequip[self.plantedtacticalequip.size] = var_0;
  }

  var_3 = var_0 getentitynumber();
  level.mines[var_3] = var_0;
  level notify("mine_planted");
}

function getmaxplantedtacticalequip(var_0) {
  var_1 = 0;
  var_1 = 4;
  return var_1;
}

function equipmentdeathvfx(var_0) {
  var_1 = spawnfx(scripts\engine\utility::getfx("equipment_sparks"), self.origin);
  triggerfx(var_1);

  if(!isDefined(var_0) || var_0 == 0) {
    self playSound("sentry_explode");
  }

  var_1 thread scripts\cp\utility::delayentdelete(1);
}

function equipmentdeletevfx() {
  var_0 = spawnfx(scripts\engine\utility::getfx("placeEquipmentFailed"), self.origin);
  triggerfx(var_0);
  self playSound("mp_killstreak_disappear");
  var_0 thread scripts\cp\utility::delayentdelete(1);
}

function monitordisownedequipment(var_0, var_1) {
  level endon("game_ended");
  var_1 endon("death");
  var_0 scripts\engine\utility::ref_143A6("joined_team", "joined_spectators", "disconnect");
  deleteexplosive(var_1);
}

function isprimaryweapon(var_0) {
  if(issameweapon(var_0) && nullweapon(var_0)) {
    return 0;
  }

  if(isstring(var_0) && var_0 == "none") {
    return 0;
  }

  if(weaponinventorytype(var_0) != "primary") {
    return 0;
  }

  switch (weaponclass(var_0)) {
    case "smg":
    case "pistol":
    case "sniper":
    case "spread":
    case "mg":
    case "rifle":
    case "rocketlauncher":
      return 1;
    default:
      return 0;
  }
}

function getexplosiveusableoffset() {
  var_0 = anglestoup(self.angles);
  return 10 * var_0;
}

function isknifeonly(var_0) {
  var_1 = getweaponbasename(var_0);
  return issubstr(var_1, "knife");
}

function is_incompatible_weapon(var_0) {
  var_1 = undefined;

  if(issameweapon(var_0)) {
    var_1 = var_0.basename;
  } else {
    var_1 = var_0;
  }

  if(isDefined(level.ammoincompatibleweaponslist)) {
    if(scripts\engine\utility::array_contains(level.ammoincompatibleweaponslist, var_1)) {
      return true;
    }
  }

  return false;
}

function isbulletweapon(var_0) {
  if(issameweapon(var_0) && nullweapon(var_0)) {
    return 0;
  }

  if(isstring(var_0) && var_0 == "none") {
    return 0;
  }

  if(scripts\cp\utility::isriotshield(var_0) || isknifeonly(var_0)) {
    return 0;
  }

  if(isDefined(var_0.inventorytype) && var_0.inventorytype == "model_only") {
    return 0;
  }

  switch (weaponclass(var_0)) {
    case "smg":
    case "pistol":
    case "sniper":
    case "spread":
    case "mg":
    case "rifle":
      return 1;
    default:
      return 0;
  }
}

function is_explosive_kill(var_0) {
  var_1 = undefined;

  if(issameweapon(var_0)) {
    var_1 = var_0.basename;
  } else {
    var_1 = var_0;
  }

  switch (var_1) {
    case "zombie_armageddon_mp":
    case "zfreeze_semtex_mp":
    case "splash_grenade_zm":
    case "splash_grenade_mp":
    case "throwingknifec4_mp":
    case "cluster_grenade_zm":
    case "semtex_zm":
    case "c4_mp_p":
    case "frag_grenade_zm":
    case "semtex_mp":
      return 1;
    default:
      return 0;
  }
}

function get_weapon_level(var_0) {
  if(!isPlayer(self)) {
    return int(1);
  }

  var_1 = undefined;

  if(issameweapon(var_0)) {
    var_1 = var_0.basename;
  } else {
    var_1 = var_0;
  }

  if(isDefined(self.pap[var_1])) {
    return self.pap[var_1].lvl;
  }

  var_2 = scripts\cp\utility::getrawbaseweaponname(var_1);

  if(isDefined(self.pap[var_2])) {
    return self.pap[var_2].lvl;
  }

  return int(1);
}

function can_upgrade(var_0, var_1) {
  if(!isDefined(level.pap)) {
    return 0;
  }

  if(isDefined(level.max_pap_func)) {
    return [[level.max_pap_func]](var_0, var_1);
  }

  if(isDefined(var_0)) {
    var_2 = scripts\cp\utility::getrawbaseweaponname(var_0);
  } else {
    return 0;
  }

  if(!isDefined(var_2)) {
    return 0;
  }

  if(!isDefined(level.pap[var_2])) {
    var_3 = getsubstr(var_2, 0, var_2.size - 1);

    if(!isDefined(level.pap[var_3])) {
      return 0;
    }
  }

  if(istrue(var_1) && isDefined(self.pap[var_2]) && self.pap[var_2].lvl <= min(level.pap_max + 1, 2)) {
    return 1;
  }

  if(isDefined(self.pap[var_2]) && self.pap[var_2].lvl >= level.pap_max) {
    return 0;
  }

  return 1;
}

function get_pap_camo(var_0, var_1, var_2) {
  var_3 = undefined;

  if(isDefined(var_1)) {
    if(isDefined(level.no_pap_camos) && scripts\engine\utility::array_contains(level.no_pap_camos, var_1)) {
      var_3 = undefined;
    } else if(isDefined(level.pap_1_camo) && isDefined(var_0) && var_0 == 2) {
      var_3 = level.pap_1_camo;
    } else if(isDefined(level.pap_2_camo) && isDefined(var_0) && var_0 == 3) {
      var_3 = level.pap_2_camo;
    }

    switch (var_1) {
      case "dischord":
        var_2 = "iw7_dischord_zm_pap1";
        var_3 = "camo20";
        break;
      case "facemelter":
        var_2 = "iw7_facemelter_zm_pap1";
        var_3 = "camo22";
        break;
      case "headcutter":
        var_2 = "iw7_headcutter_zm_pap1";
        var_3 = "camo21";
        break;
      case "forgefreeze":
        if(var_0 == 2) {
          var_2 = "iw7_forgefreeze_zm_pap1";
        } else if(var_0 == 3) {
          var_2 = "iw7_forgefreeze_zm_pap2";
        }

        var_4 = 1;
        break;
      case "axe":
        if(var_0 == 2) {
          var_2 = "iw7_axe_zm_pap1";
        } else if(var_0 == 3) {
          var_2 = "iw7_axe_zm_pap2";
        }

        var_4 = 1;
        break;
      case "shredder":
        var_2 = "iw7_shredder_zm_pap1";
        var_3 = "camo23";
        break;
    }
  }

  return var_3;
}

function validate_current_weapon(var_0, var_1, var_2) {
  if(isDefined(level.weapon_upgrade_path) && isDefined(level.weapon_upgrade_path[getweaponbasename(var_2)])) {
    var_2 = level.weapon_upgrade_path[getweaponbasename(var_2)];
  } else if(isDefined(var_1)) {
    switch (var_1) {
      case "two":
        if(var_0 == 2) {
          var_2 = "iw7_two_headed_axe_mp";
        } else if(var_0 == 3) {
          var_2 = "iw7_two_headed_axe_mp";
        }

        break;
      case "golf":
        if(var_0 == 2) {
          var_2 = "iw7_golf_club_mp";
        } else if(var_0 == 3) {
          var_2 = "iw7_golf_club_mp";
        }

        break;
      case "machete":
        if(var_0 == 2) {
          var_2 = "iw7_machete_mp";
        } else if(var_0 == 3) {
          var_2 = "iw7_machete_mp";
        }

        break;
      case "spiked":
        if(var_0 == 2) {
          var_2 = "iw7_spiked_bat_mp";
        } else if(var_0 == 3) {
          var_2 = "iw7_spiked_bat_mp";
        }

        break;
      case "axe":
        if(var_0 == 2) {
          var_2 = "iw7_axe_zm_pap1";
        } else if(var_0 == 3) {
          var_2 = "iw7_axe_zm_pap2";
        }

        break;
      case "katana":
        if(var_0 == 2) {
          var_2 = "iw7_katana_zm_pap1";
        } else if(var_0 == 3) {
          var_2 = "iw7_katana_zm_pap2";
        }

        break;
      case "nunchucks":
        if(var_0 == 2) {
          var_2 = "iw7_nunchucks_zm_pap1";
        } else if(var_0 == 3) {
          var_2 = "iw7_nunchucks_zm_pap2";
        }

        break;
      default:
        return var_2;
    }
  }

  return var_2;
}

function watchplayermelee() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  level endon("game_ended");

  for(;;) {
    self waittill("melee_fired", var_0);
    var_1 = var_0.basename;

    if(self.meleekill == 0) {
      if(var_1 == "iw7_fists_zm_crane" || var_1 == "iw7_fists_zm_dragon" || var_1 == "iw7_fists_zm_snake" || var_1 == "iw7_fists_zm_tiger") {
        if(self.kung_fu_vo == 0) {
          self.kung_fu_vo = 1;
          thread scripts\cp\cp_vo::try_to_play_vo("melee_punch", "zmb_comment_vo", "high", 1, 0, 0, 1);
          thread kung_fu_vo_wait();
        } else {
          self.kung_fu_vo = 1;
          self notify("kung_fu_vo_reset");
          thread scripts\cp\cp_vo::try_to_play_vo("melee_punch", "zmb_comment_vo", "high", 1, 0, 0, 1, 60);
          thread kung_fu_vo_wait();
        }
      } else {
        thread scripts\cp\cp_vo::try_to_play_vo("melee_miss", "zmb_comment_vo", "high", 1, 0, 0, 1, 20);
      }

      continue;
    }

    if(issubstr(var_1, "katana") && self.vo_prefix == "p5_") {
      thread scripts\cp\cp_vo::try_to_play_vo("melee_special_katana", "rave_comment_vo", "high", 1, 0, 0, 1);
      continue;
    }

    if((issubstr(var_1, "golf") || issubstr(var_1, "machete") || issubstr(var_1, "spiked_bat") || issubstr(var_1, "two_headed_axe")) && self.meleekill == 1) {
      thread scripts\cp\cp_vo::try_to_play_vo("melee_special", "rave_comment_vo", "high", 1, 0, 0, 1);
      continue;
    }

    if(issubstr(var_1, "iw7_knife") && scripts\cp\utility::is_melee_weapon(var_1) && self.meleekill == 1) {
      thread scripts\cp\cp_vo::try_to_play_vo("melee_fatal", "zmb_comment_vo", "high", 1, 0, 0, 1);
      self.meleekill = 0;
      continue;
    }

    if((var_1 == "iw7_axe_zm" || var_1 == "iw7_axe_zm_pap1" || var_1 == "iw7_axe_zm_pap2") && scripts\cp\utility::is_melee_weapon(var_1) && self.meleekill == 1) {
      thread scripts\cp\cp_vo::try_to_play_vo("melee_splice", "zmb_comment_vo", "high", 1, 0, 0, 1);
      self.meleekill = 0;
    }
  }
}

function kung_fu_vo_wait() {
  self endon("kung_fu_vo_reset");
  wait 4;
  self.kung_fu_vo = 0;
}

function watchweaponfired() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  self notify("watchWeaponFired");
  self endon("watchWeaponFired");
  level endon("game_ended");

  for(;;) {
    wait 1;
    var_0 = self getcurrentweapon();

    if(!isDefined(var_0) || nullweapon(var_0)) {
      continue;
    }

    self waittill("fired", var_0);
    var_0 = self getcurrentweapon();
    var_1 = self getammocount(var_0);
    var_2 = weaponclipsize(var_0);

    if(var_2 == 0) {
      continue;
    }

    var_3 = var_1 / var_2;

    if(scripts\cp\utility::is_melee_weapon(var_0) || issubstr(var_0.basename, "fists") || issubstr(var_0.basename, "heart")) {
      continue;
    }

    if(var_1 <= 5 && var_1 > 0 && self getweaponammostock(var_0) == 0 || self getweaponammostock(var_0) > 0 && var_1 / self getweaponammostock(var_0) < 0.1) {} else if(var_1 == 0 && var_0.basename != "iw7_cpbasketball_mp" && !nullweapon(var_0)) {
      scripts\cp\cp_vo::try_to_play_vo("nag_out_ammo", "zmb_comment_vo", "low", 3, 0, 0, 0, 20);
    }

    if(var_0.basename == "ac130_105mm_mp" || var_0.basename == "ac130_40mm_mp" || var_0.basename == "ac130_25mm_mp") {}
  }
}

function getitemweaponname() {
  var_0 = self.classname;
  var_1 = getsubstr(var_0, 7);
  return var_1;
}

function watchweaponpickup(var_0) {
  self endon("death");
  var_1 = getitemweaponname();

  for(;;) {
    self waittill("trigger", var_2, var_3);
    var_4 = var_2 getcurrentweapon();
    thread watchpickupcomplete(var_2, var_1);
    var_2 notify("weapon_pickup", var_1);
    var_5 = fixupplayerweapons(var_2, var_1);
  }

  LOC_00000056:
    if(isDefined(var_3)) {
      var_2 notify("manual_switch_from_minigun");
      var_6 = getitemweaponname(var_3);
      var_7 = asmdevgetallstates(var_6);

      if(isDefined(var_2.tookweaponfrom[var_6])) {
        var_3.owner = var_2.tookweaponfrom[var_6];
        var_2.tookweaponfrom[var_6] = undefined;
      }

      var_3.objweapon = var_7.basename;
      var_3.targetname = "dropped_weapon";
      thread watchweaponpickup();
    }

  var_2.tookweaponfrom[var_1] = self.owner;
}

function fixupplayerweapons(var_0, var_1) {
  var_2 = var_0 getweaponslistprimaries();
  var_3 = 1;
  var_4 = 1;
  var_5 = undefined;

  if(issameweapon(var_1)) {
    var_5 = createheadicon(var_1);
  } else {
    var_5 = var_1;
  }

  foreach(var_7 in var_2) {
    if(isDefined(var_0.primaryweaponobj) && var_0.primaryweaponobj == var_7) {
      var_3 = 0;
      continue;
    }

    if(isDefined(var_0.secondaryweaponobj) && var_0.secondaryweaponobj == var_7) {
      var_4 = 0;
    }
  }

  if(var_3) {
    var_0.primaryweapon = var_5;
    var_0.primaryweaponobj = asmdevgetallstates(var_5);
  } else if(var_4) {
    var_0.secondaryweapon = var_5;
    var_0.secondaryweaponobj = asmdevgetallstates(var_5);
  }

  return var_3 || var_4;
}

function watchpickupcomplete(var_0, var_1) {
  self endon("death");
  self endon("disconnect");
  self notify("watchPickupComplete()");
  self endon("watchPickupComplete()");
  var_2 = self.currentweapon;
  var_3 = 0;

  if(isstring(var_0)) {
    var_0 = asmdevgetallstates(var_0);
  }

  jumpiffalse(var_2 == var_0) LOC_00000046;
  var_3 = 1;
  goto LOC_0000007c;
}

function notifyuiofpickedupweapon() {
  self setclientomnvar("ui_weapon_pickup", 0);
}

function watchweaponusage(var_0) {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  level endon("game_ended");
  self notify("watchWeaponUsage");
  self endon("watchWeaponUsage");

  for(;;) {
    self waittill("weapon_fired", var_1);
    var_2 = self getcurrentweapon();

    if(!isDefined(var_2) || nullweapon(var_2)) {
      continue;
    }

    if(!scripts\cp\utility::isinventoryprimaryweapon(var_2)) {
      continue;
    }

    if(isDefined(level.updateonusepassivesfunc)) {
      GscBinSkip1(0x74, level.updateonusepassivesfunc, self, createheadicon(var_2));
    }

    var_3 = gettime();

    if(!isDefined(self.lastshotfiredtime)) {
      self.lastshotfiredtime = 0;
    }

    var_4 = gettime() - self.lastshotfiredtime;
    self.lastshotfiredtime = var_3;

    if(isai(self)) {
      continue;
    }

    var_5 = getweaponbasename(var_2);

    if(!isDefined(self.shotsfiredwithweapon[var_5])) {
      self.shotsfiredwithweapon[var_5] = 1;
    } else {
      self.shotsfiredwithweapon[var_5]++;
    }

    if(!isDefined(self.accuracy_shots_fired)) {
      self.accuracy_shots_fired = 1;
    } else {
      self.accuracy_shots_fired++;
    }

    scripts\cp\cp_persistence::increment_player_career_shots_fired(self);

    if(isDefined(var_5)) {
      if(isDefined(self.hitsthismag[var_5])) {
        thread hitsthismag_update(var_5, var_2);
      }
    }
  }
}

function hitsthismag_update(var_0, var_1) {
  self endon("death");
  self endon("disconnect");
  var_0 = var_1.basename;
  self endon("updateMagShots_" + var_0);
  self.hitsthismag[var_0]--;
  wait 0.1;
  self notify("shot_missed", var_1);
  self.consecutivehitsperweapon[var_0] = 0;
  self.hitsthismag[var_0] = weaponclipsize(var_1);
}

function watchweaponchange() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  self notify("watchWeaponChange");
  self endon("watchWeaponChange");
  self.hitsthismag = [];
  var_0 = getweaponbasename(self getcurrentweapon());
  hitsthismag_init(var_0);

  for(;;) {
    self waittill("weapon_change", var_1);
    var_0 = var_1.basename;
    weapontracking_init(var_0);

    if(isDefined(self.weapon_passives[var_1.basename])) {}

    hitsthismag_init(var_0);
  }
}

function harpoon_impale_additional_func(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(!issubstr(var_0, "harpoon")) {
    return;
  }

  var_2 startragdoll();
  var_8 = physics_createcontents(["physicscontents_solid", "physicscontents_glass", "physicscontents_missileclip", "physicscontents_vehicle"]);
  var_9 = var_3 + var_4 * 4096;
  var_10 = scripts\engine\trace::ray_trace_detail(var_3, var_9, undefined, var_8, undefined, 1);
  var_9 = var_10["position"] - var_4 * 12;
  var_11 = length(var_9 - var_3);
  var_12 = var_11 / 1250;
  var_12 = clamp(var_12, 0.05, 1);
  wait 0.05;
  var_13 = var_4;
  var_14 = anglestoup(var_1.angles);
  var_15 = vectorcross(var_13, var_14);
  var_16 = scripts\engine\utility::spawn_tag_origin(var_3, axistoangles(var_13, var_15, var_14));
  var_16 moveTo(var_9, var_12);
  var_17 = spawnragdollconstraint(var_2, var_5, var_6, var_7);
  var_17.origin = var_16.origin;
  var_17.angles = var_16.angles;
  var_17 linkTo(var_16);
  thread play_explosion_post_impale(var_9, var_1);
  thread impale_cleanup(var_2, var_16, var_12 + 0.05, var_17);
}

function impale_cleanup(var_0, var_1, var_2, var_3) {
  var_0 scripts\engine\utility::ref_143BA(var_2, "death", "disconnect");
  var_3 delete();
  var_1 delete();
}

function play_explosion_post_impale(var_0, var_1) {
  wait 2;
  var_1 radiusdamage(var_0, 500, 1000, 500, var_1, "MOD_EXPLOSIVE");
  playFX(level._effect["penetration_railgun_explosion"], var_0);
}

function weapontracking_init(var_0) {
  if(!isDefined(var_0) || var_0 == "none") {
    return;
  }

  if(!isDefined(self.shotsfiredwithweapon[var_0])) {
    self.shotsfiredwithweapon[var_0] = 0;
  }

  if(!isDefined(self.shotsontargetwithweapon[var_0])) {
    self.shotsontargetwithweapon[var_0] = 0;
  }

  if(!isDefined(self.headshots[var_0])) {
    self.headshots[var_0] = 0;
  }

  if(!isDefined(self.wavesheldwithweapon[var_0])) {
    self.wavesheldwithweapon[var_0] = 1;
  }

  if(!isDefined(self.downsperweaponlog[var_0])) {
    self.downsperweaponlog[var_0] = 0;
  }

  if(!isDefined(self.killsperweaponlog[var_0])) {
    self.killsperweaponlog[var_0] = 0;
    return;
  }
}

function hitsthismag_init(var_0) {
  if(!isDefined(var_0) || var_0 == "none") {
    return;
  }

  if(scripts\cp\utility::isinventoryprimaryweapon(var_0) && !isDefined(self.hitsthismag[var_0])) {
    self.hitsthismag[var_0] = weaponclipsize(var_0);
    return;
  }
}

function addattachmenttoweapon(var_0, var_1, var_2) {
  var_3 = self.currentweapon;
  var_4 = var_3;
  var_0 = undefined;
  var_5 = scripts\cp\utility::attachmentmap_tounique(var_1, var_4);
  var_6 = 0;

  if(var_3.attachments.size == 0) {
    if(var_4 canuseattachment(var_5)) {
      var_6 = 1;
    } else {
      var_6 = 0;
    }
  } else {
    for(var_7 = 0; var_7 < var_3.attachments.size; var_7++) {
      if(var_4 canuseattachment(var_5) && attachmentsconflict(var_3.attachments[var_7], var_5, var_4) == "") {
        var_6 = 1;
        continue;
      }

      var_6 = 0;
      break;
    }
  }

  if(var_6) {
    var_0 = var_4 withattachment(var_5);
  }

  if(!isDefined(var_0)) {
    if(isbot(self)) {}

    return undefined;
  }

  var_8 = self getweaponammoclip(var_0);
  var_9 = self getweaponammostock(var_0);

  if(istrue(var_2)) {
    var_8 = weaponclipsize(var_0);
    var_9 = weaponmaxammo(var_0);
  }

  scripts\cp_mp\utility\inventory_utility::_takeweapon(var_3);
  self giveweapon(var_0);
  self setweaponammoclip(var_0, var_8);
  self setweaponammostock(var_0, var_9);
  scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate(var_0);
  fixupplayerweapons(self, var_0);
  return var_0;
}

function player_has_silencer(var_0) {
  if(!isDefined(var_0)) {
    var_0 = self getcurrentweapon();
  }

  return var_0 hasattachment("silenc", 1);
}

function _buildweaponcustom(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_9 = var_0;
  var_10 = strtok(var_9, "_");
  var_11 = 0;

  if(var_10[0] == "alt") {
    var_11++;
  }

  if(var_10[var_11] == "iw7") {
    return;
  }

  if(var_10[var_11] == "iw8") {
    var_12 = var_0;

    if(!isDefined(var_1)) {
      var_1 = [];
    }

    if(!isDefined(var_2)) {
      var_2 = "none";
    }

    if(!isDefined(var_3)) {
      var_3 = "none";
    }

    if(!isDefined(var_4)) {
      var_4 = -1;
    }

    if(!isDefined(var_5)) {
      var_5 = [];
    }

    if(!isDefined(var_6)) {
      var_6 = "none";
    }

    if(!isDefined(var_7)) {
      var_7 = [];
    }

    if(!isDefined(var_8)) {
      var_8 = 0;
    }

    if(!isPlayer(self)) {
      return buildweapon(var_12, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
    }

    return buildweapon(var_12, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
  }
}

function weaponsupportslaserir(var_0) {
  switch (var_0) {
    case "iw8_la_juliet_mp":
    case "iw8_lm_dblmg_mp":
    case "iw8_me_riotshield_mp":
    case "iw8_fists_mp":
    case "iw8_knife_mp":
      return false;
  }

  if(scripts\cp\utility::iskillstreakweapon(var_0)) {
    return false;
  }

  var_1 = weaponclass(var_0);
  return var_1 == "rifle" || var_1 == "mg" || var_1 == "sniper" || var_1 == "smg" || var_1 == "spread";
}

function checkforinvalidattachments(var_0, var_1) {
  var_2 = getcompleteweaponname(var_1);
  var_3 = [];

  foreach(var_5 in var_0) {
    if(var_2 canuseattachment(var_5)) {
      var_3 = var_5;
      continue;
    }

    thread invalidattachmentwarning(var_5, var_1);
  }

  return var_3;
}

function invalidattachmentwarning(var_0, var_1) {
  var_2 = "Invalid Attachment: " + var_0 + " on " + var_1;

  if(isDefined(self) && isPlayer(self)) {
    if(getdvarint("scr_playtest", 0) == 1) {
      self iprintlnbold(var_2);
    }
  }
}

function doesweaponhaveattachmenttype(var_0, var_1, var_2) {
  var_3 = [];

  if(istrue(var_2)) {
    var_3 = var_0.others;
  } else {
    var_3 = var_0.attachments;
  }

  if(hasattachmenttype(var_3, var_1)) {
    return 1;
  }

  return 0;
}

function hasattachmenttype(var_0, var_1) {
  foreach(var_3 in var_0) {
    if(scripts\cp\utility::attachmentmap_tobase(var_3) == var_1) {
      return true;
    }
  }

  return false;
}

function hasscope(var_0) {
  foreach(var_2 in var_0) {
    if(scripts\cp\utility::getattachmenttype(var_2) == "rail") {
      return true;
    }
  }

  return false;
}

function getreticleindex(var_0) {
  if(!isDefined(var_0)) {
    return undefined;
  }

  var_1 = int(tablelookup("mp/reticleTable.csv", 1, var_0, 5));

  if(!isDefined(var_1) || var_1 == 0) {
    return undefined;
  }

  return var_1;
}

function buildweaponuniqueattachments(var_0, var_1, var_2) {
  if(isDefined(var_2) && var_2 < 0) {
    var_2 = undefined;
  }

  var_1 = scripts\cp\utility::weaponattachremoveextraattachments(var_1, var_0);
  var_1 = scripts\engine\utility::array_remove(var_1, "none");
  var_3 = scripts\cp\utility::weaponattachdefaultmap(var_0);
  var_4 = scripts\cp\utility::buildweaponassetname(var_0, var_2);
  var_5 = var_1;

  for(var_6 = 0; var_6 < var_5.size; var_6++) {
    var_5 = scripts\cp\utility::attachmentmap_tobase(var_5[var_6]);
  }

  if(isDefined(var_3)) {
    var_7 = var_3;
    var_6 = 0;

    if(var_6 < var_7.size) {
      GscBinSkip0(0x2e, var_6, scripts\cp\utility::attachmentmap_tobase(var_7[var_6]));
    }

    var_5 = scripts\engine\utility::array_combine_unique(var_5, var_7);
  }

  var_8 = [];

  if(var_5.size > 0) {
    var_5 = scripts\cp\utility::filterattachments(var_5);

    for(var_9 = 0; var_9 < var_5.size; var_9++) {
      var_8 = scripts\cp\utility::attachmentmap_tounique(var_5[var_9], var_4);
    }
  }

  var_10 = [];

  foreach(var_12 in var_8) {
    var_13 = scripts\cp\utility::attachmentmap_toextra(var_12);

    if(isDefined(var_13)) {
      var_10 = scripts\cp\utility::attachmentmap_tounique(var_13, var_4);
    }
  }

  if(var_10.size > 0) {
    var_8 = scripts\engine\utility::array_combine_unique(var_8, var_10);
  }

  if(isDefined(var_2)) {
    var_15 = scripts\cp\utility::getweaponvariantattachments(var_4, var_2);

    foreach(var_17 in var_15) {
      var_8 = var_17;
    }
  }

  var_19 = undefined;
  return var_8;
}

function applyflashfromdamage(var_0, var_1, var_2, var_3) {
  var_0 endon("death");

  if(isDefined(var_0.usingremote)) {
    return false;
  }

  if(isDefined(var_0.vehicle)) {
    return false;
  }

  if(!var_0 scripts\cp_mp\utility\player_utility::_isalive()) {
    return false;
  }

  if(scripts\cp\utility::is_friendly_damage(var_0, var_1) && var_0 != var_1) {
    return false;
  }

  var_4 = distance(var_2, var_0.origin);
  var_5 = 0;

  if(var_1 == var_0) {
    if(var_4 > 384) {
      return false;
    } else {
      var_5 = 1;
    }
  }

  var_6 = 0;
  var_7 = 0;

  if(var_4 >= 512 || !scripts\engine\utility::within_fov(var_1.origin, var_1 getplayerangles(), var_2, 0.5)) {
    var_6 = 3;
    var_7 = 0.25;
  } else if(var_4 <= 256) {
    var_6 = 5;
    var_7 = 0.75;
  } else {
    var_8 = 1 - (var_4 - 256) / 256;
    var_6 = 3 + var_8 * 2;
    var_7 = 0.25 + var_8 * 0.5;
  }

  if(var_3) {
    var_0 = var_1;
    var_6 = max(3, var_6 * 0.75);
    var_7 = max(0.25, var_7 * 0.75);
  } else if(var_5) {
    var_6 = max(3, var_6 * 0.75);
    var_7 = max(0.25, var_7 * 0.75);
  }

  if(isPlayer(var_0)) {
    var_0 shellshock("flashbang_mp", var_6);
    var_0.flashendtime = gettime() + var_6 * 1000;
    thread flashrumbleloop(var_0);
  } else if(var_0 scripts\cp\utility::is_zombie_agent() || var_0.agent_type == "soldier_agent" || var_0.unittype == "soldier") {
    stunenemiesinrange(var_2, var_1);
  } else {
    var_0 shellshock("flashbang_mp", var_6);
    var_0.flashendtime = gettime() + var_6 * 1000;
    thread flashrumbleloop(var_0);
  }

  return true;
}

function isflashgrenadedamage(var_0, var_1) {
  return var_0.basename == "flash_grenade_mp" && var_1 != "MOD_IMPACT";
}

function flashrumbleloop(var_0) {
  self endon("stop_monitoring_flash");
  self endon("flash_rumble_loop");
  self notify("flash_rumble_loop");
  var_1 = gettime() + var_0 * 1000;

  while(gettime() < var_1) {
    self playRumbleOnEntity("damage_heavy");
    wait 0.05;
  }
}

function giveequipmentasaweapon(var_0) {
  switch (var_0) {
    case "molotov":
      self.last_weapon = self getcurrentweapon();
      self giveweapon("iw8_molotov_zm");
      self switchtoweapon("iw8_molotov_zm");
      break;
    case "breach_charge":
      self.last_weapon = self getcurrentweapon();
      self giveweapon("c4_mp_p");
      self switchtoweapon("c4_mp_p");
      break;
  }
}

function watch_for_dropped_weapons() {
  for(;;) {
    level waittill("ai_weapon_dropped");
    var_0 = getweaponarray();

    foreach(var_2 in var_0) {
      var_2 setusepriority(1, 1);
    }
  }
}

function drop_script_weapon_from_ai(var_0, var_1) {
  var_2 = var_0.basename;

  if(scripts\engine\utility::array_contains(level.invalid_drop_weapons, var_2)) {
    return;
  }

  var_3 = var_0.attachments;
  var_4 = getDvar("scr_weapdrop_force_att", "");

  if(var_4 != "") {
    var_3 = scripts\engine\utility::array_add(var_3, var_4);
  }

  if(ref_124AE()) {
    var_5 = 1;
  } else {
    var_5 = undefined;
  }

  var_6 = spawn_script_weapon(var_3, var_4, self.origin + (0, 0, 32), self.angles, var_5);

  if(!isDefined(var_6)) {
    return;
  }

  var_7 = getweapongroup(var_1);
  scripts\cp_mp\utility\weapon_utility::dropweaponfordeathlaunch(var_6, var_7);

  if(!isDefined(var_6)) {
    return;
  }

  update_dropped_weapon_priorities(var_6);
  var_8 = getsubstr(var_6.classname, 7, var_6.classname.size);
  var_6 scripts\anim\shared::setscriptammo(var_8, self);
  thread delete_weapon_after_time();
  thread watchweaponpickup();
}

function ref_124AE() {
  if(level.script == "cp_so_estate") {
    return true;
  }

  return false;
}

function delete_weapon_after_time() {
  level endon("game_ended");
  self endon("death");
  self endon("entitydeleted");
  wait 30;
  remove_from_weapon_array(self);
  self delete();
}

function update_dropped_weapon_priorities() {
  self setusepriority(1, 1);
  self setuserange(72);
}

function initializeweaponpickups() {
  if(level.gametype == "cp_pvpve") {
    return;
  }

  if(isDefined(level.custom_allowedweaponnames)) {
    var_0 = level.custom_allowedweaponnames;
  } else {
    var_0 = ["iw8_ar_falpha", "iw8_sm_papa90", "iw8_sm_augolf", "iw8_lm_pkilo", "iw8_sn_alpha50", "iw8_pi_mike1911", "iw8_ar_mike4", "iw8_ar_akilo47", "iw8_sm_mpapa5", "iw8_sh_dpapa12", "iw8_lm_kilo121", "iw8_sn_mike14", "iw8_sn_kilo98", "iw8_pi_golf21", "iw8_sn_crossbow"];
  }

  var_1 = scripts\engine\utility::getStructArray("weapon_pickup", "script_noteworthy");

  foreach(var_3 in var_1) {
    if(isDefined(var_3.script_parameters)) {
      var_4 = getcompletenameforweapon(var_3.script_parameters + "_mp");
      var_5 = spawn("weapon_" + var_4, var_3.origin);
      var_5 itemweaponsetammo(weaponclipsize(var_4), weaponmaxammo(var_4));
      thread watchweaponpickup();
      var_1 = scripts\engine\utility::array_remove(var_1, var_3);
    }
  }

  var_7 = [];
  var_8 = [];

  foreach(var_14, var_10 in level.weaponmapdata) {
    foreach(var_4 in var_0) {
      if(var_14 == var_4) {
        var_12 = strtok(var_14, "_");

        if(var_12[0] == "iw8") {
          var_7 = var_14;
          level.attachmentmap[var_14] = pullattachmentsforweapon(var_14);
        }
      }
    }
  }

  var_7 = eliminatenullweapons(var_7);
  var_15 = 0;
  var_16 = 0;
  var_17 = var_1.size;

  while(var_16 < var_17) {
    var_15 = randomintrange(0, var_7.size);
    var_18 = attachmentroll(var_7[var_15]);

    foreach(var_20 in var_18) {
      foreach(var_22 in var_18) {
        if(!attachmentscompatible(var_20, var_22)) {
          var_18 = scripts\engine\utility::array_remove(var_18, var_22);
          LOC_00000213:
        }
        LOC_00000213:
      }
    }

    var_4 = getcompletenameforweapon(var_7[var_15]);
    var_5 = spawn("weapon_" + var_4, var_1[var_16].origin);

    if(isDefined(var_1[var_16].angles)) {
      var_5.angles = var_1[var_16].angles;
    } else {
      var_5.angles = (0, 0, 0);
    }

    var_5 itemweaponsetammo(weaponclipsize(var_4), weaponmaxammo(var_4));
    thread watchweaponpickup();
    var_16++;
  }
}

function attachmentroll(var_0) {
  var_1 = [];

  if(isDefined(level.attachmentmap[var_0])) {
    var_2 = scripts\engine\utility::array_randomize(level.attachmentmap[var_0]);
    var_3 = attachmentrollcount();

    for(var_4 = 0; var_4 < var_3 && var_4 < var_2.size; var_4++) {
      var_1 = var_2[var_4];
    }
  }

  return var_1;
}

function attachmentrollcount() {
  var_0 = randomint(100);

  if(var_0 < 50) {
    return 0;
  } else if(var_0 < 80) {
    return 1;
  } else if(var_0 < 95) {
    return 2;
  } else if(var_0 < 100) {
    return 3;
  }

  return 0;
}

function pullattachmentsforweapon(var_0) {
  foreach(var_2 in level.attachmentmap_basetounique) {
    if(var_0 == var_3) {
      return returnarraywithoutdefaults(var_2, var_0);
    }
  }
}

function returnarraywithoutdefaults(var_0, var_1) {
  foreach(var_3 in level.weaponmapdata) {
    if(var_1 == var_4) {
      if(scripts\engine\utility::array_contains(var_0, "doubletap")) {
        var_0 = scripts\engine\utility::array_remove(var_0, "doubletap");
      }

      if(scripts\engine\utility::array_contains(var_0, "reconsilencer_cp")) {
        var_0 = scripts\engine\utility::array_remove(var_0, "reconsilencer_cp");
      }

      if(isDefined(var_3.attachdefaults)) {
        return scripts\engine\utility::array_remove_array(var_0, var_3.attachdefaults);
      }
    }
  }
}

function eliminatenullweapons(var_0) {
  var_1 = ["iw8_knife", "iw8_fists", "iw8_knifestab", "none", "speciality_null", "iw8_ar_dummycp", "iw8_ar_dummycs", "iw8_me_riotshield"];
  var_2 = [];

  if(isstruct(scripts\engine\utility::random(var_0))) {
    foreach(var_4 in var_0) {
      if(!scripts\engine\utility::array_contains(var_1, var_5)) {
        var_2 = var_4;
      }
    }

    return var_2;
  }

  return scripts\engine\utility::array_remove_array(var_3, var_4);
}

function choosepassive() {
  for(;;) {
    var_0 = scripts\engine\utility::random(level.lootpassivesstructs);

    foreach(var_2 in level.cp_weapon_passives) {
      if(var_0.name == var_3) {
        return var_0;
      }
    }

    waitframe();
  }
}

function makeexplosiveunusuabletag() {
  self notify("makeExplosiveUnusable");
  self makeunusable();
}

function isplantedequipment(var_0) {
  return isDefined(level.mines[var_0 getentitynumber()]) || istrue(var_0.planted);
}

function assignlootpassivetoweapon(var_0, var_1) {
  var_2 = choosepassive();

  if(isDefined(var_2.attachmentref)) {
    return getcompleteweaponname(var_0, [var_2.attachmentref]);
  }

  var_3 = scripts\cp\utility::getweaponrootname(var_0);
  var_4 = getcompleteweaponname(var_0);
  var_1.weapon_passives[var_3] = var_2;
  return var_4;
}

function grenadeinpullback() {
  return !nullweapon(self getheldoffhand());
}

function getgrenadeinpullback() {
  var_0 = self getheldoffhand();

  if(isDefined(self.gestureweapon) && var_0 == asmdevgetallstates(self.gestureweapon)) {
    var_0 = isundefinedweapon();
  }

  return var_0;
}

function grenadeinitialize(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_0.weapon_object)) {
    var_0.weapon_object = var_1;
  }

  if(!isDefined(var_0.weapon_name)) {
    var_0.weapon_name = var_1.basename;
  }

  if(!isDefined(var_0.owner)) {
    var_0.owner = self;
  }

  if(!isDefined(var_0.team)) {
    var_0.team = self.team;
  }

  if(!isDefined(var_0.tickpercent)) {
    var_0.tickpercent = var_2;
  }

  if(!isDefined(var_0.ticks) && isDefined(var_0.tickpercent)) {
    var_0.ticks = scripts\cp\utility::roundup(4 * var_2);
  }

  var_4 = scripts\cp\cp_equipment::getequipmentreffromweapon(var_1);

  if(isDefined(var_4)) {
    var_0.equipmentref = var_4;
    var_0.isequipment = 1;
  }

  var_0.threwback = isDefined(var_3);
}

function allow_weapon_first_raise_anims(var_0, var_1) {
  var_2 = scripts\common\input_allow::allow_input_internal("firstRaiseAnims", var_0, var_1);

  if(isDefined(var_2) && var_2) {
    setsaveddvar("bg_disableWeaponFirstRaiseAnims", 0);
    return;
  }

  if(isDefined(var_2) && !var_2) {
    setsaveddvar("bg_disableWeaponFirstRaiseAnims", 1);
    return;
  }
}

function updatelastweapon() {
  self endon("disconnect");
  self endon("faux_spawn");
  self.lastnormalweaponobj = scripts\engine\utility::ter_op(isDefined(self.spawnweaponobj), self.spawnweaponobj, isundefinedweapon());
  self.lastweaponobj = scripts\engine\utility::ter_op(isDefined(self.spawnweaponobj), self.spawnweaponobj, isundefinedweapon());
  self.lastdroppableweaponobj = scripts\engine\utility::ter_op(isDefined(self.spawnweaponobj), self.spawnweaponobj, isundefinedweapon());
  self.lastcacweaponobj = scripts\engine\utility::ter_op(isDefined(self.spawnweaponobj) && iscacprimaryorsecondary(self.spawnweaponobj), self.spawnweaponobj, isundefinedweapon());

  for(;;) {
    self waittill("weapon_change", var_0);
    self.lastweaponobj = var_0;

    if(isnormallastweapon(var_0)) {
      self.lastnormalweaponobj = var_0;
    }

    if(isdroppableweapon(var_0)) {
      self.lastdroppableweaponobj = var_0;
    }

    if(iscacprimaryorsecondary(var_0)) {
      self.lastcacweaponobj = var_0;
    }
  }
}

function isnormallastweapon(var_0) {
  if(var_0.basename == "none") {
    return false;
  }

  if(var_0.classname == "turret") {
    return false;
  }

  if(scripts\cp\utility::issuperweapon(var_0.basename)) {
    return false;
  }

  if(scripts\cp\utility::iskillstreakweapon(var_0.basename)) {
    return false;
  }

  if(var_0.inventorytype != "primary" && var_0.inventorytype != "altmode") {
    return false;
  }

  return true;
}

function iscacprimaryweapon(var_0) {
  switch (getweapongroup(var_0)) {
    case "weapon_assault":
    case "weapon_dmr":
    case "weapon_smg":
    case "weapon_melee":
    case "weapon_shotgun":
    case "weapon_lmg":
    case "weapon_sniper":
      return 1;
    default:
      return 0;
  }
}

function getweapongroup(var_0) {
  if(!isDefined(var_0)) {
    return "other";
  }

  if(issameweapon(var_0) && nullweapon(var_0)) {
    return "other";
  }

  if(isstring(var_0) && (var_0 == "none" || var_0 == "alt_none")) {
    return "other";
  }

  var_1 = scripts\cp\utility::getweaponrootname(var_0);
  var_2 = scripts\cp\utility::weapongroupmap(var_1);

  if(!isDefined(var_2)) {
    if(scripts\cp\utility::issuperweapon(var_0)) {
      var_2 = "super";
    } else if(scripts\cp\utility::isenvironmentweapon(var_0)) {
      var_2 = "weapon_mg";
    } else if(scripts\cp\utility::iskillstreakweapon(var_0)) {
      var_2 = "killstreak";
    } else {
      var_2 = "other";
    }
  }

  return var_2;
}

function iscacsecondaryweapon(var_0) {
  switch (getweapongroup(var_0)) {
    case "weapon_machine_pistol":
    case "weapon_rail":
    case "weapon_beam":
    case "weapon_pistol":
    case "weapon_projectile":
    case "weapon_melee2":
      return 1;
    default:
      return 0;
  }
}

function iscacprimaryorsecondary(var_0) {
  return iscacprimaryweapon(var_0) || iscacsecondaryweapon(var_0);
}

function iscacmeleeweapon(var_0) {
  return getweapongroup(var_0) == "weapon_melee";
}

function isdroppableweapon(var_0) {
  if(var_0.basename == "none") {
    return false;
  }

  if(isfistweapon(var_0.basename)) {
    return false;
  }

  if(isDefined(self) && istrue(self.inlaststand)) {
    return false;
  }

  if(scripts\cp\utility::iskillstreakweapon(var_0.basename)) {
    return false;
  }

  if(scripts\cp\utility::issuperweapon(var_0.basename)) {
    return false;
  }

  if(var_0.inventorytype != "primary") {
    return false;
  }

  if(var_0.classname == "turret") {
    return false;
  }

  if(!iscacprimaryweapon(var_0.basename) && !iscacsecondaryweapon(var_0.basename)) {
    return false;
  }

  return true;
}

function gui_giveattachment() {
  var_0 = getDvar("scr_giveattachment");

  if(isDefined(var_0)) {
    foreach(var_2 in level.players) {
      gui_giveattachment_internal(var_2, var_0);
    }
  }
}

function gui_giveattachment_internal(var_0, var_1) {
  var_2 = var_0.currentweapon;
  var_0 dropitem(var_2);
  var_2 = var_2 getnoaltweapon();
  var_3 = scripts\cp\utility::getweaponattachmentsbasenames(var_2);
  var_4 = 0;

  if(scripts\engine\utility::array_contains(var_3, var_1)) {
    var_4 = 1;
  } else {
    var_5 = scripts\cp\utility::attachmentmap_tounique(var_1, var_2);

    if(!var_2 canuseattachment(var_5)) {
      if(!isbot(var_0)) {
        var_0 iprintlnbold("Invalid attachment for this weapon: " + var_5);
      }

      var_4 = 1;
    }
  }

  if(var_4) {
    var_0 giveweapon(var_2);
    return;
  }

  var_6 = var_3;
  GscBinSkip0(0x2e, var_6.size, var_1);
}

function watchgunsmithdebugui() {
  for(;;) {
    level waittill("connected", var_0);
    thread watchplayergunsmithdebugui();
  }
}

function watchplayergunsmithdebugui() {
  self endon("disconnect");

  for(;;) {
    self waittill("luinotifyserver", var_0, var_1);

    if(var_0 == "debug_attach_select") {
      var_2 = tablelookup("mp/attachmenttable.csv", 0, var_1, 4);
      gui_giveattachment_internal(self, var_2);
    }
  }
}

function create_weapon_pickups() {
  var_0 = scripts\engine\utility::getStructArray("weapon_pickup", "targetname");

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_2 = strtok(var_0[var_1].script_noteworthy, "+");
    var_3 = var_2[0];
    var_4 = [];

    if(var_2.size > 1) {
      var_5 = strtok(var_2[1], " ");

      for(var_6 = 0; var_6 < var_5.size; var_6++) {
        var_4 = var_5[var_6];
      }
    }

    var_3 = spawn_script_weapon(var_3, var_4, var_0[var_1].origin, var_0[var_1].angles);
  }
}

function spawn_script_weapon(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_1)) {
    var_1 = [];
  }

  if(!isarray(var_1)) {
    var_1 = [var_1];
  }

  var_5 = undefined;

  if(getdvarint("scr_ai_random_weap", 0) != 0) {
    var_5 = buildweaponwithrandomattachments(var_0, var_1);
  } else {
    var_5 = buildweapon(var_0, var_1, "none", "none", -1, undefined, undefined, undefined, var_4);
  }

  var_6 = createheadicon(var_5);
  var_7 = spawn("weapon_" + var_6, var_2);

  if(isDefined(var_7)) {
    if(scripts\cp\utility::turn_off_sniper_laser()) {
      var_7 itemweaponsetammo(weaponclipsize(var_7), 0);
    } else {
      var_7 itemweaponsetammo(weaponclipsize(var_7), weaponclipsize(var_7));
    }

    var_7.angles = var_3;
    add_to_weapon_array(var_7);
    var_7 thread scripts\engine\utility::thread_on_notify_no_endon_death("death", &remove_from_weapon_array);
  }

  return var_7;
}

function add_to_weapon_array(var_0) {
  level.dropped_weapons[level.dropped_weapons.size] = var_0;
}

function remove_from_weapon_array(var_0) {
  if(isDefined(var_0)) {
    if(scripts\engine\utility::array_contains(level.dropped_weapons, var_0)) {
      level.dropped_weapons = scripts\engine\utility::array_remove(level.dropped_weapons, var_0);
      return;
    }

    return;
  }
}

function smokegrenadeused(var_0) {
  thread scripts\cp\utility::notifyafterframeend("death", "end_explode");
  self endon("end_explode");
  var_1 = self.owner.name;
  jumpiffalse(istrue(var_0)) LOC_0000005a;
  self waittill("missile_stuck", var_2, var_3, var_4, var_5, var_6, var_7);
  thread ref_13426(var_6);
  goto LOC_00000066;
}

function smokegrenadeexplode(var_0, var_1) {
  wait 1;
  var_2 = scripts\cp\cp_outline_utility::addoutlineoccluder(var_0, 330);
  var_3 = spawn("script_model", var_0);
  var_3 show();
  var_4 = getEnt("smoke_grenade_sight_clip_256", "targetname");

  if(isDefined(var_4)) {
    level notify("grenade_exploded_during_stealth", var_3, "smoke_grenade_mp", var_1);
    var_3 clonebrushmodeltoscriptmodel(var_4);
    var_3 setmovertransparentvolume();
  } else {
    var_3 delete();
  }

  wait 8.25;

  if(isDefined(var_3)) {
    var_3 delete();
  }

  scripts\cp\cp_outline_utility::removeoutlineoccluder(var_2);
}

function sfx_smoke_grenade_smoke(var_0) {
  wait 0.2;
  var_1 = spawn("script_origin", var_0);
  var_1 playLoopSound("smoke_grenade_smoke_lp");
  var_1 scripts\cp_mp\ent_manager::registerspawncount(1);
  wait 5.25;
  thread scripts\engine\utility::play_sound_in_space("smoke_grenade_smoke_tail", var_0);
  wait 0.3;
  var_1 scripts\cp_mp\ent_manager::deregisterspawn();
  var_1 stoploopsound();
  var_1 delete();
}

function ref_13426(var_0, var_1) {
  playFX(scripts\engine\utility::getfx("glsmoke"), var_0, anglestoup((0, 90, 0)));
}

function monitorsmokeactive() {
  self endon("disconnect");
  level endon("game_ended");
  self notify("monitorSmokeActive()");
  self endon("monitorSmokeActive()");
  scripts\cp\utility::printgameaction("smoke grenade activated", self);
  self.hasactivesmokegrenade = 1;
  var_0 = scripts\engine\utility::ref_143B9(9.25, "death");
  self.hasactivesmokegrenade = 0;
  scripts\cp\utility::printgameaction("smoke grenade deactivated", self);
}

function buildweaponwithrandomattachments(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  var_10 = scripts\cp\utility::getweaponrootname(var_0);

  if(!isai(self)) {
    return;
  }

  return getweapon(var_10, weaponclass(var_0));
}

function getweapon(var_0, var_1) {
  var_2 = [];

  if(isarray(var_0)) {
    var_2 = var_0;
    var_0 = var_0[randomint(var_0.size)];
  } else {
    var_2 = [var_0];
  }

  if(var_0 == "iw8_lm_dblmg_mp") {}

  if(true) {
    return getweapon_aq(var_1, var_0, var_2);
  }

  if(issubstr(tolower(self.classname), "_alq_")) {
    return getweapon_aq(var_1, var_0, var_2);
  } else if(issubstr(tolower(self.classname), "_rus_desert_")) {
    return getweapon_ru(var_1, var_0, var_2);
  } else if(issubstr(tolower(self.classname), "_spetsnaz_")) {
    return getweapon_ru(var_1, var_0, var_2);
  } else if(issubstr(tolower(self.classname), "_hero_")) {
    return getweapon_hero(var_0, var_2);
  } else if(issubstr(tolower(self.classname), "_villain_")) {
    return getweapon_hero(var_0, var_2);
  } else if(issubstr(tolower(self.classname), "_sas_")) {
    return getweapon_sas(var_1, var_0, var_2);
  } else if(issubstr(tolower(self.classname), "_reb_")) {
    return getweapon_reb(var_1, var_0, var_2);
  } else if(issubstr(tolower(self.classname), "_so15_")) {
    return getweapon_so15(var_1, var_0, var_2);
  } else if(issubstr(tolower(self.classname), "_london_police_")) {
    return getweapon_so15(var_1, var_0, var_2);
  } else if(issubstr(tolower(self.classname), "_usmc_")) {
    return getweapon_usmc(var_1, var_0, var_2);
  } else {
    return buildweapon(var_0);
  }

  return var_0;
}

function getweapon_hero(var_0, var_1) {
  if(issubstr(tolower(self.classname), "_hero_alex")) {
    switch (var_0) {
      case "iw8_pi_mike1911":
        return make_weapon_special("alex_pistol");
      case "iw8_sn_mike14":
        return make_weapon_special("alex_sniper");
    }
  } else if(issubstr(tolower(self.classname), "_hero_hadir")) {
    switch (var_0) {
      case "iw8_sm_augolf":
        return make_weapon_special("hadir_smg");
      case "iw8_sn_hdromeo":
        return make_weapon_special("hadir_sniper");
    }
  } else if(issubstr(tolower(self.classname), "_hero_kyle")) {
    switch (var_0) {
      case "iw8_ar_mcharlie":
        return make_weapon_special("kyle_ar");
    }
  } else if(issubstr(tolower(self.classname), "_hero_price")) {
    switch (var_0) {
      case "iw8_pi_papa320":
        return make_weapon_special("papa320_black");
      case "iw8_ar_kilo433":
        return make_weapon_special("price_ar");
    }
  } else if(issubstr(tolower(self.classname), "_hero_farah")) {
    switch (var_0) {
      case "iw8_ar_akilo47":
        return make_weapon_special("farah_ar");
    }
  } else if(issubstr(tolower(self.classname), "_villain_barkov")) {
    switch (var_0) {
      case "iw8_pi_golf21":
        return make_weapon_special("barkov_pistol");
    }
  }

  if(getdvarint("scr_randomweapon_debug")) {
    iprintln("not whitelisted!skipping scripted build.");
  }

  return make_weapon(var_0, []);
}

function getweapon_aq(var_0, var_1, var_2) {
  var_3 = [];
  var_4 = [];

  switch (var_0) {
    case "rifle":
    case "ar":
      GscBinSkip1(0x45, "iw8_ar_akilo47", 45);

    case "dmr":
      GscBinSkip1(0x45, "iw8_sn_kilo98", 50);

    case "jugg":
      return "iw8_lm_dblmg";
    case "launcher":
      return "iw8_la_rpapa7";
    case "lmg":
      GscBinSkip1(0x45, "iw8_lm_pkilo", 50);

    case "pistol":
      GscBinSkip1(0x45, "iw8_pi_mike1911", 50);

    case "shotgun":
      GscBinSkip1(0x45, "iw8_sh_romeo870", 50);

    case "smg":
      GscBinSkip1(0x45, "iw8_sm_uzulu", 90);

    case "sniper":
      GscBinSkip1(0x45, "iw8_sn_delta", 50);
  }

  return randomize_weapon(var_1, var_3, var_4);
}

function getweapon_ru(var_0, var_1, var_2) {
  var_3 = [];
  var_4 = [];

  switch (var_0) {
    case "rifle":
      GscBinSkip1(0x45, "iw8_ar_akilo47", 70);

    case "dmr":
      switch (var_1) {
        case "iw8_sn_mike14":
          var_3 = [50, "snprscope_mike14"];
          var_3 = [100, "laserads_bar"];
          break;
      }

      break;
    case "launcher":
      break;
    case "lmg":
      switch (var_1) {
        case "iw8_lm_pkilo":
          var_3 = [50, "bipod_pkilo"];
          break;
      }

      break;
    case "pistol":
      break;
    case "shotgun":
      GscBinSkip1(0x45, "iw8_sh_romeo870", 50);

    case "smg":
      GscBinSkip1(0x45, "iw8_ar_akilo47", 70);

    case "sniper":
      switch (var_1) {
        case "iw8_sn_delta":
          var_3 = [100, "laserads_bar"];
          break;
      }

      break;
  }

  return randomize_weapon(var_1, var_3, var_4);
}

function getweapon_reb(var_0, var_1, var_2) {
  var_3 = [];
  var_4 = [];

  switch (var_0) {
    case "rifle":
      GscBinSkip1(0x45, "iw8_ar_akilo47", 50);

    case "dmr":
      switch (var_1) {
        case "iw8_sn_kilo98":
          var_3 = [50, "snprscope_kilo98", "vzscope_kilo98"];
          var_3 = [30, "xmags_kilo98"];
          var_3 = [40, "laserads_bar"];
          break;
      }

      break;
    case "launcher":
      break;
    case "lmg":
      GscBinSkip1(0x45, "iw8_lm_pkilo", 50);

    case "pistol":
      break;
    case "shotgun":
      switch (var_1) {
        case "iw8_sh_romeo870":
          var_3 = [100, "stockno_romeo870", "stockh_romeo870", "stockl_romeo870", "stocks_romeo870"];
          var_3 = [50, "barshort_romeo870", "barlong_romeo870"];
          break;
      }

      break;
    case "smg":
      GscBinSkip1(0x45, "iw8_ar_akilo47", 70);

    case "sniper":
      switch (var_1) {
        case "iw8_sn_alpha50":
          var_3 = [100, "snprscope_alpha50", "vzscope_alpha50"];
          var_3 = [50, "barmid_alpha50", "barshort_alpha50"];
          var_3 = [100, "laserads"];
          var_3 = [50, "stockl_alpha50", "stockh_alpha50", "stocks_alpha50"];
          var_3 = [25, "bipodsnpr"];
          var_3 = [35, "xmags_alpha50"];
          break;
      }

      break;
  }

  return randomize_weapon(var_1, var_3, var_4);
}

function getweapon_sas(var_0, var_1, var_2) {
  var_3 = [];
  var_4 = [];

  switch (var_0) {
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

  return randomize_weapon(var_1, var_3, var_4);
}

function getweapon_so15(var_0, var_1, var_2) {
  var_3 = [];
  var_4 = [];

  switch (var_0) {
    case "rifle":
      break;
    case "dmr":
      break;
    case "launcher":
      break;
    case "lmg":
      break;
    case "pistol":
      if(level.script == "piccadilly" || level.script == "ai_aitypes_allies") {
        return make_weapon_special("papa320_black_rain");
      } else {
        return make_weapon_special("papa320_black");
      }
    case "shotgun":
      break;
    case "smg":
      break;
    case "sniper":
      break;
  }

  return randomize_weapon(var_1, var_3, var_4);
}

function getweapon_usmc(var_0, var_1, var_2) {
  var_3 = [];
  var_4 = [];

  switch (var_0) {
    case "rifle":
      switch (var_1) {
        case "iw8_ar_mike4":
          var_3 = [85, "reflex_west01", "reflex_west02", "holo_west01", "acog_west01_irons", "minireddot"];
          var_3 = [70, "stockl_mike4", "stocks_mike4", "back_mike4|1", "back_mike4|2"];
          var_3 = [50, "xmags_mike4", "mag_mike4|1", "mag_mike4|2"];
          var_3 = [50, "gripvert", "gripang", "gripvertpro", "gripangpro"];
          var_3 = [70, "barshort_mike4", "front_mike4|2"];
          var_3 = [15, "ub_mike203"];
          var_3 = [65, "flashhider", "comp", "brake", "linearbrake", "laser", "laserir"];
          var_3 = [50, "rec_mike4|1", "rec_mike4|2"];
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

  return randomize_weapon(var_1, var_3, var_4);
}

function make_weapon_special(var_0) {
  switch (var_0) {
    case "farah_ar":
      var_0 = make_weapon("iw8_ar_akilo47", ["rec_akilo47_mp|1", "back_akilo47|1", "front_akilo47|1", "mag_akilo47|1", "guard_akilo47|1"]);
      break;
    case "alex_sniper":
      var_0 = make_weapon("iw8_sn_mike14", ["vzscope_mike14", "rec_mike14|1", "reargrip_mike14|1", "front_mike14|1", "mag_mike14|1"]);
      break;
    case "alex_pistol":
      var_0 = make_weapon("iw8_pi_mike1911", ["rec_mike1911|2", "mag_mike1911|2", "slide_mike1911|2"]);
      break;
    case "hadir_smg":
      var_0 = make_weapon("iw8_sm_augolf", ["rec_augolf|1", "front_augolf|1", "mag_augolf|1", "toprail_augolf|1"]);
      break;
    case "hadir_sniper":
      var_0 = make_weapon("iw8_sn_hdromeo_ballistics", ["vzscope_hdromeo_ballistics", "bipod_hdromeo", "rec_hdromeo|1", "back_hdromeo|1", "front_hdromeo|1", "mag_hdromeo|1"]);
      break;
    case "sas_ar":
      var_0 = make_weapon("iw8_ar_kilo433", ["holo_west01", "laserir", "rec_kilo433|1", "back_kilo433|1", "front_kilo433|1", "mag_kilo433|1"]);
      break;
    case "price_ar":
      var_0 = make_weapon("iw8_ar_kilo433", ["hybrid_west01", "laserir", "rec_kilo433|1", "back_kilo433|1", "front_kilo433|1", "mag_kilo433|1"]);
      break;
    case "kyle_ar":
      var_0 = make_weapon("iw8_ar_mcharlie", ["semi_ar", "reflex_west01", "silencer04", "laserir", "rec_mcharlie|1", "back_mcharlie|1", "front_mcharlie|1", "mag_mcharlie|1"]);
      break;
    case "papa320_black":
      var_0 = make_weapon("iw8_pi_papa320", ["rec_papa320|2", "mag_papa320|2", "slide_papa320|2"]);
      break;
    case "papa320_black_rain":
      var_0 = make_weapon("iw8_pi_papa320", ["rec_papa320_r", "mag_papa320_r", "slide_papa320_r"]);
      break;
    case "barkov_pistol":
      var_0 = make_weapon("iw8_pi_golf21", ["rec_golf21|1", "mag_golf21|1", "slide_golf21|1"]);
      break;
    case "estate_teaser_price":
      var_0 = make_weapon("iw8_ar_kilo433", ["hybrid_west01", "laserir", "silencer04", "rec_kilo433|1", "mag_kilo433|1", "stockh"]);
      break;
    case "estate_teaser":
      var_0 = make_weapon("iw8_ar_kilo433", ["reflex_west01", "laserir", "silencer04", "rec_kilo433|1", "mag_kilo433|1", "stockh"]);
      break;
    default:
      var_0 = undefined;
      break;
  }

  return var_0;
}

function make_weapon(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(level._weapons)) {
    level._weapons = spawnStruct();
  }

  if(!isDefined(var_1)) {
    var_1 = [];
  }

  if(!issameweapon(var_0)) {
    var_6 = strtok(var_0, "+");

    if(var_6.size > 1) {
      var_0 = var_6[0];
      var_1 = scripts\engine\utility::array_combine(var_1, scripts\engine\utility::array_remove(var_6, var_6[0]));
    }
  } else {
    if(nullweapon(var_0)) {
      return var_0;
    }

    var_0 = getweaponbasename(var_0);
  }

  if(istrue(var_5)) {
    var_7 = &makeweaponfromstring;
  } else {
    var_7 = &getcompleteweaponname;
  }

  var_8 = var_1;

  if(issubstr(var_1, "_mp")) {
    var_8 = scripts\cp\utility::getweaponrootname(var_1);
  }

  var_9 = scripts\cp\utility::weaponattachdefaultmap(var_8);
  var_9 = removeconflictingattachments(var_2, var_9);
  var_2 = scripts\engine\utility::array_combine(var_2, var_9);
  var_10 = scripts\cp\utility::buildweaponassetname(var_8, var_5);
  var_11 = [];

  foreach(var_13 in var_2) {
    if(issubstr(var_13, "|")) {
      var_2 = scripts\engine\utility::array_remove(var_2, var_13);
      var_2 = strtok(var_13, "|")[0];
      var_11 = var_13;
    }
  }

  var_15 = buildweaponuniqueattachments(var_8, var_2, var_5);
  var_15 = checkforinvalidattachments(var_15, var_10);
  var_2 = var_15;

  if(isDefined(var_5)) {
    var_16 = builtin[[var_7]](var_10, var_2, var_3, var_4, var_5);
  } else if(isDefined(var_5)) {
    var_16 = builtin[[var_8]](var_11, var_3, var_4, var_5);
  } else if(isDefined(var_5)) {
    var_16 = builtin[[var_9]](var_12, var_4, var_5);
  } else if(isDefined(var_5)) {
    var_16 = builtin[[var_10]](var_13, var_5);
  } else {
    var_16 = builtin[[var_11]](var_14);
  }

  foreach(var_16 in var_15) {
    var_6 = strtok(var_16, "|");
    var_16 = var_16 withattachment(var_6[0], int(var_6[1]));
  }

  return var_16;
}

function removeconflictingattachments(var_0, var_1) {
  var_1 = removeconflictingdefaultattachment(var_0, var_1, "bar", "front_");
  var_1 = removeconflictingdefaultattachment(var_0, var_1, "barlong", "slide_");
  var_1 = removeconflictingdefaultattachment(var_0, var_1, "barcust", "guard_");
  var_1 = removeconflictingdefaultattachment(var_0, var_1, "stock", "back_");
  var_1 = removeconflictingdefaultattachment(var_0, var_1, "cal", "mag_");
  var_1 = removeconflictingdefaultattachment(var_0, var_1, "drums", "mag_");
  var_1 = removeconflictingdefaultattachment(var_0, var_1, "xmags", "mag_");
  var_1 = removeconflictingdefaultattachment(var_0, var_1, "rack", "mag_");
  var_1 = removeconflictingdefaultattachment(var_0, var_1, "rack", "ammo_");
  var_1 = removeconflictingdefaultattachment(var_0, var_1, "thermal", "scope");
  var_1 = removeconflictingdefaultattachment(var_0, var_1, "acog", "scope");
  var_1 = removeconflictingdefaultattachment(var_0, var_1, "reflex", "scope");
  var_1 = removeconflictingdefaultattachment(var_0, var_1, "holo", "scope");
  var_1 = removeconflictingdefaultattachment(var_0, var_1, "grip", "grip_");
  var_1 = removeconflictingdefaultattachment(var_0, var_1, "rec_", "rec_");
  var_1 = removeconflictingdefaultattachment(var_0, var_1, "toprail_", "toprail_");
  return var_1;
}

function removeconflictingdefaultattachment(var_0, var_1, var_2, var_3) {
  var_4 = undefined;

  foreach(var_6 in var_0) {
    if(issubstr(var_6, var_3)) {
      var_4 = 1;
    }

    if(isstartstr(var_6, var_2) || istrue(var_4)) {
      for(var_7 = 0; var_7 < var_1.size; var_7++) {
        if(issubstr(var_1[var_7], var_3)) {
          var_1 = scripts\engine\utility::array_remove_index(var_1, var_7);
          return var_1;
        }
      }
    }
  }

  return var_1;
}

function randomize_weapon(var_0, var_1, var_2) {
  var_3 = scripts\common\utility::get_random_attachments(var_1, var_2);
  var_4 = make_weapon(var_0, var_3);
  return var_4;
}

function getscriptedweapon(var_0, var_1) {
  if(!isDefined(var_0)) {
    return isundefinedweapon();
  }

  if(!isarray(var_0) && var_0 == "") {
    return isundefinedweapon();
  }

  if(isDefined(var_1) && var_1 == "sidearm") {
    var_2 = getweapon(var_0, "pistol");
  } else {
    var_2 = getweapon(var_1, self.scriptedweaponclassprimary);
  }

  return var_2;
}

function printweapon() {
  self notify("stop printWeapon");
  self endon("death");
  self endon("stop printWeapon");

  for(;;) {
    var_0 = 72;

    if(isDefined(self) && isDefined(self.weapon)) {
      if(isDefined(self.weapon.basename)) {}

      if(isDefined(self.weapon.attachments)) {
        var_1 = var_0 - 1.5;

        foreach(var_3 in self.weapon.attachments) {
          var_1 -= 1.4;
        }
      }
    }

    waitframe();
  }
}

function create_weapon_in_script(var_0, var_1) {
  if(!isDefined(level.fnscriptedweaponassignment)) {
    self.usescriptedweapon = undefined;

    if(!isDefined(var_0)) {
      var_2 = isundefinedweapon();
    } else if(!isarray(var_1) && var_1 == "") {
      var_2 = isundefinedweapon();
    } else if(isarray(var_2)) {
      var_2 = getcompleteweaponname(var_2[randomint(var_2.size)]);
    } else {
      var_2 = getcompleteweaponname(var_2);
    }

    if(!nullweapon(var_2)) {
      self.scriptedweaponfailed = 1;

      if(isDefined(var_2) && var_2 == "sidearm") {
        self.scriptedweaponfailed_sidearmarray = var_2;
      } else {
        self.scriptedweaponfailed_primaryarray = var_2;
      }
    }

    return var_2;
  }

  return [[level.fnscriptedweaponassignment]](var_2, var_2);
}

function buildweapon_variant(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = weaponattachcustomtoidmap(var_0, var_3);

  if(!isDefined(var_7)) {
    var_7 = [];
  }

  return buildweapon_attachmentidmap(var_0, var_7, "none", "none", var_3, var_4, var_5, var_6);
}

function buildweapon_attachmentidmap(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = [];
  var_9 = [];

  foreach(var_11 in var_1) {
    var_8 = var_12;
    var_9 = var_11;
  }

  return buildweapon(var_0, var_8, var_2, var_3, var_4, var_9, var_5, var_6, var_7);
}

function buildweapon(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(var_0 != "iw8_minigunksjugg_mp") {
    if(issubstr(var_0, "_mp")) {
      var_0 = scripts\cp\utility::getweaponrootname(var_0);
    }
  }

  if(isDefined(var_1)) {} else {
    var_1 = [];
  }

  if(!isDefined(var_2)) {
    var_2 = "none";
  }

  if(isDefined(var_4) && var_4 < 0) {
    var_4 = undefined;
  }

  var_9 = scripts\cp\utility::buildweaponassetname(var_0, var_4);
  var_10 = buildweaponattachmentidmap(var_1, var_5);

  if(istrue(var_8)) {
    if(weaponsupportslaserir(var_9)) {
      var_11 = getweaponnvgattachment(var_9);

      if(!scripts\engine\utility::array_contains(var_1, var_11)) {
        var_1 = var_11;

        if(var_10.size > 0) {
          var_10 = 0;
        }
      }
    }
  }

  var_12 = buildweaponuniqueattachmenttoidmap(var_0, var_1, var_4, var_10);

  if(isDefined(var_6) && var_6 != "none") {
    GscBinSkip0(0x2e, var_6, 0);
  }

  var_12 = filterinvalidattachmentsfromidmap(var_12, var_9);
  var_1 = [];
  var_5 = [];

  foreach(var_14 in var_12) {
    var_1 = var_15;
    var_5 = var_14;
  }

  var_16 = getcompleteweaponname(var_9, [], undefined, var_2, var_4);

  for(var_17 = 0; var_17 < var_1.size; var_17++) {
    var_16 = var_16 withattachment(var_1[var_17], var_5[var_17]);
  }

  if(isDefined(var_7)) {
    for(var_17 = 0; var_17 < var_7.size; var_17++) {
      if(!isDefined(var_7[var_17])) {
        continue;
      }

      var_18 = var_7[var_17];

      if("i/" != getsubstr(var_18, 0, 2)) {
        var_18 = "i/" + var_7[var_17];
      }

      var_16 = var_16 setsticker(var_17, var_18);
    }
  }

  if(isDefined(var_16.scope) && !isstartstr(var_16.scope, "ironsdefault")) {
    var_19 = getreticleindex(var_3);

    if(isDefined(var_19)) {
      var_16 = var_16 withreticle(var_19);
    }
  }

  return var_16;
}

function buildweaponattachmentidmap(var_0, var_1) {
  var_2 = [];

  if(isDefined(var_1)) {
    foreach(var_4 in var_0) {
      if(var_5 < var_1.size) {
        var_2 = var_1[var_5];
        continue;
      }

      var_2 = 0;
    }
  }

  return var_2;
}

function buildweaponuniqueattachmenttoidmap(var_0, var_1, var_2, var_3) {
  if(isDefined(var_2) && var_2 < 0) {
    var_2 = undefined;
  }

  if(!isDefined(var_3)) {
    var_3 = [];
  }

  var_1 = scripts\engine\utility::array_remove(var_1, "none");
  var_3 = scripts\engine\utility::array_remove_key(var_3, "none");

  if(var_1.size > 0 && var_3.size == 0) {
    foreach(var_5 in var_1) {
      var_3 = 0;
    }
  }

  var_7 = weaponattachdefaulttoidmap(var_0, var_2);
  var_8 = scripts\cp\utility::buildweaponassetname(var_0, var_2);
  var_9 = [];

  if(isDefined(var_7)) {
    var_9 = combinedefaultandcustomattachmentidmaps(var_7, var_3);
  }

  var_10 = [];

  if(var_9.size > 0) {
    var_9 = filterattachmenttoidmap(var_9, var_0);

    foreach(var_5, var_12 in var_9) {
      var_13 = scripts\cp\utility::attachmentmap_tounique(var_5, var_8);
      var_10 = var_12;
    }
  }

  var_14 = [];
  var_15 = 0;
  var_16 = undefined;

  foreach(var_23, var_12 in var_10) {
    var_18 = scripts\cp\utility::attachmentmap_toextra(var_23);

    if(isDefined(var_18)) {
      var_19 = 0;

      if(isDefined(var_2)) {
        var_20 = scripts\cp\utility::attachmentmap_tobase(var_18);
        var_19 = attachmentmap_extratovariantid(var_20, var_0, var_2);
      }

      var_21 = scripts\cp\utility::attachmentmap_tounique(var_18, var_8);
      var_14 = var_19;
    }

    var_22 = scripts\cp\utility::attachmentmap_tobase(var_23);

    if(!isDefined(var_16) && scripts\cp\utility::tv_station_fastrope_two_infil_rider_start_targetname(var_22)) {
      var_16 = var_23;
    }

    if(!var_15 && (scripts\cp\utility::useeventtype(var_22) || scripts\cp\utility::useeventtimestamp(var_23))) {
      var_15 = 1;
    }
  }

  if(var_14.size > 0) {
    var_10 = scripts\engine\utility::array_combine_unique_keys(var_10, var_14);
  }

  if(isDefined(var_16) && var_15) {
    var_16 = scripts\engine\utility::ter_op(var_16 == "calsmg_mike4", "calsil_mike4smg", "calsil");
    var_10 = 0;
  }

  return var_10;
}

function combinedefaultandcustomattachmentidmaps(var_0, var_1) {
  var_2 = [];

  foreach(var_5, var_4 in var_0) {
    if(scripts\engine\utility::array_contains_key(var_1, var_5)) {
      continue;
    }

    var_2 = var_4;
  }

  foreach(var_4 in var_1) {
    var_2 = var_4;
  }

  return var_2;
}

function useprophudserver(var_0) {
  if(!issameweapon(var_0)) {
    return 0;
  }

  switch (var_0.basename) {
    case "iw8_sn_hdromeo_mp":
      if(var_0 hasattachment("barmid", 1)) {
        return 1;
      } else {
        return 0;
      }

      break;
    case "iw8_ar_charlie_mp":
      if(var_0 hasattachment("barsil", 1)) {
        return 1;
      } else {
        return 0;
      }

      break;
    case "iw8_ar_kilo433_mp":
      if(var_0 hasattachment("barsil", 1)) {
        return 1;
      } else {
        return 0;
      }

      break;
    case "iw8_ar_mike4_mp":
      if(var_0 hasattachment("barsil", 1)) {
        return 1;
      } else {
        return 0;
      }

      break;
    case "iw8_sm_mpapa5_mp":
      if(var_0 hasattachment("barsil", 1)) {
        return 1;
      } else {
        return 0;
      }

      break;
    default:
      if(var_0 hasattachment("barsil", 1)) {
        return 1;
      }

      return 0;
  }
}

function filterattachmenttoidmap(var_0, var_1) {
  var_2 = [];
  var_3 = [];

  foreach(var_6, var_5 in var_0) {
    var_3 = var_6;
  }

  if(var_3.size > 0) {
    for(var_7 = 0; var_7 < var_3.size; var_7++) {
      var_6 = var_3[var_7];

      if(var_6 == "none") {
        continue;
      }

      var_8 = 1;

      for(var_9 = 0; var_9 < var_2.size; var_9++) {
        if(var_6 == var_2[var_9]) {
          var_8 = 0;
          break;
        }

        var_10 = attachmentsconflict(var_6, var_2[var_9], var_1);

        if(var_10 != "") {
          var_8 = 0;
          var_2 = scripts\engine\utility::array_remove_index(var_2, var_9);
          var_11 = [];
          var_11 = strtok(var_10, " ");

          foreach(var_13 in var_11) {
            var_3 = scripts\engine\utility::array_insert(var_3, var_13, var_7 + 1 + var_14);
          }

          break;
        }
      }

      if(var_8) {
        var_2 = var_6;
      }
    }
  }

  var_15 = [];

  foreach(var_6 in var_2) {
    var_5 = scripts\engine\utility::ter_op(isDefined(var_0[var_6]), var_0[var_6], 0);
    var_15 = var_5;
  }

  return var_15;
}

function filterinvalidattachmentsfromidmap(var_0, var_1) {
  var_2 = getcompleteweaponname(var_1);
  var_3 = [];

  foreach(var_6, var_5 in var_0) {
    if(var_2 canuseattachment(var_6)) {
      var_3 = var_5;
      continue;
    }

    thread invalidattachmentwarning(var_6, var_1);
  }

  return var_3;
}

function attachmentscompatible(var_0, var_1) {
  if(scripts\cp\utility::attachmentiscosmetic(var_0) && scripts\cp\utility::attachmentiscosmetic(var_1)) {
    return 0;
  }

  var_0 = scripts\cp\utility::attachmentmap_tobase(var_0);
  var_1 = scripts\cp\utility::attachmentmap_tobase(var_1);
  var_2 = 1;

  if(var_0 == var_1) {
    var_2 = 0;
  } else if(isDefined(level.attachmentmap_conflicts)) {
    var_3 = scripts\engine\utility::alphabetize([var_0, var_1]);
    var_2 = !isDefined(level.attachmentmap_conflicts[var_3[0] + "_" + var_3[1]]);
  } else if(var_0 != "none" && var_1 != "none") {
    var_4 = tablelookuprownum("mp/attachmentcombos.csv", 0, var_1);

    if(tablelookup("mp/attachmentcombos.csv", 0, var_0, var_4) == "no") {
      var_2 = 0;
    }
  }

  return var_2;
}

function attachmentsconflict(var_0, var_1, var_2) {
  if(scripts\cp\utility::attachmentiscosmetic(var_0) && scripts\cp\utility::attachmentiscosmetic(var_1)) {
    return var_0;
  }

  var_3 = undefined;

  if(issameweapon(var_2)) {
    var_3 = createheadicon(var_2);
  } else {
    var_3 = var_2;
  }

  var_4 = scripts\cp\utility::attachmentmap_tounique(var_0, var_3);
  var_5 = scripts\cp\utility::attachmentmap_tounique(var_1, var_3);

  if(add_head_icon_on_allies(var_4, var_5)) {
    return var_0;
  }

  if(add_head_icon_on_allies(var_5, var_4)) {
    return var_0;
  }

  var_0 = scripts\cp\utility::attachmentmap_tobase(var_0);
  var_1 = scripts\cp\utility::attachmentmap_tobase(var_1);
  var_6 = "";

  if(var_0 == var_1) {
    var_6 = var_0;
  } else if(isDefined(level.attachmentmap_conflicts)) {
    var_7 = scripts\engine\utility::alphabetize([var_0, var_1]);
    var_8 = var_7[0] + "_" + var_7[1];

    if(isDefined(level.attachmentmap_conflicts[var_8])) {
      if(level.attachmentmap_conflicts[var_8] == "no") {
        var_6 = var_0;
      } else {
        var_6 = level.attachmentmap_conflicts[var_8];
      }
    }
  }

  return var_6;
}

function add_head_icon_on_allies(var_0, var_1) {
  var_2 = carryitemomnvar(var_0);
  var_3 = carryiteminfo(var_1);
  return isDefined(var_2) && isDefined(var_3) && var_3 == var_2;
}

function carryiteminfo(var_0) {
  if(isDefined(level.carrier_remove_carriable_weapon[var_0])) {
    return level.carrier_remove_carriable_weapon[var_0];
  }

  return undefined;
}

function carryitemomnvar(var_0) {
  if(isDefined(level.carryobjects_onjuggernaut[var_0])) {
    return level.carryobjects_onjuggernaut[var_0];
  }

  var_1 = scripts\cp\utility::attachmentmap_tobase(var_0);

  if(isDefined(level.carry_ref[var_1])) {
    return level.carry_ref[var_1];
  }

  return undefined;
}

function attachmentmap_extratovariantid(var_0, var_1, var_2) {
  var_3 = var_1 + "|" + var_2;

  if(isDefined(level.weaponlootmapdata[var_3]) && isDefined(level.weaponlootmapdata[var_3].attachextratoidmap) && isDefined(level.weaponlootmapdata[var_3].attachextratoidmap[var_0])) {
    return level.weaponlootmapdata[var_3].attachextratoidmap[var_0];
  }

  return 0;
}

function weaponattachdefaulttoidmap(var_0, var_1) {
  if(isDefined(var_1)) {
    var_2 = var_0 + "|" + var_1;

    if(isDefined(level.weaponlootmapdata[var_2]) && isDefined(level.weaponlootmapdata[var_2].attachdefaulttoidmap)) {
      return level.weaponlootmapdata[var_2].attachdefaulttoidmap;
    }
  }

  if(isDefined(level.weaponmapdata[var_0]) && isDefined(level.weaponmapdata[var_0].attachdefaulttoidmap)) {
    return level.weaponmapdata[var_0].attachdefaulttoidmap;
  }

  return undefined;
}

function getweaponnvgattachment(var_0) {
  return "laserir";
}

function weaponattachcustomtoidmap(var_0, var_1) {
  if(isDefined(var_1) && var_1 >= 0) {
    var_2 = var_0 + "|" + var_1;

    if(isDefined(level.weaponlootmapdata[var_2]) && isDefined(level.weaponlootmapdata[var_2].attachcustomtoidmap)) {
      return level.weaponlootmapdata[var_2].attachcustomtoidmap;
    }
  }

  return undefined;
}

function buildweaponmap() {
  level.weaponmapdata = [];
  level.ref_14589 = [];
  var_0 = tablelookupgetnumrows("mp/statstable.csv");

  for(var_1 = 0; var_1 < var_0; var_1++) {
    var_2 = tablelookupbyrow("mp/statstable.csv", var_1, 0);
    var_3 = tablelookup("mp/statstable.csv", 0, var_2, 4);

    if(var_3 != "" && scripts\cp_mp\utility\weapon_utility::vehicle_ai_script_models(var_3)) {
      level.weaponmapdata[var_3] = spawnStruct();
      var_4 = tablelookup("mp/statstable.csv", 0, var_2, 0);

      if(var_4 != "") {
        level.weaponmapdata[var_3].number = var_4;
      }

      var_5 = tablelookup("mp/statstable.csv", 0, var_2, 1);

      if(var_5 != "") {
        level.weaponmapdata[var_3].group = var_5;
        var_6 = tablelookup("mp/statstable.csv", 0, var_2, 41);

        if(var_6 != "") {
          var_7 = int(var_6);

          if(var_7 > -1) {
            if(!isDefined(level.ref_14589[var_5])) {
              level.ref_14589[var_5] = [];
            }

            level.ref_14589[var_5][level.ref_14589[var_5].size] = var_3;
          } else {
            level.weaponmapdata[var_3].ref_13EFC = 1;
          }
        }
      }

      var_8 = tablelookup("mp/statstable.csv", 0, var_2, 5);

      if(var_8 != "") {
        level.weaponmapdata[var_3].assetname = var_8;
      }

      var_9 = tablelookup("mp/statstable.csv", 0, var_2, 44);

      if(var_9 != "") {
        level.weaponmapdata[var_3].perk = var_9;
      }

      var_10 = tablelookup("mp/statstable.csv", 0, var_2, 9);
      var_11 = parseattachdefaulttoidmap(var_10);

      if(isDefined(var_11)) {
        level.weaponmapdata[var_3].attachdefaulttoidmap = var_11;
      }

      var_12 = tablelookup("mp/statstable.csv", 0, var_2, 8);

      if(var_12 != "") {
        var_12 = float(var_12);
        level.weaponmapdata[var_3].speed = var_12;
      }
    }
  }

  level.weaponlootmapdata = [];
  var_1 = -1;

  for(;;) {
    var_1++;
    var_13 = tablelookupbyrow("loot/weapon_ids.csv", var_1, 0);

    if(var_13 == "") {
      break;
    }

    var_3 = tablelookupbyrow("loot/weapon_ids.csv", var_1, 1);

    if(!scripts\cp_mp\utility\weapon_utility::vehicle_ai_script_models(var_3)) {
      continue;
    }

    var_14 = tablelookupbyrow("loot/weapon_ids.csv", var_1, 6);
    var_15 = getweaponvarianttablename(var_3);
    var_16 = tablelookup(var_15, 1, var_14, 0);

    if(var_16 == "") {
      continue;
    }

    var_17 = var_3 + "|" + var_16;
    level.weaponlootmapdata[var_17] = spawnStruct();
    level.weaponlootmapdata[var_17].variantid = int(var_16);
    var_18 = tablelookup(var_15, 1, var_14, 3);

    if(var_18 != "") {
      level.weaponlootmapdata[var_17].assetoverridename = var_18;
    }

    var_19 = tablelookup("loot/weapon_ids.csv", 6, var_14, 5);
    level.weaponlootmapdata[var_17].update_focus_fire_objective = int(var_16) != 0 && int(var_19) == 99;
    var_20 = tablelookup(var_15, 1, var_14, 4);
    var_11 = parseattachdefaulttoidmap(var_20);

    if(isDefined(var_11)) {
      if(isDefined(level.weaponmapdata[var_3].attachdefaulttoidmap)) {
        var_11 = scripts\engine\utility::array_combine_unique_keys(var_11, level.weaponmapdata[var_3].attachdefaulttoidmap);
      }

      level.weaponlootmapdata[var_17].attachdefaulttoidmap = var_11;
    }

    var_21 = [];

    for(var_22 = 5; var_22 <= 15; var_22++) {
      var_23 = tablelookup(var_15, 1, var_14, var_22);

      if(var_23 != "") {
        var_24 = strtok(var_23, "|");

        if(var_24.size == 2) {
          var_21 = int(var_24[1]);
        } else {
          var_21 = 0;
        }
      }
    }

    if(var_21.size > 0) {
      level.weaponlootmapdata[var_17].attachcustomtoidmap = var_21;
    }

    var_25 = tablelookup(var_15, 1, var_14, 16);

    if(var_25 != "") {
      var_26 = [];
      var_27 = strtok(var_25, " ");

      foreach(var_29 in var_27) {
        var_30 = strtok(var_29, "|");

        if(var_30.size != 2) {
          continue;
        }

        var_26 = int(var_30[1]);
      }

      if(var_26.size > 0) {
        level.weaponlootmapdata[var_17].attachextratoidmap = var_26;
      }
    }
  }
}

function getweaponvarianttablename(var_0) {
  if(scripts\cp\utility::isstrstart(var_0, "iw8_")) {
    var_0 = getsubstr(var_0, 4);
  }

  return "mp/gunsmith/" + var_0 + "_variants.csv";
}

function parseattachdefaulttoidmap(var_0) {
  if(var_0 != "") {
    var_1 = strtok(var_0, " ");
    var_2 = [];

    foreach(var_4 in var_1) {
      var_5 = strtok(var_4, "|");

      if(getdvarint("scr_selectfire_enabled", 1) == 0) {
        if(scripts\engine\utility::string_starts_with(var_5[0], "select")) {
          continue;
        }
      }

      if(var_5.size == 2) {
        var_2 = int(var_5[1]);
        continue;
      }

      var_2 = 0;
    }

    return var_2;
  }

  return undefined;
}

function monitordisownedgrenade(var_0, var_1) {
  level endon("game_ended");
  var_1 endon("death");
  var_1 endon("mine_planted");
  var_0 scripts\engine\utility::ref_143A6("joined_team", "joined_spectators", "disconnect");

  if(isDefined(var_1)) {
    var_1 delete();
    return;
  }
}

function riotshield_getmodel() {
  return "weapon_wm_riotshield";
}

function setignoreriotshieldxp() {
  self.ignoreriotshieldxp = 1;
}

function clearignoreriotshieldxp() {
  self.ignoreriotshieldxp = undefined;
}

function ispickedupweapon(var_0) {
  if(iscacprimaryweapon(var_0) || iscacsecondaryweapon(var_0)) {
    var_1 = undefined;

    if(issameweapon(var_0)) {
      var_1 = createheadicon(var_0 getnoaltweapon());
    } else if(isstring(var_0)) {
      var_1 = var_0;

      if(issubstr(var_1, "alt_")) {
        var_1 = getsubstr(var_1, 4, var_0.size);
      }
    }

    var_2 = isDefined(self.pers["primaryWeapon"]) && self.pers["primaryWeapon"] == var_1;
    var_3 = isDefined(self.pers["secondaryWeapon"]) && self.pers["secondaryWeapon"] == var_1;

    if(!var_2 && !var_3) {
      return true;
    }
  }

  return false;
}

function isvehicleweapon(var_0) {
  var_1 = undefined;

  if(issameweapon(var_0)) {
    var_1 = var_0.basename;
  } else {
    var_1 = var_0;
  }

  switch (var_1) {
    case "bradley_tow_proj_mp":
    case "lighttank_mp":
    case "lighttank_tur_mp":
    case "hoopty_truck_mp":
    case "van_mp":
    case "cargo_truck_mg_mp":
    case "cargo_truck_mp":
    case "med_transport_mp":
    case "hoopty_mp":
    case "pickup_truck_mp":
    case "jeep_mp":
    case "big_bird_mp":
    case "cop_car_mp":
    case "tur_apc_rus_mp":
    case "apc_rus_mp":
    case "large_transport_mp":
    case "atv_mp":
    case "tac_rover_mp":
    case "little_bird_mg_mp":
    case "little_bird_mp":
    case "technical_mp":
      return 1;
    default:
      return 0;
  }
}

function attachmentsfilterforstats(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in var_0) {
    if(attachmentlogsstats(var_4, var_1)) {
      var_2 = var_4;
    }
  }

  return var_2;
}

function attachmentlogsstats(var_0, var_1) {
  if(scripts\cp\utility::attachmentiscosmetic(var_0)) {
    return false;
  }

  if(!carriedpunchcard(var_1, var_0)) {
    return false;
  }

  if(scripts\engine\utility::string_starts_with(var_0, "laststand_")) {
    return false;
  }

  return true;
}

function carriedpunchcard(var_0, var_1) {
  var_2 = scripts\cp\utility::getweaponrootname(var_0);
  var_3 = level.weaponattachments[var_2];
  return isDefined(var_3) && isDefined(var_3[var_1]);
}

function ref_12BBB(var_0) {
  switch (var_0) {
    case "laserbalanced":
    case "laserrange":
    case "laserads":
      var_0 = "laser";
      break;
    case "barsil2":
    case "silencer4":
    case "silencer3":
    case "silencer2":
    case "barsil":
      var_0 = "silencer";
      break;
    case "barcustnoguard":
    case "barcust2":
    case "barcust":
    case "barshortnoguard":
    case "barmid":
    case "barshort":
    case "barlong":
      var_0 = "barlong";
      break;
  }

  return var_0;
}

function mapweapon(var_0, var_1, var_2) {
  var_3 = var_0;

  if(!isDefined(var_0)) {
    var_3 = getcompleteweaponname("none");
  }

  var_4 = 0;

  if(var_3.basename != "none") {
    switch (var_3.basename) {
      case "pop_rocket_proj_mp":
        var_3 = getcompleteweaponname("pop_rocket_mp");
        break;
      case "tur_gun_mp":
      case "tur_gun_faridah_mp":
        var_3 = getcompleteweaponname("iw8_turret_50cal_mp");
        break;
      case "tur_bradley_mp":
      case "tur_gun_lighttank_mp":
        var_3 = getcompleteweaponname("lighttank_tur_mp");
        break;
      case "tur_gun_lighttank_ks_mp":
      case "tur_bradley_ks_mp":
        var_3 = getcompleteweaponname("lighttank_tur_ks_mp");
        break;
      case "ks_remote_drone_mp":
        var_3 = getcompleteweaponname("none");
        break;
    }
  } else if(isDefined(var_1)) {
    if(isDefined(var_1.objweapon)) {
      var_3 = getcompleteweaponname(var_1.objweapon.basename);
      var_4 = 1;
    } else if(isDefined(var_1.weapon_name)) {
      var_3 = getcompleteweaponname(var_1.weapon_name);
      var_4 = 1;
    }
  }

  if(var_4 && !istrue(var_2)) {
    var_3 = mapweapon(var_3, var_1, 1);
  }

  return var_3;
}