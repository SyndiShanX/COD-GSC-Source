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
  var0 = [getcompleteweaponname(level.sentrysettings["sentry_turret"].weaponinfo), getcompleteweaponname("tur_gun_decho_cp"), getcompleteweaponname("iw8_gunless_infil"), getcompleteweaponname("deploy_manual_turret_mp"), getcompleteweaponname("manual_turret_mp"), getcompleteweaponname("deploy_tactical_cover_mp"), getcompleteweaponname("tac_cover_mp"), getcompleteweaponname("ac130_25mm_mp"), getcompleteweaponname("ac130_40mm_mp"), getcompleteweaponname("ac130_105mm_mp"), getcompleteweaponname("iw8_ammo_marker_cp"), getcompleteweaponname("iw8_armor_marker_cp"), getcompleteweaponname("iw8_adrenaline_marker_cp"), getcompleteweaponname("iw8_health_marker_cp"), getcompleteweaponname("vip_carry_cp"), getcompleteweaponname("iw8_health_marker_cp"), getcompleteweaponname("deploy_sentry_mp"), getcompleteweaponname("ks_generic_mp"), getcompleteweaponname("ks_remote_gauntlet_mp"), getcompleteweaponname("ks_remote_map_cp"), getcompleteweaponname("ks_remote_device_mp"), getcompleteweaponname("ks_remote_target_mp"), getcompleteweaponname("ks_gesture_generic_mp"), getcompleteweaponname("deploy_dronepackage_mp"), getcompleteweaponname("deploy_warden_mp"), getcompleteweaponname("deploy_box_marker_mp"), getcompleteweaponname("ks_manual_turret_marker_mp"), getcompleteweaponname("ks_marker_mp"), getcompleteweaponname("deploy_pac_sentry_mp"), getcompleteweaponname("intel_put_usb_in_tablet"), getcompleteweaponname("intel_call_phone"), getcompleteweaponname("intel_take_photo"), getcompleteweaponname("intel_found_usb"), getcompleteweaponname("iw8_nukecore_mp"), getcompleteweaponname("tur_gun_lighttank_mp"), getcompleteweaponname("tur_gun_cargo_truck_mp"), getcompleteweaponname("tur_gun_little_bird_right_mp"), getcompleteweaponname("tur_gun_little_bird_left_mp"), getcompleteweaponname("intel_pickup_phone"), getcompleteweaponname("iw8_spotter_scope_mp"), getcompleteweaponname("iw8_la_mike32_mp"), getcompleteweaponname("iw8_green_beam_mp"), getcompleteweaponname("iw8_minigunksjugg_mp"), getcompleteweaponname("ks_remote_drone_mp"), getcompleteweaponname("iw8_gunless")];
  level.additional_laststand_weapon_exclusion = scripts\engine\utility::array_combine(level.additional_laststand_weapon_exclusion, var0);
}

function blank(var0) {}

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
  var0 = 70;
  level.claymoredetectiondot = cos(var0);
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
  var0 = spawnStruct();
  var0.mine_beacon["enemy"] = loadfx("vfx/core/equipment/light_c4_blink.vfx");
  var0.mine_beacon["friendly"] = loadfx("vfx/misc/light_mine_blink_friendly");
  level.weaponconfigs["c4_mp_p"] = var0;
  var0 = spawnStruct();
  var0.armingdelay = 1.5;
  var0.detectionradius = 232;
  var0.detectionheight = 512;
  var0.detectiongraceperiod = 1;
  var0.headiconoffset = 20;
  var0.killcamoffset = 12;
  level.weaponconfigs["proximity_explosive_mp"] = var0;
  var0 = spawnStruct();
  var1 = 800;
  var2 = 200;
  var0.radius_max_sq = var1 * var1;
  var0.radius_min_sq = var2 * var2;
  var0.onexplodesfx = "flash_grenade_expl_trans";
  var0.vfxradius = 72;
  level.weaponconfigs["flash_grenade_mp"] = var0;
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

function getweapongunsmithattachmenttable(var0) {
  var1 = undefined;

  if(issameweapon(var0)) {
    var1 = var0.basename;
  } else {
    var1 = var0;
  }

  var2 = scripts\cp\utility::getweaponrootname(var1);
  return "mp/gunsmith/" + getsubstr(var2, 4) + "_attachments.csv";
}

function getcompletenameforweapon(var0, var1, var2, var3, var4, var5, var6) {
  var7 = var0;
  var8 = strtok(var7, "_");
  var9 = 0;

  if(var8[0] == "alt") {
    var9++;
  }

  if(var8[var9] == "iw7") {
    return;
  }

  if(var8[var9] == "iw8") {
    var10 = var0;

    if(!isDefined(var1)) {
      var11 = ["none", "none", "none", "none", "none", "none"];
    } else {
      var11 = var2;
    }

    if(!isDefined(var3)) {
      var12 = "none";
    } else {
      var12 = var4;
    }

    if(!isDefined(var5)) {
      var13 = "none";
    } else {
      var13 = var6;
    }

    if(!isDefined(var7)) {
      var14 = -1;
    } else {
      var14 = var8;
    }

    if(!isDefined(var9)) {
      var15 = 0;
    } else {
      var15 = var10;
    }

    if(!isDefined(var11)) {
      var16 = "none";
    } else {
      var16 = var11;
    }

    return createheadicon(buildweapon(var13, var14, var14, var15, var15, 1, 1, var16, var16));
  }
}

function turret_monitoruse() {
  for(;;) {
    self waittill("trigger", var0);
    thread turret_playerthread(var0);
  }
}

function turret_playerthread(var0) {
  var0 endon("death");
  var0 endon("disconnect");
  var0 notify("weapon_change", isundefinedweapon());
  self waittill("turret_deactivate");
  var0 notify("weapon_change", var0 getcurrentweapon());
}

function onplayerconnect() {
  for(;;) {
    level waittill("connected", var0);
    var0.hits = 0;
    thread onplayerspawned();
    thread watchmissileusage();
    thread sniperdustwatcher();
    thread watchjavelinusage();
    thread updatelastweapon();
    thread watchchangeweapon();
    var0 thread scripts\cp\equipment\cp_stinger::watchlauncherusage();
  }
}

function watchjavelinusage() {
  scripts\cp\equipment\cp_javelin::javelinusageloop();
}

function watchchangeweapon() {
  self endon("disconnect");
  level endon("game_ended");

  for(;;) {
    var0 = self getcurrentweapon();

    if(isDefined(var0)) {
      dochangeweapon(var0);

      if(scripts\cp\utility::turn_off_sniper_laser()) {
        for(var1 = 0; var1 < self.primaryweapons.size; var1++) {
          var2 = self.primaryweapons[var1].basename;
          var3 = scripts\cp\utility::strip_suffix(var2, "_mp");

          if(var1 < 2) {
            self setplayerdata("cp", "waveSurvivalWeapon", var1, var3);
          }
        }
      }
    }

    self waittill("weapon_change");
  }
}

function dochangeweapon(var0) {
  updateweaponspeed(var0);
  updatelastweaponobj(var0);
  updatelauncherusage();
  ref_13fd2(var0);
  ref_12f87(var0);
  updateweaponperks();
  updatedefaultflinchreduction();
  scripts\mp\mp_agent_damage::updateweaponchangetime();
  riotshieldonweaponchange(var0);

  if(isDefined(self.suit) && self.suit == "iw8_suit_cp") {
    thread scripts\cp_mp\gestures::ref_13e1a();
    return;
  }
}

function ref_12f87(var0) {
  if(istrue(level.loadout_updateammo)) {
    return;
  }

  if(ref_132f2(var0)) {
    scripts\common\utility::allow_mount_top(0, "scriptedMountDisable");
    scripts\common\utility::allow_mount_side(0, "scriptedMountDisable");
    thread ref_12f88();
    return;
  }
}

function ref_12f88() {
  scripts\engine\utility::ref_143a5("death_or_disconnect", "weapon_change");
  scripts\common\utility::allow_mount_top(1, "scriptedMountDisable");
  scripts\common\utility::allow_mount_side(1, "scriptedMountDisable");
}

function ref_132f2(var0) {
  var1 = scripts\cp\utility::getweaponrootname(var0);

  if(var1 == "iw8_lm_sierrax" && var0 hasattachment("stocksaw_sierrax")) {
    return true;
  }

  return false;
}

function ref_13fd2(var0) {
  self notify("end_dragBreath");

  if(getweapongroup(var0) == "weapon_shotgun") {
    if(unlockables(var0)) {
      thread terminal_pusher_approach_array(var0);
      return;
    }

    return;
  }
}

function terminal_pusher_approach_array(var0) {
  var0.unlockableindex = 1;
  thread ref_138da(var0);
}

function ref_138da(var0) {
  self endon("disconnect");
  scripts\engine\utility::ref_143a5("end_dragBreath", "death");

  if(isDefined(var0)) {
    var0.unlockableindex = undefined;
    return;
  }
}

function unlockables(var0) {
  var1 = getweaponammopoolname(var0);
  return var1 == "WEAPON/AMMO_DB";
}

function updateweaponspeed(var0) {
  if(var0.basename == "none") {
    return;
  } else if(scripts\cp\utility::issuperweapon(var0.basename)) {
    scripts\cp\cp_loadout::updatemovespeedscale();
    return;
  } else if(scripts\cp\utility::iskillstreakweapon(var0.basename)) {
    return;
  } else if(var0.basename == "iw8_fists_mp_ls") {
    scripts\cp\cp_loadout::updatemovespeedscale();
    return;
  } else if(var0.inventorytype != "primary" && var0.inventorytype != "altmode") {
    return;
  }

  scripts\cp\cp_loadout::updatemovespeedscale();
}

function updatedefaultflinchreduction() {
  if(isagent(self)) {
    return;
  }

  var0 = undefined;
  var1 = ref_14584(self.currentweapon);

  if(var1 == 4) {
    var0 = 0.85;
  } else if(var1 == 3) {
    var0 = 0.2;
  } else if(var1 == 2) {
    var0 = 0.08;
  } else if(var1 == 1) {
    var0 = 0.25;
  } else {
    var0 = 0.05;
  }

  updateviewkickscale(var0);
}

function updateviewkickscale(var0) {
  if(isDefined(var0)) {
    self.viewkickscale = var0;
  }

  if(isDefined(self.overchargeviewkickscale)) {
    var0 = self.overchargeviewkickscale;
  } else if(isDefined(self.overrideviewkickscale)) {
    var0 = self.overrideviewkickscale;
    var1 = ref_14584(self getcurrentweapon());

    if(var1 == 1) {
      var0 = self.overrideviewkickscalepistol;
    } else if(var1 == 3) {
      var0 = self.ref_1218d;
    } else if(var1 == 2) {
      var0 = self.ref_1218e;
    } else if(var1 == 4) {
      var0 = self.overrideviewkickscalesniper;
    }
  } else if(isDefined(self.viewkickscale)) {
    var0 = self.viewkickscale;
  } else {
    var0 = 1;
  }

  var0 = clamp(var0, 0, 1);
  self setviewkickscale(var0);
}

function ref_14584(var0) {
  var1 = "none";
  var2 = -1;

  if(isDefined(var0) && !nullweapon(var0)) {
    var1 = weaponclass(var0);

    switch (var1) {
      case "pistol":
        var2 = 1;
        break;
      case "sniper":
        if(getweapongroup(var0) == "weapon_dmr") {
          if(var0.basename == "iw8_sn_kilo98_mp") {
            var2 = 2;
          } else {
            var2 = 3;
          }
        } else {
          var2 = 4;
        }

        break;
      default:
        var2 = 0;
        break;
    }
  }

  return var2;
}

function updateweaponperks() {
  self.prevweaponobj = doweaponperkupdate(self.prevweaponobj);
}

function doweaponperkupdate(var0) {
  var1 = self getcurrentweapon();
  weaponattachmentperkupdate(var1, var0);
  weaponperkupdate(var1, var0);
  return var1;
}

function weaponperkupdate(var0, var1) {
  if(!getqueuedspleveltransients(var1)) {
    var2 = scripts\cp\utility::getweaponrootname(var1.basename);
    var3 = weaponperkmap(var2);

    if(isDefined(var3)) {
      scripts\cp\perks\cp_perks::removeperk(var3);
    }
  }

  if(!getqueuedspleveltransients(var0)) {
    var4 = scripts\cp\utility::getweaponrootname(var0.basename);
    var5 = weaponperkmap(var4);

    if(isDefined(var5)) {
      scripts\cp\utility::giveperk(var5);
      return;
    }

    return;
  }
}

function weaponperkmap(var0) {
  if(isDefined(level.weaponmapdata[var0]) && isDefined(level.weaponmapdata[var0].perk)) {
    return level.weaponmapdata[var0].perk;
  }

  return undefined;
}

function weaponattachmentperkupdate(var0, var1) {
  var2 = undefined;
  var3 = undefined;

  if(!getqueuedspleveltransients(var1)) {
    var3 = getweaponattachments(var1);

    if(isDefined(var3) && var3.size > 0) {
      foreach(var5 in var3) {
        var6 = attachmentperkmap(var5);

        if(!isDefined(var6)) {
          continue;
        }

        scripts\cp\perks\cp_perks::removeperk(var6);
      }
    }
  }

  if(!getqueuedspleveltransients(var0)) {
    var2 = getweaponattachments(var0);

    if(isDefined(var2) && var2.size > 0) {
      foreach(var9 in var2) {
        var6 = attachmentperkmap(var9);

        if(!isDefined(var6)) {
          continue;
        }

        scripts\cp\utility::giveperk(var6);
      }

      return;
    }

    return;
  }
}

function attachmentperkmap(var0) {
  if(isDefined(level.attachmentmap_attachtoperk[var0])) {
    return level.attachmentmap_attachtoperk[var0];
  }

  return undefined;
}

function updatelastweaponobj(var0) {
  self.lastweaponobj = var0;

  if(isnormallastweapon(var0)) {
    self.lastnormalweaponobj = var0;
  }

  if(isdroppableweapon(var0)) {
    self.lastdroppableweaponobj = var0;
  }

  if(iscacprimaryorsecondary(var0)) {
    self.lastcacweaponobj = var0;
    return;
  }
}

function ref_13c57() {
  for(;;) {
    self waittill("grenade_pullback", var0);

    if(!nullweapon(var0) && var0.basename == "c4_mp_p" && scripts\cp\utility::isriotshield(self getcurrentweapon())) {
      self.ref_1207e = 1;
    }
  }
}

function ref_13c5d() {
  if(!istrue(self.ref_1207e)) {
    var0 = self getheldoffhand();

    if(!nullweapon(var0) && var0.basename != "c4_mp_p" && scripts\cp\utility::isriotshield(self getcurrentweapon()) && scripts\cp\utility::valuehud(var0)) {
      self.ref_1207e = 1;
      return;
    }

    return;
  }
}

function ref_13c58(var0) {
  self notify("trackRiotShield_monitorShieldAttach");
  self endon("trackRiotShield_monitorShieldAttach");
  self endon("death_or_disconnect");
  self endon("faux_spawn");
  self endon("riotshield_detach");
  GscBinSkip4(0x35);
}

function ref_13c5a() {
  var0 = isDefined(self.riotshieldmodel);
  var1 = isDefined(self.riotshieldmodelstowed);

  if(!var1) {
    if(var0) {
      scripts\cp\utility::riotshield_move(1);
      return;
    }

    scripts\cp\utility::riotshield_attach(0, riotshield_getmodel());
    return;
  }
}

function ref_13c59() {
  var0 = isDefined(self.riotshieldmodel);
  var1 = isDefined(self.riotshieldmodelstowed);

  if(!var0) {
    if(var1) {
      scripts\cp\utility::riotshield_move(0);
      return;
    }

    scripts\cp\utility::riotshield_attach(1, riotshield_getmodel());
    return;
  }
}

function ref_13c5b() {
  var0 = isDefined(self.riotshieldmodel);
  var1 = isDefined(self.riotshieldmodelstowed);

  if(var0) {
    scripts\cp\utility::riotshield_detach(1);
  }

  if(var1) {
    scripts\cp\utility::riotshield_detach(0);
    return;
  }
}

function ref_13c5c() {
  if(scripts\cp\utility::riotshield_hasweapon()) {
    var0 = scripts\cp\utility::isriotshield(self getcurrentweapon());

    if(var0) {
      ref_13c59();
      return;
    }

    ref_13c5a();
    return;
  }

  var1 = isDefined(self.riotshieldmodel);
  var2 = isDefined(self.riotshieldmodelstowed);

  if(var1) {
    scripts\cp\utility::riotshield_detach(1);
  }

  if(var2) {
    scripts\cp\utility::riotshield_detach(0);
    return;
  }
}

function riotshieldonweaponchange(var0) {
  if(scripts\cp\utility::riotshield_hasweapon()) {
    thread ref_13c58();
    return;
  }

  ref_13c5c();
  ref_12d4e();
  self notify("riotshield_detach");
}

function ref_12d4e(var0) {
  self.watch_for_heli_bosses_dead = undefined;
  self.watch_for_heli_death = undefined;
  self.ref_1443a = undefined;

  if(istrue(var0)) {
    self.hasriotshield = undefined;
    self.hasriotshieldequipped = undefined;
    self.riotshieldmodel = undefined;
    self.riotshieldmodelstowed = undefined;
    return;
  }
}

function get_enemies_in_range(var0, var1, var2, var3) {
  var4 = cos(var3);
  var5 = var1 * var1;
  var6 = [];

  foreach(var8 in level.spawned_enemies) {
    if(distancesquared(var0, var8.origin) < var5) {
      if(scripts\engine\utility::within_fov(var0, var2.angles, var8.origin, var4)) {
        var6 = var8;
      }
    }
  }

  return var6;
}

function sniperdustwatcher() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");

  for(var0 = undefined;; var0 = gettime()) {
    self waittill("weapon_fired");

    if(self getstance() != "prone") {
      continue;
    }

    var1 = self getcurrentweapon();

    if(var1.classname != "weapon_sniper") {
      continue;
    }

    var2 = anglesToForward(self.angles);

    if(!isDefined(var0) || gettime() - var0 > 2000) {}
  }
}

function unset_scriptable_part_state_after_time(var0, var1) {
  self endon("death");
  wait var0;
  self setscriptablepartstate("projectile", "inactive");
  var1 notify("ranged_katana_missile_done");

  if(isDefined(self)) {
    self delete();
    return;
  }
}

function watchmissileusage() {
  self endon("disconnect");
  thread listen_for_custom_proj_dvar();

  for(;;) {
    var0 = waittill_missile_fire();
    var1 = undefined;

    switch (var0.weapon_name) {
      case "iw8_la_gromeo_mp":
      case "iw8_la_gromeoks_mp":
        var1 = self.missilelaunchertarget;
        break;
      case "iw8_la_juliet_mp":
        var1 = self.javelin.target;
        break;
      case "iw8_la_mike32_mp":
        thread launch_custom_gl_projectile(var0);
        break;
      case "remotemissile_projectile_mp":
        thread grenade_earthquake();
        break;
      case "glsmoke":
        thread smokegrenadeused(var0);
        break;
      case "glconc":
        thread watchconcussiongrenadeexplode();
        break;
      case "glflash":
        break;
      case "glincendiary":
        thread scripts\cp\equipment\cp_thermite::thermite_used(var0, 1);
        break;
      case "glsnap":
        thread scripts\cp\equipment\cp_snapshot_grenade::snapshot_grenade_used(var0, 1);
        break;
      default:
        break;
    }

    if(scripts\cp_mp\utility\weapon_utility::islockonlauncher(var0.weapon_name) && isDefined(var1)) {
      var0.ref_119a0 = var1;
      level notify("stinger_fired", self, var0, var1);
      thread scripts\cp_mp\utility\weapon_utility::watchtargetlockedontobyprojectile(var1, var0);
    }

    if(isPlayer(self) && isDefined(var0)) {
      var0.adsfire = scripts\cp\utility::isplayerads();
    }
  }
}

function issmallmissile(var0) {
  return false;
}

function isexplosivemissile(var0) {
  var1 = getweaponbasename(var0);

  switch (var1) {
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
    var0 = getDvar("scr_gl_proj", "none");

    if(var0 != "none") {
      self.gl_proj_override = var0;
    }

    wait 0.1;
  }
}

function launch_custom_gl_projectile(var0) {
  var1 = get_custom_gl_projectile(var0);

  if(isDefined(var1)) {
    self delete();

    if(isDefined(level.custom_proj_func[var1])) {
      level thread[[level.custom_proj_func[var1]]](var0);
      return;
    }

    return;
  }
}

function get_custom_gl_projectile(var0) {
  if(isDefined(var0.gl_proj_override)) {
    return var0.gl_proj_override;
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

function create_new_projectile(var0, var1) {
  var2 = anglesToForward(var1 getplayerangles());
  var2 *= 2000;

  if(var1 tagexists("tag_flash")) {
    var3 = var1 gettagorigin("tag_flash");
  } else {
    var3 = var2 getEye();
  }

  var4 = var2 launchgrenade(var1, var3, var3);
  var4.owner = var2;
  return var4;
}

function launchthermite(var0) {
  var1 = create_new_projectile("thermite_proj_cp", var0);
  var0 thread scripts\cp\equipment\cp_thermite::thermite_used(var1);
}

function launchmolotov(var0) {
  var1 = create_new_projectile("molotov_mp", var0);
  var0 thread scripts\cp\powers\coop_molotov::molotov_used(var1);
  self delete();
}

function launchstickytimedgrenade(var0) {
  var1 = create_new_projectile("semtex_mp", var0);
  thread semtexused(var0);
  self delete();
}

function launchc4grenade(var0) {
  var1 = create_new_projectile("c4_mp_p", var0);
  var0 thread scripts\cp\cp_c4::c4_used(var1);
  self delete();
}

function launchexplosivetiplogic(var0) {
  self waittill("explode", var1, var2, var3, var4);
  var0 endon("disconnect");
  var0 endon("joined_team");
  var0 endon("joined_spectators");
  var5 = spawn("script_model", var1);
  var5 setModel("offhand_wm_grenade_thermite");
  var5 setscriptablepartstate("effects", "impact", 0);
  var5.trigger = spawn("trigger_radius", var5.origin, 0, 125, 72);
  thread watch_for_thermite_triggered(var5.trigger);
  wait 0.5;
  var6 = 1;

  while(var6 <= 10) {
    var7 = var6 + 1;
    var6 = var7;
    wait 0.5;
  }

  thread bolt_destroy();
}

function wait_for_crate_drop_to_ground(var0) {
  var1 = scripts\engine\utility::drop_to_ground(var0.origin + (0, 0, -100), 0, -5000);
  var2 = 900;
  var3 = 1000;
  var4 = 0;

  for(;;) {
    if(distancesquared(var0.origin, var1) <= var2) {
      return var1;
    }

    if(var4 >= var3) {
      return var1;
    }

    var4 += 50;
    waitframe();
  }
}

function watch_for_thermite_triggered(var0) {
  self endon("end_thermite_trigger");
  self endon("death");

  for(;;) {
    self waittill("trigger", var1);

    if(isPlayer(var1)) {
      continue;
    }

    if(!var1 scripts\cp\utility::is_soldier_agent()) {
      continue;
    }

    if(isalive(var1) && !istrue(var1.marked_for_death)) {
      var1.marked_for_death = 1;
      thread watch_for_victim_death(var1);
      var1 thread scripts\cp\utility::damage_over_time(var1, var0, 2.5, 100, "MOD_EXPLOSIVE");
    }
  }
}

function watch_for_victim_death(var0) {
  self endon("death");
  var0 waittill("death");
  var0.marked_for_death = undefined;
  playFX(level._effect["vfx_thermite_end"], var0.origin);
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

function waitfortriggernotify(var0) {
  self endon("death");

  for(;;) {
    self waittill("trigger", var1);

    if(isPlayer(var1)) {
      continue;
    }

    if(!var1 scripts\cp\utility::is_soldier_agent()) {
      continue;
    }

    if(isalive(var1) && !istrue(var1.marked_for_death)) {
      var1.marked_for_death = 1;
      var1 thread scripts\cp\utility::damage_over_time(var1, var0, 5, 100, "MOD_EXPLOSIVE");
    }
  }
}

function launchconcertinabomb(var0) {
  self waittill("missile_stuck", var1, var2);
  var3 = spawn("trigger_radius", self.origin, 0, 500, 72);
  thread waitfortriggernotify(var3);
  wait 6;
  var3 delete();
}

function removelinkafterdelay(var0, var1) {
  wait var1;

  if(scripts\engine\utility::array_contains(level.strrazorlinks, var0)) {
    level.strrazorlinks = scripts\engine\utility::array_remove(level.strrazorlinks, var0);
    return;
  }
}

function lockonlaunchers_gettargetarray(var0) {
  var1 = [];
  var2 = 0;
  var3 = lockonlaunchers_gettargetvehiclerefs();

  if(level.teambased) {
    if(isDefined(var0) && var0 == 1) {
      foreach(var5 in level.characters) {
        if(isDefined(var5) && isalive(var5) && (var5.team != self.team || var2)) {
          var1 = var5;
        }
      }
    }

    if(isDefined(level.activekillstreaks)) {
      foreach(var8 in level.activekillstreaks) {
        if(isDefined(var8.affectedbylockon) && (var8.team != self.team || var2)) {
          var1 = var8;
        }
      }
    }

    if(isDefined(level.special_lockon_target_list)) {
      foreach(var11 in level.special_lockon_target_list) {
        var1 = var11;
      }
    }

    jumpiffalse(isDefined(level.cratedropdata)) LOC_0000015d;
    jumpiffalse(isDefined(level.cratedropdata.ac130s)) LOC_0000015d;

    foreach(var14 in level.cratedropdata.ac130s) {
      if(var14.team != self.team || var2) {
        var1 = var14;
      }
    }

    foreach(var17 in var3) {
      var18 = scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_getgameinstances(var17);

      foreach(var20 in var18) {
        if(!scripts\cp_mp\vehicles\vehicle::ref_141b9(var20, self) || var2) {
          var1 = var20;
        }
      }
    }
  } else {
    if(isDefined(var3) && var3 == 1) {
      foreach(var5 in level.characters) {
        if((!isDefined(var5) || !isalive(var5)) && !var18) {
          continue;
        }

        var17 = var5;
      }
    }

    if(isDefined(level.activekillstreaks)) {
      foreach(var8 in level.activekillstreaks) {
        if(isDefined(var8.affectedbylockon) && (isDefined(var8.owner) && var8.owner != self || var18)) {
          var17 = var8;
        }
      }
    }

    jumpiffalse(isDefined(level.cratedropdata)) LOC_000002d9;
    jumpiffalse(isDefined(level.cratedropdata.ac130s)) LOC_000002d9;

    foreach(var14 in level.cratedropdata.ac130s) {
      if(var14.owner != self || var18) {
        var17 = var14;
      }
    }

    foreach(var17 in var20) {
      var18 = scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_getgameinstances(var17);

      foreach(var20 in var18) {
        if(!isDefined(var20.owner)) {
          var17 = var20;
          continue;
        }

        if(var20.owner != self || var18) {
          var17 = var20;
        }
      }
    }
  }

  foreach(var34 in var17) {
    if(!isvector(var34.origin)) {
      var17 = scripts\engine\utility::array_remove(var17, var34);
    }
  }

  return var17;
}

function lockonlaunchers_gettargetvehiclerefs() {
  return ["apc_russian", "atv", "big_bird", "cargo_truck", "cargo_truck_mg", "cop_car", "hoopty", "hoopty_truck", "jeep", "large_transport", "light_tank", "little_bird", "little_bird_mg", "medium_transport", "pickup_truck", "tac_rover", "technical", "van"];
}

function add_to_special_lockon_target_list(var0) {
  if(!isDefined(level.special_lockon_target_list)) {
    level.special_lockon_target_list = [];
  }

  if(!scripts\engine\utility::array_contains(level.special_lockon_target_list, var0)) {
    level.special_lockon_target_list = scripts\engine\utility::array_add(level.special_lockon_target_list, var0);
    return;
  }
}

function remove_from_special_lockon_target_list(var0) {
  if(!isDefined(level.special_lockon_target_list)) {
    level.special_lockon_target_list = [];
  }

  if(scripts\engine\utility::array_contains(level.special_lockon_target_list, var0)) {
    level.special_lockon_target_list = scripts\engine\utility::array_remove(level.special_lockon_target_list, var0);
    return;
  }
}

function getrandomdirection(var0, var1) {
  var2 = anglestoup(var1);
  var3 = anglestoright(var1);
  var4 = anglesToForward(var1);
  var5 = randomint(360);
  var6 = randomint(360);
  var7 = cos(var6) * sin(var5);
  var8 = sin(var6) * sin(var5);
  var9 = cos(var5);
  var10 = (var7 * var3 + var8 * var4 + var9 * var2) / 0.33;
  return -1 * var10;
}

function waittill_missile_fire() {
  self waittill("missile_fire", var0, var1);

  if(isDefined(var0)) {
    if(!isDefined(var0.weapon_name)) {
      if(var1.isalternate) {
        var2 = scripts\cp\utility::attachmentmap_tobase(var1.underbarrel);

        switch (var2) {
          case "glconc":
            var0.weapon_name = "glconc";
            break;
          case "glflash":
            var0.weapon_name = "glflash";
            break;
          case "glincendiary":
            var0.weapon_name = "glincendiary";
            break;
          case "glsnap":
            var0.weapon_name = "glsnap";
            break;
          case "glsmoke":
            var0.weapon_name = "glsmoke";
            break;
          case "gl":
          default:
            var0.weapon_name = "gl";
            break;
        }
      } else {
        var0.weapon_name = var1.basename;
      }
    }

    if(!isDefined(var0.owner)) {
      var0.owner = self;
    }

    if(!isDefined(var0.team)) {
      var0.team = self.team;
    }
  }

  return var0;
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

    ref_12d4e(1);
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
  var0 = self getcurrentweapon();

  switch (var0.basename) {
    case "iw8_la_gromeo_mp":
      thread scripts\cp\agents\gametype_cp_specops::missilelauncherusageloop();
      break;
    case "iw8_la_juliet_mp":
      thread scripts\cp\equipment\cp_javelin::javelinusageloop();
      break;
  }
}

function updatelauncherusage() {
  var0 = self getcurrentweapon();
  var1 = scripts\cp\utility::getweaponrootname(var0.basename);

  switch (var1) {
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
    var2 = weaponclass(var0.basename) == "rocketlauncher";

    if(var2 && !istrue(self.fastreloadlaunchers)) {
      scripts\cp\utility::giveperk("specialty_fastreload");
      self.fastreloadlaunchers = 1;
    } else if(istrue(self.fastreloadlaunchers)) {
      scripts\cp\utility::_unsetperk("specialty_fastreload");
      self.fastreloadlaunchers = undefined;
    }
  }

  switch (var1) {
    default:
      break;
    case "iw8_sn_crossbow":
      thread scripts\cp\vehicles\vehicle_damage_cp::initarmor(var0);
      break;
    case "iw8_la_gromeo":
      thread scripts\cp\agents\gametype_cp_specops::missilelauncherusageloop();
      break;
    case "iw8_la_juliet":
      thread scripts\cp\equipment\cp_javelin::javelinusageloop();
      break;
    case "iw8_sn_xmike109":
      thread scripts\cp_mp\utility\omnvar_utility::ref_1403e(var0);
      break;
    case "iw8_sh_aalpha12":
      thread scripts\cp\utility\cp_safehouse_util::ref_1403e(var0);
      break;
  }
}

function watchforweapondropped() {
  self endon("disconnect");
  self notify("watchForWeaponDropped");
  self endon("watchForWeaponDropped");

  for(;;) {
    self waittill("weapon_dropped", var0, var1);

    if(isDefined(var0) && isDefined(var1)) {
      self.storedweapons[var1.basename] = undefined;
    }
  }
}

function monitorlauncherspawnedgrenades() {
  self endon("disconnect");
  self endon("death");
  self endon("faux_spawn");

  for(;;) {
    var0 = waittill_grenade_fire();

    if(isDefined(var0.weapon_name)) {
      if(glprox_trygetweaponname(var0.weapon_name) == "stickglprox") {
        semtexused(var0);
      }

      switch (var0.weapon_name) {
        case "thermite_proj_cp":
        case "thermite_mp":
          thread scripts\cp\equipment\cp_thermite::thermite_used(var0);
          break;
        case "throwingknife_drill_mp":
        case "throwingknife_electric_mp":
        case "throwingknife_fire_mp":
        case "throwingknife_mp":
          scripts\cp_mp\equipment\throwing_knife::throwing_knife_used(var0);
          break;
      }
    }
  }
}

function glprox_trygetweaponname(var0) {
  if(issameweapon(var0) && nullweapon(var0)) {
    return var0;
  }

  if(isstring(var0) && var0 == "none") {
    return var0;
  }

  if(getweaponbasename(var0) == "iw7_glprox_mp") {
    if(isstring(var0) && scripts\cp\utility::isaltmodeweapon(var0) || issameweapon(var0) && var0.isalternate) {
      var1 = getweaponattachments(var0);
      var0 = var1[0];
    } else {
      var0 = getweaponbasename(var0);
    }
  }

  return var0;
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
    scripts\engine\utility::ref_143a6("adjustedStance", "sprint_begin", "weapon_change");
    wait 0.5;

    if(isDefined(self.onhelisniper) && self.onhelisniper) {
      continue;
    }

    var0 = self getstance();
    stancerecoilupdate(var0);
  }
}

function stancerecoilupdate(var0) {
  var1 = self getcurrentprimaryweapon();
  var2 = 0;

  if(isrecoilreducingweapon(var1)) {
    var2 = getrecoilreductionvalue();
  }

  if(var0 == "prone") {
    var3 = var1.classname;

    if(isDefined(var3)) {
      if(var3 == "weapon_lmg") {
        setrecoilscale(0, 40);
        return;
      }

      if(var3 == "weapon_sniper") {
        if(var1 hasattachment("barrelbored", 1)) {
          setrecoilscale(0, 20 + var2);
          return;
        }

        setrecoilscale(0, 40 + var2);
        return;
      }

      return;
    }

    setrecoilscale();
    return;
  }

  if(var0 == "crouch") {
    var3 = var1.classname;

    if(isDefined(var3)) {
      if(var3 == "weapon_lmg") {
        setrecoilscale(0, 10);
        return;
      }

      if(var3 == "weapon_sniper") {
        if(var1 hasattachment("barrelbored", 1)) {
          setrecoilscale(0, 10 + var2);
          return;
        }

        setrecoilscale(0, 20 + var2);
        return;
      }

      return;
    }

    setrecoilscale();
    return;
  }

  if(var2 > 0) {
    setrecoilscale(0, var2);
    return;
  }

  setrecoilscale();
}

function setrecoilscale(var0, var1) {
  if(!isDefined(var0)) {
    var0 = 0;
  }

  if(!isDefined(self.recoilscale)) {
    self.recoilscale = var0;
  } else {
    self.recoilscale += var0;
  }

  if(isDefined(var1)) {
    if(isDefined(self.recoilscale) && var1 < self.recoilscale) {
      var1 = self.recoilscale;
    }

    var2 = 100 - var1;
  } else {
    var2 = 100 - self.recoilscale;
  }

  if(var2 < 0) {
    var2 = 0;
  }

  if(var2 > 100) {
    var2 = 100;
  }

  if(var2 == 100) {
    self player_recoilscaleoff();
    return;
  }

  self player_recoilscaleon(var2);
}

function isrecoilreducingweapon(var0) {
  if(nullweapon(var0)) {
    return 0;
  }

  var1 = 0;

  if(var0 hasattachment("kbsscope", 1) || var0 hasattachment("m8scope_zm", 1) || var0 hasattachment("cheytacscope", 1)) {
    var1 = 1;
  }

  return var1;
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
    self waittill("weapon_change", var0);

    if(nullweapon(var0)) {
      continue;
    }

    if(isvalidweapon(var0)) {
      self.last_valid_weapon = var0;
    }

    if(!isDefined(self.storedweapons)) {
      self.storedweapons = [];
    }

    if(!isDefined(self.storedweapons[var0.basename])) {
      self.storedweapons[var0.basename] = createheadicon(var0);
    }

    thread updatelauncherusage();

    if(scripts\cp\utility::iskillstreakweapon(var0)) {
      continue;
    }

    if(is_launcher(var0) && !is_killstreak_weapon(var0)) {
      if(self.class == "tank") {
        var0 = add_launcher_xmags(var0);
      } else {
        var0 = ref_12bda(var0);
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

function minigamefinishcount(var0) {
  var0 notify("dropping_minigun");
  var1 = ["iw8_minigunksjugg_mp", "iw8_lm_dblmg_mp"];
  var2 = "iw8_lm_dblmg_mp";

  foreach(var4 in var1) {
    if(var0 hasweapon(var4)) {
      var2 = var4;
    }
  }

  var6 = getcompleteweaponname(var2);
  var7 = var0 dropitem(var6);
  thread watchweaponpickup();
}

function ref_1447d(var0, var1) {
  var0 endon("death");
  var0 endon("disconnect");
  var0 endon("faux_spawn");
  var0 endon("dropping_minigun");
  var0 notify("watchMinigunAmmo");
  var0 endon("watchMinigunAmmo");

  for(;;) {
    var2 = var0 getweaponammoclip(var1);

    if(var2 <= 0) {
      var0 takeweapon(var1);
      return;
    }

    waitframe();
  }
}

function ref_12349(var0) {
  if(var0.basename == "iw8_lm_dblmg_mp") {
    return true;
  }

  if(var0.basename == "iw8_minigunksjugg_mp") {
    return true;
  }

  return false;
}

function ref_139cf(var0, var1) {
  if(var1.basename == "iw8_lm_dblmg_mp") {
    return 0;
  }

  if(var1.basename == "iw8_minigunksjugg_mp") {
    return 0;
  }

  return ref_124ad(var0);
}

function ref_124ad(var0) {
  var1 = ["iw8_minigunksjugg_mp", "iw8_lm_dblmg_mp"];

  foreach(var3 in var1) {
    if(var0 hasweapon(var3)) {
      return true;
    }
  }

  return false;
}

function is_launcher(var0) {
  var1 = weaponclass(var0);

  if(var1 == "rocketlauncher") {
    return true;
  }

  switch (var0.basename) {
    case "iw8_la_rpapa7_mp":
    case "iw8_la_kgolf_mp":
    case "iw8_la_juliet_mp":
    case "iw8_la_gromeo_mp":
      return true;
  }

  return false;
}

function is_killstreak_weapon(var0) {
  switch (var0.basename) {
    case "ac130_25mm_cp":
    case "ac130_40mm_cp":
      return 1;
    default:
      return 0;
  }
}

function add_launcher_xmags(var0) {
  var1 = "xmags_cp_gromeo";

  switch (var0.basename) {
    case "iw8_la_gromeo_mp":
      var1 = "xmags_cp_gromeo";
      break;
    case "iw8_la_juliet_mp":
      var1 = "xmags_cp_juliet";
      break;
    case "iw8_la_kgolf_mp":
      var1 = "xmags_cp_kgolf";
      break;
    case "iw8_la_rpapa7_mp":
      var1 = "xmags_cp_rpapa7";
      break;
    default:
      break;
  }

  if(!var0 hasattachment(var1)) {
    var0 = addattachmenttoweapon(var0, var1, 1);
  }

  return var0;
}

function ref_12bda(var0) {
  var1 = "xmags_cp_gromeo";

  switch (var0.basename) {
    case "iw8_la_gromeo_mp":
      var1 = "xmags_cp_gromeo";
      break;
    case "iw8_la_juliet_mp":
      var1 = "xmags_cp_juliet";
      break;
    case "iw8_la_kgolf_mp":
      var1 = "xmags_cp_kgolf";
      break;
    case "iw8_la_rpapa7_mp":
      var1 = "xmags_cp_rpapa7";
      break;
    default:
      break;
  }

  if(var0 hasattachment(var1)) {
    remove_attachment(var1, self, var0);
  }

  return var0;
}

function isfistweapon(var0) {
  var0 = scripts\cp\utility::getweaponrootname(var0);
  return var0 == "iw8_fists";
}

function isvalidweapon(var0) {
  var1 = level.additional_laststand_weapon_exclusion;
  var2 = undefined;

  if(issameweapon(var0)) {
    var2 = var0;
  } else {
    var2 = asmdevgetallstates(var0);
  }

  if(nullweapon(var2)) {
    return 0;
  }

  if(isDefined(var1) && scripts\engine\utility::array_contains(var1, var2)) {
    return 0;
  }

  if(scripts\cp\utility::is_melee_weapon(var2, 1)) {
    return 0;
  }

  return 1;
}

function updatesavedlastweapon() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  var0 = self.currentweaponatspawn;

  if(isDefined(self.saved_lastweaponhack)) {
    var0 = self.saved_lastweaponhack;
  }

  self.saved_lastweapon = var0;

  for(;;) {
    self waittill("weapon_change", var1);

    if(nullweapon(var1)) {
      self.saved_lastweapon = var0;
      continue;
    }

    var2 = weaponinventorytype(var1);
    self[[level.move_speed_scale]]();
    self.saved_lastweapon = var0;

    if(isdroppableweapon(self.saved_lastweapon)) {
      self.lastdroppableweaponobj = self.saved_lastweapon;
    }

    var0 = var1;
  }
}

function bomber_spawn_origin_array_init() {
  self endon("death");

  for(;;) {
    self waittill("grenade_fire", var0, var1);
    var0.owner = self;

    switch (var1.basename) {
      case "molotov_mp":
        level thread scripts\cp\powers\coop_molotov::bomber_shouldusetraversals(self, var0);
        break;
      case "gas_mp":
        thread scripts\cp\equipment\cp_gas_grenade::gas_used(var0);
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
    self waittill("grenade_pullback", var0);
    var1 = self getthrowbackweapon();

    if(!nullweapon(var1)) {
      continue;
    }

    var2 = var0.basename;
    thread watchoffhandcancel();
    self.throwinggrenade = var2;

    if(var2 == "c4_mp_p") {
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
  scripts\engine\utility::ref_143a6("grenade_fire", "weapon_change", "offhand_end");
  self.changingweapon = undefined;
}

function dudgrenadeused(var0) {
  var0 endon("disconnect");
  thread ownerdisconnectcleanup(var0);
  thread scripts\cp\utility::notifyafterframeend("death", "end_explode");
  self endon("end_explode");
  self waittill("explode", var1);
  self delete();
}

function begingrenadetracking() {
  self endon("offhand_end");
  var0 = gettime();
  var1 = waittill_grenade_fire();

  if(!isDefined(var1)) {
    return;
  }

  if(!isDefined(var1.weapon_name)) {
    return;
  }

  self.changingweapon = undefined;

  switch (var1.weapon_name) {
    case "snapshot_grenade_mp":
      thread scripts\cp\equipment\cp_snapshot_grenade::snapshot_grenade_used(var1);
      break;
    case "iw8_molotov_zm":
    case "molotov_mp":
      thread scripts\cp\powers\coop_molotov::molotov_used(var1);
      self.waittill_any_timeout_no_endon_death_4 = gettime();
      break;
    case "iw8_health_marker_cp":
    case "iw8_adrenaline_marker_cp":
    case "iw8_armor_marker_cp":
    case "iw8_ammo_marker_cp":
      scripts\cp\crafting_system::throwcrate(var1);
      break;
    case "dud_grenade_zm":
      thread dudgrenadeused(var1);
      thread grenade_earthquake();
      break;
    case "thermobaric_grenade_mp":
    case "frag_grenade_zm":
    case "frag_grenade_mp":
      if(gettime() - var0 > 1000) {
        var1.iscooked = 1;
      }

      thread ref_144d9();
      var1.originalowner = self;
      break;
    case "cluster_grenade_zm":
      var1.clusterticks = var1.ticks;

      if(var1.ticks >= 1) {
        var1.iscooked = 1;
      }

      var1.originalowner = self;
      thread clustergrenadeused();
      thread grenade_earthquake();
      break;
    case "zfreeze_semtex_mp":
    case "semtex_mp":
    case "semtex_zm":
      thread semtexused(var1);
      break;
    case "gas_mp":
      thread scripts\cp\equipment\cp_gas_grenade::gas_used(var1);
      break;
    case "hb_sensor_mp":
      thread scripts\mp\equipment\hb_sensor::hb_sensor_used(var1);
      break;
    case "c4_mp_p":
      thread scripts\cp\cp_c4::c4_used(var1);
      break;
    case "claymore_mp":
      thread scripts\cp\cp_claymore::claymore_use(var1);
      break;
    case "at_mine_mp":
      thread scripts\cp\equipment\cp_at_mine::at_mine_use(var1);
      break;
    case "trophy_mp":
      thread scripts\cp\equipment\cp_trophy_system::trophy_used(var1);
      break;
    case "flare_mp":
      thread scripts\cp\crafting_system::ref_12c8b(var1);
      break;
    case "concussion_grenade_mp":
      thread watchconcussiongrenadeexplode();
      break;
    case "bouncing_betty_mp":
      thread mineused(var1, &spawnmine);
      break;
    case "throwingknifec4_mp":
    case "throwingknifejugg_mp":
    case "throwingknife_mp":
      thread throwingknifeused(level, self, var1);
      break;
    case "zom_repulsor_mp":
      var1 delete();
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
      var1.ninebangticks = var1.ticks;
      thread ref_144a9();

      if(var1.ticks >= 1) {
        var1.iscooked = 1;
      }

      break;
    case "decoy_grenade_mp":
      thread scripts\mp\trials\trial_jugg::decoy_used(var1);
      break;
  }

  if(isDefined(var1)) {
    var1 thread scripts\cp\cp_player_battlechatter::grenadeproximitytracking();
    scripts\cp\cp_player_battlechatter::ongrenadeuse(var1);
    return;
  }
}

function extinguishonexplode(var0) {
  thread scripts\cp\utility::notifyafterframeend("death", "end_explode");
  self endon("end_explode");
  var1 = self.owner;
  self waittill("explode", var2);
  level notify("explosion_extinguish", var2, var0, var1);
}

function ninebangexplodewaiter() {
  thread scripts\cp\utility::notifyafterframeend("death", "end_explode");
  self endon("end_explode");
  self waittill("explode", var0);
  thread doninebang(var0, self.owner, self.ninebangticks);
  ninebangdoempdamage(var0, self.owner, self.ninebangticks);
}

function ninebangdoempdamage(var0, var1, var2) {
  if(var2 >= 5) {
    playsoundatpos(var0, "emp_grenade_explode_default");
    var3 = level.players;

    foreach(var5 in var3) {
      var5 notify("emp_damage", self.owner, 8);
    }

    return;
  }
}

function doninebang(var0, var1, var2) {
  level endon("game_ended");
  var3 = level.weaponconfigs[self.weapon_name];
  wait randomfloatrange(0.25, 0.5);

  for(var4 = 1; var4 < var2; var4++) {
    var5 = getninebangsubexplosionpos(var0, var3.vfxradius);
    playFX(var3.onexplodevfx, var5);

    foreach(var7 in level.players) {
      if(!var7 scripts\cp_mp\utility\player_utility::_isalive() || var7.sessionstate != "playing") {
        continue;
      }

      var8 = var7 getEye();
      var9 = distancesquared(var0, var8);

      if(var9 > var3.radius_max_sq) {
        continue;
      }

      if(!scripts\engine\trace::_bullet_trace_passed(var0, var8, 0, var7)) {
        continue;
      }

      if(var9 <= var3.radius_min_sq) {
        var10 = 1;
      } else {
        var10 = 1 - (var9 - var3.radius_min_sq) / (var3.radius_max_sq - var3.radius_min_sq);
      }

      var11 = anglesToForward(var7 getplayerangles());
      var12 = var0 - var8;
      var12 = vectorNormalize(var12);
      var13 = 0.5 * (1 + vectordot(var11, var12));
      var14 = 1;
      var7 notify("flashbang", var0, var10, var13, var1, var14);
    }

    wait randomfloatrange(0.25, 0.5);
  }
}

function getninebangsubexplosionpos(var0, var1) {
  var2 = (randomfloatrange(-1 * var1, var1), randomfloatrange(-1 * var1, var1), 0);
  var3 = var0 + var2;
  var4 = scripts\engine\trace::_bullet_trace(var0, var3, 0, undefined, 0, 0, 0, 0, 0);

  if(var4["fraction"] < 1) {
    var3 = var0 + var4["fraction"] * var2;
  }

  return var3;
}

function rat_executevisuals(var0) {
  level endon("game_ended");
  self endon("disconnect");
  self playlocalsound("eye_pulse_plr_lr");
  self setscriptablepartstate("rat_eye_pulse", "active");
  scripts\engine\utility::ref_143ba(var0, "last_stand", "death");
  self setscriptablepartstate("rat_eye_pulse", "inactive");
}

function handleratvisionburst(var0) {
  level endon("game_ended");
  var0 endon("disconnect");
  var0 endon("last_stand");
  var0 endon("death");
  thread rat_executevisuals(var0);
}

function isinvalidzone(var0, var1, var2, var3, var4, var5) {
  var6 = getEntArray("power_exclusion_volume", "targetname");

  if(isDefined(var5)) {
    if(isDefined(level.neil) && isDefined(level.neil.upper_body)) {
      if(var5 == level.neil || var5 == level.neil.upper_body) {
        return false;
      }
    }

    if(isDefined(level.boat_vehicle)) {
      if(var5 == level.boat_vehicle) {
        return false;
      }
    }

    if(isDefined(var5.targetname) && var5.targetname == "beginning_area_balloons") {
      return false;
    }
  }

  if(isDefined(var1)) {
    var6 = scripts\engine\utility::array_combine(var6, var1);
  }

  foreach(var8 in var6) {
    if(ispointinvolume(var0, var8)) {
      return false;
    }
  }

  if(istrue(var4) && !ispointonnavmesh(var0)) {
    return false;
  }

  if(istrue(var3)) {
    if(navtrace(var2.origin, var0)) {
      return false;
    }
  }

  return true;
}

function placeequipmentfailed(var0, var1, var2, var3) {
  if(isPlayer(self)) {
    self playlocalsound("scavenger_pack_pickup");
  }

  if(istrue(var1)) {
    var4 = undefined;

    if(isPlayer(self)) {
      if(isDefined(var3)) {
        var4 = spawnfxforclient(scripts\engine\utility::getfx("placeEquipmentFailed"), var2, self, anglesToForward(var3), anglestoup(var3));
      } else {
        var4 = spawnfxforclient(scripts\engine\utility::getfx("placeEquipmentFailed"), var2, self);
      }
    } else {
      var4 = spawnfx(scripts\engine\utility::getfx("placeEquipmentFailed"), var2);
    }

    triggerfx(var4);
    thread placeequipmentfailedcleanup(var4);
    return;
  }
}

function placeequipmentfailedcleanup(var0) {
  wait 2;
  var0 delete();
}

function spawnmine(var0, var1, var2, var3) {
  if(!isDefined(var3)) {
    var3 = (0, randomfloat(360), 0);
  }

  var4 = level.weaponconfigs[var2];
  var5 = spawn("script_model", var0);
  var5.angles = var3;
  var5.owner = var1;
  var5.weapon_name = var2;
  var5.config = var4;
  var5 setModel(var4.model);
  var5 setotherent(var1);
  var5.killcamoffset = (0, 0, 4);
  var5.killcament = spawn("script_model", var5.origin + var5.killcamoffset);
  var5.killcament setscriptmoverkillcam("explosive");
  onlethalequipmentplanted(var1, var5);

  if(isDefined(var4.mine_beacon)) {
    thread doblinkinglight(var5, "tag_fx", var4.mine_beacon["friendly"]);
  }

  var6 = undefined;

  if(self != level) {
    var6 = self getlinkedparent();
  }

  explosivehandlemovers(var5, var6);
  thread mineproximitytrigger(var5);
  thread grenade_earthquake();
  thread mineselfdestruct();
  thread mineexplodeonnotify();
  thread monitordisownedequipment(level, var1);
  return var5;
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
  self waittill("detonateExplosive", var0);

  if(!isDefined(self) || !isDefined(self.owner)) {
    return;
  }

  if(!isDefined(var0)) {
    var0 = self.owner;
  }

  var1 = self.config;
  var2 = var1.vfxtag;

  if(!isDefined(var2)) {
    var2 = "tag_fx";
  }

  var3 = self gettagorigin(var2);

  if(!isDefined(var3)) {
    var3 = self gettagorigin("tag_origin");
  }

  self notify("explode", var3);
  wait 0.05;

  if(!isDefined(self) || !isDefined(self.owner)) {
    return;
  }

  self hide();

  if(isDefined(var1.onexplodefunc)) {
    self thread[[var1.onexplodefunc]]();
  }

  if(isDefined(var1.onexplodesfx)) {
    self playSound(var1.onexplodesfx);
  }

  var4 = scripts\engine\utility::ter_op(isDefined(var1.onexplodevfx), var1.onexplodevfx, level.mine_explode);
  var5 = scripts\engine\utility::ter_op(isDefined(var1.minedamagemin), var1.minedamagemin, level.minedamagemin);
  var6 = scripts\engine\utility::ter_op(isDefined(var1.minedamagemax), var1.minedamagemax, level.minedamagemax);
  var7 = scripts\engine\utility::ter_op(isDefined(var1.minedamageradius), var1.minedamageradius, level.minedamageradius);
  self radiusdamage(self.origin, var7, var6, var5, var0, "MOD_EXPLOSIVE", self.weapon_name);
  wait 0.2;
  deleteexplosive();
}

function mineproximitytrigger(var0) {
  self endon("mine_destroyed");
  self endon("mine_selfdestruct");
  self endon("death");
  self endon("disabled");
  var1 = self.config;
  wait var1.armtime;

  if(isDefined(var1.mine_beacon)) {
    thread doblinkinglight("tag_fx", var1.mine_beacon["friendly"], var1.mine_beacon["enemy"]);
  }

  var2 = spawn("trigger_radius", self.origin, 0, level.minedetectionradius, level.minedetectionheight);
  var2.owner = self;
  var2.team = var2.owner.team;
  thread minedeletetrigger(var2);

  if(isDefined(var0)) {
    var2 enablelinkTo();
    var2 linkTo(var0);
  }

  self.damagearea = var2;

  for(;;) {
    var2 waittill("trigger", var3);

    if(isPlayer(var3)) {
      wait 0.05;
      continue;
    }

    if(var3 damageconetrace(self.origin, self) > 0) {
      break;
    }
  }

  self notify("mine_triggered");
  self playSound(self.config.ontriggeredsfx);
  explosivetrigger(var3, level.minedetectiongraceperiod, "mine");
  self thread[[self.config.ontriggeredfunc]]();
}

function minedeletetrigger(var0) {
  scripts\engine\utility::ref_143a7("mine_triggered", "mine_destroyed", "mine_selfdestruct", "death");

  if(isDefined(var0)) {
    var0 delete();
    return;
  }
}

function doblinkinglight(var0, var1, var2) {
  if(!isDefined(var1)) {
    var1 = scripts\engine\utility::getfx("weap_blink_friend");
  }

  if(!isDefined(var2)) {
    var2 = scripts\engine\utility::getfx("weap_blink_enemy");
  }

  self.blinkinglightfx["friendly"] = var1;
  self.blinkinglightfx["enemy"] = var2;
  self.blinkinglighttag = var0;
  thread updateblinkinglight(var1, var2, var0);
  self waittill("death");
  stopblinkinglight();
}

function updateblinkinglight(var0, var1, var2) {
  self endon("death");
  self endon("carried");
  self endon("emp_damage");
  var3 = &checkteam;

  if(!level.teambased) {
    var3 = &checkplayer;
  }

  var4 = randomfloatrange(0.05, 0.25);
  wait var4;
  GscBinSkip4(0x35, var0, var1, var2, var3);
}

function checkplayer(var0) {
  return self == var0;
}

function checkteam(var0) {
  return self.team == var0.team;
}

function onjointeamblinkinglight(var0, var1, var2, var3) {
  self endon("death");
  level endon("game_ended");
  self endon("emp_damage");

  for(;;) {
    level waittill("joined_team", var4);

    if(self.owner[[var3]](var4)) {
      playfxontagforclients(var0, self, var2, var4);
      continue;
    }

    playfxontagforclients(var1, self, var2, var4);
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

function ref_144d9() {
  var0 = self.owner.name;
  self waittill("explode", var1);
  level notify("grenade_exploded_during_stealth", var1, "frag_grenade_mp", var0);
}

function ref_144a9() {
  var0 = self.owner.name;
  self waittill("explode", var1);
  level notify("grenade_exploded_during_stealth", var1, "flash_grenade_mp", var0);
}

function watchgasgrenadeexplode() {
  var0 = self.owner;
  var0 endon("disconnect");
  self waittill("explode", var1);
  thread ongasgrenadeimpact(var0, var1);
}

function ongasgrenadeimpact(var0, var1) {
  var2 = spawn("trigger_radius", var1, 0, 128, 160);
  var2.owner = var0;
  var3 = 128;
  var4 = spawnfx(scripts\engine\utility::getfx("gas_grenade_smoke_enemy"), var1);
  triggerfx(var4);
  wait 1;
  var5 = 8;

  while(var5 > 0) {
    var6 = undefined;

    if(isDefined(level.spawned_enemies)) {
      var6 = level.spawned_enemies;
    } else {
      var6 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
    }

    foreach(var8 in var6) {
      if(isDefined(var8.agent_type) && (var8.agent_type == "zombie_brute" || var8.agent_type == "superslasher" || var8.agent_type == "slasher" || var8.agent_type == "zombie_grey")) {
        continue;
      }

      var9 = getdamagefromzombietype(var8);

      if(isalive(var8)) {
        applygaseffect(var8, var0, var1, var2, var2, int(var9));
      }
    }

    wait 0.2;
    var5 -= 0.2;
  }

  var4 delete();
  wait 2;
  var2 delete();

  foreach(var8 in scripts\cp\cp_agent_utils::getaliveagentsofteam("axis")) {
    if(isalive(var8)) {
      var8.flame_damage_time = undefined;
    }
  }
}

function getdamagefromzombietype(var0) {
  if(isalive(var0)) {
    if(istrue(var0.is_suicide_bomber)) {
      return int(min(1000, var0.maxhealth * 0.25));
    }

    return int(min(1000, var0.maxhealth * 0.1));
  }

  return 150;
}

function applygaseffect(var0, var1, var2, var3, var4) {
  if(isalive(self) && self istouching(var2)) {
    if(var0 scripts\cp\utility::isenemy(self)) {
      var3 radiusdamage(self.origin, 1, var4, var4, var0, "MOD_GRENADE_SPLASH", "gas_grenade_mp");
      self.flame_damage_time = gettime() + 200;
      return;
    }

    return;
  }
}

function throwingknifeused(var0, var1, var2) {
  if(var2 == "throwingknifec4_mp") {
    var1 makeunusable();
    thread recordthrowingknifetraveldist();
  }

  thread throwingknifedamagedvictim(var0, var1);
  var3 = undefined;
  var4 = undefined;
  var1 waittill("missile_stuck", var3, var4);
  var5 = isDefined(var4) && var4 == "tag_flicker";
  var6 = isDefined(var4) && var4 == "tag_weapon";

  if(isDefined(var3) && (isPlayer(var3) || isagent(var3)) && var5) {
    var3 notify("shield_hit", var1);
  }

  if(isDefined(var3) && (isPlayer(var3) || isagent(var3)) && !var6 && !var5) {
    if(var2 == "throwingknifec4_mp") {
      throwingknifec4detonate(var1, var3, var0);
    }
  }

  var1.equipmentref = "equip_throwing_knife";
  thread watchgrenadedeath();

  for(;;) {
    var1 waittill("trigger", var7);
    var7 scripts\cp\cp_powers::power_adjustcharges(1, "primary");
  }
}

function throwingknifedamagedvictim(var0, var1) {
  var1 endon("death");
  var0 endon("death");
  var0 endon("disconnect");

  for(;;) {
    var0 waittill("victim_damaged", var2, var3, var4, var5, var6, var7);

    if(isDefined(var3) && var3 == var1) {
      if(var7 == "throwingknifeteleport_mp" && !isDefined(var1.knifeteleownerinvalid)) {
        throwingknifeteleport(var1, var2, var0, 1);
        var1.giveknifeback = 1;
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

function throwingknifeused_trygiveknife(var0, var1, var2) {
  var3 = var0 getweaponammoclip(var2);
  var4 = 2;
  var5 = undefined;

  if(var3 >= var4) {
    var5 = 0;
  } else {
    var0 setweaponammoclip(var2, var3 + 1);
    var0 thread scripts\cp\cp_damagefeedback::hudicontype("throwingknife");
    var5 = 1;
  }

  return var5;
}

function throwingknifeteleport(var0, var1, var2, var3) {
  var2 playlocalsound("blinkknife_teleport");
  var2 playsoundonmovingent("blinkknife_teleport_npc");
  playsoundatpos(var0.origin, "blinkknife_impact");
  thread throwingknifeteleport_fxstartburst(var2, var1);
  var4 = var1 getcorpseentity();

  if(isDefined(var4)) {
    var4 notsolid();
  }

  var5 = [];

  foreach(var7 in level.characters) {
    if(!isDefined(var7) || !isalive(var7) || var7 == var1 || var7 == var2 || !var2 scripts\cp\utility::isenemy(var7)) {
      continue;
    }

    var5 = var7;
  }

  var5 = sortbydistance(var5, var1.origin);
  var9 = var2 gettagorigin("TAG_EYE");
  var10 = var1.origin;
  var11 = var1.origin + (0, 0, var9[2] - var2.origin[2]);
  var12 = var2.angles;

  foreach(var14 in var5) {
    var15 = (var14.origin[0], var14.origin[1], var14 gettagorigin("TAG_EYE")[2]);

    if(distancesquared(var14.origin, var1.origin) < 230400 && sighttracepassed(var11, var15, 0, undefined)) {
      var12 = vectortoangles(var15 - var11);
      break;
    }
  }

  var2 setOrigin(var1.origin, !var3);
  var2 setplayerangles(var12);
  throwingknifeteleport_fxendburst(var2, var1);
}

function throwingknifeteleport_fxstartburst(var0, var1) {
  var2 = var1.origin - var0.origin;
  var3 = var0.origin + (0, 0, 32);
  var4 = vectorNormalize(var2);
  var5 = vectorNormalize(vectorcross(var2, (0, 0, 1)));
  var6 = vectorcross(var5, var4);
  var7 = axistoangles(var4, var5, var6);
  var8 = 0;

  if(var8) {
    var9 = spawn("script_model", var3);
    var9.angles = var7;
    var9 setModel("tag_origin");
    var9 hidefromplayer(var0);
    waitframe();
    playfxontagforteam(scripts\engine\utility::getfx("vfx_knife_tele_start_friendly"), var9, "tag_origin", var0.team);
    wait 3;
    var9 delete();
    return;
  }

  var10 = spawn("script_model", var3);
  var10.angles = var7;
  var10 setModel("tag_origin");
  var10 hidefromplayer(var0);
  waitframe();

  foreach(var12 in level.players) {
    var10 hidefromplayer(var12);
  }

  playFXOnTag(scripts\engine\utility::getfx("vfx_tele_start_friendly"), var10, "tag_origin");
  wait 3;
  var10 delete();
}

function recordthrowingknifetraveldist() {
  level endon("game_ended");
  self.owner endon("disconnect");
  self.disttravelled = 0;
  var0 = self.origin;

  for(;;) {
    var1 = scripts\engine\utility::ref_143ba(0.15, "death", "missile_stuck");

    if(!isDefined(self)) {
      break;
    }

    var2 = distance(var0, self.origin);
    self.disttravelled += var2;
    var0 = self.origin;

    if(var1 != "timeout") {
      break;
    }
  }
}

function throwingknifeteleport_fxendburst(var0, var1) {}

function throwingknifec4detonate(var0, var1, var2) {
  var1 playSound("biospike_explode");
  playFX(scripts\engine\utility::getfx("throwingknifec4_explode"), var0.origin);
  var0 radiusdamage(var0.origin, 180, 1200, 600, var2, "MOD_EXPLOSIVE", var0.weapon_name);
  thread grenade_earthquake();
  var0 notify("explode", var0.origin);
  var0 delete();
}

function throwingknifeused_recordownerinvalid(var0, var1) {
  var1 endon("missile_stuck");
  var1 endon("death");
  var0 scripts\engine\utility::ref_143a5("death", "disconnect");
  var1.knifeteleownerinvalid = 1;
}

function watchconcussiongrenadeexplode() {
  thread endondeath();
  self endon("end_explode");
  var0 = self.owner.name;
  self waittill("explode", var1);
  level notify("grenade_exploded_during_stealth", var1, "concussion_grenade_mp", var0);
  GscBinSkip4(0x35, var1, self.owner);
}

function stunplayersinrange(var0, var1) {
  var2 = level.players;
  var3 = scripts\engine\utility::get_array_of_closest(var0, var2, undefined, 24, 256);

  foreach(var5 in var3) {
    if((scripts\cp\utility::is_friendly_damage(var5, var1) && var5 != var1) == 0) {
      thread stundamageonplayers(var5, var5, var1);
    }
  }
}

function stundamageonplayers(var0, var1, var2) {
  var3 = 3;
  var4 = 3;

  if(var0 == var1) {
    var3 = 2;
    var4 = 2;
  }

  var5 = 1 - distance(var0.origin, var2) / 512;

  if(var5 < 0) {
    var5 = 0;
  }

  var6 = var3 + var4 * var5;
  var1 notify("stun_hit");
  var0 notify("concussed", var1);
  var0 scripts\cp\utility::setplayerstunned();
  thread cleanupconcussionstun(var0);
  var0 shellshock("concussion_grenade_mp", var6);
  var0.concussionendtime = gettime() + var6 * 1000;
}

function cleanupconcussionstun(var0) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  wait var0;
  scripts\cp\utility::setplayerunstunned();
}

function stunenemiesinrange(var0, var1) {
  var2 = scripts\engine\utility::array_combine(scripts\cp\cp_agent_utils::getaliveagentsofteam("axis"), scripts\cp\cp_agent_utils::getaliveagentsofteam("team_three"));
  var3 = scripts\engine\utility::get_array_of_closest(var0, var2, undefined, 24, 500);

  foreach(var5 in var3) {
    thread fx_stun_damage(var5, var5);
  }
}

function fx_stun_damage(var0, var1) {
  var0 endon("death");

  if(isDefined(var0.stun_hit_time)) {
    if(gettime() > var0.stun_hit_time) {
      var0.allowpain = 1;
      var0.stun_hit_time = gettime() + 1000;
      var0.stunned = 1;
      thread ref_12abb();
    } else {
      return;
    }
  } else {
    var0.allowpain = 1;
    var0.stun_hit_time = gettime() + 1000;
    var0.stunned = 1;
    thread ref_12abb();
  }

  var0 dodamage(1, var0.origin, var1, var1, "MOD_GRENADE_SPLASH", "concussion_grenade_mp");
  wait 10;
  var0.allowpain = 0;
  var0.stunned = undefined;
}

function ref_12abb() {
  self endon("death");
  self notify("sturn_accuracy_reduction");
  self endon("sturn_accuracy_reduction");

  if(self.baseaccuracy != 0) {
    self.ref_11fbd = self.baseaccuracy;
  }

  self.baseaccuracy = 0;

  while(istrue(self.stunned)) {
    waitframe();
  }

  if(isDefined(self.ref_11fbd)) {
    self.baseaccuracy = self.ref_11fbd;
    return;
  }
}

function mineused(var0, var1) {
  if(!isalive(self)) {
    var0 delete();
    return;
  }

  thread minethrown(var0, self, var0.weapon_name);
}

function minethrown(var0, var1, var2, var3) {
  self.owner = var0;
  self waittill("missile_stuck", var4);

  if(!isDefined(var0)) {
    return;
  }

  if(var1 != "trip_mine_mp") {
    if(isDefined(var4) && isDefined(var4.owner)) {
      if(isDefined(var3)) {
        self.owner[[var3]](self);
      }

      self delete();
      return;
    }
  }

  var5 = scripts\engine\trace::_bullet_trace(self.origin + (0, 0, 4), self.origin - (0, 0, 4), 0, self);
  var6 = var5["position"];

  if(var5["fraction"] == 1) {
    var6 = getgroundposition(self.origin, 12, 0, 32);
    var5 = var5["normal"] * -1;
  }

  var7 = vectorNormalize(var5["normal"]);
  var8 = vectortoangles(var7);
  var8 += (90, 0, 0);
  var9 = [[var2]](var6, var0, var1, var8);
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
  var0 = undefined;

  for(;;) {
    self waittill("damage", var1, var0, var2, var3, var4, var5, var6, var7, var8, var9);

    if(!isPlayer(var0) && !isagent(var0)) {
      continue;
    }

    if(isDefined(var9) && isendstr(var9.basename, "betty_mp")) {
      continue;
    }

    if(isDefined(self.owner) && var0 != self.owner && !scripts\cp\cp_damage::friendlyfirecheck(self.owner, var0)) {
      continue;
    }

    if(isDefined(var9)) {
      switch (var9.basename) {
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

  if(isDefined(var4) && (issubstr(var4, "MOD_GRENADE") || issubstr(var4, "MOD_EXPLOSIVE"))) {
    self.waschained = 1;
  }

  if(isDefined(var8) && var8 &level.idflags_penetration) {
    self.wasdamagedfrombulletpenetration = 1;
  }

  self.wasdamaged = 1;

  if(isDefined(var0)) {
    self.damagedby = var0;
  }

  self notify("detonateExplosive", var0);
}

function is_hive_explosion(var0, var1) {
  if(!isDefined(var0) || !isDefined(var0.classname)) {
    return false;
  }

  return var0.classname == "scriptable" && var1 == "MOD_EXPLOSIVE";
}

function claymoredetonation(var0) {
  self endon("death");
  var1 = spawn("trigger_radius", self.origin + (0, 0, 0 - level.claymoredetonateradius), 0, level.claymoredetonateradius, level.claymoredetonateradius * 2);

  if(isDefined(var0)) {
    var1 enablelinkTo();
    var1 linkTo(var0);
  }

  thread deleteondeath(var1);

  for(;;) {
    var1 waittill("trigger", var2);

    if(getdvarint("scr_claymoredebug") != 1) {
      if(isDefined(self.owner)) {
        if(var2 == self.owner) {
          continue;
        }

        if(isDefined(var2.owner) && var2.owner == self.owner) {
          continue;
        }
      }

      if(!scripts\cp\cp_damage::friendlyfirecheck(self.owner, var2, 0)) {
        continue;
      }
    }

    if(lengthsquared(var2 getentityvelocity()) < 10) {
      continue;
    }

    var3 = abs(var2.origin[2] - self.origin[2]);

    if(var3 > 128) {
      continue;
    }

    if(!shouldaffectclaymore(var2, self)) {
      continue;
    }

    if(var2 damageconetrace(self.origin, self) > 0) {
      break;
    }
  }

  explosivetrigger(var2, level.claymoredetectiongraceperiod, "claymore");
  self notify("detonateExplosive");
}

function explosivetrigger(var0, var1, var2) {
  self setscriptablepartstate("arm", "neutral", 0);
  self setscriptablepartstate("trigger", "active", 0);

  if(isPlayer(var0) && var0 scripts\cp\utility::_hasperk("specialty_delaymine")) {
    var0 notify("triggeredExpl", var2);
    var1 = level.delayminetime;
  }

  wait var1;
}

function shouldaffectclaymore(var0) {
  if(isDefined(var0.disabled)) {
    return false;
  }

  var1 = self.origin + (0, 0, 32);
  var2 = var1 - var0.origin;
  var3 = anglesToForward(var0.angles);
  var4 = vectordot(var2, var3);

  if(var4 < level.claymoredetectionmindist) {
    return false;
  }

  var2 = vectorNormalize(var2);
  var5 = vectordot(var2, var3);
  return var5 > level.claymoredetectiondot;
}

function deleteondeath(var0) {
  self waittill("death");
  self setscriptablepartstate("destroy", "active", 0);
  wait 0.05;

  if(isDefined(var0)) {
    if(isDefined(var0.trigger)) {
      var0.trigger delete();
    }

    var0 delete();
    return;
  }
}

function c4empdamage() {
  self endon("death");

  for(;;) {
    self waittill("emp_damage", var0, var1);
    equipmentempstunvfx();
    self.disabled = 1;
    self notify("disabled");
    wait var1;
    self.disabled = undefined;
    self notify("enabled");
  }
}

function equipmentempstunvfx() {
  playFXOnTag(scripts\engine\utility::getfx("emp_stun"), self, "tag_origin");
}

function c4implode(var0, var1, var2) {
  var1 endon("disconnect");
  wait 0.5;
  var2 radiusdamage(var0, 256, 1200, 600, var1, "MOD_EXPLOSIVE", "c4_mp_p");
  thread c4_earthquake();
}

function resetc4explodethisframe() {
  wait 0.05;
  level.c4explodethisframe = 0;
}

function onlethalequipmentplanted(var0, var1, var2) {
  if(self.plantedlethalequip.size) {
    self.plantedlethalequip = scripts\engine\utility::array_removeundefined(self.plantedlethalequip);

    if(self.plantedlethalequip.size >= level.maxperplayerexplosives) {
      if(istrue(var2)) {
        self.plantedlethalequip[0] notify("detonateExplosive");
      } else {
        deleteexplosive(self.plantedlethalequip[0]);
      }
    }
  }

  self.plantedlethalequip[self.plantedlethalequip.size] = var0;
  var3 = var0 getentitynumber();
  level.mines[var3] = var0;
  level notify("mine_planted");
}

function bankingoverlimitwillendot(var0) {
  var1 = var0 getentitynumber();
  level.mines[var1] = var0;
}

function watchc4altdetonate(var0) {
  self notify("watchC4AltDetonate");
  self endon("watchC4AltDetonate");
  self endon("death");
  self endon("disconnect");
  self endon("detonated");
  level endon("game_ended");
  var1 = 0;

  for(;;) {
    if(self useButtonPressed()) {
      var1 = 0;

      while(self useButtonPressed()) {
        var1 += 0.05;
        wait 0.05;
      }

      if(var1 >= 0.5) {
        continue;
      }

      var1 = 0;

      while(!self useButtonPressed() && var1 < 0.5) {
        var1 += 0.05;
        wait 0.05;
      }

      if(var1 >= 0.5) {
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
    var0 = self getcurrentweapon();

    if(var0.basename != "c4_mp_p") {
      c4detonateallcharges();
    }
  }
}

function watchc4detonation() {
  self notify("watchC4Detonation");
  self endon("watchC4Detonation");
  self endon("death");
  self endon("disconnect");
  var0 = getcompleteweaponname("c4_mp_p");

  for(;;) {
    self waittillmatch("detonate", var0);
    c4detonateallcharges();
  }
}

function c4detonateallcharges() {
  foreach(var1 in self.plantedlethalequip) {
    if(isDefined(var1) && var1.weapon_name == "c4_mp_p") {
      thread waitanddetonate(var1);
      scripts\engine\utility::array_remove(self.plantedlethalequip, var1);
    }
  }

  self notify("c4_update", 0);
  waittillframeend();
  self notify("detonated");
}

function waitanddetonate(var0) {
  self endon("death");
  wait var0;
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
  var0 = self.originalowner;
  var0 endon("disconnect");
  thread ownerdisconnectcleanup(var0);
  var1 = [];

  for(var2 = 0; var2 < 4; var2++) {
    var1 = 0.2;
  }

  var3 = 0;

  foreach(var5 in var1) {
    var3 += var5;
  }

  var7 = spawn("script_model", self.origin);
  var7 linkTo(self);
  var7 setModel("tag_origin");
  var7 setscriptmoverkillcam("explosive");
  thread deathdelaycleanup(var7, self);
  thread ownerdisconnectcleanup(var7);
  var7.threwback = self.threwback;
  var8 = var0 scripts\cp\utility::_launchgrenade("cluster_grenade_indicator_mp", self.origin, (0, 0, 0));
  var8 linkTo(self);
  thread deathdelaycleanup(var8, self);
  thread ownerdisconnectcleanup(var8);
  thread scripts\cp\utility::notifyafterframeend("death", "end_explode");
  self endon("end_explode");
  self waittill("explode", var9);
  thread clustergrenadeexplode(var9, var1, var0, var7);
}

function clustergrenadeexplode(var0, var1, var2, var3) {
  var2 endon("disconnect");
  var4 = scripts\engine\trace::create_contents(0, 1, 1, 0, 1, 0, 0);
  var5 = 0;
  var6 = var0 + (0, 0, 3);
  var7 = var6 + (0, 0, -5);
  var8 = physics_raycast(var6, var7, var4, undefined, 0, "physicsquery_closest");

  if(isDefined(var8) && var8.size > 0) {
    var5 = 1;
  }

  var9 = scripts\engine\utility::ter_op(var5, (0, 0, 32), (0, 0, 2));
  var10 = var0 + var9;
  var11 = randomint(90) - 45;
  var4 = scripts\engine\trace::create_contents(0, 1, 1, 0, 1, 0, 0);

  for(var12 = 0; var12 < 4; var12++) {
    var3.shellshockondamage = scripts\engine\utility::ter_op(var12 == 0, 1, undefined);
    var3 radiusdamage(var0, 256, 800, 400, var2, "MOD_EXPLOSIVE", "cluster_grenade_zm");
    var13 = scripts\engine\utility::ter_op(var12 < 4, 90 * var12 + var11, randomint(360));
    var14 = scripts\engine\utility::ter_op(var5, 110, 90);
    var15 = scripts\engine\utility::ter_op(var5, 12, 45);
    var16 = var14 + randomint(var15 * 2) - var15;
    var17 = randomint(60) + 30;
    var18 = cos(var13) * sin(var16);
    var19 = sin(var13) * sin(var16);
    var20 = cos(var16);
    var21 = (var18, var19, var20) * var17;
    var6 = var10;
    var7 = var10 + var21;
    var8 = physics_raycast(var6, var7, var4, undefined, 0, "physicsquery_closest");

    if(isDefined(var8) && var8.size > 0) {
      var7 = var8[0]["position"];
    }

    playFX(scripts\engine\utility::getfx("clusterGrenade_explode"), var7);

    switch (var12) {
      case 0:
        playsoundatpos(var7, "frag_grenade_expl_trans");
        break;
      case 3:
        playsoundatpos(var7, "cluster_explode_end");
        break;
      default:
        playsoundatpos(var7, "cluster_explode_mid");
        break;
    }

    wait var1[var12];
  }
}

function deathdelaycleanup(var0, var1) {
  self endon("death");
  var0 waittill("death");
  wait var1;
  self delete();
}

function ownerdisconnectcleanup(var0) {
  self endon("death");
  var0 waittill("disconnect");
  self delete();
}

function semtexused(var0) {
  if(!isDefined(var0)) {
    return;
  }

  var0.originalowner = self;
  var0 setentityowner(self);
  var0 setotherent(self);
  thread semtex_watch_cleanup();
  thread semtex_watch_fuse();
  var1 = var0.owner.name;
  var0 waittill("missile_stuck", var2);
  level notify("grenade_exploded_during_stealth", var0.origin, "semtex_mp", var1);
  thread grenade_earthquake();
  explosivehandlemovers(var0, undefined);
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

function semtex_delete(var0) {
  self notify("death");
  self.exploding = 1;
  wait var0;
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

function canweaponhaveattachment(var0, var1) {
  var2 = scripts\cp\utility::getweaponattachmentsbasenames(var0);

  foreach(var1 in var2) {}
}

function doesattachmentconflict(var0, var1) {
  foreach(var3 in level.br_pickups.br_pickupconflicts[var1]) {
    if(attachmentisdefault(var0)) {
      continue;
    }

    var4 = scripts\cp\utility::attachmentmap_tobase(var0);

    if(var4 == var3) {
      return true;
    }
  }

  return false;
}

function attachmentisdefault(var0) {
  return isDefined(var0) && (scripts\engine\utility::string_starts_with(var0, "rec") || scripts\engine\utility::string_starts_with(var0, "front") || scripts\engine\utility::string_starts_with(var0, "back") || scripts\engine\utility::string_starts_with(var0, "mag") || scripts\engine\utility::string_starts_with(var0, "guard") || scripts\engine\utility::string_starts_with(var0, "triggrip") || scripts\engine\utility::string_starts_with(var0, "toprail"));
}

function hasattachmentconflictwithweapon(var0, var1) {
  return hasattachmentconflict(getweaponattachments(var0), var1);
}

function hasattachmentconflict(var0, var1) {
  if(var1 == -1) {
    return true;
  }

  foreach(var3 in var0) {
    if(doesattachmentconflict(var3, var1)) {
      return true;
    }
  }

  return false;
}

function removeattachmentsandgiveweapon(var0, var1) {
  if(!isDefined(var0) || !isDefined(self) || !isPlayer(self)) {
    return;
  }

  var2 = var1;
  var3 = self getweaponammoclip(var2);
  var4 = self getweaponammostock(var2);
  var5 = scripts\cp\utility::getweaponattachmentsbasenames(var2);

  for(var6 = 0; var6 < var0.size; var6++) {
    if(scripts\engine\utility::array_contains(var5, var0[var6])) {
      var5 = scripts\engine\utility::array_remove(var5, var0[var6]);
    }
  }

  scripts\cp\cp_weapons::_takeweapon(var2);
  var7 = scripts\cp\utility::getweaponrootname(var2.basename);
  var8 = buildweaponuniqueattachments(var7, var5, -1);

  if(isDefined(var2.attachments)) {
    foreach(var10 in var2.attachments) {
      var2 = var2 withoutattachment(var10);
    }
  }

  foreach(var13 in var8) {
    var2 = var2 withattachment(var13);
  }

  self giveweapon(var2);
  self setweaponammoclip(var2, var3);
  self setweaponammostock(var2, var4);
  self switchtoweapon(var2);
}

function remove_attachment(var0, var1, var2) {
  if(!isDefined(var0) && !isDefined(var1)) {
    return;
  }

  var3 = [];
  var4 = undefined;
  var5 = undefined;

  if(isDefined(var2)) {
    if(issameweapon(var2)) {
      var3 = var2;
    } else {
      var3 = asmdevgetallstates(var2);
    }
  } else {
    var3 = var1 getweaponslistall();
  }

  foreach(var7 in var3) {
    if(var7 hasattachment(var0, 1)) {
      var8 = scripts\cp\utility::getrawbaseweaponname(var7);
      var9 = getweaponbasename(var7);
      var1 takeweapon(var7);
      var10 = getweaponattachments(var7);

      foreach(var12 in var10) {
        if(issubstr(var12, var0)) {
          var10 = scripts\engine\utility::array_remove(var10, var12);
          break;
        }
      }

      if(isDefined(level.build_weapon_name_func)) {
        var5 = var1[[level.build_weapon_name_func]](var9, var10);
      }

      if(isDefined(var5)) {
        var3 = self getweaponslistprimaries();

        foreach(var2 in var3) {
          if(issubstr(var2.basename, var5.basename)) {
            if(var2.isalternate) {
              var9 = getweaponbasename(var2);

              if(isDefined(level.alt_mode_weapons_allowed) && scripts\engine\utility::array_contains(level.alt_mode_weapons_allowed, var9)) {
                var5 = var5 getaltweapon();
                break;
              }
            }
          }
        }

        var1 scripts\cp\utility::_giveweapon(var5, -1, -1, 1);
        var1 switchtoweapon(var5);
      }
    }
  }
}

function has_weapon_variation(var0) {
  var1 = self getweaponslistall();
  var2 = undefined;

  if(issameweapon(var0)) {
    var2 = var0.basename;
  } else {
    var2 = var0;
  }

  foreach(var4 in var1) {
    var5 = scripts\cp\utility::getrawbaseweaponname(var2);
    var6 = scripts\cp\utility::getrawbaseweaponname(var4);

    if(var5 == var6) {
      return true;
    }
  }

  return false;
}

function has_weapon_variation_without_attachments(var0, var1) {
  var2 = self getweaponslistall();

  foreach(var4 in var2) {
    if(var1 == var4.basename) {
      var5 = [];

      foreach(var7 in var4.attachments) {
        var5 = scripts\cp\utility::attachmentmap_tobase(var7);
      }

      foreach(var10 in var0) {
        if(scripts\engine\utility::array_contains(var5, var10)) {
          return false;
        }

        return true;
      }

      var10 = undefined;
    }
  }

  var4 = undefined;
  var5 = undefined;
  return false;
}

function get_weapon_variation_obj(var0) {
  var1 = self getweaponslistall();
  var2 = [];
  var3 = undefined;

  if(issameweapon(var0)) {
    var3 = var0.basename;
  } else {
    var3 = var0;
  }

  foreach(var5 in var1) {
    var6 = scripts\cp\utility::getrawbaseweaponname(var3);
    var7 = scripts\cp\utility::getrawbaseweaponname(var5);

    if(var6 == var7) {
      var2 = var5;
    }
  }

  return var2;
}

function buildattachmentmaps() {
  level.attachmentmap_uniquetobase = [];
  level.attachmentmap_uniquetoextra = [];
  level.weaponattachments = [];
  var0 = [];
  var1 = 1;

  for(var2 = tablelookupbyrow("mp/attachmentmap.csv", var1, 0); var2 != ""; var2 = tablelookupbyrow("mp/attachmentmap.csv", var1, 0)) {
    if(scripts\cp_mp\utility\weapon_utility::vehicle_ai_script_models(var2)) {
      var0 = var2;
    }

    var1++;
  }

  var3 = [];
  var4 = 1;

  for(var5 = tablelookupbyrow("mp/attachmentmap.csv", 0, var4); var5 != ""; var5 = tablelookupbyrow("mp/attachmentmap.csv", 0, var4)) {
    var3 = var4;
    var4++;
  }

  level.attachmentmap_basetounique = [];

  foreach(var2 in var0) {
    foreach(var10, var8 in var3) {
      var9 = tablelookup("mp/attachmentmap.csv", 0, var2, var8);

      if(var9 == "") {
        continue;
      }

      if(!isDefined(level.attachmentmap_basetounique[var2])) {
        level.attachmentmap_basetounique[var2] = [];
      }

      level.attachmentmap_basetounique[var2][var10] = var9;

      if(!isDefined(level.attachmentmap_uniquetobase[var9])) {
        level.attachmentmap_uniquetobase[var9] = var10;
        continue;
      }

      if(level.attachmentmap_uniquetobase[var9] != var10) {}
    }
  }

  foreach(var20, var13 in level.weaponmapdata) {
    var14 = getsubstr(var20, 4);
    var15 = "mp/gunsmith/" + var14 + "_progression.csv";

    if(!tableexists(var15)) {
      continue;
    }

    level.weaponattachments[var20] = [];
    var1 = 1;
    var16 = tablelookupbyrow(var15, var1, 0);
    var17 = tablelookupbyrow(var15, var1, 1);
    var18 = "loot/iw8_" + var14 + "_attachment_ids.csv";

    while(var16 != "") {
      if(var17 != "") {
        var19 = tablelookup(var18, 0, var17, 1);

        if(var19 != "") {
          level.weaponattachments[var20][var19] = var19;
        }
      }

      var1++;
      var16 = tablelookupbyrow(var15, var1, 0);
      var17 = tablelookupbyrow(var15, var1, 1);
    }
  }

  level.attachmentmap_attachtoperk = [];
  level.carrier_remove_carriable_weapon = [];
  level.carry_ref = [];
  level.carryobjects_onjuggernaut = [];
  var21 = getattachmentlistuniquenames();

  foreach(var23 in var21) {
    var24 = tablelookup("mp/attachmenttable.csv", 4, var23, 2);
    var25 = scripts\cp\utility::attachmentmap_tobase(var23);

    if(var24 != "" && isDefined(var25)) {
      var26 = level.carry_ref[var25];

      if(!isDefined(var26)) {
        level.carry_ref[var25] = var24;
      } else if(var24 != var26) {
        level.carryobjects_onjuggernaut[var23] = var24;
      }
    }

    var27 = tablelookup("mp/attachmenttable.csv", 4, var23, 12);

    if(var27 != "") {
      level.attachmentmap_attachtoperk[var23] = var27;
    }

    var28 = tablelookup("mp/attachmenttable.csv", 4, var23, 13);

    if(var28 != "") {
      level.attachmentmap_uniquetoextra[var23] = var28;
    }

    var29 = tablelookup("mp/attachmenttable.csv", 4, var23, 9);

    if(var29 != "") {
      level.carrier_remove_carriable_weapon[var23] = var29;
    }
  }

  level.attachmentmap_conflicts = [];
  var31 = 1;

  for(var32 = tablelookupbyrow("mp/attachmentcombos.csv", var31, 0); var32 != ""; var32 = tablelookupbyrow("mp/attachmentcombos.csv", var31, 0)) {
    var33 = 1;

    for(var34 = tablelookupbyrow("mp/attachmentcombos.csv", 0, var33); var34 != ""; var34 = tablelookupbyrow("mp/attachmentcombos.csv", 0, var33)) {
      if(var32 != var34) {
        var35 = tablelookupbyrow("mp/attachmentcombos.csv", var31, var33);
        var36 = scripts\engine\utility::alphabetize([var32, var34]);
        var37 = var36[0] + "_" + var36[1];

        if(var35 == "no" && !isDefined(level.attachmentmap_conflicts[var37])) {
          level.attachmentmap_conflicts[var37] = 1;
        } else if(var35 != "") {
          level.attachmentmap_conflicts[var37] = var35;
        }
      }

      var33++;
    }

    var31++;
  }
}

function getattachmentlistuniquenames() {
  var0 = [];
  var1 = 0;

  for(var2 = tablelookup("mp/attachmenttable.csv", 0, var1, 4); var2 != ""; var2 = tablelookup("mp/attachmenttable.csv", 0, var1, 4)) {
    var0 = var2;
    var1++;
  }

  return var0;
}

function create_zombie_base_to_unique_map(var0, var1, var2, var3) {
  if(var0 == "zombie") {
    foreach(var5 in var1) {
      foreach(var9, var7 in var2) {
        var8 = tablelookup(var3, 0, var5, var7);

        if(var8 == "") {
          continue;
        }

        if(!isDefined(level.attachmentmap_basetounique[var5])) {
          level.attachmentmap_basetounique[var5] = [];
        }

        if(var8 == "none") {
          level.attachmentmap_basetounique[var5][var9] = undefined;
          continue;
        }

        level.attachmentmap_basetounique[var5][var9] = var8;
      }
    }

    return;
  }
}

function grenade_earthquake(var0) {
  self notify("grenade_earthQuake");
  self endon("grenade_earthQuake");
  thread endondeath();
  self endon("end_explode");
  var1 = undefined;

  if(!isDefined(var0) || var0) {
    self waittill("explode", var1);
  } else {
    var1 = self.origin;
  }

  playrumbleonposition("grenade_rumble", var1);
  earthquake(0.5, 0.75, var1, 800);

  foreach(var3 in level.players) {
    if(var3 scripts\cp\utility::isusingremote()) {
      continue;
    }

    if(distancesquared(var1, var3.origin) > 360000) {
      continue;
    }

    if(var3 damageconetrace(var1)) {
      thread dirteffect(var3);
    }

    var3 setclientomnvar("ui_hud_shake", 1);
  }
}

function c4_earthquake() {
  thread endondeath();
  self endon("end_explode");
  self waittill("explode", var0);
  playrumbleonposition("grenade_rumble", var0);
  earthquake(0.4, 0.75, var0, 512);

  foreach(var2 in level.players) {
    if(var2 scripts\cp\utility::isusingremote()) {
      continue;
    }

    if(distance(var0, var2.origin) > 512) {
      continue;
    }

    if(var2 damageconetrace(var0)) {
      thread dirteffect(var2);
    }

    var2 setclientomnvar("ui_hud_shake", 1);
  }
}

function endondeath() {
  self waittill("death");
  waittillframeend();
  self notify("end_explode");
}

function dirteffect(var0) {
  self notify("dirtEffect");
  self endon("dirtEffect");
  self endon("disconnect");

  if(!scripts\cp_mp\utility\player_utility::_isalive()) {
    return;
  }

  var1 = vectorNormalize(anglesToForward(self.angles));
  var2 = vectorNormalize(anglestoright(self.angles));
  var3 = vectorNormalize(var0 - self.origin);
  var4 = vectordot(var3, var1);
  var5 = vectordot(var3, var2);
  var6 = ["death", "damage"];
  var7 = self getcurrentweapon();

  if(var4 > 0 && var4 > 0.5 && var7.basename != "iw6_riotshield_mp") {
    scripts\engine\utility::waittill_any_in_array_or_timeout(var6, 2);
    return;
  }

  if(abs(var4) < 0.866) {
    if(var5 > 0) {
      scripts\engine\utility::waittill_any_in_array_or_timeout(var6, 2);
      return;
    }

    scripts\engine\utility::waittill_any_in_array_or_timeout(var6, 2);
    return;
  }
}

function shellshockondamage(var0, var1) {
  if(isflashbanged()) {
    return;
  }

  if(var0 == "MOD_EXPLOSIVE" || var0 == "MOD_GRENADE" || var0 == "MOD_GRENADE_SPLASH" || var0 == "MOD_PROJECTILE" || var0 == "MOD_PROJECTILE_SPLASH") {
    if(var1 > 10) {
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
    self waittill("grenade_fire", var0, var1, var2, var3);

    if(isDefined(self.throwinggrenade) && var1.basename != self.throwinggrenade) {
      continue;
    }

    if(isDefined(var0)) {
      if(!isDefined(var0.weapon_obj)) {
        var0.weapon_obj = var1;
      }

      if(!isDefined(var0.weapon_name)) {
        var0.weapon_name = var1.basename;
      }

      if(!isDefined(var0.owner)) {
        var0.owner = self;
      }

      if(!isDefined(var0.team)) {
        var0.team = self.team;
      }

      if(!isDefined(var0.ticks) && isDefined(self.throwinggrenade)) {
        var0.ticks = scripts\cp\utility::roundup(4 * var2);
      }
    }

    grenadeinitialize(var0, var1, var2, var3);

    if(!scripts\cp_mp\utility\player_utility::_isalive() && !isDefined(self.throwndyinggrenade)) {
      self notify("grenade_fire_dead", var0, var1.basename);
      self.throwndyinggrenade = 1;
    }

    if(istrue(var0.threwback)) {
      scripts\cp\cp_powers::power_adjustcharges(1, "primary");
    }

    return var0;
  }
}

function grenadestuckto(var0, var1, var2) {
  if(!isDefined(self)) {
    var0.stuckenemyentity = var1;
    var1.stuckbygrenade = var0;
    return;
  }

  if(level.teambased && scripts\engine\utility::is_equal(var1.team, self.team)) {
    var0.isstuck = "friendly";
    return;
  }

  var3 = undefined;

  if(!isDefined(var0.weapon_name)) {
    return;
  }

  switch (var0.weapon_name) {
    case "semtex_mp":
      var3 = "semtex_stuck";
      break;
    case "molotov_mp":
      var3 = "molotov_stuck";
      break;
    case "pop_rocket_proj_mp":
      var3 = "flare_gun_attacker_stuck";
      break;
    case "thermite_mp":
      var3 = "thermite_attacker_stuck";
      break;
  }

  var0.isstuck = "enemy";
  var0.stuckenemyentity = var1;
  var1.stuckbygrenade = var0;
  self notify("grenade_stuck_enemy");

  if(isPlayer(var1)) {
    level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(var1, "incoming_stuck");
    return;
  }
}

function grenadestucktosplash(var0, var1) {
  var2 = self;

  if(isPlayer(var1) && isDefined(var0)) {
    if(isDefined(var2.owner)) {
      var2 = var2.owner;
    }

    var2 scripts\cp\cp_hud_message::showsplash(var0);
    return;
  }
}

function can_use_attachment(var0, var1) {
  if(!isDefined(var1)) {
    var1 = self getcurrentweapon();
  }

  var2 = getweaponbasename(var1);
  var3 = var1.classname;
  var4 = get_possible_attachments_by_weaponclass(var3, var2, var0);

  if(!var4) {
    return false;
  }

  return true;
}

function add_attachment_to_weapon(var0, var1, var2, var3) {
  var4 = undefined;

  if(isDefined(var1)) {
    if(issameweapon(var1)) {
      var4 = var1;
    } else {
      var4 = asmdevgetallstates(var1);
    }
  } else {
    var4 = scripts\cp\utility::getvalidtakeweapon();
  }

  var5 = getweaponbasename(var4);
  var6 = 0;
  var7 = getweaponattachments(var4);
  var8 = scripts\cp\utility::getcurrentcamoname(var4);
  var9 = return_weapon_name_with_like_attachments(var4, var0, var7, undefined, var8);

  if(!isDefined(var9)) {
    return false;
  }

  var10 = asmdevgetallstates(var9);

  if(nullweapon(var10)) {
    return false;
  }

  var11 = var4.isalternate;

  if(var10 hasattachment("xmags", 1)) {
    var6 = 1;
  }

  if(isDefined(var0)) {
    if(!issubstr(var0, "pap")) {
      var12 = self getweaponammoclip(var4);
      var13 = self getweaponammostock(var4);

      if(var10 hasattachment("akimbo", 1)) {
        var14 = self getweaponammoclip(var4, "left");
      } else {
        var14 = undefined;
      }

      self takeweapon(var5);
      scripts\cp\utility::_giveweapon(var11, undefined, undefined, 1);

      if(var11 hasattachment("xmags", 1) && !var7) {
        var13 = weaponclipsize(var11);
      }

      self setweaponammoclip(var11, var13);
      self setweaponammostock(var11, var14);

      if(isDefined(var14)) {
        self setweaponammoclip(var11, var14, "left");
      }
    } else {
      self takeweapon(var5);
      scripts\cp\utility::_giveweapon(var11, undefined, undefined, 0);
      self givemaxammo(var11);
    }
  }

  self playlocalsound("weap_raise_large_plr");
  var15 = self getweaponslistprimaries();

  foreach(var2 in var15) {
    if(issubstr(var2.basename, var11.basename)) {
      if(var2.isalternate) {
        var17 = getweaponbasename(var2);

        if(isDefined(level.alt_mode_weapons_allowed) && scripts\engine\utility::array_contains(level.alt_mode_weapons_allowed, var17) || var12) {
          var11 = var11 getaltweapon();
          break;
        }
      }
    }
  }

  var15 = undefined;
  var16 = undefined;

  if(istrue(var3)) {
    return true;
  }

  if(istrue(var2)) {
    self switchtoweaponimmediate(var10);
  } else {
    self switchtoweapon(var10);
  }

  return true;
}

function isforgefreezeweapon(var0) {
  if(!isDefined(var0)) {
    return false;
  }

  if(isDefined(var0)) {
    if(var0 == "iw7_forgefreeze_zm" || var0 == "iw7_forgefreeze_zm_pap1" || var0 == "iw7_forgefreeze_zm_pap2" || var0 == "zfreeze_semtex_mp") {
      return true;
    }
  }

  return false;
}

function issteeldragon(var0) {
  var1 = getweaponbasename(var0);

  if(!isDefined(var1)) {
    return false;
  }

  return var1 == "iw7_steeldragon_zm";
}

function is_perk_attachment(var0) {
  if(!isDefined(var0)) {
    return false;
  }

  if(var0 == "doubletap") {
    return true;
  }

  return false;
}

function is_arcane_attachment(var0) {
  if(!isDefined(var0)) {
    return false;
  }

  if(issubstr(var0, "ark")) {
    return true;
  }

  if(issubstr(var0, "arcane")) {
    return true;
  }

  return false;
}

function is_mod_attachment(var0) {
  if(!isDefined(var0)) {
    return false;
  }

  if(issubstr(var0, "mod")) {
    return true;
  }

  return false;
}

function is_default_attachment(var0, var1) {
  var2 = scripts\cp\utility::weaponattachdefaultmap(var1);

  if(!isDefined(var2) || var2.size < 1) {
    return false;
  }

  foreach(var4 in var2) {
    if(var0 == var4) {
      return true;
    }
  }

  return false;
}

function is_pap_attachment(var0) {
  if(!isDefined(var0)) {
    return false;
  }

  if(issubstr(var0, "pap")) {
    return true;
  }

  return false;
}

function get_possible_attachments_by_weaponclass(var0, var1, var2) {
  if(!isDefined(var0)) {
    return false;
  }

  if(!isDefined(var1)) {
    return false;
  }

  if(!isDefined(var2)) {
    return false;
  }

  var3 = [];
  var4 = scripts\cp\utility::getbaseweaponname(var1);

  if(isDefined(level.attachmentmap_basetounique[var4])) {
    if(isDefined(level.attachmentmap_basetounique[var4][var2])) {
      if(level.attachmentmap_basetounique[var4][var2] != "none") {
        return true;
      } else {
        return false;
      }
    }
  }

  if(isDefined(level.attachmentmap_basetounique[var0])) {
    if(isDefined(level.attachmentmap_basetounique[var0][var2])) {
      if(level.attachmentmap_basetounique[var0][var2] != "none") {
        return true;
      } else {
        return false;
      }
    }
  }

  if(isDefined(level.attachmentmap_basetounique[var4])) {
    var5 = getarraykeys(level.attachmentmap_basetounique[var4]);

    foreach(var7 in var5) {
      if(level.attachmentmap_basetounique[var4][var7] == var2) {
        if(level.attachmentmap_basetounique[var4][var7] != "none") {
          return true;
        }

        return false;
      }
    }
  }

  if(isDefined(level.attachmentmap_basetounique[var0])) {
    var5 = getarraykeys(level.attachmentmap_basetounique[var0]);

    foreach(var7 in var5) {
      if(level.attachmentmap_basetounique[var0][var7] == var2) {
        if(level.attachmentmap_basetounique[var0][var7] != "none") {
          return true;
        }

        return false;
      }
    }
  }

  return false;
}

function return_weapon_name_with_like_attachments(var0, var1, var2, var3, var4) {
  if(isDefined(var0)) {
    if(issameweapon(var0)) {
      var5 = var0;
    } else {
      var5 = asmdevgetallstates(var1);
    }
  } else {
    var5 = self getcurrentweapon();
  }

  var6 = getweaponbasename(var5);
  var7 = scripts\cp\utility::get_weapon_variant_id(self, var5);
  var8 = 0;
  var9 = 0;
  var10 = 0;
  var11 = 0;
  var12 = undefined;
  var13 = [];
  var14 = 7;
  var15 = [];
  var16 = 1;
  var17 = [];
  var18 = 1;
  var19 = [];
  var20 = 1;
  var21 = [];
  var22 = 1;
  var23 = [];
  var24 = 1;
  var25 = [];
  var26 = 12;
  var27 = var5.classname;

  if(var5 hasattachment("xmags", 1)) {
    var9 = 1;
  }

  var28 = get_possible_attachments_by_weaponclass(var27, var6, var3);

  if(!var28 && isDefined(var3)) {
    if(!istrue(var5)) {
      scripts\cp\utility::setlowermessage("cant_attach", &"COOP_PILLAGE/CANT_USE", 3);
    }

    return undefined;
  }

  if(!isDefined(var4)) {
    var4 = getweaponattachments(var5);
  }

  if(scripts\cp\utility::has_zombie_perk("perk_machine_rat_a_tat")) {
    if(get_possible_attachments_by_weaponclass(var27, var6, "doubletap")) {
      var4 = "doubletap";
    }
  }

  if(isDefined(var3)) {
    if(weaponclass(var2) == "spread") {
      if(issubstr(var3, "arkyellow")) {
        foreach(var30 in var4) {
          if(issubstr(var30, "smart")) {
            var4 = scripts\engine\utility::array_remove(var4, var30);
          }
        }
      }
    }
  }

  var4 = scripts\engine\utility::array_remove_duplicates(var4);
  var4 = scripts\engine\utility::array_removeundefined(var4);

  if(var4.size > 0 && var4.size <= var26) {
    foreach(var33 in var4) {
      if(is_pap_attachment(var33)) {
        if(var17.size < var18) {
          var17 = var33;
          var25 = var33;
        } else {
          continue;
        }

        continue;
      }

      if(is_arcane_attachment(var33)) {
        if(var23.size < var24) {
          var23 = var33;
          var25 = var33;
        } else {
          continue;
        }

        continue;
      }

      if(is_mod_attachment(var33)) {
        if(var19.size < var20) {
          var19 = var33;
          var25 = var33;
        } else {
          continue;
        }

        continue;
      }

      if(is_default_attachment(var33, scripts\cp\utility::getweaponrootname(var6))) {
        if(var21.size < var22) {
          var21 = var33;
          var25 = var33;
        } else {
          continue;
        }

        continue;
      }

      if(is_perk_attachment(var33)) {
        if(var15.size < var16) {
          var15 = var33;
          var25 = var33;
        } else {
          continue;
        }

        continue;
      }

      if(var13.size < var14) {
        var13 = var33;
        var25 = var33;
        continue;
      }
    }
  }

  if(isDefined(var3)) {
    var35 = scripts\cp\utility::attachmentmap_tobase(var3);

    if(isDefined(var35) && var35 != "none") {
      for(var36 = 0; var36 < var25.size; var36++) {
        var37 = scripts\cp\utility::attachmentmap_tobase(var25[var36]);

        if(var37 == var35) {
          var25 = var3;
          var8 = 1;
          break;
        }
      }
    }

    var38 = scripts\cp\utility::getattachmenttype(var3);

    if(isDefined(var38) && var38 != "none") {
      if(!var8) {
        if(is_pap_attachment(var3)) {
          if(var17.size < var18) {
            var17 = var3;
            var25 = var3;
          } else {
            for(var36 = 0; var36 < var25.size; var36++) {
              var39 = scripts\cp\utility::getattachmenttype(var25[var36]);

              if(var39 == var38) {
                var17 = var3;
                var25 = var3;
                var8 = 1;
                break;
              }
            }
          }
        } else if(is_arcane_attachment(var3)) {
          if(var23.size < var24) {
            var23 = var3;
            var25 = var3;
          } else {
            for(var36 = 0; var36 < var25.size; var36++) {
              var39 = scripts\cp\utility::getattachmenttype(var25[var36]);

              if(var39 == var38) {
                var23 = var3;
                var25 = var3;
                var8 = 1;
                break;
              }
            }
          }
        } else if(is_perk_attachment(var3)) {
          if(var15.size < var16) {
            var15 = var3;
            var25 = var3;
          } else {
            for(var36 = 0; var36 < var25.size; var36++) {
              var39 = scripts\cp\utility::getattachmenttype(var25[var36]);

              if(var39 == var38) {
                var15 = var3;
                var25 = var3;
                var8 = 1;
                break;
              }
            }
          }
        } else if(var13.size < var14) {
          var13 = var3;
          var25 = var3;
        } else {
          for(var36 = 0; var36 < var25.size; var36++) {
            var39 = scripts\cp\utility::getattachmenttype(var25[var36]);

            if(var39 == var38) {
              var13 = var3;
              var25 = var3;
              var8 = 1;
              break;
            }
          }

          if(!var8) {
            return undefined;
          }
        }
      } else if(is_perk_attachment(var3)) {
        var17 = var3;
        var25 = var3;
      } else if(is_pap_attachment(var3)) {
        var15 = var3;
        var25 = var3;
      } else if(is_arcane_attachment(var3)) {
        var23 = var3;
        var25 = var3;
      } else {
        var13 = var3;
        var25 = var3;
      }
    } else if(isDefined(var3)) {
      if(is_perk_attachment(var3)) {
        var15 = var3;
        var25 = var3;
      } else if(is_pap_attachment(var3)) {
        var17 = var3;
        var25 = var3;
      } else if(is_arcane_attachment(var3)) {
        var23 = var3;
        var25 = var3;
      } else {
        var13 = var3;
        var25 = var3;
      }
    }
  }

  var40 = scripts\cp\utility::getweaponrootname(var6);
  var41 = isDefined(self.weapon_build_models[scripts\cp\utility::getrawbaseweaponname(var5)]);

  if(!isDefined(var5) && var41) {
    var10 = scripts\cp\utility::getweaponcamo(var40);
  } else {
    var10 = var5;
  }

  if(var41) {
    var42 = 0;

    foreach(var30 in var25) {
      if(issubstr(var30, "cos_")) {
        var42 = 1;
        var12 = undefined;
        break;
      }
    }

    if(!var42) {
      var12 = scripts\cp\utility::getweaponcosmeticattachment(var40);
    }

    var11 = scripts\cp\utility::getweaponreticle(var40);
    var45 = scripts\cp\utility::getweaponpaintjobid(var40);
  } else {
    var13 = undefined;
    var12 = undefined;
    var45 = undefined;
  }

  foreach(var30 in var26) {
    if(issubstr(var30, "arcane") || issubstr(var30, "ark")) {
      foreach(var48 in var26) {
        if(var30 == var48) {
          continue;
        }

        if(issubstr(var48, "cos_")) {
          var26 = scripts\engine\utility::array_remove(var26, var48);
        }
      }

      var13 = undefined;
    }
  }

  var51 = scripts\cp\utility::mpbuildweaponname(var41, var26, var11, var12, var8, self getentitynumber(), self.clientid, var45, var13);

  if(isDefined(var51)) {
    return var51;
  }

  return createheadicon(var6);
}

function getattachmenttypeslist(var0, var1) {
  var2 = scripts\cp\utility::getweaponattachmentarrayfromstats(var0);
  var3 = [];

  foreach(var5 in var2) {
    var6 = scripts\cp\utility::getattachmenttype(var5);

    if(isDefined(var1) && scripts\cp\utility::listhasattachment(var1, var5)) {
      continue;
    }

    if(!isDefined(var3[var6])) {
      var3 = [];
    }

    var7 = var3[var6];
    var7 = var5;
    var3 = var7;
  }

  return var3;
}

function getattachmentlistbasenames() {
  var0 = [];
  var1 = ["mp/attachmenttable.csv", "cp/cp_attachmenttable.csv"];

  foreach(var3 in var1) {
    var4 = 0;

    for(var5 = tablelookup(var3, 0, var4, 5); var5 != ""; var5 = tablelookup(var3, 0, var4, 5)) {
      var6 = tablelookup(var3, 0, var4, 2);

      if(var6 != "none" && !scripts\engine\utility::array_contains(var0, var5)) {
        var0 = var5;
      }

      var4++;
    }
  }

  return var0;
}

function getweaponattachmentarray(var0) {
  var1 = [];
  var2 = scripts\cp\utility::getbaseweaponname(var0);
  var3 = scripts\cp\utility::coop_getweaponclass(var0);

  if(isDefined(level.attachmentmap_basetounique[var2])) {
    var1 = scripts\engine\utility::array_combine(var1, level.attachmentmap_basetounique[var2]);
  }

  if(isDefined(level.attachmentmap_basetounique[var3])) {
    var1 = scripts\engine\utility::array_combine(var1, level.attachmentmap_basetounique[var3]);
  }

  return var1;
}

function isvalidzombieweapon(var0) {
  if(!isDefined(level.weaponrefs)) {
    level.weaponrefs = [];

    foreach(var2 in level.weaponlist) {
      level.weaponrefs[createheadicon(var2)] = 1;
    }
  }

  if(isDefined(level.weaponrefs[var0])) {
    return true;
  }

  return false;
}

function setweaponlaser_internal() {
  self endon("death");
  self endon("disconnect");
  self endon("unsetWeaponLaser");
  self.perkweaponlaseron = 0;
  var0 = self getcurrentweapon();
  setweaponlaser_waitforlaserweapon(var0);

  if(self.perkweaponlaseron == 0) {
    self.perkweaponlaseron = 1;
    enableweaponlaser();
  }

  GscBinSkip4(0x35);
}

function setweaponlaser_waitforlaserweapon(var0) {
  for(;;) {
    if(isDefined(var0) && (var0.basename == "iw6_kac_mp" || var0.basename == "iw6_arx160_mp")) {
      break;
    }

    self waittill("weapon_change", var0);
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

function setweaponlaser_monitorweaponswitchstart(var0) {
  self endon("weapon_change");
  self waittill("weapon_switch_started");
  GscBinSkip4(0x35, var0);
}

function setweaponlaser_onweaponswitchstart(var0) {
  self notify("setWeaponLaser_onWeaponSwitchStart");
  self endon("setWeaponLaser_onWeaponSwitchStart");

  if(self.perkweaponlaseron == 1) {
    self.perkweaponlaseroffforswitchstart = 1;
    self.perkweaponlaseron = 0;
    disableweaponlaser();
  }

  wait var0;
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

function ondetonateexplosive(var0) {
  self endon("death");
  level endon("game_ended");
  thread cleanupexplosivesondeath();
  self waittill("detonateExplosive");

  if(isDefined(var0)) {
    self.owner notify(var0, 1);
  } else {
    self.owner notify("powers_c4_used", 1);
  }

  self detonate(self.owner);
}

function cleanupexplosivesondeath() {
  self endon("deleted_equipment");
  level endon("game_ended");
  var0 = self getentitynumber();
  var1 = self.killcament;
  var2 = self.trigger;
  var3 = self.sensor;
  self waittill("death");
  cleanupequipment(var0, var1, var2, var3);
}

function cleanupequipment(var0, var1, var2, var3) {
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

  if(isDefined(var0)) {
    level.mines[var0] = undefined;
  }

  if(isDefined(var1)) {
    var1 delete();
  }

  if(isDefined(var2)) {
    var2 delete();
  }

  if(isDefined(var3)) {
    var3 delete();
    return;
  }
}

function monitordamage(var0, var1, var2, var3, var4, var5) {
  self endon("death");
  level endon("game_ended");

  if(!isDefined(var5)) {
    var5 = 0;
  }

  self setCanDamage(1);
  self.health = 9999999;
  self.maxhealth = var0;
  self.damagetaken = 0;

  if(!isDefined(var4)) {
    var4 = 0;
  }

  for(var6 = 1; var6; var6 = monitordamageoneshot(var7, var8, var9, var10, var11, var12, var13, var14, var15, var16, var20, var1, var2, var3, var4)) {
    self waittill("damage", var7, var8, var9, var10, var11, var12, var13, var14, var15, var16, var17, var18, var19, var20);

    if(var5) {
      self playRumbleOnEntity("damage_light");
    }

    if(isDefined(self.helitype) && self.helitype == "littlebird") {
      if(!isDefined(self.attackers)) {
        self.attackers = [];
      }

      var21 = "";

      if(isDefined(var8) && isPlayer(var8)) {
        var21 = var8 scripts\cp\utility::getuniqueid();
      }

      if(isDefined(self.attackers[var21])) {
        self.attackers[var21] += var7;
      } else {
        self.attackers[var21] = var7;
      }
    }
  }
}

function monitordamageoneshot(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12, var13, var14) {
  if(!isDefined(self)) {
    return false;
  }

  if(isDefined(var1) && !scripts\cp\cp_damage::friendlyfirecheck(self.owner, var1)) {
    if(isDefined(self.equipmentref) && self.equipmentref == "equip_tac_cover") {} else {
      return true;
    }
  }

  var15 = var0;

  if(isDefined(var9)) {
    if(non_player_should_ignore_damage(var1, var9, var10, var4)) {
      return true;
    }
  }

  var16 = scripts\cp_mp\utility\damage_utility::packdamagedata(var1, self, var0, var9, var4, var10, var3, var2, var5, var7, var6, var8);

  if(!isDefined(var13)) {
    var13 = &scripts\cp\cp_damage::modifydamage;
  }

  var15 = self[[var13]](var16);

  if(var15 <= 0) {
    return true;
  }

  self.wasdamaged = 1;
  self.damagetaken += var15;
  self.health = 2147483647;

  if(istrue(var14)) {
    scripts\cp\utility::killstreakhit(var1, var9, self, var4, var15);
  }

  if(isDefined(var1)) {
    if(isPlayer(var1)) {
      var1 scripts\cp\cp_damagefeedback::updatedamagefeedback(var11);
    }
  }

  if(self.damagetaken >= self.maxhealth) {
    var16 = scripts\cp_mp\utility\damage_utility::packdamagedata(var1, self, var0, var9, var4, var10, var3, var2, var5, var7, var6, var8);
    self thread[[var12]](var16);
    return false;
  }

  return true;
}

function non_player_should_ignore_damage(var0, var1, var2, var3) {
  if(non_player_should_ignore_damage_signature(var0, var1, var2, var3)) {
    return true;
  }

  if(isDefined(var1.basename)) {
    if(var3 != "MOD_MELEE") {
      switch (var1.basename) {
        case "iw8_green_beam_mp":
        case "iw8_spotter_scope_mp":
          return true;
      }
    }

    if(var3 == "MOD_IMPACT") {
      switch (var1.basename) {
        case "at_mine_mp":
        case "claymore_mp":
        case "c4_mp_p":
        case "thermite_mp":
        case "semtex_mp":
          return true;
      }
    } else {
      switch (var1.basename) {
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

function non_player_should_ignore_damage_signature(var0, var1, var2, var3) {
  if(!isDefined(self.ignoredamagesignatures)) {
    return false;
  }

  if(isDefined(var1) && isstring(var1)) {
    var1 = getcompleteweaponname(var1);
  }

  foreach(var5 in self.ignoredamagesignatures) {
    if(!isDefined(var5)) {
      return false;
    }

    if(var5.checkattacker) {
      if(!isDefined(var5.attacker)) {
        non_player_remove_ignore_damage_signature(var5.id);
        continue;
      } else if(!isDefined(var0)) {
        continue;
      } else if(var0 != var5.attacker) {
        continue;
      }
    }

    if(var5.checkobjweapon) {
      if(!isDefined(var1) || nullweapon(var1)) {
        continue;
      } else if(var1 != var5.objweapon) {
        continue;
      }
    }

    if(var5.checkinflictor) {
      if(!isDefined(var5.inflictor)) {
        non_player_remove_ignore_damage_signature(var5.id);
        continue;
      } else if(!isDefined(var2)) {
        continue;
      } else if(var2 != var5.inflictor) {
        continue;
      }
    }

    if(var5.checkmeansofdeath) {
      if(!isDefined(var3)) {
        continue;
      } else if(var3 != var5.meansofdeath) {
        continue;
      }
    }

    return true;
  }

  return false;
}

function non_player_remove_ignore_damage_signature(var0) {
  if(!isDefined(self.ignoredamagesignatures)) {
    return;
  }

  self.ignoredamagesignatures[var0] = undefined;
}

function non_player_add_ignore_damage_signature(var0, var1, var2, var3) {
  if(!isDefined(self.ignoredamageid)) {
    self.ignoredamageid = 0;
  }

  if(!isDefined(self.ignoredamagesignatures)) {
    self.ignoredamagesignatures = [];
  }

  var4 = self.ignoredamageid;
  self.ignoredamageid++;

  if(isDefined(var1) && isstring(var1)) {
    var1 = getcompleteweaponname(var1);
  }

  var5 = spawnStruct();
  var5.id = var4;
  var5.attacker = var0;
  var5.objweapon = var1;
  var5.inflictor = var2;
  var5.meansofdeath = var3;
  var5.checkattacker = isDefined(var0);
  var5.checkobjweapon = isDefined(var1) && !nullweapon(var1);
  var5.checkinflictor = isDefined(var2);
  var5.checkmeansofdeath = isDefined(var3);
  self.ignoredamagesignatures[var4] = var5;
  return var4;
}

function explosivehandlemovers(var0, var1) {
  var2 = spawnStruct();
  var2.linkparent = var0;
  var2.deathoverridecallback = &movingplatformdetonate;
  var2.endonstring = "death";

  if(!isDefined(var1) || !var1) {
    var2.invalidparentoverridecallback = &scripts\cp\cp_movers::moving_platform_empty_func;
  }

  thread scripts\cp\cp_movers::handle_moving_platforms(var2);
}

function movingplatformdetonate(var0) {
  if(!isDefined(var0.lasttouchedplatform) || !isDefined(var0.lasttouchedplatform.destroyexplosiveoncollision) || var0.lasttouchedplatform.destroyexplosiveoncollision) {
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

function equipmentwatchuse(var0, var1) {
  self notify("equipmentWatchUse");
  self endon("spawned_player");
  self endon("disconnect");
  self endon("equipmentWatchUse");
  self.trigger setCursorHint("HINT_NOICON");
  self.trigger scripts\cp\cp_equipment::setexplosiveusablehintstring(self.weapon_name);
  self.trigger scripts\cp\utility::setselfusable(var0);
  self.trigger thread scripts\cp\utility::notusableforjoiningplayers(var0);

  if(isDefined(var1) && var1) {
    thread updatetriggerposition();
  }

  for(;;) {
    self.trigger waittill("trigger", var0);
    var0 notify("pickup_equipment", self.weapon_name);
    var0 setweaponammostock(self.weapon_name, var0 getweaponammostock(self.weapon_name) + 1);
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

function deleteexplosive(var0) {
  if(isDefined(self)) {
    if(isDefined(self.deletefunc)) {
      self thread[[self.deletefunc]]();
      self notify("deleted_equipment");
      return;
    }

    var1 = self getentitynumber();
    var2 = self.killcament;
    var3 = self.trigger;
    var4 = self.sensor;
    cleanupequipment(var1, var2, var3, var4);
    self notify("deleted_equipment");
    self delete();
    return;
  }
}

function ontacticalequipmentplanted(var0, var1, var2) {
  var0.equipmentref = var1;
  var0.deletefunc = var2;
  var0.planted = 1;

  if(!istrue(var0.issuper)) {
    if(self.plantedtacticalequip.size) {
      self.plantedtacticalequip = scripts\engine\utility::array_removeundefined(self.plantedtacticalequip);

      if(self.plantedtacticalequip.size && self.plantedtacticalequip.size >= getmaxplantedtacticalequip(self)) {
        deleteexplosive(self.plantedtacticalequip[0]);
      }
    }

    self.plantedtacticalequip[self.plantedtacticalequip.size] = var0;
  }

  var3 = var0 getentitynumber();
  level.mines[var3] = var0;
  level notify("mine_planted");
}

function getmaxplantedtacticalequip(var0) {
  var1 = 0;
  var1 = 4;
  return var1;
}

function equipmentdeathvfx(var0) {
  var1 = spawnfx(scripts\engine\utility::getfx("equipment_sparks"), self.origin);
  triggerfx(var1);

  if(!isDefined(var0) || var0 == 0) {
    self playSound("sentry_explode");
  }

  var1 thread scripts\cp\utility::delayentdelete(1);
}

function equipmentdeletevfx() {
  var0 = spawnfx(scripts\engine\utility::getfx("placeEquipmentFailed"), self.origin);
  triggerfx(var0);
  self playSound("mp_killstreak_disappear");
  var0 thread scripts\cp\utility::delayentdelete(1);
}

function monitordisownedequipment(var0, var1) {
  level endon("game_ended");
  var1 endon("death");
  var0 scripts\engine\utility::ref_143a6("joined_team", "joined_spectators", "disconnect");
  deleteexplosive(var1);
}

function isprimaryweapon(var0) {
  if(issameweapon(var0) && nullweapon(var0)) {
    return 0;
  }

  if(isstring(var0) && var0 == "none") {
    return 0;
  }

  if(weaponinventorytype(var0) != "primary") {
    return 0;
  }

  switch (weaponclass(var0)) {
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
  var0 = anglestoup(self.angles);
  return 10 * var0;
}

function isknifeonly(var0) {
  var1 = getweaponbasename(var0);
  return issubstr(var1, "knife");
}

function is_incompatible_weapon(var0) {
  var1 = undefined;

  if(issameweapon(var0)) {
    var1 = var0.basename;
  } else {
    var1 = var0;
  }

  if(isDefined(level.ammoincompatibleweaponslist)) {
    if(scripts\engine\utility::array_contains(level.ammoincompatibleweaponslist, var1)) {
      return true;
    }
  }

  return false;
}

function isbulletweapon(var0) {
  if(issameweapon(var0) && nullweapon(var0)) {
    return 0;
  }

  if(isstring(var0) && var0 == "none") {
    return 0;
  }

  if(scripts\cp\utility::isriotshield(var0) || isknifeonly(var0)) {
    return 0;
  }

  if(isDefined(var0.inventorytype) && var0.inventorytype == "model_only") {
    return 0;
  }

  switch (weaponclass(var0)) {
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

function is_explosive_kill(var0) {
  var1 = undefined;

  if(issameweapon(var0)) {
    var1 = var0.basename;
  } else {
    var1 = var0;
  }

  switch (var1) {
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

function get_weapon_level(var0) {
  if(!isPlayer(self)) {
    return int(1);
  }

  var1 = undefined;

  if(issameweapon(var0)) {
    var1 = var0.basename;
  } else {
    var1 = var0;
  }

  if(isDefined(self.pap[var1])) {
    return self.pap[var1].lvl;
  }

  var2 = scripts\cp\utility::getrawbaseweaponname(var1);

  if(isDefined(self.pap[var2])) {
    return self.pap[var2].lvl;
  }

  return int(1);
}

function can_upgrade(var0, var1) {
  if(!isDefined(level.pap)) {
    return 0;
  }

  if(isDefined(level.max_pap_func)) {
    return [[level.max_pap_func]](var0, var1);
  }

  if(isDefined(var0)) {
    var2 = scripts\cp\utility::getrawbaseweaponname(var0);
  } else {
    return 0;
  }

  if(!isDefined(var2)) {
    return 0;
  }

  if(!isDefined(level.pap[var2])) {
    var3 = getsubstr(var2, 0, var2.size - 1);

    if(!isDefined(level.pap[var3])) {
      return 0;
    }
  }

  if(istrue(var1) && isDefined(self.pap[var2]) && self.pap[var2].lvl <= min(level.pap_max + 1, 2)) {
    return 1;
  }

  if(isDefined(self.pap[var2]) && self.pap[var2].lvl >= level.pap_max) {
    return 0;
  }

  return 1;
}

function get_pap_camo(var0, var1, var2) {
  var3 = undefined;

  if(isDefined(var1)) {
    if(isDefined(level.no_pap_camos) && scripts\engine\utility::array_contains(level.no_pap_camos, var1)) {
      var3 = undefined;
    } else if(isDefined(level.pap_1_camo) && isDefined(var0) && var0 == 2) {
      var3 = level.pap_1_camo;
    } else if(isDefined(level.pap_2_camo) && isDefined(var0) && var0 == 3) {
      var3 = level.pap_2_camo;
    }

    switch (var1) {
      case "dischord":
        var2 = "iw7_dischord_zm_pap1";
        var3 = "camo20";
        break;
      case "facemelter":
        var2 = "iw7_facemelter_zm_pap1";
        var3 = "camo22";
        break;
      case "headcutter":
        var2 = "iw7_headcutter_zm_pap1";
        var3 = "camo21";
        break;
      case "forgefreeze":
        if(var0 == 2) {
          var2 = "iw7_forgefreeze_zm_pap1";
        } else if(var0 == 3) {
          var2 = "iw7_forgefreeze_zm_pap2";
        }

        var4 = 1;
        break;
      case "axe":
        if(var0 == 2) {
          var2 = "iw7_axe_zm_pap1";
        } else if(var0 == 3) {
          var2 = "iw7_axe_zm_pap2";
        }

        var4 = 1;
        break;
      case "shredder":
        var2 = "iw7_shredder_zm_pap1";
        var3 = "camo23";
        break;
    }
  }

  return var3;
}

function validate_current_weapon(var0, var1, var2) {
  if(isDefined(level.weapon_upgrade_path) && isDefined(level.weapon_upgrade_path[getweaponbasename(var2)])) {
    var2 = level.weapon_upgrade_path[getweaponbasename(var2)];
  } else if(isDefined(var1)) {
    switch (var1) {
      case "two":
        if(var0 == 2) {
          var2 = "iw7_two_headed_axe_mp";
        } else if(var0 == 3) {
          var2 = "iw7_two_headed_axe_mp";
        }

        break;
      case "golf":
        if(var0 == 2) {
          var2 = "iw7_golf_club_mp";
        } else if(var0 == 3) {
          var2 = "iw7_golf_club_mp";
        }

        break;
      case "machete":
        if(var0 == 2) {
          var2 = "iw7_machete_mp";
        } else if(var0 == 3) {
          var2 = "iw7_machete_mp";
        }

        break;
      case "spiked":
        if(var0 == 2) {
          var2 = "iw7_spiked_bat_mp";
        } else if(var0 == 3) {
          var2 = "iw7_spiked_bat_mp";
        }

        break;
      case "axe":
        if(var0 == 2) {
          var2 = "iw7_axe_zm_pap1";
        } else if(var0 == 3) {
          var2 = "iw7_axe_zm_pap2";
        }

        break;
      case "katana":
        if(var0 == 2) {
          var2 = "iw7_katana_zm_pap1";
        } else if(var0 == 3) {
          var2 = "iw7_katana_zm_pap2";
        }

        break;
      case "nunchucks":
        if(var0 == 2) {
          var2 = "iw7_nunchucks_zm_pap1";
        } else if(var0 == 3) {
          var2 = "iw7_nunchucks_zm_pap2";
        }

        break;
      default:
        return var2;
    }
  }

  return var2;
}

function watchplayermelee() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  level endon("game_ended");

  for(;;) {
    self waittill("melee_fired", var0);
    var1 = var0.basename;

    if(self.meleekill == 0) {
      if(var1 == "iw7_fists_zm_crane" || var1 == "iw7_fists_zm_dragon" || var1 == "iw7_fists_zm_snake" || var1 == "iw7_fists_zm_tiger") {
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

    if(issubstr(var1, "katana") && self.vo_prefix == "p5_") {
      thread scripts\cp\cp_vo::try_to_play_vo("melee_special_katana", "rave_comment_vo", "high", 1, 0, 0, 1);
      continue;
    }

    if((issubstr(var1, "golf") || issubstr(var1, "machete") || issubstr(var1, "spiked_bat") || issubstr(var1, "two_headed_axe")) && self.meleekill == 1) {
      thread scripts\cp\cp_vo::try_to_play_vo("melee_special", "rave_comment_vo", "high", 1, 0, 0, 1);
      continue;
    }

    if(issubstr(var1, "iw7_knife") && scripts\cp\utility::is_melee_weapon(var1) && self.meleekill == 1) {
      thread scripts\cp\cp_vo::try_to_play_vo("melee_fatal", "zmb_comment_vo", "high", 1, 0, 0, 1);
      self.meleekill = 0;
      continue;
    }

    if((var1 == "iw7_axe_zm" || var1 == "iw7_axe_zm_pap1" || var1 == "iw7_axe_zm_pap2") && scripts\cp\utility::is_melee_weapon(var1) && self.meleekill == 1) {
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
    var0 = self getcurrentweapon();

    if(!isDefined(var0) || nullweapon(var0)) {
      continue;
    }

    self waittill("fired", var0);
    var0 = self getcurrentweapon();
    var1 = self getammocount(var0);
    var2 = weaponclipsize(var0);

    if(var2 == 0) {
      continue;
    }

    var3 = var1 / var2;

    if(scripts\cp\utility::is_melee_weapon(var0) || issubstr(var0.basename, "fists") || issubstr(var0.basename, "heart")) {
      continue;
    }

    if(var1 <= 5 && var1 > 0 && self getweaponammostock(var0) == 0 || self getweaponammostock(var0) > 0 && var1 / self getweaponammostock(var0) < 0.1) {} else if(var1 == 0 && var0.basename != "iw7_cpbasketball_mp" && !nullweapon(var0)) {
      scripts\cp\cp_vo::try_to_play_vo("nag_out_ammo", "zmb_comment_vo", "low", 3, 0, 0, 0, 20);
    }

    if(var0.basename == "ac130_105mm_mp" || var0.basename == "ac130_40mm_mp" || var0.basename == "ac130_25mm_mp") {}
  }
}

function getitemweaponname() {
  var0 = self.classname;
  var1 = getsubstr(var0, 7);
  return var1;
}

function watchweaponpickup(var0) {
  self endon("death");
  var1 = getitemweaponname();

  for(;;) {
    self waittill("trigger", var2, var3);
    var4 = var2 getcurrentweapon();
    thread watchpickupcomplete(var2, var1);
    var2 notify("weapon_pickup", var1);
    var5 = fixupplayerweapons(var2, var1);
  }

  LOC_00000056:
    if(isDefined(var3)) {
      var2 notify("manual_switch_from_minigun");
      var6 = getitemweaponname(var3);
      var7 = asmdevgetallstates(var6);

      if(isDefined(var2.tookweaponfrom[var6])) {
        var3.owner = var2.tookweaponfrom[var6];
        var2.tookweaponfrom[var6] = undefined;
      }

      var3.objweapon = var7.basename;
      var3.targetname = "dropped_weapon";
      thread watchweaponpickup();
    }

  var2.tookweaponfrom[var1] = self.owner;
}

function fixupplayerweapons(var0, var1) {
  var2 = var0 getweaponslistprimaries();
  var3 = 1;
  var4 = 1;
  var5 = undefined;

  if(issameweapon(var1)) {
    var5 = createheadicon(var1);
  } else {
    var5 = var1;
  }

  foreach(var7 in var2) {
    if(isDefined(var0.primaryweaponobj) && var0.primaryweaponobj == var7) {
      var3 = 0;
      continue;
    }

    if(isDefined(var0.secondaryweaponobj) && var0.secondaryweaponobj == var7) {
      var4 = 0;
    }
  }

  if(var3) {
    var0.primaryweapon = var5;
    var0.primaryweaponobj = asmdevgetallstates(var5);
  } else if(var4) {
    var0.secondaryweapon = var5;
    var0.secondaryweaponobj = asmdevgetallstates(var5);
  }

  return var3 || var4;
}

function watchpickupcomplete(var0, var1) {
  self endon("death");
  self endon("disconnect");
  self notify("watchPickupComplete()");
  self endon("watchPickupComplete()");
  var2 = self.currentweapon;
  var3 = 0;

  if(isstring(var0)) {
    var0 = asmdevgetallstates(var0);
  }

  jumpiffalse(var2 == var0) LOC_00000046;
  var3 = 1;
  goto LOC_0000007c;
}

function notifyuiofpickedupweapon() {
  self setclientomnvar("ui_weapon_pickup", 0);
}

function watchweaponusage(var0) {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  level endon("game_ended");
  self notify("watchWeaponUsage");
  self endon("watchWeaponUsage");

  for(;;) {
    self waittill("weapon_fired", var1);
    var2 = self getcurrentweapon();

    if(!isDefined(var2) || nullweapon(var2)) {
      continue;
    }

    if(!scripts\cp\utility::isinventoryprimaryweapon(var2)) {
      continue;
    }

    if(isDefined(level.updateonusepassivesfunc)) {
      GscBinSkip1(0x74, level.updateonusepassivesfunc, self, createheadicon(var2));
    }

    var3 = gettime();

    if(!isDefined(self.lastshotfiredtime)) {
      self.lastshotfiredtime = 0;
    }

    var4 = gettime() - self.lastshotfiredtime;
    self.lastshotfiredtime = var3;

    if(isai(self)) {
      continue;
    }

    var5 = getweaponbasename(var2);

    if(!isDefined(self.shotsfiredwithweapon[var5])) {
      self.shotsfiredwithweapon[var5] = 1;
    } else {
      self.shotsfiredwithweapon[var5]++;
    }

    if(!isDefined(self.accuracy_shots_fired)) {
      self.accuracy_shots_fired = 1;
    } else {
      self.accuracy_shots_fired++;
    }

    scripts\cp\cp_persistence::increment_player_career_shots_fired(self);

    if(isDefined(var5)) {
      if(isDefined(self.hitsthismag[var5])) {
        thread hitsthismag_update(var5, var2);
      }
    }
  }
}

function hitsthismag_update(var0, var1) {
  self endon("death");
  self endon("disconnect");
  var0 = var1.basename;
  self endon("updateMagShots_" + var0);
  self.hitsthismag[var0]--;
  wait 0.1;
  self notify("shot_missed", var1);
  self.consecutivehitsperweapon[var0] = 0;
  self.hitsthismag[var0] = weaponclipsize(var1);
}

function watchweaponchange() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  self notify("watchWeaponChange");
  self endon("watchWeaponChange");
  self.hitsthismag = [];
  var0 = getweaponbasename(self getcurrentweapon());
  hitsthismag_init(var0);

  for(;;) {
    self waittill("weapon_change", var1);
    var0 = var1.basename;
    weapontracking_init(var0);

    if(isDefined(self.weapon_passives[var1.basename])) {}

    hitsthismag_init(var0);
  }
}

function harpoon_impale_additional_func(var0, var1, var2, var3, var4, var5, var6, var7) {
  if(!issubstr(var0, "harpoon")) {
    return;
  }

  var2 startragdoll();
  var8 = physics_createcontents(["physicscontents_solid", "physicscontents_glass", "physicscontents_missileclip", "physicscontents_vehicle"]);
  var9 = var3 + var4 * 4096;
  var10 = scripts\engine\trace::ray_trace_detail(var3, var9, undefined, var8, undefined, 1);
  var9 = var10["position"] - var4 * 12;
  var11 = length(var9 - var3);
  var12 = var11 / 1250;
  var12 = clamp(var12, 0.05, 1);
  wait 0.05;
  var13 = var4;
  var14 = anglestoup(var1.angles);
  var15 = vectorcross(var13, var14);
  var16 = scripts\engine\utility::spawn_tag_origin(var3, axistoangles(var13, var15, var14));
  var16 moveTo(var9, var12);
  var17 = spawnragdollconstraint(var2, var5, var6, var7);
  var17.origin = var16.origin;
  var17.angles = var16.angles;
  var17 linkTo(var16);
  thread play_explosion_post_impale(var9, var1);
  thread impale_cleanup(var2, var16, var12 + 0.05, var17);
}

function impale_cleanup(var0, var1, var2, var3) {
  var0 scripts\engine\utility::ref_143ba(var2, "death", "disconnect");
  var3 delete();
  var1 delete();
}

function play_explosion_post_impale(var0, var1) {
  wait 2;
  var1 radiusdamage(var0, 500, 1000, 500, var1, "MOD_EXPLOSIVE");
  playFX(level._effect["penetration_railgun_explosion"], var0);
}

function weapontracking_init(var0) {
  if(!isDefined(var0) || var0 == "none") {
    return;
  }

  if(!isDefined(self.shotsfiredwithweapon[var0])) {
    self.shotsfiredwithweapon[var0] = 0;
  }

  if(!isDefined(self.shotsontargetwithweapon[var0])) {
    self.shotsontargetwithweapon[var0] = 0;
  }

  if(!isDefined(self.headshots[var0])) {
    self.headshots[var0] = 0;
  }

  if(!isDefined(self.wavesheldwithweapon[var0])) {
    self.wavesheldwithweapon[var0] = 1;
  }

  if(!isDefined(self.downsperweaponlog[var0])) {
    self.downsperweaponlog[var0] = 0;
  }

  if(!isDefined(self.killsperweaponlog[var0])) {
    self.killsperweaponlog[var0] = 0;
    return;
  }
}

function hitsthismag_init(var0) {
  if(!isDefined(var0) || var0 == "none") {
    return;
  }

  if(scripts\cp\utility::isinventoryprimaryweapon(var0) && !isDefined(self.hitsthismag[var0])) {
    self.hitsthismag[var0] = weaponclipsize(var0);
    return;
  }
}

function addattachmenttoweapon(var0, var1, var2) {
  var3 = self.currentweapon;
  var4 = var3;
  var0 = undefined;
  var5 = scripts\cp\utility::attachmentmap_tounique(var1, var4);
  var6 = 0;

  if(var3.attachments.size == 0) {
    if(var4 canuseattachment(var5)) {
      var6 = 1;
    } else {
      var6 = 0;
    }
  } else {
    for(var7 = 0; var7 < var3.attachments.size; var7++) {
      if(var4 canuseattachment(var5) && attachmentsconflict(var3.attachments[var7], var5, var4) == "") {
        var6 = 1;
        continue;
      }

      var6 = 0;
      break;
    }
  }

  if(var6) {
    var0 = var4 withattachment(var5);
  }

  if(!isDefined(var0)) {
    if(isbot(self)) {}

    return undefined;
  }

  var8 = self getweaponammoclip(var0);
  var9 = self getweaponammostock(var0);

  if(istrue(var2)) {
    var8 = weaponclipsize(var0);
    var9 = weaponmaxammo(var0);
  }

  scripts\cp_mp\utility\inventory_utility::_takeweapon(var3);
  self giveweapon(var0);
  self setweaponammoclip(var0, var8);
  self setweaponammostock(var0, var9);
  scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate(var0);
  fixupplayerweapons(self, var0);
  return var0;
}

function player_has_silencer(var0) {
  if(!isDefined(var0)) {
    var0 = self getcurrentweapon();
  }

  return var0 hasattachment("silenc", 1);
}

function _buildweaponcustom(var0, var1, var2, var3, var4, var5, var6, var7, var8) {
  var9 = var0;
  var10 = strtok(var9, "_");
  var11 = 0;

  if(var10[0] == "alt") {
    var11++;
  }

  if(var10[var11] == "iw7") {
    return;
  }

  if(var10[var11] == "iw8") {
    var12 = var0;

    if(!isDefined(var1)) {
      var1 = [];
    }

    if(!isDefined(var2)) {
      var2 = "none";
    }

    if(!isDefined(var3)) {
      var3 = "none";
    }

    if(!isDefined(var4)) {
      var4 = -1;
    }

    if(!isDefined(var5)) {
      var5 = [];
    }

    if(!isDefined(var6)) {
      var6 = "none";
    }

    if(!isDefined(var7)) {
      var7 = [];
    }

    if(!isDefined(var8)) {
      var8 = 0;
    }

    if(!isPlayer(self)) {
      return buildweapon(var12, var1, var2, var3, var4, var5, var6, var7, var8);
    }

    return buildweapon(var12, var1, var2, var3, var4, var5, var6, var7, var8);
  }
}

function weaponsupportslaserir(var0) {
  switch (var0) {
    case "iw8_la_juliet_mp":
    case "iw8_lm_dblmg_mp":
    case "iw8_me_riotshield_mp":
    case "iw8_fists_mp":
    case "iw8_knife_mp":
      return false;
  }

  if(scripts\cp\utility::iskillstreakweapon(var0)) {
    return false;
  }

  var1 = weaponclass(var0);
  return var1 == "rifle" || var1 == "mg" || var1 == "sniper" || var1 == "smg" || var1 == "spread";
}

function checkforinvalidattachments(var0, var1) {
  var2 = getcompleteweaponname(var1);
  var3 = [];

  foreach(var5 in var0) {
    if(var2 canuseattachment(var5)) {
      var3 = var5;
      continue;
    }

    thread invalidattachmentwarning(var5, var1);
  }

  return var3;
}

function invalidattachmentwarning(var0, var1) {
  var2 = "Invalid Attachment: " + var0 + " on " + var1;

  if(isDefined(self) && isPlayer(self)) {
    if(getdvarint("scr_playtest", 0) == 1) {
      self iprintlnbold(var2);
    }
  }
}

function doesweaponhaveattachmenttype(var0, var1, var2) {
  var3 = [];

  if(istrue(var2)) {
    var3 = var0.others;
  } else {
    var3 = var0.attachments;
  }

  if(hasattachmenttype(var3, var1)) {
    return 1;
  }

  return 0;
}

function hasattachmenttype(var0, var1) {
  foreach(var3 in var0) {
    if(scripts\cp\utility::attachmentmap_tobase(var3) == var1) {
      return true;
    }
  }

  return false;
}

function hasscope(var0) {
  foreach(var2 in var0) {
    if(scripts\cp\utility::getattachmenttype(var2) == "rail") {
      return true;
    }
  }

  return false;
}

function getreticleindex(var0) {
  if(!isDefined(var0)) {
    return undefined;
  }

  var1 = int(tablelookup("mp/reticleTable.csv", 1, var0, 5));

  if(!isDefined(var1) || var1 == 0) {
    return undefined;
  }

  return var1;
}

function buildweaponuniqueattachments(var0, var1, var2) {
  if(isDefined(var2) && var2 < 0) {
    var2 = undefined;
  }

  var1 = scripts\cp\utility::weaponattachremoveextraattachments(var1, var0);
  var1 = scripts\engine\utility::array_remove(var1, "none");
  var3 = scripts\cp\utility::weaponattachdefaultmap(var0);
  var4 = scripts\cp\utility::buildweaponassetname(var0, var2);
  var5 = var1;

  for(var6 = 0; var6 < var5.size; var6++) {
    var5 = scripts\cp\utility::attachmentmap_tobase(var5[var6]);
  }

  if(isDefined(var3)) {
    var7 = var3;
    var6 = 0;

    if(var6 < var7.size) {
      GscBinSkip0(0x2e, var6, scripts\cp\utility::attachmentmap_tobase(var7[var6]));
    }

    var5 = scripts\engine\utility::array_combine_unique(var5, var7);
  }

  var8 = [];

  if(var5.size > 0) {
    var5 = scripts\cp\utility::filterattachments(var5);

    for(var9 = 0; var9 < var5.size; var9++) {
      var8 = scripts\cp\utility::attachmentmap_tounique(var5[var9], var4);
    }
  }

  var10 = [];

  foreach(var12 in var8) {
    var13 = scripts\cp\utility::attachmentmap_toextra(var12);

    if(isDefined(var13)) {
      var10 = scripts\cp\utility::attachmentmap_tounique(var13, var4);
    }
  }

  if(var10.size > 0) {
    var8 = scripts\engine\utility::array_combine_unique(var8, var10);
  }

  if(isDefined(var2)) {
    var15 = scripts\cp\utility::getweaponvariantattachments(var4, var2);

    foreach(var17 in var15) {
      var8 = var17;
    }
  }

  var19 = undefined;
  return var8;
}

function applyflashfromdamage(var0, var1, var2, var3) {
  var0 endon("death");

  if(isDefined(var0.usingremote)) {
    return false;
  }

  if(isDefined(var0.vehicle)) {
    return false;
  }

  if(!var0 scripts\cp_mp\utility\player_utility::_isalive()) {
    return false;
  }

  if(scripts\cp\utility::is_friendly_damage(var0, var1) && var0 != var1) {
    return false;
  }

  var4 = distance(var2, var0.origin);
  var5 = 0;

  if(var1 == var0) {
    if(var4 > 384) {
      return false;
    } else {
      var5 = 1;
    }
  }

  var6 = 0;
  var7 = 0;

  if(var4 >= 512 || !scripts\engine\utility::within_fov(var1.origin, var1 getplayerangles(), var2, 0.5)) {
    var6 = 3;
    var7 = 0.25;
  } else if(var4 <= 256) {
    var6 = 5;
    var7 = 0.75;
  } else {
    var8 = 1 - (var4 - 256) / 256;
    var6 = 3 + var8 * 2;
    var7 = 0.25 + var8 * 0.5;
  }

  if(var3) {
    var0 = var1;
    var6 = max(3, var6 * 0.75);
    var7 = max(0.25, var7 * 0.75);
  } else if(var5) {
    var6 = max(3, var6 * 0.75);
    var7 = max(0.25, var7 * 0.75);
  }

  if(isPlayer(var0)) {
    var0 shellshock("flashbang_mp", var6);
    var0.flashendtime = gettime() + var6 * 1000;
    thread flashrumbleloop(var0);
  } else if(var0 scripts\cp\utility::is_zombie_agent() || var0.agent_type == "soldier_agent" || var0.unittype == "soldier") {
    stunenemiesinrange(var2, var1);
  } else {
    var0 shellshock("flashbang_mp", var6);
    var0.flashendtime = gettime() + var6 * 1000;
    thread flashrumbleloop(var0);
  }

  return true;
}

function isflashgrenadedamage(var0, var1) {
  return var0.basename == "flash_grenade_mp" && var1 != "MOD_IMPACT";
}

function flashrumbleloop(var0) {
  self endon("stop_monitoring_flash");
  self endon("flash_rumble_loop");
  self notify("flash_rumble_loop");
  var1 = gettime() + var0 * 1000;

  while(gettime() < var1) {
    self playRumbleOnEntity("damage_heavy");
    wait 0.05;
  }
}

function giveequipmentasaweapon(var0) {
  switch (var0) {
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
    var0 = getweaponarray();

    foreach(var2 in var0) {
      var2 setusepriority(1, 1);
    }
  }
}

function drop_script_weapon_from_ai(var0, var1) {
  var2 = var0.basename;

  if(scripts\engine\utility::array_contains(level.invalid_drop_weapons, var2)) {
    return;
  }

  var3 = var0.attachments;
  var4 = getDvar("scr_weapdrop_force_att", "");

  if(var4 != "") {
    var3 = scripts\engine\utility::array_add(var3, var4);
  }

  if(ref_124ae()) {
    var5 = 1;
  } else {
    var5 = undefined;
  }

  var6 = spawn_script_weapon(var3, var4, self.origin + (0, 0, 32), self.angles, var5);

  if(!isDefined(var6)) {
    return;
  }

  var7 = getweapongroup(var1);
  scripts\cp_mp\utility\weapon_utility::dropweaponfordeathlaunch(var6, var7);

  if(!isDefined(var6)) {
    return;
  }

  update_dropped_weapon_priorities(var6);
  var8 = getsubstr(var6.classname, 7, var6.classname.size);
  var6 scripts\anim\shared::setscriptammo(var8, self);
  thread delete_weapon_after_time();
  thread watchweaponpickup();
}

function ref_124ae() {
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
    var0 = level.custom_allowedweaponnames;
  } else {
    var0 = ["iw8_ar_falpha", "iw8_sm_papa90", "iw8_sm_augolf", "iw8_lm_pkilo", "iw8_sn_alpha50", "iw8_pi_mike1911", "iw8_ar_mike4", "iw8_ar_akilo47", "iw8_sm_mpapa5", "iw8_sh_dpapa12", "iw8_lm_kilo121", "iw8_sn_mike14", "iw8_sn_kilo98", "iw8_pi_golf21", "iw8_sn_crossbow"];
  }

  var1 = scripts\engine\utility::getStructArray("weapon_pickup", "script_noteworthy");

  foreach(var3 in var1) {
    if(isDefined(var3.script_parameters)) {
      var4 = getcompletenameforweapon(var3.script_parameters + "_mp");
      var5 = spawn("weapon_" + var4, var3.origin);
      var5 itemweaponsetammo(weaponclipsize(var4), weaponmaxammo(var4));
      thread watchweaponpickup();
      var1 = scripts\engine\utility::array_remove(var1, var3);
    }
  }

  var7 = [];
  var8 = [];

  foreach(var14, var10 in level.weaponmapdata) {
    foreach(var4 in var0) {
      if(var14 == var4) {
        var12 = strtok(var14, "_");

        if(var12[0] == "iw8") {
          var7 = var14;
          level.attachmentmap[var14] = pullattachmentsforweapon(var14);
        }
      }
    }
  }

  var7 = eliminatenullweapons(var7);
  var15 = 0;
  var16 = 0;
  var17 = var1.size;

  while(var16 < var17) {
    var15 = randomintrange(0, var7.size);
    var18 = attachmentroll(var7[var15]);

    foreach(var20 in var18) {
      foreach(var22 in var18) {
        if(!attachmentscompatible(var20, var22)) {
          var18 = scripts\engine\utility::array_remove(var18, var22);
          LOC_00000213:
        }
        LOC_00000213:
      }
    }

    var4 = getcompletenameforweapon(var7[var15]);
    var5 = spawn("weapon_" + var4, var1[var16].origin);

    if(isDefined(var1[var16].angles)) {
      var5.angles = var1[var16].angles;
    } else {
      var5.angles = (0, 0, 0);
    }

    var5 itemweaponsetammo(weaponclipsize(var4), weaponmaxammo(var4));
    thread watchweaponpickup();
    var16++;
  }
}

function attachmentroll(var0) {
  var1 = [];

  if(isDefined(level.attachmentmap[var0])) {
    var2 = scripts\engine\utility::array_randomize(level.attachmentmap[var0]);
    var3 = attachmentrollcount();

    for(var4 = 0; var4 < var3 && var4 < var2.size; var4++) {
      var1 = var2[var4];
    }
  }

  return var1;
}

function attachmentrollcount() {
  var0 = randomint(100);

  if(var0 < 50) {
    return 0;
  } else if(var0 < 80) {
    return 1;
  } else if(var0 < 95) {
    return 2;
  } else if(var0 < 100) {
    return 3;
  }

  return 0;
}

function pullattachmentsforweapon(var0) {
  foreach(var2 in level.attachmentmap_basetounique) {
    if(var0 == var3) {
      return returnarraywithoutdefaults(var2, var0);
    }
  }
}

function returnarraywithoutdefaults(var0, var1) {
  foreach(var3 in level.weaponmapdata) {
    if(var1 == var4) {
      if(scripts\engine\utility::array_contains(var0, "doubletap")) {
        var0 = scripts\engine\utility::array_remove(var0, "doubletap");
      }

      if(scripts\engine\utility::array_contains(var0, "reconsilencer_cp")) {
        var0 = scripts\engine\utility::array_remove(var0, "reconsilencer_cp");
      }

      if(isDefined(var3.attachdefaults)) {
        return scripts\engine\utility::array_remove_array(var0, var3.attachdefaults);
      }
    }
  }
}

function eliminatenullweapons(var0) {
  var1 = ["iw8_knife", "iw8_fists", "iw8_knifestab", "none", "speciality_null", "iw8_ar_dummycp", "iw8_ar_dummycs", "iw8_me_riotshield"];
  var2 = [];

  if(isstruct(scripts\engine\utility::random(var0))) {
    foreach(var4 in var0) {
      if(!scripts\engine\utility::array_contains(var1, var5)) {
        var2 = var4;
      }
    }

    return var2;
  }

  return scripts\engine\utility::array_remove_array(var3, var4);
}

function choosepassive() {
  for(;;) {
    var0 = scripts\engine\utility::random(level.lootpassivesstructs);

    foreach(var2 in level.cp_weapon_passives) {
      if(var0.name == var3) {
        return var0;
      }
    }

    waitframe();
  }
}

function makeexplosiveunusuabletag() {
  self notify("makeExplosiveUnusable");
  self makeunusable();
}

function isplantedequipment(var0) {
  return isDefined(level.mines[var0 getentitynumber()]) || istrue(var0.planted);
}

function assignlootpassivetoweapon(var0, var1) {
  var2 = choosepassive();

  if(isDefined(var2.attachmentref)) {
    return getcompleteweaponname(var0, [var2.attachmentref]);
  }

  var3 = scripts\cp\utility::getweaponrootname(var0);
  var4 = getcompleteweaponname(var0);
  var1.weapon_passives[var3] = var2;
  return var4;
}

function grenadeinpullback() {
  return !nullweapon(self getheldoffhand());
}

function getgrenadeinpullback() {
  var0 = self getheldoffhand();

  if(isDefined(self.gestureweapon) && var0 == asmdevgetallstates(self.gestureweapon)) {
    var0 = isundefinedweapon();
  }

  return var0;
}

function grenadeinitialize(var0, var1, var2, var3) {
  if(!isDefined(var0.weapon_object)) {
    var0.weapon_object = var1;
  }

  if(!isDefined(var0.weapon_name)) {
    var0.weapon_name = var1.basename;
  }

  if(!isDefined(var0.owner)) {
    var0.owner = self;
  }

  if(!isDefined(var0.team)) {
    var0.team = self.team;
  }

  if(!isDefined(var0.tickpercent)) {
    var0.tickpercent = var2;
  }

  if(!isDefined(var0.ticks) && isDefined(var0.tickpercent)) {
    var0.ticks = scripts\cp\utility::roundup(4 * var2);
  }

  var4 = scripts\cp\cp_equipment::getequipmentreffromweapon(var1);

  if(isDefined(var4)) {
    var0.equipmentref = var4;
    var0.isequipment = 1;
  }

  var0.threwback = isDefined(var3);
}

function allow_weapon_first_raise_anims(var0, var1) {
  var2 = scripts\common\input_allow::allow_input_internal("firstRaiseAnims", var0, var1);

  if(isDefined(var2) && var2) {
    setsaveddvar("MRKKPQPTQR", 0);
    return;
  }

  if(isDefined(var2) && !var2) {
    setsaveddvar("MRKKPQPTQR", 1);
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
    self waittill("weapon_change", var0);
    self.lastweaponobj = var0;

    if(isnormallastweapon(var0)) {
      self.lastnormalweaponobj = var0;
    }

    if(isdroppableweapon(var0)) {
      self.lastdroppableweaponobj = var0;
    }

    if(iscacprimaryorsecondary(var0)) {
      self.lastcacweaponobj = var0;
    }
  }
}

function isnormallastweapon(var0) {
  if(var0.basename == "none") {
    return false;
  }

  if(var0.classname == "turret") {
    return false;
  }

  if(scripts\cp\utility::issuperweapon(var0.basename)) {
    return false;
  }

  if(scripts\cp\utility::iskillstreakweapon(var0.basename)) {
    return false;
  }

  if(var0.inventorytype != "primary" && var0.inventorytype != "altmode") {
    return false;
  }

  return true;
}

function iscacprimaryweapon(var0) {
  switch (getweapongroup(var0)) {
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

function getweapongroup(var0) {
  if(!isDefined(var0)) {
    return "other";
  }

  if(issameweapon(var0) && nullweapon(var0)) {
    return "other";
  }

  if(isstring(var0) && (var0 == "none" || var0 == "alt_none")) {
    return "other";
  }

  var1 = scripts\cp\utility::getweaponrootname(var0);
  var2 = scripts\cp\utility::weapongroupmap(var1);

  if(!isDefined(var2)) {
    if(scripts\cp\utility::issuperweapon(var0)) {
      var2 = "super";
    } else if(scripts\cp\utility::isenvironmentweapon(var0)) {
      var2 = "weapon_mg";
    } else if(scripts\cp\utility::iskillstreakweapon(var0)) {
      var2 = "killstreak";
    } else {
      var2 = "other";
    }
  }

  return var2;
}

function iscacsecondaryweapon(var0) {
  switch (getweapongroup(var0)) {
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

function iscacprimaryorsecondary(var0) {
  return iscacprimaryweapon(var0) || iscacsecondaryweapon(var0);
}

function iscacmeleeweapon(var0) {
  return getweapongroup(var0) == "weapon_melee";
}

function isdroppableweapon(var0) {
  if(var0.basename == "none") {
    return false;
  }

  if(isfistweapon(var0.basename)) {
    return false;
  }

  if(isDefined(self) && istrue(self.inlaststand)) {
    return false;
  }

  if(scripts\cp\utility::iskillstreakweapon(var0.basename)) {
    return false;
  }

  if(scripts\cp\utility::issuperweapon(var0.basename)) {
    return false;
  }

  if(var0.inventorytype != "primary") {
    return false;
  }

  if(var0.classname == "turret") {
    return false;
  }

  if(!iscacprimaryweapon(var0.basename) && !iscacsecondaryweapon(var0.basename)) {
    return false;
  }

  return true;
}

function gui_giveattachment() {
  var0 = getDvar("scr_giveattachment");

  if(isDefined(var0)) {
    foreach(var2 in level.players) {
      gui_giveattachment_internal(var2, var0);
    }
  }
}

function gui_giveattachment_internal(var0, var1) {
  var2 = var0.currentweapon;
  var0 dropitem(var2);
  var2 = var2 getnoaltweapon();
  var3 = scripts\cp\utility::getweaponattachmentsbasenames(var2);
  var4 = 0;

  if(scripts\engine\utility::array_contains(var3, var1)) {
    var4 = 1;
  } else {
    var5 = scripts\cp\utility::attachmentmap_tounique(var1, var2);

    if(!var2 canuseattachment(var5)) {
      if(!isbot(var0)) {
        var0 iprintlnbold("Invalid attachment for this weapon: " + var5);
      }

      var4 = 1;
    }
  }

  if(var4) {
    var0 giveweapon(var2);
    return;
  }

  var6 = var3;
  GscBinSkip0(0x2e, var6.size, var1);
}

function watchgunsmithdebugui() {
  for(;;) {
    level waittill("connected", var0);
    thread watchplayergunsmithdebugui();
  }
}

function watchplayergunsmithdebugui() {
  self endon("disconnect");

  for(;;) {
    self waittill("luinotifyserver", var0, var1);

    if(var0 == "debug_attach_select") {
      var2 = tablelookup("mp/attachmenttable.csv", 0, var1, 4);
      gui_giveattachment_internal(self, var2);
    }
  }
}

function create_weapon_pickups() {
  var0 = scripts\engine\utility::getStructArray("weapon_pickup", "targetname");

  for(var1 = 0; var1 < var0.size; var1++) {
    var2 = strtok(var0[var1].script_noteworthy, "+");
    var3 = var2[0];
    var4 = [];

    if(var2.size > 1) {
      var5 = strtok(var2[1], " ");

      for(var6 = 0; var6 < var5.size; var6++) {
        var4 = var5[var6];
      }
    }

    var3 = spawn_script_weapon(var3, var4, var0[var1].origin, var0[var1].angles);
  }
}

function spawn_script_weapon(var0, var1, var2, var3, var4) {
  if(!isDefined(var1)) {
    var1 = [];
  }

  if(!isarray(var1)) {
    var1 = [var1];
  }

  var5 = undefined;

  if(getdvarint("scr_ai_random_weap", 0) != 0) {
    var5 = buildweaponwithrandomattachments(var0, var1);
  } else {
    var5 = buildweapon(var0, var1, "none", "none", -1, undefined, undefined, undefined, var4);
  }

  var6 = createheadicon(var5);
  var7 = spawn("weapon_" + var6, var2);

  if(isDefined(var7)) {
    if(scripts\cp\utility::turn_off_sniper_laser()) {
      var7 itemweaponsetammo(weaponclipsize(var7), 0);
    } else {
      var7 itemweaponsetammo(weaponclipsize(var7), weaponclipsize(var7));
    }

    var7.angles = var3;
    add_to_weapon_array(var7);
    var7 thread scripts\engine\utility::thread_on_notify_no_endon_death("death", &remove_from_weapon_array);
  }

  return var7;
}

function add_to_weapon_array(var0) {
  level.dropped_weapons[level.dropped_weapons.size] = var0;
}

function remove_from_weapon_array(var0) {
  if(isDefined(var0)) {
    if(scripts\engine\utility::array_contains(level.dropped_weapons, var0)) {
      level.dropped_weapons = scripts\engine\utility::array_remove(level.dropped_weapons, var0);
      return;
    }

    return;
  }
}

function smokegrenadeused(var0) {
  thread scripts\cp\utility::notifyafterframeend("death", "end_explode");
  self endon("end_explode");
  var1 = self.owner.name;
  jumpiffalse(istrue(var0)) LOC_0000005a;
  self waittill("missile_stuck", var2, var3, var4, var5, var6, var7);
  thread ref_13426(var6);
  goto LOC_00000066;
}

function smokegrenadeexplode(var0, var1) {
  wait 1;
  var2 = scripts\cp\cp_outline_utility::addoutlineoccluder(var0, 330);
  var3 = spawn("script_model", var0);
  var3 show();
  var4 = getEnt("smoke_grenade_sight_clip_256", "targetname");

  if(isDefined(var4)) {
    level notify("grenade_exploded_during_stealth", var3, "smoke_grenade_mp", var1);
    var3 clonebrushmodeltoscriptmodel(var4);
    var3 setmovertransparentvolume();
  } else {
    var3 delete();
  }

  wait 8.25;

  if(isDefined(var3)) {
    var3 delete();
  }

  scripts\cp\cp_outline_utility::removeoutlineoccluder(var2);
}

function sfx_smoke_grenade_smoke(var0) {
  wait 0.2;
  var1 = spawn("script_origin", var0);
  var1 playLoopSound("smoke_grenade_smoke_lp");
  var1 scripts\cp_mp\ent_manager::registerspawncount(1);
  wait 5.25;
  thread scripts\engine\utility::play_sound_in_space("smoke_grenade_smoke_tail", var0);
  wait 0.3;
  var1 scripts\cp_mp\ent_manager::deregisterspawn();
  var1 stoploopsound();
  var1 delete();
}

function ref_13426(var0, var1) {
  playFX(scripts\engine\utility::getfx("glsmoke"), var0, anglestoup((0, 90, 0)));
}

function monitorsmokeactive() {
  self endon("disconnect");
  level endon("game_ended");
  self notify("monitorSmokeActive()");
  self endon("monitorSmokeActive()");
  scripts\cp\utility::printgameaction("smoke grenade activated", self);
  self.hasactivesmokegrenade = 1;
  var0 = scripts\engine\utility::ref_143b9(9.25, "death");
  self.hasactivesmokegrenade = 0;
  scripts\cp\utility::printgameaction("smoke grenade deactivated", self);
}

function buildweaponwithrandomattachments(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9) {
  var10 = scripts\cp\utility::getweaponrootname(var0);

  if(!isai(self)) {
    return;
  }

  return getweapon(var10, weaponclass(var0));
}

function getweapon(var0, var1) {
  var2 = [];

  if(isarray(var0)) {
    var2 = var0;
    var0 = var0[randomint(var0.size)];
  } else {
    var2 = [var0];
  }

  if(var0 == "iw8_lm_dblmg_mp") {}

  if(true) {
    return getweapon_aq(var1, var0, var2);
  }

  if(issubstr(tolower(self.classname), "_alq_")) {
    return getweapon_aq(var1, var0, var2);
  } else if(issubstr(tolower(self.classname), "_rus_desert_")) {
    return getweapon_ru(var1, var0, var2);
  } else if(issubstr(tolower(self.classname), "_spetsnaz_")) {
    return getweapon_ru(var1, var0, var2);
  } else if(issubstr(tolower(self.classname), "_hero_")) {
    return getweapon_hero(var0, var2);
  } else if(issubstr(tolower(self.classname), "_villain_")) {
    return getweapon_hero(var0, var2);
  } else if(issubstr(tolower(self.classname), "_sas_")) {
    return getweapon_sas(var1, var0, var2);
  } else if(issubstr(tolower(self.classname), "_reb_")) {
    return getweapon_reb(var1, var0, var2);
  } else if(issubstr(tolower(self.classname), "_so15_")) {
    return getweapon_so15(var1, var0, var2);
  } else if(issubstr(tolower(self.classname), "_london_police_")) {
    return getweapon_so15(var1, var0, var2);
  } else if(issubstr(tolower(self.classname), "_usmc_")) {
    return getweapon_usmc(var1, var0, var2);
  } else {
    return buildweapon(var0);
  }

  return var0;
}

function getweapon_hero(var0, var1) {
  if(issubstr(tolower(self.classname), "_hero_alex")) {
    switch (var0) {
      case "iw8_pi_mike1911":
        return make_weapon_special("alex_pistol");
      case "iw8_sn_mike14":
        return make_weapon_special("alex_sniper");
    }
  } else if(issubstr(tolower(self.classname), "_hero_hadir")) {
    switch (var0) {
      case "iw8_sm_augolf":
        return make_weapon_special("hadir_smg");
      case "iw8_sn_hdromeo":
        return make_weapon_special("hadir_sniper");
    }
  } else if(issubstr(tolower(self.classname), "_hero_kyle")) {
    switch (var0) {
      case "iw8_ar_mcharlie":
        return make_weapon_special("kyle_ar");
    }
  } else if(issubstr(tolower(self.classname), "_hero_price")) {
    switch (var0) {
      case "iw8_pi_papa320":
        return make_weapon_special("papa320_black");
      case "iw8_ar_kilo433":
        return make_weapon_special("price_ar");
    }
  } else if(issubstr(tolower(self.classname), "_hero_farah")) {
    switch (var0) {
      case "iw8_ar_akilo47":
        return make_weapon_special("farah_ar");
    }
  } else if(issubstr(tolower(self.classname), "_villain_barkov")) {
    switch (var0) {
      case "iw8_pi_golf21":
        return make_weapon_special("barkov_pistol");
    }
  }

  if(getdvarint("scr_randomweapon_debug")) {
    iprintln("not whitelisted!skipping scripted build.");
  }

  return make_weapon(var0, []);
}

function getweapon_aq(var0, var1, var2) {
  var3 = [];
  var4 = [];

  switch (var0) {
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

  return randomize_weapon(var1, var3, var4);
}

function getweapon_ru(var0, var1, var2) {
  var3 = [];
  var4 = [];

  switch (var0) {
    case "rifle":
      GscBinSkip1(0x45, "iw8_ar_akilo47", 70);

    case "dmr":
      switch (var1) {
        case "iw8_sn_mike14":
          var3 = [50, "snprscope_mike14"];
          var3 = [100, "laserads_bar"];
          break;
      }

      break;
    case "launcher":
      break;
    case "lmg":
      switch (var1) {
        case "iw8_lm_pkilo":
          var3 = [50, "bipod_pkilo"];
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
      switch (var1) {
        case "iw8_sn_delta":
          var3 = [100, "laserads_bar"];
          break;
      }

      break;
  }

  return randomize_weapon(var1, var3, var4);
}

function getweapon_reb(var0, var1, var2) {
  var3 = [];
  var4 = [];

  switch (var0) {
    case "rifle":
      GscBinSkip1(0x45, "iw8_ar_akilo47", 50);

    case "dmr":
      switch (var1) {
        case "iw8_sn_kilo98":
          var3 = [50, "snprscope_kilo98", "vzscope_kilo98"];
          var3 = [30, "xmags_kilo98"];
          var3 = [40, "laserads_bar"];
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
      switch (var1) {
        case "iw8_sh_romeo870":
          var3 = [100, "stockno_romeo870", "stockh_romeo870", "stockl_romeo870", "stocks_romeo870"];
          var3 = [50, "barshort_romeo870", "barlong_romeo870"];
          break;
      }

      break;
    case "smg":
      GscBinSkip1(0x45, "iw8_ar_akilo47", 70);

    case "sniper":
      switch (var1) {
        case "iw8_sn_alpha50":
          var3 = [100, "snprscope_alpha50", "vzscope_alpha50"];
          var3 = [50, "barmid_alpha50", "barshort_alpha50"];
          var3 = [100, "laserads"];
          var3 = [50, "stockl_alpha50", "stockh_alpha50", "stocks_alpha50"];
          var3 = [25, "bipodsnpr"];
          var3 = [35, "xmags_alpha50"];
          break;
      }

      break;
  }

  return randomize_weapon(var1, var3, var4);
}

function getweapon_sas(var0, var1, var2) {
  var3 = [];
  var4 = [];

  switch (var0) {
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

  return randomize_weapon(var1, var3, var4);
}

function getweapon_so15(var0, var1, var2) {
  var3 = [];
  var4 = [];

  switch (var0) {
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

  return randomize_weapon(var1, var3, var4);
}

function getweapon_usmc(var0, var1, var2) {
  var3 = [];
  var4 = [];

  switch (var0) {
    case "rifle":
      switch (var1) {
        case "iw8_ar_mike4":
          var3 = [85, "reflex_west01", "reflex_west02", "holo_west01", "acog_west01_irons", "minireddot"];
          var3 = [70, "stockl_mike4", "stocks_mike4", "back_mike4|1", "back_mike4|2"];
          var3 = [50, "xmags_mike4", "mag_mike4|1", "mag_mike4|2"];
          var3 = [50, "gripvert", "gripang", "gripvertpro", "gripangpro"];
          var3 = [70, "barshort_mike4", "front_mike4|2"];
          var3 = [15, "ub_mike203"];
          var3 = [65, "flashhider", "comp", "brake", "linearbrake", "laser", "laserir"];
          var3 = [50, "rec_mike4|1", "rec_mike4|2"];
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

  return randomize_weapon(var1, var3, var4);
}

function make_weapon_special(var0) {
  switch (var0) {
    case "farah_ar":
      var0 = make_weapon("iw8_ar_akilo47", ["rec_akilo47_mp|1", "back_akilo47|1", "front_akilo47|1", "mag_akilo47|1", "guard_akilo47|1"]);
      break;
    case "alex_sniper":
      var0 = make_weapon("iw8_sn_mike14", ["vzscope_mike14", "rec_mike14|1", "reargrip_mike14|1", "front_mike14|1", "mag_mike14|1"]);
      break;
    case "alex_pistol":
      var0 = make_weapon("iw8_pi_mike1911", ["rec_mike1911|2", "mag_mike1911|2", "slide_mike1911|2"]);
      break;
    case "hadir_smg":
      var0 = make_weapon("iw8_sm_augolf", ["rec_augolf|1", "front_augolf|1", "mag_augolf|1", "toprail_augolf|1"]);
      break;
    case "hadir_sniper":
      var0 = make_weapon("iw8_sn_hdromeo_ballistics", ["vzscope_hdromeo_ballistics", "bipod_hdromeo", "rec_hdromeo|1", "back_hdromeo|1", "front_hdromeo|1", "mag_hdromeo|1"]);
      break;
    case "sas_ar":
      var0 = make_weapon("iw8_ar_kilo433", ["holo_west01", "laserir", "rec_kilo433|1", "back_kilo433|1", "front_kilo433|1", "mag_kilo433|1"]);
      break;
    case "price_ar":
      var0 = make_weapon("iw8_ar_kilo433", ["hybrid_west01", "laserir", "rec_kilo433|1", "back_kilo433|1", "front_kilo433|1", "mag_kilo433|1"]);
      break;
    case "kyle_ar":
      var0 = make_weapon("iw8_ar_mcharlie", ["semi_ar", "reflex_west01", "silencer04", "laserir", "rec_mcharlie|1", "back_mcharlie|1", "front_mcharlie|1", "mag_mcharlie|1"]);
      break;
    case "papa320_black":
      var0 = make_weapon("iw8_pi_papa320", ["rec_papa320|2", "mag_papa320|2", "slide_papa320|2"]);
      break;
    case "papa320_black_rain":
      var0 = make_weapon("iw8_pi_papa320", ["rec_papa320_r", "mag_papa320_r", "slide_papa320_r"]);
      break;
    case "barkov_pistol":
      var0 = make_weapon("iw8_pi_golf21", ["rec_golf21|1", "mag_golf21|1", "slide_golf21|1"]);
      break;
    case "estate_teaser_price":
      var0 = make_weapon("iw8_ar_kilo433", ["hybrid_west01", "laserir", "silencer04", "rec_kilo433|1", "mag_kilo433|1", "stockh"]);
      break;
    case "estate_teaser":
      var0 = make_weapon("iw8_ar_kilo433", ["reflex_west01", "laserir", "silencer04", "rec_kilo433|1", "mag_kilo433|1", "stockh"]);
      break;
    default:
      var0 = undefined;
      break;
  }

  return var0;
}

function make_weapon(var0, var1, var2, var3, var4, var5) {
  if(!isDefined(level._weapons)) {
    level._weapons = spawnStruct();
  }

  if(!isDefined(var1)) {
    var1 = [];
  }

  if(!issameweapon(var0)) {
    var6 = strtok(var0, "+");

    if(var6.size > 1) {
      var0 = var6[0];
      var1 = scripts\engine\utility::array_combine(var1, scripts\engine\utility::array_remove(var6, var6[0]));
    }
  } else {
    if(nullweapon(var0)) {
      return var0;
    }

    var0 = getweaponbasename(var0);
  }

  if(istrue(var5)) {
    var7 = &makeweaponfromstring;
  } else {
    var7 = &getcompleteweaponname;
  }

  var8 = var1;

  if(issubstr(var1, "_mp")) {
    var8 = scripts\cp\utility::getweaponrootname(var1);
  }

  var9 = scripts\cp\utility::weaponattachdefaultmap(var8);
  var9 = removeconflictingattachments(var2, var9);
  var2 = scripts\engine\utility::array_combine(var2, var9);
  var10 = scripts\cp\utility::buildweaponassetname(var8, var5);
  var11 = [];

  foreach(var13 in var2) {
    if(issubstr(var13, "|")) {
      var2 = scripts\engine\utility::array_remove(var2, var13);
      var2 = strtok(var13, "|")[0];
      var11 = var13;
    }
  }

  var15 = buildweaponuniqueattachments(var8, var2, var5);
  var15 = checkforinvalidattachments(var15, var10);
  var2 = var15;

  if(isDefined(var5)) {
    var16 = builtin[[var7]](var10, var2, var3, var4, var5);
  } else if(isDefined(var5)) {
    var16 = builtin[[var8]](var11, var3, var4, var5);
  } else if(isDefined(var5)) {
    var16 = builtin[[var9]](var12, var4, var5);
  } else if(isDefined(var5)) {
    var16 = builtin[[var10]](var13, var5);
  } else {
    var16 = builtin[[var11]](var14);
  }

  foreach(var16 in var15) {
    var6 = strtok(var16, "|");
    var16 = var16 withattachment(var6[0], int(var6[1]));
  }

  return var16;
}

function removeconflictingattachments(var0, var1) {
  var1 = removeconflictingdefaultattachment(var0, var1, "bar", "front_");
  var1 = removeconflictingdefaultattachment(var0, var1, "barlong", "slide_");
  var1 = removeconflictingdefaultattachment(var0, var1, "barcust", "guard_");
  var1 = removeconflictingdefaultattachment(var0, var1, "stock", "back_");
  var1 = removeconflictingdefaultattachment(var0, var1, "cal", "mag_");
  var1 = removeconflictingdefaultattachment(var0, var1, "drums", "mag_");
  var1 = removeconflictingdefaultattachment(var0, var1, "xmags", "mag_");
  var1 = removeconflictingdefaultattachment(var0, var1, "rack", "mag_");
  var1 = removeconflictingdefaultattachment(var0, var1, "rack", "ammo_");
  var1 = removeconflictingdefaultattachment(var0, var1, "thermal", "scope");
  var1 = removeconflictingdefaultattachment(var0, var1, "acog", "scope");
  var1 = removeconflictingdefaultattachment(var0, var1, "reflex", "scope");
  var1 = removeconflictingdefaultattachment(var0, var1, "holo", "scope");
  var1 = removeconflictingdefaultattachment(var0, var1, "grip", "grip_");
  var1 = removeconflictingdefaultattachment(var0, var1, "rec_", "rec_");
  var1 = removeconflictingdefaultattachment(var0, var1, "toprail_", "toprail_");
  return var1;
}

function removeconflictingdefaultattachment(var0, var1, var2, var3) {
  var4 = undefined;

  foreach(var6 in var0) {
    if(issubstr(var6, var3)) {
      var4 = 1;
    }

    if(isstartstr(var6, var2) || istrue(var4)) {
      for(var7 = 0; var7 < var1.size; var7++) {
        if(issubstr(var1[var7], var3)) {
          var1 = scripts\engine\utility::array_remove_index(var1, var7);
          return var1;
        }
      }
    }
  }

  return var1;
}

function randomize_weapon(var0, var1, var2) {
  var3 = scripts\common\utility::get_random_attachments(var1, var2);
  var4 = make_weapon(var0, var3);
  return var4;
}

function getscriptedweapon(var0, var1) {
  if(!isDefined(var0)) {
    return isundefinedweapon();
  }

  if(!isarray(var0) && var0 == "") {
    return isundefinedweapon();
  }

  if(isDefined(var1) && var1 == "sidearm") {
    var2 = getweapon(var0, "pistol");
  } else {
    var2 = getweapon(var1, self.scriptedweaponclassprimary);
  }

  return var2;
}

function printweapon() {
  self notify("stop printWeapon");
  self endon("death");
  self endon("stop printWeapon");

  for(;;) {
    var0 = 72;

    if(isDefined(self) && isDefined(self.weapon)) {
      if(isDefined(self.weapon.basename)) {}

      if(isDefined(self.weapon.attachments)) {
        var1 = var0 - 1.5;

        foreach(var3 in self.weapon.attachments) {
          var1 -= 1.4;
        }
      }
    }

    waitframe();
  }
}

function create_weapon_in_script(var0, var1) {
  if(!isDefined(level.fnscriptedweaponassignment)) {
    self.usescriptedweapon = undefined;

    if(!isDefined(var0)) {
      var2 = isundefinedweapon();
    } else if(!isarray(var1) && var1 == "") {
      var2 = isundefinedweapon();
    } else if(isarray(var2)) {
      var2 = getcompleteweaponname(var2[randomint(var2.size)]);
    } else {
      var2 = getcompleteweaponname(var2);
    }

    if(!nullweapon(var2)) {
      self.scriptedweaponfailed = 1;

      if(isDefined(var2) && var2 == "sidearm") {
        self.scriptedweaponfailed_sidearmarray = var2;
      } else {
        self.scriptedweaponfailed_primaryarray = var2;
      }
    }

    return var2;
  }

  return [[level.fnscriptedweaponassignment]](var2, var2);
}

function buildweapon_variant(var0, var1, var2, var3, var4, var5, var6) {
  var7 = weaponattachcustomtoidmap(var0, var3);

  if(!isDefined(var7)) {
    var7 = [];
  }

  return buildweapon_attachmentidmap(var0, var7, "none", "none", var3, var4, var5, var6);
}

function buildweapon_attachmentidmap(var0, var1, var2, var3, var4, var5, var6, var7) {
  var8 = [];
  var9 = [];

  foreach(var11 in var1) {
    var8 = var12;
    var9 = var11;
  }

  return buildweapon(var0, var8, var2, var3, var4, var9, var5, var6, var7);
}

function buildweapon(var0, var1, var2, var3, var4, var5, var6, var7, var8) {
  if(var0 != "iw8_minigunksjugg_mp") {
    if(issubstr(var0, "_mp")) {
      var0 = scripts\cp\utility::getweaponrootname(var0);
    }
  }

  if(isDefined(var1)) {} else {
    var1 = [];
  }

  if(!isDefined(var2)) {
    var2 = "none";
  }

  if(isDefined(var4) && var4 < 0) {
    var4 = undefined;
  }

  var9 = scripts\cp\utility::buildweaponassetname(var0, var4);
  var10 = buildweaponattachmentidmap(var1, var5);

  if(istrue(var8)) {
    if(weaponsupportslaserir(var9)) {
      var11 = getweaponnvgattachment(var9);

      if(!scripts\engine\utility::array_contains(var1, var11)) {
        var1 = var11;

        if(var10.size > 0) {
          var10 = 0;
        }
      }
    }
  }

  var12 = buildweaponuniqueattachmenttoidmap(var0, var1, var4, var10);

  if(isDefined(var6) && var6 != "none") {
    GscBinSkip0(0x2e, var6, 0);
  }

  var12 = filterinvalidattachmentsfromidmap(var12, var9);
  var1 = [];
  var5 = [];

  foreach(var14 in var12) {
    var1 = var15;
    var5 = var14;
  }

  var16 = getcompleteweaponname(var9, [], undefined, var2, var4);

  for(var17 = 0; var17 < var1.size; var17++) {
    var16 = var16 withattachment(var1[var17], var5[var17]);
  }

  if(isDefined(var7)) {
    for(var17 = 0; var17 < var7.size; var17++) {
      if(!isDefined(var7[var17])) {
        continue;
      }

      var18 = var7[var17];

      if("i/" != getsubstr(var18, 0, 2)) {
        var18 = "i/" + var7[var17];
      }

      var16 = var16 setsticker(var17, var18);
    }
  }

  if(isDefined(var16.scope) && !isstartstr(var16.scope, "ironsdefault")) {
    var19 = getreticleindex(var3);

    if(isDefined(var19)) {
      var16 = var16 withreticle(var19);
    }
  }

  return var16;
}

function buildweaponattachmentidmap(var0, var1) {
  var2 = [];

  if(isDefined(var1)) {
    foreach(var4 in var0) {
      if(var5 < var1.size) {
        var2 = var1[var5];
        continue;
      }

      var2 = 0;
    }
  }

  return var2;
}

function buildweaponuniqueattachmenttoidmap(var0, var1, var2, var3) {
  if(isDefined(var2) && var2 < 0) {
    var2 = undefined;
  }

  if(!isDefined(var3)) {
    var3 = [];
  }

  var1 = scripts\engine\utility::array_remove(var1, "none");
  var3 = scripts\engine\utility::array_remove_key(var3, "none");

  if(var1.size > 0 && var3.size == 0) {
    foreach(var5 in var1) {
      var3 = 0;
    }
  }

  var7 = weaponattachdefaulttoidmap(var0, var2);
  var8 = scripts\cp\utility::buildweaponassetname(var0, var2);
  var9 = [];

  if(isDefined(var7)) {
    var9 = combinedefaultandcustomattachmentidmaps(var7, var3);
  }

  var10 = [];

  if(var9.size > 0) {
    var9 = filterattachmenttoidmap(var9, var0);

    foreach(var5, var12 in var9) {
      var13 = scripts\cp\utility::attachmentmap_tounique(var5, var8);
      var10 = var12;
    }
  }

  var14 = [];
  var15 = 0;
  var16 = undefined;

  foreach(var23, var12 in var10) {
    var18 = scripts\cp\utility::attachmentmap_toextra(var23);

    if(isDefined(var18)) {
      var19 = 0;

      if(isDefined(var2)) {
        var20 = scripts\cp\utility::attachmentmap_tobase(var18);
        var19 = attachmentmap_extratovariantid(var20, var0, var2);
      }

      var21 = scripts\cp\utility::attachmentmap_tounique(var18, var8);
      var14 = var19;
    }

    var22 = scripts\cp\utility::attachmentmap_tobase(var23);

    if(!isDefined(var16) && scripts\cp\utility::tv_station_fastrope_two_infil_rider_start_targetname(var22)) {
      var16 = var23;
    }

    if(!var15 && (scripts\cp\utility::useeventtype(var22) || scripts\cp\utility::useeventtimestamp(var23))) {
      var15 = 1;
    }
  }

  if(var14.size > 0) {
    var10 = scripts\engine\utility::array_combine_unique_keys(var10, var14);
  }

  if(isDefined(var16) && var15) {
    var16 = scripts\engine\utility::ter_op(var16 == "calsmg_mike4", "calsil_mike4smg", "calsil");
    var10 = 0;
  }

  return var10;
}

function combinedefaultandcustomattachmentidmaps(var0, var1) {
  var2 = [];

  foreach(var5, var4 in var0) {
    if(scripts\engine\utility::array_contains_key(var1, var5)) {
      continue;
    }

    var2 = var4;
  }

  foreach(var4 in var1) {
    var2 = var4;
  }

  return var2;
}

function useprophudserver(var0) {
  if(!issameweapon(var0)) {
    return 0;
  }

  switch (var0.basename) {
    case "iw8_sn_hdromeo_mp":
      if(var0 hasattachment("barmid", 1)) {
        return 1;
      } else {
        return 0;
      }

      break;
    case "iw8_ar_charlie_mp":
      if(var0 hasattachment("barsil", 1)) {
        return 1;
      } else {
        return 0;
      }

      break;
    case "iw8_ar_kilo433_mp":
      if(var0 hasattachment("barsil", 1)) {
        return 1;
      } else {
        return 0;
      }

      break;
    case "iw8_ar_mike4_mp":
      if(var0 hasattachment("barsil", 1)) {
        return 1;
      } else {
        return 0;
      }

      break;
    case "iw8_sm_mpapa5_mp":
      if(var0 hasattachment("barsil", 1)) {
        return 1;
      } else {
        return 0;
      }

      break;
    default:
      if(var0 hasattachment("barsil", 1)) {
        return 1;
      }

      return 0;
  }
}

function filterattachmenttoidmap(var0, var1) {
  var2 = [];
  var3 = [];

  foreach(var6, var5 in var0) {
    var3 = var6;
  }

  if(var3.size > 0) {
    for(var7 = 0; var7 < var3.size; var7++) {
      var6 = var3[var7];

      if(var6 == "none") {
        continue;
      }

      var8 = 1;

      for(var9 = 0; var9 < var2.size; var9++) {
        if(var6 == var2[var9]) {
          var8 = 0;
          break;
        }

        var10 = attachmentsconflict(var6, var2[var9], var1);

        if(var10 != "") {
          var8 = 0;
          var2 = scripts\engine\utility::array_remove_index(var2, var9);
          var11 = [];
          var11 = strtok(var10, " ");

          foreach(var13 in var11) {
            var3 = scripts\engine\utility::array_insert(var3, var13, var7 + 1 + var14);
          }

          break;
        }
      }

      if(var8) {
        var2 = var6;
      }
    }
  }

  var15 = [];

  foreach(var6 in var2) {
    var5 = scripts\engine\utility::ter_op(isDefined(var0[var6]), var0[var6], 0);
    var15 = var5;
  }

  return var15;
}

function filterinvalidattachmentsfromidmap(var0, var1) {
  var2 = getcompleteweaponname(var1);
  var3 = [];

  foreach(var6, var5 in var0) {
    if(var2 canuseattachment(var6)) {
      var3 = var5;
      continue;
    }

    thread invalidattachmentwarning(var6, var1);
  }

  return var3;
}

function attachmentscompatible(var0, var1) {
  if(scripts\cp\utility::attachmentiscosmetic(var0) && scripts\cp\utility::attachmentiscosmetic(var1)) {
    return 0;
  }

  var0 = scripts\cp\utility::attachmentmap_tobase(var0);
  var1 = scripts\cp\utility::attachmentmap_tobase(var1);
  var2 = 1;

  if(var0 == var1) {
    var2 = 0;
  } else if(isDefined(level.attachmentmap_conflicts)) {
    var3 = scripts\engine\utility::alphabetize([var0, var1]);
    var2 = !isDefined(level.attachmentmap_conflicts[var3[0] + "_" + var3[1]]);
  } else if(var0 != "none" && var1 != "none") {
    var4 = tablelookuprownum("mp/attachmentcombos.csv", 0, var1);

    if(tablelookup("mp/attachmentcombos.csv", 0, var0, var4) == "no") {
      var2 = 0;
    }
  }

  return var2;
}

function attachmentsconflict(var0, var1, var2) {
  if(scripts\cp\utility::attachmentiscosmetic(var0) && scripts\cp\utility::attachmentiscosmetic(var1)) {
    return var0;
  }

  var3 = undefined;

  if(issameweapon(var2)) {
    var3 = createheadicon(var2);
  } else {
    var3 = var2;
  }

  var4 = scripts\cp\utility::attachmentmap_tounique(var0, var3);
  var5 = scripts\cp\utility::attachmentmap_tounique(var1, var3);

  if(add_head_icon_on_allies(var4, var5)) {
    return var0;
  }

  if(add_head_icon_on_allies(var5, var4)) {
    return var0;
  }

  var0 = scripts\cp\utility::attachmentmap_tobase(var0);
  var1 = scripts\cp\utility::attachmentmap_tobase(var1);
  var6 = "";

  if(var0 == var1) {
    var6 = var0;
  } else if(isDefined(level.attachmentmap_conflicts)) {
    var7 = scripts\engine\utility::alphabetize([var0, var1]);
    var8 = var7[0] + "_" + var7[1];

    if(isDefined(level.attachmentmap_conflicts[var8])) {
      if(level.attachmentmap_conflicts[var8] == "no") {
        var6 = var0;
      } else {
        var6 = level.attachmentmap_conflicts[var8];
      }
    }
  }

  return var6;
}

function add_head_icon_on_allies(var0, var1) {
  var2 = carryitemomnvar(var0);
  var3 = carryiteminfo(var1);
  return isDefined(var2) && isDefined(var3) && var3 == var2;
}

function carryiteminfo(var0) {
  if(isDefined(level.carrier_remove_carriable_weapon[var0])) {
    return level.carrier_remove_carriable_weapon[var0];
  }

  return undefined;
}

function carryitemomnvar(var0) {
  if(isDefined(level.carryobjects_onjuggernaut[var0])) {
    return level.carryobjects_onjuggernaut[var0];
  }

  var1 = scripts\cp\utility::attachmentmap_tobase(var0);

  if(isDefined(level.carry_ref[var1])) {
    return level.carry_ref[var1];
  }

  return undefined;
}

function attachmentmap_extratovariantid(var0, var1, var2) {
  var3 = var1 + "|" + var2;

  if(isDefined(level.weaponlootmapdata[var3]) && isDefined(level.weaponlootmapdata[var3].attachextratoidmap) && isDefined(level.weaponlootmapdata[var3].attachextratoidmap[var0])) {
    return level.weaponlootmapdata[var3].attachextratoidmap[var0];
  }

  return 0;
}

function weaponattachdefaulttoidmap(var0, var1) {
  if(isDefined(var1)) {
    var2 = var0 + "|" + var1;

    if(isDefined(level.weaponlootmapdata[var2]) && isDefined(level.weaponlootmapdata[var2].attachdefaulttoidmap)) {
      return level.weaponlootmapdata[var2].attachdefaulttoidmap;
    }
  }

  if(isDefined(level.weaponmapdata[var0]) && isDefined(level.weaponmapdata[var0].attachdefaulttoidmap)) {
    return level.weaponmapdata[var0].attachdefaulttoidmap;
  }

  return undefined;
}

function getweaponnvgattachment(var0) {
  return "laserir";
}

function weaponattachcustomtoidmap(var0, var1) {
  if(isDefined(var1) && var1 >= 0) {
    var2 = var0 + "|" + var1;

    if(isDefined(level.weaponlootmapdata[var2]) && isDefined(level.weaponlootmapdata[var2].attachcustomtoidmap)) {
      return level.weaponlootmapdata[var2].attachcustomtoidmap;
    }
  }

  return undefined;
}

function buildweaponmap() {
  level.weaponmapdata = [];
  level.ref_14589 = [];
  var0 = tablelookupgetnumrows("mp/statstable.csv");

  for(var1 = 0; var1 < var0; var1++) {
    var2 = tablelookupbyrow("mp/statstable.csv", var1, 0);
    var3 = tablelookup("mp/statstable.csv", 0, var2, 4);

    if(var3 != "" && scripts\cp_mp\utility\weapon_utility::vehicle_ai_script_models(var3)) {
      level.weaponmapdata[var3] = spawnStruct();
      var4 = tablelookup("mp/statstable.csv", 0, var2, 0);

      if(var4 != "") {
        level.weaponmapdata[var3].number = var4;
      }

      var5 = tablelookup("mp/statstable.csv", 0, var2, 1);

      if(var5 != "") {
        level.weaponmapdata[var3].group = var5;
        var6 = tablelookup("mp/statstable.csv", 0, var2, 41);

        if(var6 != "") {
          var7 = int(var6);

          if(var7 > -1) {
            if(!isDefined(level.ref_14589[var5])) {
              level.ref_14589[var5] = [];
            }

            level.ref_14589[var5][level.ref_14589[var5].size] = var3;
          } else {
            level.weaponmapdata[var3].ref_13efc = 1;
          }
        }
      }

      var8 = tablelookup("mp/statstable.csv", 0, var2, 5);

      if(var8 != "") {
        level.weaponmapdata[var3].assetname = var8;
      }

      var9 = tablelookup("mp/statstable.csv", 0, var2, 44);

      if(var9 != "") {
        level.weaponmapdata[var3].perk = var9;
      }

      var10 = tablelookup("mp/statstable.csv", 0, var2, 9);
      var11 = parseattachdefaulttoidmap(var10);

      if(isDefined(var11)) {
        level.weaponmapdata[var3].attachdefaulttoidmap = var11;
      }

      var12 = tablelookup("mp/statstable.csv", 0, var2, 8);

      if(var12 != "") {
        var12 = float(var12);
        level.weaponmapdata[var3].speed = var12;
      }
    }
  }

  level.weaponlootmapdata = [];
  var1 = -1;

  for(;;) {
    var1++;
    var13 = tablelookupbyrow("loot/weapon_ids.csv", var1, 0);

    if(var13 == "") {
      break;
    }

    var3 = tablelookupbyrow("loot/weapon_ids.csv", var1, 1);

    if(!scripts\cp_mp\utility\weapon_utility::vehicle_ai_script_models(var3)) {
      continue;
    }

    var14 = tablelookupbyrow("loot/weapon_ids.csv", var1, 6);
    var15 = getweaponvarianttablename(var3);
    var16 = tablelookup(var15, 1, var14, 0);

    if(var16 == "") {
      continue;
    }

    var17 = var3 + "|" + var16;
    level.weaponlootmapdata[var17] = spawnStruct();
    level.weaponlootmapdata[var17].variantid = int(var16);
    var18 = tablelookup(var15, 1, var14, 3);

    if(var18 != "") {
      level.weaponlootmapdata[var17].assetoverridename = var18;
    }

    var19 = tablelookup("loot/weapon_ids.csv", 6, var14, 5);
    level.weaponlootmapdata[var17].update_focus_fire_objective = int(var16) != 0 && int(var19) == 99;
    var20 = tablelookup(var15, 1, var14, 4);
    var11 = parseattachdefaulttoidmap(var20);

    if(isDefined(var11)) {
      if(isDefined(level.weaponmapdata[var3].attachdefaulttoidmap)) {
        var11 = scripts\engine\utility::array_combine_unique_keys(var11, level.weaponmapdata[var3].attachdefaulttoidmap);
      }

      level.weaponlootmapdata[var17].attachdefaulttoidmap = var11;
    }

    var21 = [];

    for(var22 = 5; var22 <= 15; var22++) {
      var23 = tablelookup(var15, 1, var14, var22);

      if(var23 != "") {
        var24 = strtok(var23, "|");

        if(var24.size == 2) {
          var21 = int(var24[1]);
        } else {
          var21 = 0;
        }
      }
    }

    if(var21.size > 0) {
      level.weaponlootmapdata[var17].attachcustomtoidmap = var21;
    }

    var25 = tablelookup(var15, 1, var14, 16);

    if(var25 != "") {
      var26 = [];
      var27 = strtok(var25, " ");

      foreach(var29 in var27) {
        var30 = strtok(var29, "|");

        if(var30.size != 2) {
          continue;
        }

        var26 = int(var30[1]);
      }

      if(var26.size > 0) {
        level.weaponlootmapdata[var17].attachextratoidmap = var26;
      }
    }
  }
}

function getweaponvarianttablename(var0) {
  if(scripts\cp\utility::isstrstart(var0, "iw8_")) {
    var0 = getsubstr(var0, 4);
  }

  return "mp/gunsmith/" + var0 + "_variants.csv";
}

function parseattachdefaulttoidmap(var0) {
  if(var0 != "") {
    var1 = strtok(var0, " ");
    var2 = [];

    foreach(var4 in var1) {
      var5 = strtok(var4, "|");

      if(getdvarint("scr_selectfire_enabled", 1) == 0) {
        if(scripts\engine\utility::string_starts_with(var5[0], "select")) {
          continue;
        }
      }

      if(var5.size == 2) {
        var2 = int(var5[1]);
        continue;
      }

      var2 = 0;
    }

    return var2;
  }

  return undefined;
}

function monitordisownedgrenade(var0, var1) {
  level endon("game_ended");
  var1 endon("death");
  var1 endon("mine_planted");
  var0 scripts\engine\utility::ref_143a6("joined_team", "joined_spectators", "disconnect");

  if(isDefined(var1)) {
    var1 delete();
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

function ispickedupweapon(var0) {
  if(iscacprimaryweapon(var0) || iscacsecondaryweapon(var0)) {
    var1 = undefined;

    if(issameweapon(var0)) {
      var1 = createheadicon(var0 getnoaltweapon());
    } else if(isstring(var0)) {
      var1 = var0;

      if(issubstr(var1, "alt_")) {
        var1 = getsubstr(var1, 4, var0.size);
      }
    }

    var2 = isDefined(self.pers["primaryWeapon"]) && self.pers["primaryWeapon"] == var1;
    var3 = isDefined(self.pers["secondaryWeapon"]) && self.pers["secondaryWeapon"] == var1;

    if(!var2 && !var3) {
      return true;
    }
  }

  return false;
}

function isvehicleweapon(var0) {
  var1 = undefined;

  if(issameweapon(var0)) {
    var1 = var0.basename;
  } else {
    var1 = var0;
  }

  switch (var1) {
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

function attachmentsfilterforstats(var0, var1) {
  var2 = [];

  foreach(var4 in var0) {
    if(attachmentlogsstats(var4, var1)) {
      var2 = var4;
    }
  }

  return var2;
}

function attachmentlogsstats(var0, var1) {
  if(scripts\cp\utility::attachmentiscosmetic(var0)) {
    return false;
  }

  if(!carriedpunchcard(var1, var0)) {
    return false;
  }

  if(scripts\engine\utility::string_starts_with(var0, "laststand_")) {
    return false;
  }

  return true;
}

function carriedpunchcard(var0, var1) {
  var2 = scripts\cp\utility::getweaponrootname(var0);
  var3 = level.weaponattachments[var2];
  return isDefined(var3) && isDefined(var3[var1]);
}

function ref_12bbb(var0) {
  switch (var0) {
    case "laserbalanced":
    case "laserrange":
    case "laserads":
      var0 = "laser";
      break;
    case "barsil2":
    case "silencer4":
    case "silencer3":
    case "silencer2":
    case "barsil":
      var0 = "silencer";
      break;
    case "barcustnoguard":
    case "barcust2":
    case "barcust":
    case "barshortnoguard":
    case "barmid":
    case "barshort":
    case "barlong":
      var0 = "barlong";
      break;
  }

  return var0;
}

function mapweapon(var0, var1, var2) {
  var3 = var0;

  if(!isDefined(var0)) {
    var3 = getcompleteweaponname("none");
  }

  var4 = 0;

  if(var3.basename != "none") {
    switch (var3.basename) {
      case "pop_rocket_proj_mp":
        var3 = getcompleteweaponname("pop_rocket_mp");
        break;
      case "tur_gun_mp":
      case "tur_gun_faridah_mp":
        var3 = getcompleteweaponname("iw8_turret_50cal_mp");
        break;
      case "tur_bradley_mp":
      case "tur_gun_lighttank_mp":
        var3 = getcompleteweaponname("lighttank_tur_mp");
        break;
      case "tur_gun_lighttank_ks_mp":
      case "tur_bradley_ks_mp":
        var3 = getcompleteweaponname("lighttank_tur_ks_mp");
        break;
      case "ks_remote_drone_mp":
        var3 = getcompleteweaponname("none");
        break;
    }
  } else if(isDefined(var1)) {
    if(isDefined(var1.objweapon)) {
      var3 = getcompleteweaponname(var1.objweapon.basename);
      var4 = 1;
    } else if(isDefined(var1.weapon_name)) {
      var3 = getcompleteweaponname(var1.weapon_name);
      var4 = 1;
    }
  }

  if(var4 && !istrue(var2)) {
    var3 = mapweapon(var3, var1, 1);
  }

  return var3;
}