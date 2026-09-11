/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\weapons.gsc
***********************************************/

function attachmentgroup(var0) {
  return tablelookup("mp/attachmenttable.csv", 4, var0, 2);
}

function init() {
  level.scavenger_altmode = 1;
  level.scavenger_secondary = 1;
  level.ref_12e38 = getdvarint("scr_br_s4incendiary_dmg", 12);
  level.ref_12e39 = getdvarfloat("scr_br_s4incendiary_tickrate", 0.25);
  level.maxperplayerexplosives = max(scripts\mp\utility\dvars::getintproperty("scr_maxPerPlayerExplosives", 2), 1);
  level.riotshieldxpbullets = scripts\mp\utility\dvars::getintproperty("scr_riotShieldXPBullets", 15);
  createthreatbiasgroup("DogsDontAttack");
  createthreatbiasgroup("Dogs");
  setignoremegroup("DogsDontAttack", "Dogs");

  switch (scripts\mp\utility\dvars::getintproperty("perk_scavengerMode", 0)) {
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

  buildweaponmap();
  buildattachmentmaps();
  level._effect["emp_stun"] = loadfx("vfx/core/mp/equipment/vfx_emp_grenade");
  level._effect["emp_vehicle_stun"] = loadfx("vfx/iw8_br/island/gameplay/vfx_br3_emp_grenade_vehicle_gothit");
  level._effect["emp_person_stun"] = loadfx("vfx/iw8_br/island/gameplay/vfx_br3_emp_grenade_person_gothit");
  level._effect["equipment_explode"] = loadfx("vfx/iw7/_requests/mp/vfx_generic_equipment_exp.vfx");
  level._effect["equipment_smoke"] = loadfx("vfx/core/mp/killstreaks/vfx_sg_damage_blacksmoke");
  level._effect["equipment_sparks"] = loadfx("vfx/core/mp/killstreaks/vfx_sentry_gun_explosion");
  level._effect["glsmoke"] = loadfx("vfx/iw8_mp/equipment/smoke_grenade/vfx_smoke_gren_ch");
  level._effect["xmike109ThermiteBounce"] = loadfx("vfx/iw8_mp/equipment/vfx_xmike109_thermite_bounce");
  level._effect["8BitLimb"] = loadfx("vfx/iw8/weap/_impact/_mtx/8bit/vfx_imp_mtx_8bit_limb");
  level._effect["8BitTorso"] = loadfx("vfx/iw8/weap/_impact/_mtx/8bit/vfx_imp_mtx_8bit_torso");
  level._effect["8BitHead"] = loadfx("vfx/iw8/weap/_impact/_mtx/8bit/vfx_imp_mtx_8bit_head");
  level._effect["teslaLimb"] = loadfx("vfx/iw8/weap/_impact/_mtx/ray/vfx_dismem_limb");
  level._effect["teslaTorso"] = loadfx("vfx/iw8/weap/_impact/_mtx/ray/vfx_dismem_torso");
  level._effect["teslaHead"] = loadfx("vfx/iw8/weap/_impact/_mtx/ray/vfx_dismem_head");
  level._effect["aalpha12_explo"] = loadfx("vfx/iw8_mp/equipment/vfx_aalpha12_projectile_explo");
  scripts\mp\utility\entity::placeequipmentfailedinit();
  level.weaponconfigs = [];

  if(!isDefined(level.weapondropfunction)) {
    level.weapondropfunction = &dropweaponfordeath;
  }

  var0 = 25;
  level.sticky_minedetectiondot = cos(var0);
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
  scripts\mp\utility\spawn_event_aggregator::registeronplayerspawncallback(&onplayerspawned);
  thread onplayerconnect();
  scripts\mp\utility\outline::initoutlineoccluders();
  init_function_refs();
  level.ref_120ad = _calloutmarkerping_handleluinotify_acknowledgedcancel::friendlyfire_allowed();
  level.ref_120ae = _calloutmarkerping_handleluinotify_acknowledgedcancel::friendlyfire_allowed();

  if(getdvarint("perk_graverobber_enabled") == 1) {
    thread savegraverobberammo();
  }

  level.™Û sÇ› Ÿ8ùJ #— Õx£
  éCÐãkÝ = getdvarint("scr_br_scavengerPlunderAmount", 5);
}

function savegraverobberammo() {
  for(;;) {
    if(isDefined(level.players)) {
      foreach(var1 in level.players) {
        if(!isDefined(var1)) {
          continue;
        }

        if(var1 scripts\mp\utility\perk::_hasperk("specialty_scrap_weapons")) {
          var2 = var1 getcurrentweapon();
          var1 getcurrentweapon();

          if(!isDefined(var2)) {
            continue;
          }

          if(!isDefined(var1.graverobberammo)) {
            var1.graverobberammo = spawnStruct();
            var1.graverobberammo = spawnStruct();
            var1.graverobberammo = spawnStruct();
          }

          if(isDefined(var1.graverobberammo.currentweapon) && var1.graverobberammo.currentweapon.weapon.basename != "none" && var1.graverobberammo.currentweapon.weapon != var2) {
            var1.graverobberammo.lastweapon = var1.graverobberammo.currentweapon;
            var1.graverobberammo.currentweapon = spawnStruct();
          }

          var1.graverobberammo.currentweapon = spawnStruct();
          var1.graverobberammo.currentweapon.weapon = var2;
          var1.graverobberammo.currentweapon.rightclip = var1 getweaponammoclip(var2, "right");
          var1.graverobberammo.currentweapon.leftclip = var1 getweaponammoclip(var2, "left");
          var1.graverobberammo.currentweapon.stock = var1 getweaponammostock(var2);
          continue;
        }

        var1.graverobberammo = undefined;
      }
    }

    waitframe();
  }
}

function enablevisibilitycullingforclient(var0) {
  self hudoutlinedisableforclient(var0);
}

function onplayerconnect() {
  for(;;) {
    level waittill("connected", var0);
    var0.hits = 0;
    scripts\mp\gamelogic::sethasdonecombat(var0, 0);
    thread watchmissileusage();
  }
}

function watchchangeweapon() {
  self endon("death_or_disconnect");
  self endon("joined_spectators");
  self endon("faux_spawn");
  level endon("game_ended");

  for(;;) {
    var0 = self getcurrentweapon();

    if(isDefined(var0)) {
      dochangeweapon(var0);
    }

    self waittill("weapon_change");
  }
}

function dochangeweapon(var0) {
  if(istrue(self.get_alive_players)) {
    ref_119ad(var0);
  }

  self.get_alive_players = 1;
  updatecamoscripts(var0, self.lastweaponobj);
  updateweaponspeed(var0);
  updatelastweaponobj(var0);
  updatelauncherusage();
  updatesniperglint(var0);
  updateweaponperks();
  ref_13fd2(var0);
  ref_13ffc(var0);
  ref_12f87(var0);
  scripts\mp\perks\perkfunctions::updatedefaultflinchreduction();
  scripts\mp\events::updateweaponchangetime();
  scripts\mp\class::riotshieldonweaponchange(var0);
  scripts\mp\perks\perkfunctions::updateweaponkick();
  thread scripts\cp_mp\gestures::ref_13e1a();
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
  self endon("disconnect");
  scripts\engine\utility::ref_143a5("death", "weapon_change");
  scripts\common\utility::allow_mount_top(1, "scriptedMountDisable");
  scripts\common\utility::allow_mount_side(1, "scriptedMountDisable");
}

function ref_13ffc(var0) {
  var1 = scripts\mp\utility\weapon::getweaponrootname(var0);
  var2 = undefined;

  if(var1 == "iw8_knife") {
    if(var0.basename == "iw8_knife_mphatchetv4") {
      var2 = "flamingHatchet";
    } else if(var0.basename == "iw8_knife_mpb" && var0.attachmentvarindices["me_knifeb"] == 9) {
      var2 = "flamingKnife";
    } else if(var0.basename == "iw8_knife_mpd" && var0.attachmentvarindices["me_knifed"] == 1) {
      var2 = "electricKnife";
    }
  }

  if(isDefined(var2)) {
    thread ref_11df9(var2);
  }

  return true;
}

function ref_11df9(var0) {
  self endon("weapon_change");
  self endon("death_or_disconnect");
  self notify("newMTXVFXStateSet");
  self endon("newMTXVFXStateSet");
  var1 = "cancel_" + var0;
  thread ref_11df7(var1);
  GscBinSkip4(0x35, var0, var1);
}

function ref_11dfe(var0, var1) {
  for(;;) {
    self waittill("weapon_switch_started");

    if(self isthrowinggrenade()) {
      ref_11dfa(var1);
      self waittill("offhand_end");
      GscBinSkip4(0x35, var0, var1);
    }

    if(self isonladder()) {
      ref_11df8(var0, var1);
    }
  }
}

function ref_11dfd(var0, var1) {
  for(;;) {
    self waittill("mantle_end");

    if(self isonladder()) {
      ref_11df8(var0, var1);
    }
  }
}

function ref_11df8(var0, var1) {
  ref_11dfa(var1);

  while(self isonladder()) {
    waitframe();
  }

  GscBinSkip4(0x35, var0, var1);
}

function ref_11dfb(var0, var1) {
  self notify(var1);
  self endon(var1);
  self.ref_12745 = 1;
  self setscriptablepartstate("weaponVFXViewmodel", var0);
  self setscriptablepartstate("weaponVFXWorldModel", "neutral");
  var2 = 0.4;
  wait var2;
  self setscriptablepartstate("weaponVFXWorldModel", var0, 0);
}

function ref_11dfc(var0, var1) {
  self notify(var1);
  self endon(var1);
  self.ref_12745 = 1;
  self setscriptablepartstate("weaponVFXViewmodel", "neutral");
  self setscriptablepartstate("weaponVFXWorldModel", "neutral");
  var2 = 0.4;
  wait var2;
  self setscriptablepartstate("weaponVFXViewmodel", var0, 0);
  self setscriptablepartstate("weaponVFXWorldModel", var0, 0);
}

function ref_11dfa(var0) {
  self notify(var0);

  if(istrue(self.ref_12745)) {
    self setscriptablepartstate("weaponVFXViewmodel", "neutral");
    self setscriptablepartstate("weaponVFXWorldModel", "neutral");
  }

  self.ref_12745 = undefined;
}

function ref_11df7(var0) {
  self endon("disconnect");
  self endon("newMTXVFXStateSet");
  scripts\engine\utility::ref_143a5("death", "weapon_change");
  ref_11dfa(var0);
}

function ref_132f2(var0) {
  var1 = scripts\mp\utility\weapon::getweaponrootname(var0);

  if(var1 == "iw8_lm_sierrax" && var0 hasattachment("stocksaw_sierrax")) {
    return true;
  }

  return false;
}

function ref_119ad(var0) {
  var1 = var0.basename;
  var2 = "none";

  if(!isDefined(var1) || var1 == "none") {
    return;
  }

  if(isDefined(self.lastweaponobj) && var0 == self.lastweaponobj) {
    return;
  }

  if(self.equippedweapons.size > 1) {
    var2 = self.equippedweapons[1].basename;

    if(var2 == var1) {
      var2 = self.equippedweapons[0].basename;
    }
  }

  if(isDefined(self.equippedweapons[0])) {
    self setclientweaponinfo(0, createheadicon(self.equippedweapons[0]));
  }

  if(isDefined(self.equippedweapons[1])) {
    self setclientweaponinfo(1, createheadicon(self.equippedweapons[1]));
  }

  self dlog_recordplayerevent("dlog_event_weapon_change", ["current_weapon", var1, "secondary_weapon", var2]);
}

function updateweaponperks() {
  self.prevweaponobj = doweaponperkupdate(self.prevweaponobj);
}

function updatesniperglint(var0) {
  if(sniperglint_supported(var0)) {
    GscBinSkip4(0x35);
  }
}

function ref_13fd2(var0) {
  self notify("end_dragBreath");

  if(scripts\mp\utility\weapon::getweapongroup(var0) == "weapon_shotgun" || var0.basename == "iw8_pi_t9pistolshot_mp" || var0 hasattachment("ammo_incendiary", 1)) {
    if(scripts\cp_mp\killstreaks\nuke::unlockables(var0)) {
      thread scripts\cp_mp\killstreaks\nuke::terminal_pusher_approach_array(var0);
      return;
    }

    return;
  }
}

function updatelauncherusage() {
  var0 = self getcurrentweapon();
  var1 = scripts\mp\utility\weapon::getweaponrootname(var0.basename);

  switch (var1) {
    default:
      break;
    case "iw8_la_t9standard":
    case "iw8_la_gromeo":
      thread scripts\mp\missilelauncher::initmissilelauncherusage();
      break;
    case "iw8_la_juliet":
      thread scripts\mp\javelin::javelin_reset();
      break;
    case "iw8_sn_crossbow":
    case "iw8_sn_t9crossbow":
      thread scripts\cp\vehicles\vehicle_damage_cp::teleport_text_updated();
      break;
    case "iw8_sn_xmike109":
      thread scripts\cp_mp\utility\omnvar_utility::tr_vis_facing_dist_add_override();
      break;
    case "iw8_sh_aalpha12":
      thread scripts\cp\utility\cp_safehouse_util::tr_vis_facing_dist_add_override();
      break;
    case "iw8_me_t9ballisticknife":
      thread scripts\cp\vehicles\cargo_truck_mg_cp::tr_vis_facing_dist_add_override();
      break;
  }

  self notify("end_launcher");

  if(scripts\mp\utility\perk::_hasperk("specialty_fastreload_launchers")) {
    var2 = weaponclass(var0.basename) == "rocketlauncher" || var0.basename == "iw8_la_kgolf_mp";

    if(var2 && !istrue(self.fastreloadlaunchers)) {
      scripts\mp\utility\perk::giveperk("specialty_fastreload");
      self.fastreloadlaunchers = 1;
    } else if(!var2 && istrue(self.fastreloadlaunchers)) {
      scripts\mp\utility\perk::removeperk("specialty_fastreload");
      self.fastreloadlaunchers = undefined;
    }
  }

  switch (var1) {
    default:
      break;
    case "iw8_la_t9standard":
    case "iw8_la_gromeo":
      thread scripts\mp\missilelauncher::missilelauncherusageloop();
      break;
    case "iw8_la_juliet":
      thread scripts\mp\javelin::javelinusageloop();
      break;
    case "iw8_sn_crossbow":
    case "iw8_sn_t9crossbow":
      thread scripts\cp\vehicles\vehicle_damage_cp::initarmor(var0);
      break;
    case "iw8_sn_xmike109":
      thread scripts\cp_mp\utility\omnvar_utility::ref_1403e(var0);
      break;
    case "iw8_sh_aalpha12":
      thread scripts\cp\utility\cp_safehouse_util::ref_1403e(var0);
      break;
    case "iw8_me_t9ballisticknife":
      thread scripts\cp\vehicles\cargo_truck_mg_cp::ref_1403e(var0);
      break;
  }
}

function ref_1316b(var0) {
  self.lastdroppableweaponobj = var0;

  if(isDefined(level.waittillmatch_wait)) {
    self[[level.waittillmatch_wait]]();
    return;
  }
}

function updatelastweaponobj(var0) {
  var1 = var0 getnoaltweapon();

  if(nullweapon(var1)) {
    var1 = var0;
  }

  self.lastweaponobj = var0;

  if(isnormallastweapon(var0)) {
    self.lastnormalweaponobj = var0;
  }

  if(isdroppableweapon(var1)) {
    ref_1316b(var1);
  }

  if(scripts\mp\utility\weapon::iscacprimaryorsecondary(var0)) {
    self.lastcacweaponobj = var0;
    return;
  }
}

function updateweaponspeed(var0) {
  if(var0.basename == "none") {
    return;
  } else if(scripts\mp\utility\weapon::issuperweapon(var0.basename)) {
    updatemovespeedscale();
    return;
  } else if(scripts\mp\utility\weapon::iskillstreakweapon(var0.basename)) {
    return;
  } else if(var0.basename == "iw8_fists_mp_ls") {
    updatemovespeedscale();
    return;
  } else if(var0.inventorytype != "primary" && var0.inventorytype != "altmode") {
    return;
  }

  updatemovespeedscale();
}

function onplayerspawned() {
  self.hits = 0;
  scripts\mp\gamelogic::sethasdonecombat(self, 0);

  if(!isDefined(self.trackingweapon)) {
    self.trackingweapon = isundefinedweapon();
    self.trackingweaponshots = 0;
    self.trackingweaponkills = 0;
    self.trackingweaponhits = 0;
    self.trackingweaponheadshots = 0;
    self.trackingweapondeaths = 0;
  }

  if(!isDefined(self.plantedlethalequip)) {
    self.plantedlethalequip = [];
  }

  if(!isDefined(self.plantedtacticalequip)) {
    self.plantedtacticalequip = [];
  }

  if(!isDefined(self.plantedsuperequip)) {
    self.plantedsuperequip = [];
  }

  if(!isDefined(self.plantedhackedequip)) {
    self.plantedhackedequip = [];
  }

  self.prevweaponobj = undefined;
  thread watchchangeweapon();
  thread watchweaponusage();
  thread watchgrenadeusage();
  thread watchequipmentonspawn();

  if(scripts\mp\utility\game::onlinestatsenabled()) {
    thread ref_144c3();
  }

  if(!scripts\mp\utility\game::runleanthreadmode()) {
    thread watchdropweapons();
  }

  self.lasthittime = [];
  self.droppeddeathweapon = undefined;
  self.tookweaponfrom = [];
  self.lastnormalweaponobj = scripts\engine\utility::ter_op(isDefined(self.spawnweaponobj), self.spawnweaponobj, isundefinedweapon());
  self.lastweaponobj = scripts\engine\utility::ter_op(isDefined(self.spawnweaponobj), self.spawnweaponobj, isundefinedweapon());
  self.lastcacweaponobj = scripts\engine\utility::ter_op(isDefined(self.spawnweaponobj) && scripts\mp\utility\weapon::iscacprimaryorsecondary(self.spawnweaponobj), self.spawnweaponobj, isundefinedweapon());
  ref_1316b(scripts\engine\utility::ter_op(isDefined(self.spawnweaponobj), self.spawnweaponobj, isundefinedweapon()));
  scripts\mp\gamescore::initassisttrackers();
}

function savealtstates() {
  self.pers["altStates"] = [];
  var0 = self.primaryinventory;

  foreach(var2 in var0) {
    if(!getqueuedspleveltransients(self.primaryweaponobj) && var2 == self.primaryweaponobj || !getqueuedspleveltransients(self.secondaryweaponobj) && var2 == self.secondaryweaponobj) {
      if(shouldweaponsavealtstate(var2) && self isalternatemode(var2, 1)) {
        var3 = scripts\mp\utility\weapon::getcompleteweaponnamenoalt(var2);
        self.pers["altStates"][var3] = 1;
      }
    }
  }
}

function savetogglescopestates() {
  self.pers["toggleScopeStates"] = [];
  var0 = self.primaryinventory;

  foreach(var2 in var0) {
    if(!getqueuedspleveltransients(self.primaryweaponobj) && var2 == self.primaryweaponobj || !getqueuedspleveltransients(self.secondaryweaponobj) && var2 == self.secondaryweaponobj) {
      if(isDefined(var2.scope) && istogglescope(var2.scope) && !ref_138b1(var2.backpiece)) {
        var3 = scripts\mp\utility\weapon::getcompleteweaponnamenoalt(var2);
        self.pers["toggleScopeStates"][var3] = self gethybridscopestate(var2);
      }
    }
  }
}

function updatetogglescopestate(var0) {
  var1 = scripts\mp\utility\weapon::getcompleteweaponnamenoalt(var0);

  if(isDefined(self.pers["toggleScopeStates"]) && isDefined(self.pers["toggleScopeStates"][var1])) {
    self sethybridscopestate(var0, self.pers["toggleScopeStates"][var1]);
    return;
  }
}

function updatesavedaltstate(var0) {
  if(isDefined(self.pers["altStates"]) && istrue(var0.hasalternate)) {
    var1 = scripts\mp\utility\weapon::getcompleteweaponnamenoalt(var0);

    if(isDefined(self.pers["altStates"][var1]) && self.pers["altStates"][var1]) {
      var0 = var0 getaltweapon();
    }
  }

  return var0;
}

function istogglescope(var0) {
  var1 = scripts\mp\utility\weapon::attachmentmap_tobase(var0);

  switch (var1) {
    case "hybrid3light":
    case "hybrid2light":
    case "hybridlight":
    case "hybrid4":
    case "hybrid3":
    case "hybrid2":
    case "hybrid":
      return 1;
    default:
      return 0;
  }
}

function ref_138b1(var0) {
  return isDefined(var0) && var0 == "stocksaw_sierrax";
}

function shouldweaponsavealtstate(var0) {
  if(istrue(var0.hasalternate)) {
    if(shouldattachmentsavealtstate(var0.underbarrel)) {
      return true;
    }
  }

  return false;
}

function shouldattachmentsavealtstate(var0) {
  return turretoverridefunc(var0);
}

function turretoverridefunc(var0) {
  var1 = scripts\mp\utility\weapon::attachmentmap_tobase(var0);

  switch (var1) {
    case "selectauto":
    case "selectburst":
    case "selectsemi":
      return 1;
    default:
      return 0;
  }
}

function turretobjweapon(var0) {
  var1 = scripts\mp\utility\weapon::attachmentmap_tobase(var0);

  switch (var1) {
    case "glsnap":
    case "glsemtex":
    case "glincendiary":
    case "glflash":
    case "glconc":
    case "glgas":
    case "glsmoke":
    case "gl":
      return 1;
    default:
      return 0;
  }
}

function weaponperkupdate(var0, var1) {
  if(!getqueuedspleveltransients(var1)) {
    var2 = scripts\mp\utility\weapon::getweaponrootname(var1.basename);
    var3 = scripts\mp\utility\weapon::weaponperkmap(var2);

    if(isDefined(var3)) {
      scripts\mp\class::loadout_removeperk(var3);
    }
  }

  if(!getqueuedspleveltransients(var0)) {
    var4 = scripts\mp\utility\weapon::getweaponrootname(var0.basename);
    var5 = scripts\mp\utility\weapon::weaponperkmap(var4);

    if(isDefined(var5)) {
      scripts\mp\class::loadout_giveperk(var5);
      return;
    }

    return;
  }
}

function weaponattachmentperkupdate(var0, var1) {
  var2 = undefined;
  var3 = undefined;

  if(!getqueuedspleveltransients(var1)) {
    var3 = getweaponattachments(var1);

    if(isDefined(var3) && var3.size > 0) {
      foreach(var5 in var3) {
        var6 = scripts\mp\utility\weapon::attachmentperkmap(var5);

        if(!isDefined(var6)) {
          continue;
        }

        if(!scripts\mp\utility\perk::_hasperk(var6)) {
          continue;
        }

        scripts\mp\class::loadout_removeperk(var6);
      }
    }
  }

  if(!getqueuedspleveltransients(var0)) {
    var2 = getweaponattachments(var0);

    if(isDefined(var2) && var2.size > 0) {
      foreach(var9 in var2) {
        var6 = scripts\mp\utility\weapon::attachmentperkmap(var9);

        if(!isDefined(var6)) {
          continue;
        }

        scripts\mp\class::loadout_giveperk(var6);
      }

      return;
    }

    return;
  }
}

function doweaponperkupdate(var0) {
  var1 = self getcurrentweapon();
  weaponattachmentperkupdate(var1, var0);
  weaponperkupdate(var1, var0);
  return var1;
}

function watchweaponperkupdates() {
  self endon("death_or_disconnect");
  self endon("faux_spawn");
  self endon("giveLoadout_start");
  var0 = undefined;

  for(;;) {
    var0 = doweaponperkupdate(var0);
    self waittill("weapon_change");
  }
}

function watchsniperuse() {
  self endon("death_or_disconnect");

  for(;;) {
    var0 = self getcurrentweapon();

    if(sniperglint_supported(var0)) {
      GscBinSkip4(0x35);
    }

    self waittill("weapon_change");
  }
}

function sniperadsblur_supported(var0) {
  return scripts\mp\utility\weapon::weaponhasattachment(var0, "scope") && !issubstr(var0.basename, "alpha50") && !issubstr(var0.basename, "mike14");
}

function sniperglint_supported(var0) {
  if(nullweapon(var0) || !isDefined(var0.scope) || weaponclass(var0) == "rocketlauncher" || weaponclass(var0) == "smg") {
    return false;
  }

  if(var0.basename == "s4_mr_gecho43_mp" || var0.basename == "s4_mr_m1golf_mp" || var0.basename == "s4_mr_svictor40_mp" || var0.basename == "s4_mr_malpha1916_mp") {
    return false;
  }

  var1 = scripts\mp\utility\weapon::attachmentmap_tobase(var0.scope);

  switch (var1) {
    case "scope":
      if(var0.basename == "iw8_ar_t9british_mp") {
        return false;
      } else if(var0.classname == "sniper" && issubstr(var0.basename, "s4")) {
        return true;
      }
    case "scopelight":
      if(var0.classname == "sniper") {
        return true;
      } else {
        return false;
      }
    case "scopenorail":
      if(var0.classname == "sniper" && issubstr(var0.basename, "s4")) {
        return true;
      } else {
        return false;
      }
    case "scopenvg":
      if(var0.classname == "sniper") {
        return true;
      } else {
        return false;
      }
    case "vzscope2":
      if(var0.classname != "sniper" && issubstr(var0.basename, "s4")) {
        return false;
      }
    case "thermalvz":
    case "vzscope3":
      return true;
    case "thermal":
      var2 = scripts\mp\utility\weapon::getweapongroup(var0);

      if(var2 == "weapon_sniper") {
        return true;
      } else {
        return false;
      }
    case "acog3":
      if(var0.classname == "sniper" && issubstr(var0.basename, "t9")) {
        return true;
      } else {
        return false;
      }
    case "acog4":
      if(issubstr(var0.basename, "t9")) {
        return true;
      } else {
        return false;
      }
    case "vzscope":
      if(var0.classname == "sniper" && (issubstr(var0.basename, "s4") || issubstr(var0.basename, "t9"))) {
        return true;
      } else if(!issubstr(var0.basename, "s4") && !issubstr(var0.basename, "t9")) {
        return true;
      }

      break;
  }

  return false;
}

function sniperglint_manage() {
  self notify("manageSniperGlint");
  self endon("manageSniperGlint");
  self endon("weapon_change");
  waitframe();
  thread sniperglint_cleanup();
  self.glinton = 0;

  if(self.currentweapon hasattachment("gunperk_shrouded")) {
    var0 = getdvarfloat("scr_gunperk_shrouded_zoom_level", 0.85);
  } else {
    var0 = 0.5;
  }

  for(;;) {
    if(self playerads() > var0) {
      if(!self.glinton) {
        sniperglint_add();
      }
    } else if(self.glinton) {
      sniperglint_remove();
    }

    waitframe();
  }
}

function sniperglint_cleanup() {
  scripts\engine\utility::ref_143a5("death_or_disconnect", "weapon_change");

  if(isDefined(self.glinton) && self.glinton) {
    sniperglint_remove();
    self.glinton = undefined;
    return;
  }
}

function sniperglint_add() {
  if(scripts\mp\utility\perk::_hasperk("specialty_glintreduce")) {
    self setscriptablepartstate("sniperGlint", "sniperGlintOn_narrow", 0);
  } else {
    self setscriptablepartstate("sniperGlint", "sniperGlintOn", 0);
  }

  self.glinton = 1;
}

function sniperglint_remove() {
  if(isDefined(self)) {
    self setscriptablepartstate("sniperGlint", "sniperGlintOff", 0);
    self.glinton = 0;
    return;
  }
}

function sniperadsblur(var0) {
  self endon("weapon_change");
  self.sniperblur = 0;

  for(;;) {
    if(self playerads() > 0.65 && !self.sniperblur) {
      thread sniperadsblur_execute(var0);
    } else if(self playerads() <= 0.65) {
      sniperadsblur_remove();
    }

    waitframe();
  }
}

function sniperadsblur_execute(var0) {
  self notify("sniperBlurReset");
  self endon("sniperBlurReset");
  self.sniperblur = 1;
  self setblurforplayer(25, 0.1);
  wait 0.1;
  self setblurforplayer(0, getsniperadsblurtime(var0));
}

function sniperadsblur_remove() {
  self notify("sniperBlurReset");
  self setblurforplayer(0, 0);
  self.sniperblur = 0;
}

function getsniperadsblurtime(var0) {
  var1 = 0.3;

  switch (var0.basename) {
    case "iw8_sn_kilo98_mp":
      var1 = 0.18;
      break;
    case "iw8_sn_mike14_mp":
      var1 = 0.12;
      break;
    case "iw8_sn_sbeta_mp":
      var1 = 0.12;
      break;
  }

  return var1;
}

function watchsniperboltactionkills() {
  self endon("death_or_disconnect");
  thread watchsniperboltactionkills_ondeath();

  if(!isDefined(self.pers["recoilReduceKills"])) {
    self.pers["recoilReduceKills"] = 0;
  }

  self setclientomnvar("weap_sniper_display_state", self.pers["recoilReduceKills"]);

  for(;;) {
    self waittill("got_a_kill", var0, var1, var2);
    var3 = asmdevgetallstates(var1);

    if(isrecoilreducingweapon(var3)) {
      var4 = self.pers["recoilReduceKills"] + 1;
      self.pers["recoilReduceKills"] = int(min(var4, 4));
      self setclientomnvar("weap_sniper_display_state", self.pers["recoilReduceKills"]);

      if(var4 <= 4) {
        stancerecoilupdate(self getstance());
      }
    }
  }
}

function watchsniperboltactionkills_ondeath() {
  self notify("watchSniperBoltActionKills_onDeath");
  self endon("watchSniperBoltActionKills_onDeath");
  self endon("disconnect");
  self waittill("death");
  self.pers["recoilReduceKills"] = 0;
}

function isrecoilreducingweapon(var0) {
  if(!isDefined(var0) || nullweapon(var0)) {
    return 0;
  }

  var1 = 0;

  if(var0 hasattachment("l115a3scope", 1) || var0 hasattachment("l115a3vzscope", 1) || var0 hasattachment("usrscope", 1) || var0 hasattachment("usrvzscope", 1)) {
    var1 = 1;
  }

  return var1;
}

function getrecoilreductionvalue() {
  if(!isDefined(self.pers["recoilReduceKills"])) {
    self.pers["recoilReduceKills"] = 0;
  }

  return self.pers["recoilReduceKills"] * 3;
}

function ishackweapon(var0) {
  if(var0 == "radar_mp" || var0 == "airstrike_mp" || var0 == "helicopter_mp") {
    return true;
  }

  if(var0 == "briefcase_bomb_mp") {
    return true;
  }

  return false;
}

function isfistweapon(var0) {
  var0 = scripts\mp\utility\weapon::getweaponrootname(var0);
  return var0 == "iw8_fists";
}

function isbombplantweapon(var0) {
  return var0 == "briefcase_bomb_mp" || var0 == "briefcase_bomb_defuse_mp" || var0 == "briefcase_silent_mp" || var0 == "briefcase_defuse_silent_mp";
}

function dropweaponfordeath(var0, var1, var2, var3) {
  if(isDefined(level.blockweapondrops)) {
    return;
  }

  if(isDefined(self.droppeddeathweapon)) {
    return;
  }

  if(isDefined(var0) && var0 == self || var1 == "MOD_SUICIDE") {
    return;
  }

  var4 = self.lastdroppableweaponobj;

  if(isDefined(var2)) {
    var4 = var2;
  }

  if(!isDefined(var4)) {
    return;
  }

  if(var4.basename == "none") {
    return;
  }

  if(!self hasweapon(var4)) {
    return;
  }

  if(isDefined(level.gamemodemaydropweapon) && !self[[level.gamemodemaydropweapon]](var4)) {
    return;
  }

  var4 = var4 getnoaltweapon();
  var5 = 0;
  var6 = 0;
  var7 = 0;

  if(!scripts\mp\riotshield::isriotshield(var4.basename)) {
    if(!self anyammoforweaponmodes(var4)) {
      return;
    }

    var5 = self getweaponammoclip(var4, "right");
    var6 = self getweaponammoclip(var4, "left");

    if(!var5 && !var6) {
      return;
    }

    var7 = self getweaponammostock(var4);
    var8 = weaponmaxammo(var4);

    if(var7 > var8) {
      var7 = var8;
    }

    var9 = self dropitem(var4);

    if(!isDefined(var9)) {
      return;
    }

    if(istrue(level.clearstockondrop)) {
      var7 = 0;
    }

    var9 itemweaponsetammo(var5, var7, var6);
    var10 = scripts\mp\utility\weapon::getweapongroup(var4);

    if(var1 != "MOD_EXECUTION") {
      thread scripts\cp_mp\utility\weapon_utility::dropweaponfordeathlaunch(var9, var10, var3, self.angles);
    }
  } else {
    var9 = self dropitem(var5);

    if(!isDefined(var9)) {
      return;
    }

    var9 itemweaponsetammo(1, 1, 0);
  }

  var9 sethintdisplayrange(96);
  var9 setuserange(96);
  self.droppeddeathweapon = 1;
  var9.owner = self;
  var9.targetname = "dropped_weapon";
  var9.objweapon = var5;
  thread watchpickup(var9);
  thread deletepickupafterawhile();
}

function forcedropweapon(var0) {
  if(isDefined(level.blockweapondrops)) {
    return 0;
  }

  if(isDefined(self.droppeddeathweapon)) {
    return 0;
  }

  var1 = self.lastdroppableweaponobj;

  if(isDefined(var0)) {
    var1 = var0;
  }

  if(!isDefined(var1)) {
    return 0;
  }

  if(var1.basename == "none") {
    return 0;
  }

  if(!self hasweapon(var1)) {
    return -1;
  }

  if(isDefined(level.gamemodemaydropweapon) && !self[[level.gamemodemaydropweapon]](var1)) {
    return 0;
  }

  var1 = var1 getnoaltweapon();
  var2 = 0;
  var3 = 0;
  var4 = 0;

  if(!scripts\mp\riotshield::isriotshield(var1.basename)) {
    if(!self anyammoforweaponmodes(var1)) {
      return 0;
    }

    var2 = self getweaponammoclip(var1, "right");
    var3 = self getweaponammoclip(var1, "left");

    if(!var2 && !var3) {
      return 0;
    }

    var4 = self getweaponammostock(var1);
    var5 = weaponmaxammo(var1);

    if(var4 > var5) {
      var4 = var5;
    }

    var6 = self dropitem(var1);

    if(!isDefined(var6)) {
      return 0;
    }

    if(istrue(level.clearstockondrop)) {
      var4 = 0;
    }

    var6 itemweaponsetammo(var2, var4, var3);
  } else {
    var6 = self dropitem(var2);

    if(!isDefined(var6)) {
      return 0;
    }

    var6 itemweaponsetammo(1, 1, 0);
  }

  var6 sethintdisplayrange(96);
  var6 setuserange(96);
  var6.owner = self;
  var6.targetname = "dropped_weapon";
  var6.objweapon = var2;
  thread watchpickup(var6);
  thread deletepickupafterawhile();
  return 1;
}

function detachifattached(var0, var1) {
  var2 = self getattachsize();
  var3 = 0;

  while(var3 < var2) {
    var4 = self getattachmodelname(var3);

    if(var4 != var0) {} else {
      var5 = self getattachtagname(var3);
      self detach(var0, var5);

      if(var5 != var1) {
        var2 = self getattachsize();

        for(var3 = 0; var3 < var2; var3++) {
          var5 = self getattachtagname(var3);

          if(var5 != var1) {
            continue;
          }

          var0 = self getattachmodelname(var3);
          self detach(var0, var5);
          break;
        }
      }

      return true;
    }

    var4++;
  }

  return false;
}

function deletepickupafterawhile() {
  self endon("death");
  wait 60;

  if(!isDefined(self)) {
    return;
  }

  self delete();
}

function getitemweaponname() {
  var0 = self.classname;
  var1 = getsubstr(var0, 7);
  return var1;
}

function watchpickup(var0) {
  self endon("death");
  level.ref_120ad _calloutmarkerping_handleluinotify_acknowledgedcancel::from(self, var0, self.objweapon);
  var1 = getitemweaponname();

  for(;;) {
    self waittill("trigger", var2, var3);
    var4 = undefined;
    var5 = isDefined(level.cyberemp) && isDefined(level.cyberemp.carrier) && level.cyberemp.carrier == var2;
    var6 = scripts\mp\utility\game::getgametype() == "cyber" && (isDefined(var3) || var5);

    if(var6) {
      var7 = var2 scripts\cp_mp\utility\inventory_utility::getcurrentprimaryweaponsminusalt();

      if(var7.size > 2) {
        var8 = 0;
        var9 = 0;
        var10 = 0;

        foreach(var12 in var7) {
          if(var12.basename == "iw8_cyberemp_mp") {
            var8 = 1;
          }

          if(scripts\mp\utility\weapon::update_health_bar_to_player(var12)) {
            var9 = 1;
          }

          if(var12.basename == "iw8_lm_dblmg_mp") {
            var10 = 1;
          }
        }

        if(isDefined(var2.primaryweapon) && var2.primaryweapon != "iw8_cyberemp_mp") {
          var4 = var2.primaryweaponobj;
        } else if(isDefined(var2.secondaryweapon) && var2.secondaryweapon != "iw8_cyberemp_mp") {
          var4 = var2.secondaryweaponobj;
        }

        var14 = var7.size;

        if(var9) {
          var14--;
        }

        if(var10) {
          var14--;
        }

        if(!var8 || var14 > 3) {
          var15 = undefined;

          if(var4.basename != "none") {
            var15 = var4;
          }

          var16 = forcedropweapon(var2, var15);

          if(var5) {
            var2 scripts\common\utility::allow_weapon_switch(0);
            var2 scripts\common\utility::allow_weapon_pickup(0);
            var2 scripts\common\utility::allow_usability(0);
            thread waitthengivecyberweapon(var2);
          }

          if(var16 == 0) {
            if(var5) {
              var2 scripts\common\utility::allow_usability(1);
              var2 scripts\common\utility::allow_weapon_switch(1);
              var2 scripts\common\utility::allow_weapon_pickup(1);
            }

            return;
          } else if(var16 == -1) {}
          LOC_000001eb:
        }
      } else if(var5) {
        var2 scripts\common\utility::allow_weapon_switch(0);
        var2 scripts\common\utility::allow_weapon_pickup(0);
        var2 scripts\common\utility::allow_usability(0);
        thread waitthengivecyberweapon();
      } else if(isDefined(var3)) {
        var4 = var2.lastdroppableweaponobj;
      } else {
        var4 = var2 getcurrentweapon();
      }
    } else if(isDefined(var3)) {
      var4 = var2.lastdroppableweaponobj;
    } else {
      var4 = var2 getcurrentweapon();
    }

    var17 = var2 scripts\mp\utility\perk::_hasperk("specialty_scrap_weapons") && getdvarint("perk_graverobber_enabled") == 1;
    thread watchpickupcomplete(var2, self.objweapon, var4);
    level.ref_120ae _calloutmarkerping_handleluinotify_acknowledgedcancel::from(self, var2, self.objweapon);
    var2 notify("weapon_pickup", self.objweapon);

    if(isDefined(var3)) {
      var2.lastweaponpickuptime = gettime();
      var2 scripts\mp\utility\stats::incpersstat("weaponPickups", 1);
    }

    var18 = fixupplayerweapons(var2, var1);

    if(isDefined(var3) && var17) {
      var3 delete();
    }
  }

  LOC_000002f2:
    if(isDefined(var3)) {
      var19 = getitemweaponname(var3);
      var20 = asmdevgetallstates(var19);

      if(isDefined(var2.tookweaponfrom[var19])) {
        var3.owner = var2.tookweaponfrom[var19];
        var2.tookweaponfrom[var19] = undefined;
      }

      var3.objweapon = var20;
      var3.targetname = "dropped_weapon";
      thread watchpickup(var3);
    }

  var2.tookweaponfrom[var1] = self.owner;
}

function waitthengivecyberweapon(var0) {
  self endon("death_or_disconnect");
  self notify("cancelGiveEmp");
  self endon("cancelGiveEmp");

  while(isDefined(self.currentweapon.basename) && self.currentweapon.basename == "none") {
    waitframe();
  }

  scripts\cp_mp\utility\inventory_utility::_giveweapon("iw8_cyberemp_mp");

  if(!istrue(var0)) {
    scripts\common\utility::allow_usability(1);
    scripts\common\utility::allow_weapon_switch(1);
    scripts\common\utility::allow_weapon_pickup(1);
    return;
  }
}

function watchpickupcomplete(var0, var1, var2) {
  self endon("death_or_disconnect");
  self notify("watchPickupComplete()");
  self endon("watchPickupComplete()");
  var3 = self.currentweapon;
  var4 = 0;
  jumpiffalse(var3 == var0) LOC_00000033;
  var4 = 1;
  goto LOC_00000069;
}

function usegraverobber(var0, var1) {
  if(isDefined(var1)) {
    scripts\cp_mp\utility\inventory_utility::_takeweapon(var0);
    var2 = var1;
    var3 = safechecknum(var1.name);
    var4 = getrandomgraverobberattachment(var1);

    if(isDefined(var4)) {
      var5 = getweaponattachments(var1);

      foreach(var7 in var5) {
        if(!scripts\mp\utility\weapon::attachmentscompatible(var3, var7, var4)) {
          var5[var8] = undefined;
        }
      }

      var5 = scripts\engine\utility::array_removeundefined(var5);
      var5 = var4;
      var2 = var1 withattachments(var5);
    }

    var9 = scripts\mp\utility\weapon::getweaponfullname(var2);
    scripts\cp_mp\utility\inventory_utility::_giveweapon(var2);
    self assignweaponprimaryslot(var9);
    scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate(var9);
    fixupplayerweapons(self, var9);
    self setweaponammoclip(var2, self.graverobberammo.lastweapon.rightclip, "right");
    self setweaponammoclip(var2, self.graverobberammo.lastweapon.leftclip, "left");
    self setweaponammostock(var2, self.graverobberammo.lastweapon.stock);
    var10 = self getweaponslistprimaries();

    foreach(var12 in var10) {
      addscavengercliptoweapon(self, var12, 0.5);
    }

    if(isDefined(var4)) {
      wait 0.05;
      var5 = getweaponattachments(var2);
      var14 = scripts\engine\utility::array_find(var5, var4);

      if(!isDefined(var14)) {
        var14 = 0;
      }

      self setclientomnvar("ui_weapon_pickup", var14 + 1);
      self playlocalsound("attachment_pickup");
      return;
    }

    return;
  }
}

function getrandomgraverobberattachment(var0, var1) {
  if(!isDefined(var0)) {
    return undefined;
  }

  var2 = scripts\mp\utility\weapon::getweaponrootname(var0);
  var3 = getweaponattachments(var0);
  var4 = [];

  if(isDefined(var1) && var1.size > 0) {
    var4 = var1;
  } else {
    var4 = scripts\mp\utility\weapon::register_wave_spawner(var2);
  }

  if(!isDefined(var4)) {
    return undefined;
  }

  foreach(var6 in var3) {
    var7 = scripts\mp\utility\weapon::attachmentmap_tobase(var6);

    if(!scripts\mp\utility\weapon::carriedpunchcard(var0, var7)) {
      var3[var8] = undefined;
    }
  }

  var4 = scripts\engine\utility::can_be_shot_again(var4);
  var4 = scripts\engine\utility::array_randomize(var4);

  foreach(var10 in var4) {
    if(!isgraverobberattachment(var2, var10)) {
      continue;
    }

    var11 = 0;

    foreach(var6 in var3) {
      if(scripts\mp\utility\weapon::attachmentsconflict(var6, var10, var0) != "") {
        var11 = 1;
        break;
      }
    }

    if(var11) {
      continue;
    }

    return var10;
  }

  return undefined;
}

function addattachmenttoweapon(var0, var1) {
  var2 = getweaponvariantindex(var0);
  var0 = var0 getnoaltweapon();
  var3 = var0.attachmentvarindices;
  var4 = [];
  var5 = [];

  foreach(var9, var7 in var3) {
    var8 = scripts\mp\utility\weapon::attachmentmap_tobase(var9);
    var5 = var8;
    var4 = var7;
  }

  var10 = 0;

  if(scripts\engine\utility::array_contains(var5, var1)) {
    var10 = 1;
  } else {
    var11 = scripts\mp\utility\weapon::attachmentmap_tounique(var1, var0);

    if(!var0 canuseattachment(var11)) {
      var10 = 1;
    }
  }

  if(var10) {
    return undefined;
  }

  var5 = scripts\mp\utility\weapon::weaponattachremoveextraattachments(var5, var0);
  var12 = [];

  foreach(var9 in var5) {
    var12 = var4[var9];
  }

  var5 = var1;
  var12 = 0;
  var15 = var0.camo;
  var16 = [];

  if(isDefined(var0.stickerslot0)) {
    GscBinSkip0(0x2e, var16.size, var0.stickerslot0);
  }

  if(isDefined(var0.stickerslot1)) {
    GscBinSkip0(0x2e, var16.size, var0.stickerslot1);
  }

  if(isDefined(var0.stickerslot2)) {
    GscBinSkip0(0x2e, var16.size, var0.stickerslot2);
  }

  if(isDefined(var0.stickerslot3)) {
    GscBinSkip0(0x2e, var16.size, var0.stickerslot3);
  }

  var17 = scripts\cp_mp\utility\game_utility::isnightmap();
  var0 = scripts\mp\class::buildweapon(scripts\mp\utility\weapon::getweaponrootname(var0), var5, var15, "none", var2, var12, undefined, var16, var17);
  return var0;
}

function getammooverride(var0) {
  var1 = var0 getbaseweapon();
  var2 = weaponclipsize(var1);
  var3 = weaponclipsize(var0);
  var4 = var2;

  switch (var0.basename) {
    case "iw8_lm_mkilo3_mp":
    case "iw8_sh_mike26_mp":
    case "iw8_sn_sksierra_mp":
      break;
    default:
      var4 = int(min(var2, var3));
      break;
  }

  var5 = scripts\mp\utility\weapon::getweaponrootname(var0);
  var6 = 30;

  if(var0.isalternate) {
    var7 = scripts\mp\utility\weapon::attachmentmap_tobase(var0.underbarrel);

    switch (var7) {
      case "glsnap":
      case "glsemtex":
      case "glincendiary":
      case "glflash":
      case "glconc":
      case "glgas":
      case "glsmoke":
      case "gl":
        var6 = 1;
        break;
      case "ubshtgn":
        var6 = 999;
        break;
      default:
        var6 = 0;
        break;
    }
  } else {
    switch (var0.classname) {
      case "spread":
        switch (var5) {
          case "iw8_sh_charlie725":
            var6 = 6;
            break;
          case "iw8_sh_dpapa12":
            var6 = 8;
            break;
          default:
            var6 = int(min(var4, 30));
            break;
        }

        break;
      case "sniper":
        switch (var5) {
          case "iw8_sn_crossbow":
            var6 = 3;
            break;
          default:
            var6 = int(min(var4, 30));
            break;
        }

        break;
      default:
        var6 = int(min(var4, 30));
        break;
    }
  }

  return var6;
}

function isgraverobberattachment(var0, var1) {
  if(!scripts\mp\utility\weapon::carriedpunchcard(var0, var1)) {
    return false;
  }

  switch (var1) {
    case "laserbalanced":
    case "maxammo":
    case "laserrange":
    case "akimbo":
      return false;
  }

  if(issubstr(var1, "thermal")) {
    return false;
  }

  if(issubstr(var1, "burst")) {
    return false;
  }

  if(getsubstr(var1, 0, 3) == "cal") {
    return false;
  }

  return true;
}

function notifyuiofpickedupweapon() {}

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

function itemremoveammofromaltmodes() {
  var0 = getitemweaponname();
  var1 = weaponaltweaponname(var0);

  for(var2 = 1; var1 != "none" && var1 != var0; var2++) {
    self itemweaponsetammo(0, 0, 0, var2);
    var1 = weaponaltweaponname(var1);
  }
}

function ref_12082(var0) {
  if(isDefined(level.ref_12082)) {
    [[level.ref_12082]](var0);
    return;
  }

  scavengergiveammo(var0);
  var0 scripts\mp\equipment::givescavengerammo();
  var0 scripts\mp\gametypes\br_plunder::ref_12627(level.™Û sÇ› Ÿ8ùJ #— Õx£ éCÐãkÝ);
}

function handlescavengerbagpickup(var0) {
  self endon("death");
  level endon("game_ended");

  for(;;) {
    self waittill("scavenger", var1);

    if(!var1 scripts\cp_mp\utility\player_utility::isinvehicle()) {
      break;
    }
  }

  var1 notify("scavenger_pickup");
  ref_12082(var1);

  if(!isDefined(var1.pers["scavengerPickedUp"])) {
    var1.pers["scavengerPickedUp"] = 0;
  }

  var1 scripts\cp\vehicles\vehicle_compass_cp::ref_1205f("scavengerAmmo", 0);
  var1 scripts\mp\utility\stats::incpersstat("scavengerPickedUp", 1);
  var1 scripts\mp\damagefeedback::hudicontype("scavenger");
  var2 = scripts\mp\utility\game::unset_relic_grounded();

  if(istrue(var2)) {
    var1 scripts\mp\equipment::incrementequipmentslotammo("health", 1);
  }

  if(isDefined(self.useobj)) {
    self.useobj delete();
  }

  self notify("death");
}

function scavengergiveammo(var0) {
  var1 = var0 getweaponslistprimaries();

  foreach(var3 in var1) {
    addscavengercliptoweapon(var0, var3, 1);
  }

  var5 = scripts\mp\utility\game::unset_relic_grounded();

  if(istrue(var5)) {
    bbeingelectrocuted(var0, 1);
    return;
  }
}

function addscavengercliptoweapon(var0, var1, var2) {
  if(!scripts\mp\utility\weapon::iscacprimaryweapon(var1) && !level.scavenger_secondary) {
    return;
  }

  if(var1.isalternate) {
    return;
  }

  if(scripts\mp\utility\weapon::getweapongroup(var1) == "weapon_projectile") {
    return;
  }

  var3 = var0 getweaponammostock(var1);
  var4 = getammooverride(var1);
  var4 = int(ceil(var2 * var4));

  if(var1 hasattachment("akimbo", 1)) {
    var4 *= 1;
  }

  var0 setweaponammostock(var1, var3 + var4);
}

function bbeingelectrocuted(var0, var1) {
  var0 scripts\mp\equipment::incrementequipmentslotammo("health", var1);
}

function scavenger_budget_delete() {
  if(isDefined(self.useobj)) {
    self.useobj delete();
  }

  self delete();
}

function dropscavengerfordeath(var0, var1) {
  self endon("spawned_player");
  level endon("game_ended");

  if(!shoulddropscavengerbag(var0, var1)) {
    return;
  }

  var2 = 0;

  if(isDefined(var1) && var1 == "MOD_EXECUTION") {
    var2 = 1.5;
  }

  wait var2;

  if(var2 > 0 && !shoulddropscavengerbag(var0, var1)) {
    return;
  }

  dropscavengerfordeathinternal(var0);
}

function dropscavengerfordeathinternal(var0) {
  var1 = self dropscavengerbag("scavenger_bag_mp", "j_head");

  if(!isDefined(var1)) {
    return;
  }

  var1 scripts\cp_mp\ent_manager::registerspawn(2, &scavenger_budget_delete);
  var1.owner = var0;
  var1.team = var0.team;
  var2 = scripts\mp\utility\game::unset_relic_grounded();

  if(istrue(var2)) {
    var1.outlineid = scripts\mp\utility\outline::outlineenableforplayer(var1, var1.owner, "outline_depth_cyan", "perk");
    thread handlescavengerbagpickup(var1);
    thread scavengerbagcleanupthink(var1);
    thread scavengerbagtimeoutthink(var1);
  } else {
    thread handlescavengerbagpickup(var1);
    thread scavengerbagcleanupthink();
    thread scavengerbagtimeoutthink();
  }

  if(isDefined(level.bot_funcs) && isDefined(level.bot_funcs["bots_add_scavenger_bag"])) {
    [[level.bot_funcs["bots_add_scavenger_bag"]]](var1);
    return;
  }
}

function shoulddropscavengerbag(var0, var1) {
  if(!isDefined(var0)) {
    return false;
  }

  if(var0 == self) {
    return false;
  }

  return true;
}

function scavengerbagcleanupthink(var0) {
  self endon("death");
  level endon("game_ended");
  self.owner scripts\engine\utility::ref_143a6("death_or_disconnect", "joined_team", "bag_timeout");

  if(isDefined(self)) {
    if(isDefined(self.useobj)) {
      var1 = scripts\mp\utility\game::unset_relic_grounded();

      if(istrue(var1)) {
        scripts\mp\utility\outline::outlinedisable(var0, self);
      }

      self.useobj delete();
    }

    scripts\cp_mp\ent_manager::deregisterspawn();
    self delete();
    return;
  }
}

function scavengerbagtimeoutthink(var0) {
  self endon("death");
  self.owner endon("disconnect");
  level endon("game_ended");
  var1 = scripts\mp\utility\game::unset_relic_grounded();
  wait scripts\engine\utility::ter_op(var1, 60, 20);

  if(istrue(var1)) {
    scripts\mp\utility\outline::outlinedisable(var0, self);
  }

  if(isDefined(self)) {
    self.owner notify("bag_timeout");
    return;
  }
}

function scavengerbagusesetup() {
  self endon("death");
  self.owner endon("disconnect");
  level endon("game_ended");
  var0 = &"PERKS/HOLD_TO_SCAVENGE";
  self.useobj = scripts\mp\gameobjects::createhintobject(self.origin + anglestoup(self.angles) * 1, "HINT_BUTTON", undefined, var0, undefined, undefined, "show", 200, 160, 100, 160);
  self.useobj.owner = self.owner;
  self.useobj.team = self.team;
  self.useobj linkTo(self);

  foreach(var2 in level.players) {
    self.useobj disableplayeruse(var2);
  }

  thread scavengebagthink();
  thread scavengebagusemonitoring();

  for(;;) {
    self waittill("pickedUpScavengerBag", var2);

    if(isPlayer(var2)) {
      var2 notify("scavenger_pickup");
      ref_12082(var2);
      var2 scripts\mp\damagefeedback::hudicontype("scavenger");

      if(isDefined(self.useobj)) {
        self.useobj delete();
      }

      self notify("death");
    }
  }
}

function scavengebagusemonitoring() {
  self endon("death");
  self.owner endon("disconnect");
  level endon("game_ended");
  var0 = 1;

  while(var0) {
    wait 0.1;

    foreach(var2 in level.players) {
      if(!isDefined(self)) {
        var0 = 0;
        continue;
      }

      if(var2.team != self.team || var2 scripts\mp\utility\perk::_hasperk("specialty_scavenger")) {
        self.useobj disableplayeruse(var2);
        continue;
      }

      self.useobj enableplayeruse(var2);
    }
  }
}

function scavengebagthink() {
  self endon("restarting_physics");
  var0 = self.useobj;
  var1 = undefined;
  jumpiffalse(istrue(level.gameended) && !isDefined(var0)) LOC_00000022;
  return;
}

function useholdthink(var0, var1) {
  self.curprogress = 0;
  self.inuse = 1;
  self.userate = 0;
  self.usetime = var1;
  scripts\mp\movers::script_mover_link_to_use_object(var0);
  var0 scripts\common\utility::allow_weapon(0);
  var2 = useholdthinkloop(var0);

  if(isalive(var0)) {
    var0 scripts\common\utility::allow_weapon(1);
  }

  if(isDefined(var0)) {
    scripts\mp\movers::script_mover_unlink_from_use_object(var0);
  }

  if(!isDefined(self)) {
    return 0;
  }

  self.inuse = 0;
  self.curprogress = 0;
  return var2;
}

function useholdthinkloop(var0) {
  var1 = internal_useholdthinkloop(var0);

  if(isDefined(self)) {
    var0 scripts\mp\gameobjects::updateuiprogress(self, 0);
  }

  return istrue(var1);
}

function internal_useholdthinkloop(var0) {
  self endon("endUseHoldThink");

  while(isplayerusing(var0, self)) {
    if(!var0 scripts\mp\movers::script_mover_use_can_link(self)) {
      return 0;
    }

    self.curprogress += level.framedurationseconds * self.userate;

    if(isDefined(self.objectivescaler)) {
      self.userate = 1 * self.objectivescaler;
    } else {
      self.userate = 1;
    }

    var0 scripts\mp\gameobjects::updateuiprogress(self, 1);

    if(self.curprogress >= self.usetime) {
      return scripts\mp\utility\player::isreallyalive(var0);
    }

    waitframe();
  }

  return 0;
}

function createuseent() {
  var0 = spawn("script_origin", self.origin);
  var0.curprogress = 0;
  var0.usetime = 0;
  var0.userate = 3000;
  var0.inuse = 0;
  var0.id = self.id;
  var0 linkTo(self);
  thread deleteuseent(var0);
  return var0;
}

function deleteuseent(var0) {
  self endon("death");
  var0 waittill("death");

  if(isDefined(self.usedby)) {
    foreach(var2 in self.usedby) {
      var2 setclientomnvar("ui_securing", 0);
      var2.ui_securing = undefined;
    }
  }

  self delete();
}

function isplayerusing(var0) {
  return !level.gameended && isDefined(var0) && scripts\mp\utility\player::isreallyalive(self) && self useButtonPressed() && !self isonladder() && !self meleeButtonPressed() && var0.curprogress < var0.usetime && (!isDefined(self.teleporting) || !self.teleporting);
}

function weaponcanstoreaccuracystats(var0) {
  if(scripts\mp\utility\weapon::iscacmeleeweapon(var0.basename)) {
    return false;
  }

  return scripts\mp\utility\weapon::iscacprimaryweapon(var0.basename) || scripts\mp\utility\weapon::iscacsecondaryweapon(var0.basename);
}

function setweaponstat(var0, var1, var2) {
  scripts\mp\gamelogic::setweaponstat(var0, var1, var2);
}

function watchweaponusage(var0) {
  self endon("death_or_disconnect");
  self endon("faux_spawn");
  level endon("game_ended");

  for(;;) {
    self waittill("weapon_fired", var1);
    onweaponfired(var1);
  }
}

function onweaponfired(var0) {
  scripts\mp\gamelogic::sethasdonecombat(self, 1);
  var1 = gettime();

  if(!isDefined(self.lastshotfiredtime)) {
    self.lastshotfiredtime = 0;
  }

  var2 = gettime() - self.lastshotfiredtime;
  self.lastshotfiredtime = var1;

  if(isai(self)) {
    return;
  }

  if(!weaponcanstoreaccuracystats(var0)) {
    return;
  }

  thread watchformiss(var0);

  if(scripts\mp\utility\game::onlinestatsenabled()) {
    var3 = scripts\mp\playerstats_interface::getplayerstat("combatStats", "totalShots") + 1;
    var4 = scripts\mp\playerstats_interface::getplayerstat("combatStats", "hits");
    scripts\mp\playerstats_interface::setplayerstatbuffered(var3, "combatStats", "totalShots");
    scripts\mp\playerstats_interface::setplayerstatbuffered(int(var3 - var4), "combatStats", "misses");
  }

  var5 = 1;
  setweaponstat(var0, var5, "shots");
  setweaponstat(var0, self.hits, "hits");
  scripts\mp\utility\stats::incpersstat("shotsFired", 1);
  self.hits = 0;

  if(self getweaponammoclip(var0) == 0 && self getweaponammostock(var0) == 0) {
    level thread scripts\mp\battlechatter_mp::trysaylocalsound(self, "flavor_negative");
    return;
  }
}

function watchformiss(var0) {
  self endon("death_or_disconnect");
  var1 = createheadicon(var0);
  self endon("watchForMiss_" + var1);
  waitframe();
  self.consecutivehitsperweapon[var1] = 0;
  scripts\mp\events::shotmissed();
}

function clearmiss(var0) {
  self endon("death_or_disconnect");
  var1 = createheadicon(var0);
  self notify("watchForMiss_" + var1);
}

function ref_144c3() {
  self endon("death_or_disconnect");
  self endon("faux_spawn");
  level endon("game_ended");

  for(;;) {
    self waittill("attackerbulletwhizby");
    scripts\mp\playerstats_interface::addtoplayerstatbuffered(1, "combatStats", "nearMisses");
  }
}

function checkhit(var0, var1) {
  self endon("disconnect");

  if(var0.isalternate) {
    var2 = scripts\mp\utility\weapon::getweaponattachmentsbasenames(var0);

    if(scripts\engine\utility::array_contains(var2, "shotgun") || scripts\engine\utility::array_contains(var2, "gl") || scripts\engine\utility::array_contains(var2, "glsmoke") || scripts\engine\utility::array_contains(var2, "glgas") || scripts\engine\utility::array_contains(var2, "glconc") || scripts\engine\utility::array_contains(var2, "glflash") || scripts\engine\utility::array_contains(var2, "glincendiary") || scripts\engine\utility::array_contains(var2, "glsemtex") || scripts\engine\utility::array_contains(var2, "glsnap")) {
      self.hits = 1;
    }
  }

  if(!weaponcanstoreaccuracystats(var0)) {
    return;
  }

  if(self meleeButtonPressed() && var0.basename != "iw8_knife_mp") {
    return;
  }

  switch (weaponclass(var0)) {
    case "smg":
    case "pistol":
    case "sniper":
    case "mg":
    case "rifle":
      self.hits++;
      break;
    case "spread":
      self.hits = 1;
      break;
    default:
      break;
  }

  var3 = createheadicon(var0);

  if(scripts\mp\riotshield::isriotshield(var0.basename) || var0.basename == "iw8_knife_mp") {
    thread scripts\mp\gamelogic::threadedsetweaponstatbyname(var3, self.hits, "hits");
    self.hits = 0;
  }

  waittillframeend();
  thread clearmiss(var0);

  if(!isDefined(self.lasthittime[var3])) {
    self.lasthittime[var3] = 0;
  }

  if(self.lasthittime[var3] == gettime()) {
    return;
  }

  self.lasthittime[var3] = gettime();

  if(!isDefined(self.consecutivehitsperweapon) || !isDefined(self.consecutivehitsperweapon[var3])) {
    self.consecutivehitsperweapon[var3] = 1;
  } else {
    self.consecutivehitsperweapon[var3]++;
    scripts\cp\vehicles\vehicle_compass_cp::ref_12007(var0, self.consecutivehitsperweapon[var3]);
  }

  if(scripts\mp\utility\game::onlinestatsenabled()) {
    var4 = scripts\mp\playerstats_interface::getplayerstat("combatStats", "totalShots");
    var5 = scripts\mp\playerstats_interface::getplayerstat("combatStats", "hits") + 1;

    if(var5 <= var4) {
      scripts\mp\playerstats_interface::setplayerstatbuffered(var5, "combatStats", "hits");
      scripts\mp\playerstats_interface::setplayerstatbuffered(int(var4 - var5), "combatStats", "misses");
    }
  }

  thread scripts\cp\vehicles\vehicle_compass_cp::onsuccessfulhit(var0);
  thread scripts\mp\events::shothit();
  var6 = scripts\mp\utility\weapon::getweapongroup(var0.basename);

  if(var6 == "weapon_lmg") {
    if(!isDefined(self.shotslandedlmg)) {
      self.shotslandedlmg = 1;
    } else {
      self.shotslandedlmg++;
    }
  }

  var7 = gettime();
  self.lastdamagetime = var7;

  if(isDefined(var1)) {
    var1.lasttimedamaged = var7;
    return;
  }
}

function friendlyfirecheck(var0, var1, var2, var3) {
  if(!isDefined(var0)) {
    return true;
  }

  if(!level.teambased) {
    return true;
  }

  var4 = level.friendlyfire;

  if(isDefined(var2)) {
    var4 = var2;
  }

  if(var4 != 0) {
    return true;
  }

  if(var1 == var0 || isDefined(var1.owner) && var1.owner == var0) {
    return true;
  }

  var5 = undefined;

  if(isDefined(var1.owner)) {
    var5 = var1.owner.team;
  } else if(isDefined(var1.team)) {
    var5 = var1.team;
  }

  if(!isDefined(var5)) {
    return true;
  }

  if(var5 != var0.team) {
    return true;
  }

  return false;
}

function watchequipmentonspawn() {
  self notify("watchEquipmentOnSpawn");
  self endon("watchEquipmentOnSpawn");
  self endon("spawned_player");
  self endon("disconnect");
  self endon("faux_spawn");
  deletedisparateplacedequipment();
  var0 = scripts\mp\utility\dvars::getintproperty("scr_deleteexplosivesonspawn", 1) && (!scripts\mp\utility\perk::_hasperk("specialty_rugged_eqp") || !checkequipforrugged());

  if(var0) {
    deleteplacedequipment();
  }

  var1 = self.plantedtacticalequip.size;
  var2 = self.plantedlethalequip.size;
  var3 = self.plantedsuperequip.size;
  var4 = self.plantedhackedequip.size;
  var5 = var1 && var2 && var3 && var4;

  if(scripts\mp\utility\perk::_hasperk("specialty_rugged_eqp") && var5) {
    thread scripts\mp\perks\perkfunctions::feedbackruggedeqp(var2, var1, var3, var4);
    return;
  }
}

function getallequip() {
  var0 = [];

  if(isDefined(self.plantedlethalequip)) {
    var0 = scripts\engine\utility::array_combine(var0, self.plantedlethalequip);
  }

  if(isDefined(self.plantedtacticalequip)) {
    var0 = scripts\engine\utility::array_combine(var0, self.plantedtacticalequip);
  }

  if(isDefined(self.plantedsuperequip)) {
    var0 = scripts\engine\utility::array_combine(var0, self.plantedsuperequip);
  }

  if(isDefined(self.plantedhackedequip)) {
    var0 = scripts\engine\utility::array_combine(var0, self.plantedhackedequip);
  }

  return var0;
}

function removeequip(var0) {
  if(isDefined(self.plantedlethalequip)) {
    self.plantedlethalequip = scripts\engine\utility::array_remove(self.plantedlethalequip, var0);
  }

  if(isDefined(self.plantedtacticalequip)) {
    self.plantedtacticalequip = scripts\engine\utility::array_remove(self.plantedtacticalequip, var0);
  }

  if(isDefined(self.plantedsuperequip)) {
    self.plantedsuperequip = scripts\engine\utility::array_remove(self.plantedsuperequip, var0);
  }

  if(isDefined(self.plantedhackedequip)) {
    self.plantedhackedequip = scripts\engine\utility::array_remove(self.plantedhackedequip, var0);
    return;
  }
}

function checkequipforrugged() {
  var0 = scripts\engine\utility::array_combine(self.plantedtacticalequip, self.plantedlethalequip);

  foreach(var2 in var0) {
    if(isDefined(var2.hasruggedeqp)) {
      return true;
    }
  }

  return false;
}

function watchgrenadeusage() {
  self notify("watchGrenadeUsage");
  self endon("watchGrenadeUsage");
  self endon("spawned_player");
  self endon("disconnect");
  self endon("faux_spawn");

  for(;;) {
    watchgrenadethrows();
  }
}

function watchgrenadethrows() {
  var0 = _utilflare_isvalidflaretype::waittill_grenade_throw();

  if(!isDefined(var0)) {
    return;
  }

  if(!isDefined(var0.weapon_name)) {
    return;
  }

  setweaponstat(var0.weapon_name, 1, "shots");
  var1 = scripts\mp\equipment::isequipmentlethal(var0.weapon_name);
  var2 = isDefined(var0.equipmentref) && scripts\mp\equipment::isequipmenttactical(var0.equipmentref);
  scripts\mp\potg_events::grenadethrownevent(var1);
  scripts\mp\battlechatter_mp::ongrenadeuse(var0);
  scripts\mp\gamelogic::sethasdonecombat(self, 1);

  if(var2 && self isthrowingbackgrenade() && getdvarint("scr_infinite_tacticals_cleanup", 1)) {
    self method_87a9();
    var3 = getcompleteweaponname(var0.weapon_name);
    var4 = self getweaponammoclip(var3);
    var5 = int(max(var4 - 1, 0));
    self setweaponammoclip(var3, var5);
  }

  if(scripts\mp\utility\weapon::isaxeweapon(var0.weapon_name)) {
    var0 thread _utilflare_isvalidflaretype::watchgrenadeaxepickup(self);
    return;
  }

  var0 thread scripts\mp\battlechatter_mp::grenadeproximitytracking();
  var0.spawnpos = var0.origin;

  switch (var0.weapon_name) {
    case "frag_grenade_mp":
      if(var0.ticks >= 1) {
        var0.iscooked = 1;
      }

      var0.originalowner = self;
      var0 thread scripts\mp\shellshock::grenade_earthquake();
      break;
    case "pop_rocket_mp":
      if(var0.ticks >= 1) {
        var0.iscooked = 1;
      }

      var0.originalowner = self;
      thread scripts\mp\equipment\wristrocket::wristrocketused(var0);
      var0 thread scripts\mp\shellshock::grenade_earthquake(0.6);
      break;
    case "semtex_mp":
      thread ref_13018(var0);
      var0 thread scripts\mp\shellshock::grenade_earthquake();
      break;
    case "c4_mp_p":
      thread scripts\mp\equipment\c4::c4_used(var0);
      break;
    case "emp_grenade_mp":
      thread scripts\mp\equipment\emp_grenade::emp_grenade_used(var0);
      break;
    case "snapshot_grenade_mp":
      thread scripts\mp\equipment\snapshot_grenade::snapshot_grenade_used(var0, 0);
      break;
    case "smoke_grenade_mp":
      thread smokegrenadeused();
      break;
    case "trophy_mp":
      thread scripts\mp\equipment\trophy_system::trophy_used(var0);
      break;
    case "decon_station_mp":
      thread _debug_rooftop_heli_start::jeep_initomnvars(var0);
      break;
    case "claymore_mp":
      thread scripts\mp\equipment\claymore::claymore_use(var0);
      break;
    case "at_mine_mp":
      thread scripts\mp\equipment\at_mine::at_mine_use(var0);
      break;
    case "throwingknife_fire_mp":
    case "throwingknife_electric_mp":
    case "throwingknife_drill_mp":
    case "throwingknife_mp":
      thread scripts\cp_mp\equipment\throwing_knife::throwing_knife_used(var0);
      break;
    case "molotov_mp":
      var0 thread scripts\mp\shellshock::grenade_earthquake();
      thread scripts\mp\equipment\molotov::molotov_used(var0);
      break;
    case "thermite_mp":
      thread scripts\mp\equipment\thermite::thermite_used(var0);
      break;
    case "tac_ops_spawn_grenade_mp":
      thread scripts\mp\supers\spawnbeacon::thrown(var0);
      break;
    case "tac_ops_supply_pack_grenade_mp":
      thread scripts\mp\tac_ops\roles_utility::throwsupplypack(var0);
      break;
    case "support_box_mp":
      thread scripts\mp\equipment\support_box::supportbox_used(var0);
      break;
    case "armor_box_mp":
      thread scripts\mp\equipment\support_box::calloutmarkerpingvo_playpredictivepingadded(var0);
      break;
    case "decoy_grenade_mp":
      thread scripts\mp\equipment\decoy_grenade::decoy_used(var0);
      break;
    case "gas_mp":
      thread scripts\mp\equipment\gas_grenade::gas_used(var0);
      break;
    case "hb_sensor_mp":
      thread scripts\mp\equipment\hb_sensor::hb_sensor_used(var0);
      break;
    case "geiger_counter_mp":
      thread _determinelocationarray::postspawn_juggernaut(var0);
      break;
    case "offhand_spotter_scope_mp":
      thread _debug_rooftop_activesat::colmodel(var0);
      break;
    case "tac_cover_mp":
      thread scripts\mp\equipment\tactical_cover::tac_cover_used(var0);
      break;
    case "flare_mp":
      thread scripts\mp\equipment\tac_insert::tacinsert_used(var0);
      break;
    case "advanced_supply_drop_marker_mp":
      thread scripts\mp\equipment\advanced_supply_drop::advanced_supply_drop_marker_used(var0);
      break;
    case "advanced_vehicle_drop_marker_mp":
      thread scripts\mp\equipment\advanced_supply_drop::binoculars_onstatelospendingupdate(var0);
      break;
    case "advanced_loot_drop_marker_mp":
      thread scripts\mp\equipment\advanced_supply_drop::binoculars_onstateinvalidupdate(var0);
      break;
    case "deploy_weapondrop_mp":
      thread scripts\mp\equipment\weapon_drop::weapondrop_used(var0);
      break;
    case "kiosk_drop_marker_mp":
      thread _findgivearmoramountanddropleftovers::wait_between_combat_action(var0);
      break;
    case "concussion_grenade_mp":
      thread hoopty_truck_initdamage();
      break;
    case "jammer_br":
      thread _donewithcorpse::vehicle_compass_instanceisregistered(var0);
      break;
    case "emp_gadget_mp":
      thread _debug_rooftop_raid_exfil::morsenumber(var0);
      break;
    case "numbers_grenade_mp":
      thread scripts\mp\equipment\numbers_grenade::numbers_grenade_used(var0);
      break;
    default:
      if(isDefined(level.ref_1203b)) {
        [[level.ref_1203b]](var0.weapon_name, var0);
      }

      break;
  }

  ref_119b0(var0.weapon_name);
}

function ref_119b0(var0) {
  if(!isDefined(var0)) {
    return;
  }

  var1 = scripts\mp\utility\weapon::getequipmenttype(var0);

  if(!isDefined(var1)) {
    var1 = "none";
  }

  self dlog_recordplayerevent("dlog_event_equipment_use", ["weapon_used", var0, "equipment_type", var1]);
}

function hoopty_truck_initdamage() {
  thread scripts\mp\utility\script::notifyafterframeend("death", "end_explode");
  self endon("end_explode");
  var0 = self.owner;
  self waittill("explode", var1);
  thread scripts\mp\equipment\concussion_grenade::ref_12031(var0, var1);
}

function smokegrenadeused(var0) {
  thread scripts\mp\utility\script::notifyafterframeend("death", "end_explode");
  self endon("end_explode");
  jumpiffalse(istrue(var0)) LOC_00000054;
  self waittill("missile_stuck", var1, var2, var3, var4, var5, var6);
  thread ref_13426(var5);
  thread scripts\mp\bots\bots::init_leave_cave(var5);
  goto LOC_00000060;
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

function smokegrenadeexplode(var0) {
  wait 1;
  thread smokegrenadegiveblindeye(var0);
  var1 = scripts\mp\utility\outline::addoutlineoccluder(var0, 330);
  wait 8.25;
  scripts\mp\utility\outline::removeoutlineoccluder(var1);
}

function ref_13426(var0, var1) {
  playFX(scripts\engine\utility::getfx("glsmoke"), var0, anglestoup((0, 90, 0)));
}

function smokegrenadegiveblindeye(var0) {
  var1 = spawnStruct();
  var1.blindeyerecipients = [];
  smokegrenademonitorblindeyerecipients(var1, var0);

  foreach(var3 in var1.blindeyerecipients) {
    if(isDefined(var3) && scripts\mp\utility\player::isreallyalive(var3)) {
      var3 scripts\mp\utility\perk::removeperk("specialty_blindeye");
    }
  }
}

function smokegrenademonitorblindeyerecipients(var0, var1) {
  level endon("game_ended");
  var2 = gettime() + 8250;
  var3 = [];

  while(gettime() < var2) {
    var3 = scripts\mp\utility\player::getplayersinradius(var1, 330);

    foreach(var7, var5 in var0.blindeyerecipients) {
      if(!isDefined(var5)) {
        var0.blindeyerecipients[var7] = undefined;
        continue;
      }

      var6 = scripts\engine\utility::array_find(var3, var5);

      if(!isDefined(var6) || !scripts\mp\utility\player::isreallyalive(var5)) {
        if(var5 scripts\mp\utility\perk::_hasperk("specialty_blindeye")) {
          var5 scripts\mp\utility\perk::removeperk("specialty_blindeye");
        }

        var0.blindeyerecipients[var7] = undefined;
      }

      if(isDefined(var6)) {
        var3[var6] = undefined;
      }
    }

    foreach(var9 in var3) {
      if(!isDefined(var9)) {
        continue;
      }

      var9.lastinsmoketime = gettime();

      if(isDefined(var0.blindeyerecipients[var9 getentitynumber()])) {
        continue;
      }

      if(!scripts\mp\utility\player::isreallyalive(var9) || scripts\mp\utility\entity::isspidergrenade(var9)) {
        continue;
      }

      var9 scripts\mp\utility\perk::giveperk("specialty_blindeye");
      var0.blindeyerecipients[var9 getentitynumber()] = var9;
    }

    waitframe();
  }
}

function monitorsmokeactive() {
  self endon("disconnect");
  level endon("game_ended");
  self notify("monitorSmokeActive()");
  self endon("monitorSmokeActive()");
  scripts\mp\utility\print::printgameaction("smoke grenade activated", self);
  self.hasactivesmokegrenade = 1;
  var0 = scripts\engine\utility::ref_143b9(9.25, "death");
  self.hasactivesmokegrenade = 0;
  scripts\mp\utility\print::printgameaction("smoke grenade deactivated", self);
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
        if(isDefined(var8) && isDefined(var8.affectedbylockon) && (var8.team != self.team || var2)) {
          var1 = var8;
        }
      }
    }

    jumpiffalse(isDefined(level.cratedropdata)) LOC_00000131;
    jumpiffalse(isDefined(level.cratedropdata.ac130s)) LOC_00000131;

    foreach(var11 in level.cratedropdata.ac130s) {
      if(isDefined(var11) && (var11.team != self.team || var2)) {
        var1 = var11;
      }
    }

    foreach(var14 in var3) {
      var15 = scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_getgameinstances(var14);

      foreach(var17 in var15) {
        if(isDefined(var17) && (!scripts\cp_mp\vehicles\vehicle::ref_141b9(var17, self) || var2)) {
          var1 = var17;
        }
      }
    }
  } else {
    if(isDefined(var3) && var3 == 1) {
      foreach(var5 in level.characters) {
        if((!isDefined(var5) || !isalive(var5)) && !var15) {
          continue;
        }

        var14 = var5;
      }
    }

    if(isDefined(level.activekillstreaks)) {
      foreach(var8 in level.activekillstreaks) {
        if(isDefined(var8.affectedbylockon) && (isDefined(var8.owner) && var8.owner != self || var15)) {
          var14 = var8;
        }
      }
    }

    jumpiffalse(isDefined(level.cratedropdata)) LOC_000002b2;
    jumpiffalse(isDefined(level.cratedropdata.ac130s)) LOC_000002b2;

    foreach(var11 in level.cratedropdata.ac130s) {
      if(var11.owner != self || var15) {
        var14 = var11;
      }
    }

    foreach(var14 in var17) {
      var15 = scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_getgameinstances(var14);

      foreach(var17 in var15) {
        if(!isDefined(var17.owner)) {
          var14 = var17;
          continue;
        }

        if(var17.owner != self || var15) {
          var14 = var17;
        }
      }
    }
  }

  return var14;
}

function lockonlaunchers_gettargetvehiclerefs() {
  var0 = ["apc_russian", "atv", "big_bird", "cargo_truck", "cargo_truck_mg", "cop_car", "hoopty", "hoopty_truck", "jeep", "large_transport", "light_tank", "little_bird", "little_bird_mg", "medium_transport", "pickup_truck", "tac_rover", "technical", "van", "loot_chopper", "motorcycle", "veh_a10fd", "veh_bt", "veh_indigo", "open_jeep_carpoc"];

  if(isDefined(level.playerzombieupdatetagobjectives)) {
    var0 = level.playerzombieupdatetagobjectives;
  }

  return var0;
}

function watchmissileusage() {
  self endon("disconnect");

  for(;;) {
    var0 = waittill_missile_fire();
    updatemissilefire(var0);
  }
}

function updatemissilefire(var0) {
  var1 = undefined;
  var2 = 0;

  switch (var0.weapon_name) {
    case "iw8_la_gromeoks_mp":
    case "iw8_la_rpapa7_mp":
    case "iw8_la_gromeo_mp":
    case "iw8_la_t9freefire_mp":
    case "iw8_la_t9standard_mp":
      var1 = self.missilelaunchertarget;
      level thread scripts\mp\battlechatter_mp::watchbrsquadleaderdisconnect(var0);
      level thread scripts\mp\battlechatter_mp::trysaylocalsound(self, "use_rocket", undefined, 0.5);
      break;
    case "iw8_la_juliet_mp":
      var1 = self.javelin.target;
      level thread scripts\mp\battlechatter_mp::javelinfired(self.team, self.javelin.target.origin);
      level thread scripts\mp\battlechatter_mp::trysaylocalsound(self, "use_rocket", undefined, 0.5);
      break;
    case "gl":
      var2 = 1;
      break;
    case "glsmoke":
      var2 = 1;
      thread smokegrenadeused(var0);
      break;
    case "glgas":
      var2 = 1;
      thread scripts\mp\equipment\gas_grenade::gas_used(var0);
      break;
    case "glflash":
    case "glconc":
      var2 = 1;
      break;
    case "glincendiary":
      var2 = 1;
      var0 thread scripts\mp\shellshock::grenade_earthquake();
      thread scripts\mp\equipment\thermite::thermite_used(var0, 1);
      break;
    case "glsemtex":
      var2 = 1;
      break;
    case "glsnap":
      var2 = 1;
      thread scripts\mp\equipment\snapshot_grenade::snapshot_grenade_used(var0, var2);
      break;
    default:
      break;
  }

  if(scripts\cp_mp\utility\weapon_utility::islockonlauncher(var0.weapon_name) && isDefined(var1)) {
    var0.ref_119a0 = var1;
    level notify("stinger_fired", self, var0, var1);
    thread scripts\cp_mp\utility\weapon_utility::watchtargetlockedontobyprojectile(var1, var0);
  }

  if(isPlayer(self)) {
    var0.adsfire = scripts\mp\utility\player::isplayerads();
  }

  if(!var2 && isexplosivemissile(var0.weapon_name)) {
    var3 = 1;

    if(issmallmissile(var0.weapon_name)) {
      var3 = 0.65;
    }

    var0 thread scripts\mp\shellshock::grenade_earthquake(var3);
  }

  scripts\mp\events::missilefired(var0);
}

function issmallmissile(var0) {
  return false;
}

function isexplosivemissile(var0) {
  var1 = getweaponbasename(var0);

  switch (var1) {
    case "pop_rocket_proj_mp":
    case "ac130_25mm_mp":
    case "ac130_40mm_mp":
    case "ac130_105mm_mp":
      return false;
  }

  return true;
}

function movingplatformdetonate(var0) {
  if(!isDefined(var0.lasttouchedplatform) || !isDefined(var0.lasttouchedplatform.destroyexplosiveoncollision) || var0.lasttouchedplatform.destroyexplosiveoncollision) {
    self notify("detonateExplosive");
    return;
  }
}

function monitordisownedequipment(var0, var1, var2) {
  level endon("game_ended");
  var1 endon("death");
  var1 notify("monitorDisownedEquipment()");
  var1 endon("monitorDisownedEquipment()");

  if(istrue(var2)) {
    var0 scripts\engine\utility::ref_143a5("joined_team", "disconnect");
  } else {
    var0 scripts\engine\utility::ref_143a6("joined_team", "joined_spectators", "disconnect");
  }

  deleteexplosive(var1);
}

function monitordisownedgrenade(var0, var1) {
  level endon("game_ended");
  var1 endon("death");
  var1 endon("mine_planted");
  scripts\engine\utility::waittill_any_ents(var0, "joined_team", var0, "joined_spectators", var0, "disconnect", level, "prematch_cleanup");

  if(isDefined(var1)) {
    var1 delete();
    return;
  }
}

function isplantedequipment(var0) {
  return isDefined(level.mines[var0 getentitynumber()]) || istrue(var0.planted);
}

function getmaxplantedlethalequip(var0) {
  var1 = 2;

  if(scripts\mp\utility\perk::_hasperk("specialty_extra_planted_equipment")) {
    var1++;
  }

  return var1;
}

function getmaxplantedtacticalequip(var0) {
  var1 = 2;

  if(scripts\mp\utility\perk::_hasperk("specialty_extra_planted_equipment")) {
    var1++;
  }

  return var1;
}

function getmaxplantedsuperequip(var0) {
  return true;
}

function getmaxplantedhackedequip() {
  return 3;
}

function onequipmentplanted(var0, var1, var2) {
  var0.equipmentref = var1;
  var0.deletefunc = var2;
  var0.planted = 1;
  updateplantedarray(var0);
  var3 = var0 getentitynumber();
  level.mines[var3] = var0;

  if(var1 != "equip_tac_cover") {
    var0 enableplayermarks("equipment");

    if(level.teambased) {
      var0 filteroutplayermarks(self.team);
    } else {
      var0 filteroutplayermarks(self);
    }
  }

  var0 notify("mine_planted");
}

function updateplantedarray(var0) {
  var1 = undefined;
  var2 = 0;
  var3 = scripts\mp\equipment::findequipmentslot(var0.equipmentref);

  if(istrue(var0.ishacked)) {
    var1 = var0.owner.plantedhackedequip;
    var2 = getmaxplantedhackedequip();
  } else if(istrue(var0.issuper)) {
    var1 = var0.owner.plantedsuperequip;
    var2 = getmaxplantedsuperequip(var0.equipmentref);
  } else if(isDefined(var3) && var3 == "primary" || scripts\mp\equipment::isequipmentlethal(var0.equipmentref)) {
    var1 = var0.owner.plantedlethalequip;
    var2 = getmaxplantedlethalequip(self);
  } else if(isDefined(var3) && var3 == "secondary" || scripts\mp\equipment::isequipmenttactical(var0.equipmentref)) {
    var1 = var0.owner.plantedtacticalequip;
    var2 = getmaxplantedtacticalequip(self);
  }

  if(!isDefined(var1)) {
    var4 = "isSuper: " + var0.issuper + ", slot: " + scripts\engine\utility::ter_op(isDefined(var3), var3, "undefined") + ", equipmentRef: " + var0.equipmentref + ", allowed: " + scripts\mp\equipment::is_equipment_slot_allowed("super");
    scripts\mp\utility\script::laststand_dogtags(var4);
  }

  if(var1.size > 0) {
    if(var1.size && var1.size >= var2) {
      var5 = var1[0];
      var1 = scripts\engine\utility::array_remove(var1, var5);
      deleteexplosive(var5);
    }
  }

  var1 = var0;

  if(istrue(var0.ishacked)) {
    var0.owner.plantedhackedequip = var1;
    return;
  }

  if(istrue(var0.issuper)) {
    var0.owner.plantedsuperequip = var1;
    return;
  }

  if(isDefined(var3) && var3 == "primary" || scripts\mp\equipment::isequipmentlethal(var0.equipmentref)) {
    var0.owner.plantedlethalequip = var1;
    return;
  }

  if(isDefined(var3) && var3 == "secondary" || scripts\mp\equipment::isequipmenttactical(var0.equipmentref)) {
    var0.owner.plantedtacticalequip = var1;
    return;
  }
}

function setplantedequipmentuse(var0) {
  var1 = getallequip();

  foreach(var3 in var1) {
    if(isDefined(var3.trigger) && isDefined(var3.owner)) {
      if(var0) {
        var3.trigger enableplayeruse(var3.owner);
        continue;
      }

      var3.trigger disableplayeruse(var3.owner);
    }
  }
}

function cleanupequipment(var0, var1, var2) {
  if(isDefined(var0)) {
    level.mines[var0] = undefined;
  }

  if(isDefined(var1)) {
    var1 delete();
  }

  if(isDefined(var2)) {
    var2 delete();
    return;
  }
}

function equipmenthit(var0, var1, var2, var3) {
  if(scripts\cp_mp\utility\player_utility::playersareenemies(var1, var0)) {
    if(!isDefined(var2)) {
      return;
    }

    if(scripts\mp\utility\weapon::iskillstreakweapon(var2.basename)) {
      return;
    }

    var4 = createheadicon(var2);

    if(!isDefined(var1.lasthittime)) {
      var1.lasthittime = [];
    }

    if(!isDefined(var1.lasthittime[var4])) {
      var1.lasthittime[var4] = 0;
    }

    if(var1.lasthittime[var4] == gettime()) {
      return;
    }

    var1.lasthittime[var4] = gettime();
    var1 thread scripts\mp\gamelogic::threadedsetweaponstatbyname(var4, 1, "hits");

    if(scripts\mp\utility\game::onlinestatsenabled()) {
      var5 = var1 scripts\mp\playerstats_interface::getplayerstat("combatStats", "totalShots");
      var6 = var1 scripts\mp\playerstats_interface::getplayerstat("combatStats", "hits") + 1;

      if(var6 <= var5) {
        scripts\mp\playerstats_interface::setplayerstatbuffered(var6, "combatStats", "hits");
        scripts\mp\playerstats_interface::setplayerstatbuffered(int(var5 - var6), "combatStats", "misses");
      }
    }

    if(isDefined(var3) && scripts\engine\utility::isbulletdamage(var3) || scripts\mp\utility\damage::isprojectiledamage(var3)) {
      var1.lastdamagetime = gettime();
      var7 = scripts\mp\utility\weapon::getweapongroup(var2.basename);

      if(var7 == "weapon_lmg") {
        if(!isDefined(var1.shotslandedlmg)) {
          var1.shotslandedlmg = 1;
          return;
        }

        var1.shotslandedlmg++;
        return;
      }

      return;
    }

    return;
  }
}

function deleteexplosive() {
  if(!isDefined(self)) {
    return;
  }

  scripts\mp\sentientpoolmanager::unregistersentient(self.sentientpool, self.sentientpoolindex);
  var0 = self getentitynumber();
  level.mines[var0] = undefined;
  self disableplayermarks("equipment");

  if(isDefined(self.deletefunc)) {
    self thread[[self.deletefunc]]();
    self notify("deleted_equipment");
    return;
  }

  var1 = self.killcament;
  var2 = self.trigger;
  cleanupequipment(var0, var1, var2);
  self notify("deleted_equipment");
  self delete();
}

function makeexplosiveusable(var0) {
  self setotherent(self.owner);

  if(!isDefined(var0)) {
    var0 = 10;
  }

  var1 = spawn("script_origin", self.origin + var0 * anglestoup(self.angles));
  var1 linkTo(self);
  self.trigger = var1;
  var1.owner = self;
  thread makeexplosiveusableinternal();
  return var1;
}

function makeexplosiveusableinternal() {
  self endon("makeExplosiveUnusable");
  var0 = self.trigger;
  watchexplosiveusable();

  if(isDefined(self)) {
    var0 = self.trigger;
    self.trigger = undefined;
  }

  if(isDefined(var0)) {
    var0 delete();
    return;
  }
}

function makeexplosiveunusable() {
  self notify("makeExplosiveUnusable");
  var0 = self.trigger;
  self.trigger = undefined;

  if(isDefined(var0)) {
    var0 delete();
    return;
  }
}

function watchexplosiveusable() {
  var0 = self.owner;
  var1 = self.trigger;
  self endon("death");
  var1 endon("death");
  var0 endon("disconnect");
  level endon("game_ended");
  var1 setCursorHint("HINT_NOICON");
  var1 scripts\mp\utility\usability::setselfusable(var0);
  var1 childthread scripts\mp\utility\usability::notusableforjoiningplayers(var0);
  var1 childthread scripts\mp\utility\usability::notusableafterownerchange(var0, self);
  setexplosiveusablehintstring(var1, self.weapon_name);
  var1 waittillmatch("trigger", var0);

  if(isDefined(self.weapon_name)) {
    switch (self.weapon_name) {
      case "trophy_mp":
        thread scripts\mp\equipment\trophy_system::trophy_pickup();
        break;
    }

    var0 thread scripts\mp\equipment\c4::c4_resetaltdetonpickup();
  }

  var0 playlocalsound("scavenger_pack_pickup");
  var0 notify("scavenged_ammo", self.weapon_name);
  var2 = scripts\mp\equipment::getequipmentreffromweapon(getcompleteweaponname(self.weapon_name));

  if(isDefined(var2) && self.owner scripts\mp\equipment::hasequipment(var2)) {
    self.owner scripts\mp\equipment::incrementequipmentammo(var2, 1);
  }

  thread deleteexplosive();
}

function makeexplosiveusabletag(var0, var1) {
  self endon("death");
  self endon("makeExplosiveUnusable");
  var2 = self.owner;
  var3 = self.weapon_name;

  if(!isDefined(var1)) {
    var1 = 0;
  }

  if(var1) {
    self enablemissilehint(1);
  } else {
    self setCursorHint("HINT_NOICON");
  }

  self sethinttag(var0);
  self setuserange(72);
  setexplosiveusablehintstring(self.weapon_name);
  scripts\mp\utility\usability::setselfusable(var2);
  childthread scripts\mp\utility\usability::notusableforjoiningplayers(var2);
  childthread scripts\mp\utility\usability::notusableafterownerchange(var2, self);

  for(;;) {
    self waittillmatch("trigger", var2);

    if(istrue(var2.isjuggernaut)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
        var2[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/JUGG_CANNOT_BE_PICKED_UP");
      }

      continue;
    }

    if(isDefined(var3)) {
      switch (var3) {
        case "trophy_mp":
          thread scripts\mp\equipment\trophy_system::trophy_pickup();
          break;
        case "decon_station_mp":
          thread _debug_rooftop_heli_start::jugg_health_debug();
          break;
      }

      var2 thread scripts\mp\equipment\c4::c4_resetaltdetonpickup();
    }

    var2 playlocalsound("scavenger_pack_pickup");
    var2 notify("scavenged_ammo", var3);
    var4 = scripts\mp\equipment::getequipmentreffromweapon(getcompleteweaponname(var3));

    if(isDefined(var4)) {
      if(self.owner scripts\mp\equipment::hasequipment(var4)) {
        self.owner scripts\mp\equipment::incrementequipmentammo(var4, 1);
      } else if(isDefined(level.ref_1205c)) {
        [[level.ref_1205c]](self.owner, var4);
      }
    }

    if(isDefined(self.useobj)) {
      self.useobj delete();
    }

    thread deleteexplosive();
    return;
  }
}

function makeexplosiveunusuabletag() {
  self notify("makeExplosiveUnusable");
  self makeunusable();
}

function setexplosiveusablehintstring(var0) {
  switch (var0) {
    case "c4_mp_p":
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

function explosivehandlemovers(var0, var1) {
  var2 = spawnStruct();
  var2.linkparent = var0;
  var2.deathoverridecallback = &movingplatformdetonate;
  var2.endonstring = "death";

  if(_calloutmarkerping_handleluinotify_enemyrepinged::tugofwar_tank(var0)) {
    var2.ref_123b4 = 1;
    self method_87bb(1);
  }

  if(!isDefined(var1) || !var1) {
    var2.invalidparentoverridecallback = &scripts\mp\movers::moving_platform_empty_func;
  }

  thread scripts\mp\movers::handle_moving_platforms(var2);
}

function explosivetrigger(var0, var1, var2) {
  if(isPlayer(var0) && var0 scripts\mp\utility\perk::_hasperk("specialty_delaymine")) {
    var0 thread scripts\cp\vehicles\vehicle_compass_cp::triggereddelayedexplosion();
    var1 = level.delayminetime;
  }

  wait var1;
}

function getdamageableents(var0, var1, var2, var3) {
  var4 = [];

  if(!isDefined(var2)) {
    var2 = 0;
  }

  if(!isDefined(var3)) {
    var3 = 0;
  }

  var5 = var1 * var1;
  var6 = level.players;

  for(var7 = 0; var7 < var6.size; var7++) {
    if(!isalive(var6[var7]) || var6[var7].sessionstate != "playing") {
      continue;
    }

    var8 = scripts\mp\utility\damage::get_damageable_player_pos(var6[var7]);
    var9 = distancesquared(var0, var8);

    if(var9 < var5 && (!var2 || weapondamagetracepassed(var0, var8, var3, var6[var7]))) {
      var4 = scripts\mp\utility\damage::get_damageable_player(var6[var7], var8);
    }
  }

  var10 = getEntArray("grenade", "classname");

  for(var7 = 0; var7 < var10.size; var7++) {
    var11 = scripts\mp\utility\damage::get_damageable_grenade_pos(var10[var7]);
    var9 = distancesquared(var0, var11);

    if(var9 < var5 && (!var2 || weapondamagetracepassed(var0, var11, var3, var10[var7]))) {
      var4 = scripts\mp\utility\damage::get_damageable_grenade(var10[var7], var11);
    }
  }

  var12 = getEntArray("destructible", "targetname");

  for(var7 = 0; var7 < var12.size; var7++) {
    var11 = var12[var7].origin;
    var9 = distancesquared(var0, var11);

    if(var9 < var5 && (!var2 || weapondamagetracepassed(var0, var11, var3, var12[var7]))) {
      var13 = spawnStruct();
      var13.isplayer = 0;
      var13.isadestructable = 0;
      var13.entity = var12[var7];
      var13.damagecenter = var11;
      var4 = var13;
    }
  }

  var14 = getEntArray("destructable", "targetname");

  for(var7 = 0; var7 < var14.size; var7++) {
    var11 = var14[var7].origin;
    var9 = distancesquared(var0, var11);

    if(var9 < var5 && (!var2 || weapondamagetracepassed(var0, var11, var3, var14[var7]))) {
      var13 = spawnStruct();
      var13.isplayer = 0;
      var13.isadestructable = 1;
      var13.entity = var14[var7];
      var13.damagecenter = var11;
      var4 = var13;
    }
  }

  var15 = getEntArray("misc_turret", "classname");

  foreach(var17 in var15) {
    var11 = var17.origin + (0, 0, 32);
    var9 = distancesquared(var0, var11);

    if(var9 < var5 && (!var2 || weapondamagetracepassed(var0, var11, var3, var17))) {
      switch (var17.model) {
        case "vehicle_ugv_talon_gun_mp":
        case "mp_scramble_turret":
        case "mp_sam_turret":
        case "sentry_minigun_weak":
          var4 = scripts\mp\utility\damage::get_damageable_sentry(var17, var11);
          break;
      }
    }
  }

  var19 = getEntArray("script_model", "classname");

  foreach(var21 in var19) {
    if(var21.model != "projectile_bouncing_betty_grenade" && var21.model != "ims_scorpion_body") {
      continue;
    }

    var11 = var21.origin + (0, 0, 32);
    var9 = distancesquared(var0, var11);

    if(var9 < var5 && (!var2 || weapondamagetracepassed(var0, var11, var3, var21))) {
      var4 = scripts\mp\utility\damage::get_damageable_mine(var21, var11);
    }
  }

  return var4;
}

function weapondamagetracepassed(var0, var1, var2, var3) {
  var4 = undefined;
  var5 = var1 - var0;

  if(lengthsquared(var5) < var2 * var2) {
    return true;
  }

  var6 = vectorNormalize(var5);
  var4 = var0 + (var6[0] * var2, var6[1] * var2, var6[2] * var2);
  var7 = scripts\engine\trace::_bullet_trace(var4, var1, 0, var3);

  if(getdvarint("scr_damage_debug") != 0 || getdvarint("scr_debugMines") != 0) {
    thread debugprint(var0, ".dmg");

    if(isDefined(var3)) {
      thread debugprint(var1, "." + var3.classname);
    } else {
      thread debugprint(var1, ".undefined");
    }

    if(var7["fraction"] == 1) {
      thread debugline(var4, var1, (1, 1, 1));
    } else {
      thread debugline(var4, var7["position"], (1, 0.9, 0.8));
      thread debugline(var7["position"], var1, (1, 0.4, 0.3));
    }
  }

  return var7["fraction"] == 1;
}

function damageent(var0, var1, var2, var3, var4, var5, var6) {
  if(self.isplayer) {
    self.damageorigin = var5;
    self.entity thread[[level.callbackplayerdamage]](var0, var1, var2, 0, var3, var4, var5, var6, "none", 0);
    return;
  }

  if(self.isadestructable && (var4.basename == "artillery_mp" || var4.basename == "claymore_mp" || var4.basename == "stealth_bomb_mp")) {
    return;
  }

  self.entity notify("damage", var2, var1, (0, 0, 0), (0, 0, 0), "MOD_EXPLOSIVE", "", "", "", undefined, var4);
}

function debugline(var0, var1, var2) {
  for(var3 = 0; var3 < 600; var3++) {
    wait 0.05;
  }
}

function debugcircle(var0, var1, var2, var3) {
  if(!isDefined(var3)) {
    var3 = 16;
  }

  var4 = 360 / var3;
  var5 = [];

  for(var6 = 0; var6 < var3; var6++) {
    var7 = var4 * var6;
    var8 = cos(var7) * var1;
    var9 = sin(var7) * var1;
    var10 = var0[0] + var8;
    var11 = var0[1] + var9;
    var12 = var0[2];
    var5 = (var10, var11, var12);
  }

  for(var6 = 0; var6 < var5.size; var6++) {
    var13 = var5[var6];

    if(var6 + 1 >= var5.size) {
      var14 = var5[0];
    } else {
      var14 = var5[var6 + 1];
    }

    thread debugline(var13, var14, var2);
  }
}

function debugprint(var0, var1) {
  for(var2 = 0; var2 < 600; var2++) {
    wait 0.05;
  }
}

function onweapondamage(var0, var1, var2, var3, var4) {
  self endon("death_or_disconnect");

  if(!scripts\mp\utility\player::isreallyalive(self)) {
    return;
  }

  switch (var1.basename) {
    case "apache_turret_mp":
    case "concussion_grenade_mp":
    case "pac_sentry_turret_mp":
    case "thermite_av_mp":
    case "thermite_ap_mp":
    case "molotov_mp":
      break;
    case "thermite_mp":
      scripts\cp_mp\utility\shellshock_utility::_shellshock("thermite_mp", "explosion", 0.5);
      break;
    case "c4_mp_p":
    case "semtex_mp":
    case "frag_grenade_mp":
      scripts\cp_mp\utility\shellshock_utility::_shellshock("frag_grenade_mp", "explosion", 0.5);
      break;
    default:
      scripts\mp\shellshock::shellshockondamage(var2, var3);
      break;
  }
}

function updatelastweapon() {
  self endon("death_or_disconnect");
  self endon("faux_spawn");
  self.lastnormalweaponobj = scripts\engine\utility::ter_op(isDefined(self.spawnweaponobj), self.spawnweaponobj, isundefinedweapon());
  self.lastweaponobj = scripts\engine\utility::ter_op(isDefined(self.spawnweaponobj), self.spawnweaponobj, isundefinedweapon());
  self.lastcacweaponobj = scripts\engine\utility::ter_op(isDefined(self.spawnweaponobj) && scripts\mp\utility\weapon::iscacprimaryorsecondary(self.spawnweaponobj), self.spawnweaponobj, isundefinedweapon());
  ref_1316b(scripts\engine\utility::ter_op(isDefined(self.spawnweaponobj), self.spawnweaponobj, isundefinedweapon()));

  for(;;) {
    self waittill("weapon_change", var0);
    self.lastweaponobj = var0;

    if(isnormallastweapon(var0)) {
      self.lastnormalweaponobj = var0;
    }

    if(isdroppableweapon(var0)) {
      ref_1316b(var0);
    }

    if(scripts\mp\utility\weapon::iscacprimaryorsecondary(var0)) {
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

  if(scripts\mp\utility\weapon::issuperweapon(var0.basename)) {
    return false;
  }

  if(scripts\mp\utility\weapon::iskillstreakweapon(var0.basename)) {
    return false;
  }

  if(scripts\mp\utility\weapon::isspecialmeleeweapon(var0)) {
    return false;
  }

  if(var0.inventorytype != "primary" && var0.inventorytype != "altmode") {
    return false;
  }

  return true;
}

function isdroppableweapon(var0) {
  if(var0.basename == "none") {
    return false;
  }

  if(isfistweapon(var0.basename)) {
    return false;
  }

  if(isbombplantweapon(var0.basename)) {
    return false;
  }

  if(scripts\mp\utility\weapon::iskillstreakweapon(var0.basename)) {
    return false;
  }

  if(scripts\mp\utility\weapon::issuperweapon(var0.basename)) {
    return false;
  }

  if(var0.inventorytype != "primary") {
    return false;
  }

  if(var0.classname == "turret") {
    return false;
  }

  if(!scripts\mp\utility\weapon::iscacprimaryweapon(var0.basename) && !scripts\mp\utility\weapon::iscacsecondaryweapon(var0.basename)) {
    return false;
  }

  return true;
}

function updatemovespeedonweaponchange() {
  self endon("death_or_disconnect");
  self endon("faux_spawn");

  for(;;) {
    self waittill("weapon_change", var0);

    if(var0.basename == "none") {
      continue;
    } else if(scripts\mp\utility\weapon::issuperweapon(var0.basename)) {
      updatemovespeedscale();
      continue;
    } else if(scripts\mp\utility\weapon::iskillstreakweapon(var0.basename)) {
      continue;
    } else if(var0.basename == "iw8_fists_mp_ls") {
      updatemovespeedscale();
      continue;
    } else if(var0.inventorytype != "primary" && var0.inventorytype != "altmode") {
      continue;
    }

    updatemovespeedscale();
  }
}

function getweaponspeedslowest() {
  var0 = 2;
  self.weaponlist = self getweaponslistprimaries();

  if(self.weaponlist.size) {
    foreach(var2 in self.weaponlist) {
      if(scripts\mp\utility\weapon::issuperweapon(var2)) {
        var3 = scripts\mp\supers::getmovespeedforsuperweapon(var2);
      } else if(scripts\mp\utility\weapon::isgamemodeweapon(var2)) {
        var3 = getgamemodeweaponspeed(var2);
      } else {
        var3 = getweaponspeed(var2);
      }

      if(var3 == 0) {
        continue;
      }

      if(var3 < var0) {
        var0 = var3;
      }
    }
  } else {
    var0 = 0.85;
  }

  var0 = clampweaponspeed(var0);
  return var0;
}

function getweaponspeed(var0) {
  var1 = scripts\mp\utility\weapon::getweaponrootname(var0);

  if(!isDefined(var1) || !isDefined(level.weaponmapdata[var1]) || !isDefined(level.weaponmapdata[var1].speed)) {
    return 1;
  }

  return level.weaponmapdata[var1].speed;
}

function getgamemodeweaponspeed(var0) {
  return 0.93;
}

function clampweaponspeed(var0) {
  return clamp(var0, 0, 1);
}

function updateviewkickscale(var0) {
  if(isDefined(var0)) {
    self.viewkickscale = var0;
  }

  var1 = self getcurrentweapon();

  if(isDefined(self.overchargeviewkickscale)) {
    var0 = self.overchargeviewkickscale;
  } else if(isDefined(self.overrideviewkickscale)) {
    var0 = self.overrideviewkickscale;
    var2 = scripts\mp\utility\weapon::ref_14584(var1);

    if(var2 == 1) {
      var0 = self.overrideviewkickscalepistol;
    } else if(var2 == 4) {
      var0 = self.ref_1218d;
    } else if(var2 == 2) {
      var0 = self.ref_1218e;
    } else if(var2 == 3) {
      var0 = self.ref_1218f;
    } else if(var2 == 5) {
      var0 = self.overrideviewkickscalesniper;
    }
  } else if(isDefined(self.viewkickscale)) {
    var0 = self.viewkickscale;
  } else {
    var0 = 1;
  }

  if(weaponclass(var1) == "sniper" && isDefined(level.debug_unlock_silo) && level.debug_unlock_silo == 1) {
    if(var1 hasattachment("reargrip_bakelite", 1) && var1 hasattachment("bar_xl_heavy", 1)) {
      var0 *= 0.7;
    } else if(var1 hasattachment("bar_xl_heavy", 1)) {
      var0 *= 0.85;
    } else if(var1 hasattachment("reargrip_bakelite", 1)) {
      var0 *= 0.8;
    } else if(var1 hasattachment("mixhandle_sn", 1)) {
      var0 *= 0.85;
    } else if(var1 hasattachment("handle_sn", 1)) {
      var0 *= 0.75;
    } else if(isDefined(self.viewkickscale)) {
      var0 = self.viewkickscale;
    } else {
      var0 = 1;
    }
  }

  var0 = clamp(var0, 0, 1);
  self setviewkickscale(var0);
}

function updatemovespeedscale() {
  var0 = undefined;

  if(isDefined(self.playerstreakspeedscale)) {
    var0 = 1;
    var0 += self.playerstreakspeedscale;
  } else {
    var0 = getplayerspeedbyweapon(self);

    if(isDefined(self.overrideweaponspeed_speedscale)) {
      var0 = self.overrideweaponspeed_speedscale;
    }

    var1 = self.chill_data;

    if(isDefined(var1) && isDefined(var1.speedmod)) {
      var0 += var1.speedmod;
    }

    if(isDefined(self.gasspeedmod)) {
      var0 += self.gasspeedmod;
    }

    if(isDefined(self.disabledspeedmod)) {
      var0 += self.disabledspeedmod;
    }

    if(isDefined(self.speedonkillmod)) {
      var0 += self.speedonkillmod;
    }

    if(isDefined(self.momentumspeedincrease)) {
      var0 += self.momentumspeedincrease;
    }
  }

  self.weaponspeed = var0;

  if(!isDefined(self.combatspeedscalar)) {
    self.combatspeedscalar = 1;
  }

  var0 += self.movespeedscaler - 1;
  var0 += self.combatspeedscalar - 1;
  var0 = clamp(var0, 0, 1.08);

  if(isDefined(self.fastcrouchspeedmod)) {
    var0 += self.fastcrouchspeedmod;
  }

  self setmovespeedscale(var0);
}

function getplayerspeedbyweapon(var0) {
  var1 = 1;
  self.weaponlist = self getweaponslistprimaries();

  if(!self.weaponlist.size) {
    var1 = 0.85;
  } else {
    var2 = self getcurrentweapon();

    if(!isDefined(var2)) {
      var1 = getweaponspeedslowest();
    } else if(scripts\mp\utility\weapon::issuperweapon(var2.basename)) {
      var1 = scripts\mp\supers::getmovespeedforsuperweapon(var2);
    } else if(scripts\mp\utility\weapon::isgamemodeweapon(var2.basename)) {
      var1 = getgamemodeweaponspeed(var2);
    } else if(scripts\mp\utility\weapon::iskillstreakweapon(var2.basename)) {
      var1 = 0.85;
    } else if(scripts\mp\utility\weapon::unset_relic_mythic(var2.basename)) {
      var1 = 0.85;
    } else {
      if(var2.inventorytype != "primary" && var2.inventorytype != "altmode" || scripts\mp\utility\weapon::update_health_bar_to_player(var2)) {
        if(isDefined(self.lastnormalweaponobj)) {
          var2 = self.lastnormalweaponobj;
        } else {
          var2 = undefined;
        }
      }

      if(!self hasweapon(var2)) {
        var1 = getweaponspeedslowest();
      } else {
        var1 = getweaponspeed(var2);
      }
    }
  }

  var1 = clampweaponspeed(var1);
  return var1;
}

function stancerecoiladjuster() {
  if(!isPlayer(self)) {
    return;
  }

  self endon("death_or_disconnect");
  self endon("faux_spawn");
  self notifyonplayercommand("adjustedStance", "+stance");
  self notifyonplayercommand("adjustedStance", "+goStand");
  jumpiffalse(!self isconsoleplayer() && !isai(self)) LOC_0000009f;
  self notifyonplayercommand("adjustedStance", "+togglecrouch");
  self notifyonplayercommand("adjustedStance", "toggleprone");
  self notifyonplayercommand("adjustedStance", "+movedown");
  self notifyonplayercommand("adjustedStance", "-movedown");
  self notifyonplayercommand("adjustedStance", "+prone");
  self notifyonplayercommand("adjustedStance", "-prone");

  for(;;) {
    scripts\engine\utility::ref_143a6("adjustedStance", "sprint_begin", "weapon_change");
    wait 0.5;
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
    var3 = scripts\mp\utility\weapon::getweapongroup(var1);

    if(var3 == "weapon_lmg") {
      scripts\mp\utility\weapon::setrecoilscale(0, 0);
      return;
    }

    if(var3 == "weapon_sniper") {
      if(var1 hasattachment("barrelbored", 1)) {
        scripts\mp\utility\weapon::setrecoilscale(0, 0 + var2);
        return;
      }

      scripts\mp\utility\weapon::setrecoilscale(0, 0 + var2);
      return;
    }

    scripts\mp\utility\weapon::setrecoilscale();
    return;
  }

  if(var0 == "crouch") {
    var3 = scripts\mp\utility\weapon::getweapongroup(var1);

    if(var3 == "weapon_lmg") {
      scripts\mp\utility\weapon::setrecoilscale(0, 0);
      return;
    }

    if(var3 == "weapon_sniper") {
      if(var1 hasattachment("barrelbored", 1)) {
        scripts\mp\utility\weapon::setrecoilscale(0, 0 + var2);
        return;
      }

      scripts\mp\utility\weapon::setrecoilscale(0, 0 + var2);
      return;
    }

    scripts\mp\utility\weapon::setrecoilscale();
    return;
  }

  if(var2 > 0) {
    scripts\mp\utility\weapon::setrecoilscale(0, var2);
    return;
  }

  scripts\mp\utility\weapon::setrecoilscale();
}

function deleteallgrenades() {
  if(isDefined(level.grenades)) {
    foreach(var1 in level.grenades) {
      if(isDefined(var1) && !istrue(var1.exploding) && !isplantedequipment(var1)) {
        var1 delete();
      }
    }
  }

  if(isDefined(level.missiles)) {
    foreach(var4 in level.missiles) {
      if(isDefined(var4) && !istrue(var4.exploding) && !isplantedequipment(var4)) {
        var4 delete();
      }
    }

    return;
  }
}

function minegettwohitthreshold() {
  return 80;
}

function minedamagemonitor() {
  self endon("mine_selfdestruct");
  self endon("death");
  self setCanDamage(1);
  self.maxhealth = 100000;
  self.health = self.maxhealth;
  var0 = undefined;
  var1 = 1;
  var2 = "hitequip";

  for(;;) {
    self waittill("damage", var3, var0, var4, var5, var6, var7, var8, var9, var10, var11, var12, var13, var14, var15);
    var11 = scripts\mp\utility\weapon::mapweapon(var11, var15);
    var16 = var0;

    if(!isPlayer(var0) && !isagent(var0)) {
      if(isDefined(var0.owner) && isPlayer(var0.owner)) {
        var16 = var0.owner;
      }
    }

    if(!isPlayer(var16) && !isagent(var16)) {
      continue;
    }

    if(isDefined(var11) && isendstr(var11.basename, "betty_mp")) {
      continue;
    }

    if(!friendlyfirecheck(self.owner, var16)) {
      continue;
    }

    if(scripts\mp\utility\damage::non_player_should_ignore_damage(var16, var11, var15, var6)) {
      continue;
    }

    var17 = scripts\engine\utility::ter_op(scripts\mp\utility\damage::isfmjdamage(var11, var6, 1) || var3 >= 80, 2, 1);
    var1 -= var17;
    equipmenthit(self.owner, var16, var11, var6);

    if(var1 <= 0) {
      break;
    }

    var16 scripts\mp\damagefeedback::updatedamagefeedback(var2);
  }

  self notify("mine_destroyed");

  if(isDefined(var6) && (issubstr(var6, "MOD_GRENADE") || issubstr(var6, "MOD_EXPLOSIVE"))) {
    self.waschained = 1;
  }

  if(isDefined(var10) && var10 &level.idflags_penetration) {
    self.wasdamagedfrombulletpenetration = 1;
  }

  if(isDefined(var10) && var10 &level.idflags_ricochet) {
    self.wasdamagedfrombulletricochet = 1;
  }

  self.wasdamaged = 1;

  if(isDefined(var16)) {
    self.damagedby = var16;
  }

  if(isDefined(self.killcament)) {
    self.killcament.damagedby = var16;
  }

  if(isPlayer(var16)) {
    var16 scripts\mp\damagefeedback::updatedamagefeedback(var2);

    if(var16 != self.owner && var16.team != self.owner.team) {
      var16 scripts\mp\killstreaks\killstreaks::givescoreforequipment(self, var11);
      var16 scripts\mp\battlechatter_mp::equipmentdestroyed(self);
      scripts\cp\vehicles\vehicle_compass_cp::equipmentdestroyed(var15, var0, var3, var10, undefined, var11, undefined, var16.modifiers);
    }
  }

  if(level.teambased) {
    if(isDefined(var16) && isDefined(var16.pers["team"]) && isDefined(self.owner) && isDefined(self.owner.pers["team"])) {
      if(var16.pers["team"] != self.owner.pers["team"]) {
        var16 notify("destroyed_equipment");
      }
    }
  } else if(isDefined(self.owner) && isDefined(var16) && var16 != self.owner) {
    var16 notify("destroyed_equipment");
  }

  scripts\cp\vehicles\vehicle_compass_cp::minedestroyed(self, var16, var6);
  self notify("detonateExplosive", var16);
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
  waitframe();

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
  playFX(var4, var3);
  var5 = scripts\engine\utility::ter_op(isDefined(var1.minedamagemin), var1.minedamagemin, level.minedamagemin);
  var6 = scripts\engine\utility::ter_op(isDefined(var1.minedamagemax), var1.minedamagemax, level.minedamagemax);
  var7 = scripts\engine\utility::ter_op(isDefined(var1.minedamageradius), var1.minedamageradius, level.minedamageradius);

  if(var6 > 0) {
    self radiusdamage(self.origin, var7, var6, var5, var0, "MOD_EXPLOSIVE", self.weapon_name);
  }

  if(isDefined(self.owner)) {
    self.owner thread scripts\mp\utility\dialog::leaderdialogonplayer("mine_destroyed", undefined, undefined, self.origin);
  }

  wait 0.2;
  deleteexplosive();
}

function deleteplacedequipment(var0) {
  if(isDefined(self.plantedlethalequip)) {
    foreach(var2 in self.plantedlethalequip) {
      if(isDefined(var2)) {
        deleteexplosive(var2);
      }
    }
  }

  self.plantedlethalequip = [];

  if(isDefined(self.plantedtacticalequip)) {
    foreach(var2 in self.plantedtacticalequip) {
      if(isDefined(var2)) {
        deleteexplosive(var2);
      }
    }
  }

  self.plantedtacticalequip = [];
  var6 = scripts\mp\utility\game::isanymlgmatch() || istrue(var0);

  if(isDefined(self.plantedhackedequip)) {
    foreach(var8, var2 in self.plantedhackedequip) {
      if(isDefined(var2) && (!var6 || !istrue(var2.issuper))) {
        deleteexplosive(var2);
        self.plantedhackedequip[var8] = undefined;
      }
    }

    self.plantedhackedequip = scripts\engine\utility::array_removeundefined(self.plantedhackedequip);
  }

  if(var6 && isDefined(self.plantedsuperequip)) {
    foreach(var2 in self.plantedsuperequip) {
      deleteexplosive(var2);
      self.plantedsuperequip[var8] = undefined;
    }

    self.plantedsuperequip = scripts\engine\utility::array_removeundefined(self.plantedsuperequip);
    return;
  }
}

function deletedisparateplacedequipment() {
  var0 = scripts\mp\equipment::getcurrentequipment("primary");

  foreach(var2 in self.plantedlethalequip) {
    if(isDefined(var2)) {
      if(!isDefined(var2.equipmentref) || !isDefined(var0) || var2.equipmentref != var0) {
        deleteexplosive(var2);
      }
    }
  }

  var4 = scripts\mp\equipment::getcurrentequipment("secondary");

  foreach(var2 in self.plantedtacticalequip) {
    if(isDefined(var2)) {
      if(!isDefined(var2.equipmentref) || !isDefined(var4) || var2.equipmentref != var4) {
        deleteexplosive(var2);
      }
    }
  }
}

function equipmentdeletevfx(var0, var1) {
  if(isDefined(var0)) {
    if(isDefined(var1)) {
      var2 = anglesToForward(var1);
      var3 = anglestoup(var1);
      playFX(scripts\engine\utility::getfx("equipment_explode"), var0, var2, var3);
      playFX(scripts\engine\utility::getfx("equipment_smoke"), var0, var2, var3);
    } else {
      playFX(scripts\engine\utility::getfx("equipment_explode"), var0);
      playFX(scripts\engine\utility::getfx("equipment_smoke"), var0);
    }

    playsoundatpos(var0, "mp_killstreak_disappear");
    return;
  }

  if(isDefined(self)) {
    var4 = self.origin;
    var2 = anglesToForward(self.angles);
    var3 = anglestoup(self.angles);
    playFX(scripts\engine\utility::getfx("equipment_explode"), var4, var2, var3);
    playFX(scripts\engine\utility::getfx("equipment_smoke"), var4, var2, var3);
    self playSound("mp_killstreak_disappear");
    return;
  }
}

function vehcolignorelist() {
  if(level.mapname == "mp_firingrange" || isstartstr(level.mapname, "mp_audio")) {
    return true;
  }

  return false;
}

function buildattachmentmaps() {
  level.attachmentmap_uniquetobase = [];
  level.attachmentmap_uniquetoextra = [];
  level.weaponattachments = [];
  var0 = [];
  var1 = 1;
  var2 = tablelookupbyrow("mp/attachmentmap.csv", var1, 0);
  var3 = scripts\mp\utility\game::unset_relic_grounded();

  while(var2 != "") {
    if(var3 || scripts\cp_mp\utility\weapon_utility::vehicle_ai_script_models(var2) || vehcolignorelist()) {
      var0 = var2;
    }

    var1++;
    var2 = tablelookupbyrow("mp/attachmentmap.csv", var1, 0);
  }

  var4 = [];
  var5 = 1;

  for(var6 = tablelookupbyrow("mp/attachmentmap.csv", 0, var5); var6 != ""; var6 = tablelookupbyrow("mp/attachmentmap.csv", 0, var5)) {
    var4 = var5;
    var5++;
  }

  level.attachmentmap_basetounique = [];

  foreach(var2 in var0) {
    foreach(var11, var9 in var4) {
      var10 = tablelookup("mp/attachmentmap.csv", 0, var2, var9);

      if(var10 == "") {
        continue;
      }

      if(!isDefined(level.attachmentmap_basetounique[var2])) {
        level.attachmentmap_basetounique[var2] = [];
      }

      level.attachmentmap_basetounique[var2][var11] = var10;

      if(!isDefined(level.attachmentmap_uniquetobase[var10])) {
        level.attachmentmap_uniquetobase[var10] = var11;
        continue;
      }

      if(level.attachmentmap_uniquetobase[var10] != var11) {}
    }
  }

  level.carryingplayer = [];
  var13 = [];
  var1 = 1;

  for(var14 = tablelookupbyrow("mp/attachmentmap_comboOverrides.csv", var1, 0); var14 != ""; var14 = tablelookupbyrow("mp/attachmentmap_comboOverrides.csv", var1, 0)) {
    var13 = var14;
    var1++;
  }

  var15 = [];
  var5 = 1;

  for(var16 = tablelookupbyrow("mp/attachmentmap_comboOverrides.csv", 0, var5); var16 != ""; var16 = tablelookupbyrow("mp/attachmentmap_comboOverrides.csv", 0, var5)) {
    var15 = var16;
    var5++;
  }

  foreach(var14 in var13) {
    foreach(var9, var16 in var15) {
      var19 = tablelookup("mp/attachmentmap_comboOverrides.csv", 0, var14, var9 + 1);

      if(var19 == "") {
        continue;
      }

      if(!isDefined(level.carryingplayer[var14])) {
        level.carryingplayer[var14] = [];
      }

      level.carryingplayer[var14][var16] = var19;
    }
  }

  foreach(var31, var22 in level.weaponmapdata) {
    var23 = var31;

    if(getsubstr(var31, 0, 4) == "iw8_") {
      var23 = getsubstr(var31, 4);
    }

    var24 = "mp/gunsmith/" + var23 + "_progression.csv";

    if(!tableexists(var24)) {
      continue;
    }

    level.weaponattachments[var31] = [];
    var1 = 1;
    var25 = tablelookupbyrow(var24, var1, 0);
    var26 = var23 + "_attachment_ids.csv";

    if(getsubstr(var23, 0, 3) == "s4_") {
      var26 = "loot/" + var26;
    } else {
      var26 = "loot/iw8_" + var26;
    }

    while(var25 != "") {
      var27 = getdvarint("scr_maxAttachmentUnlocksPerLevel", 3);

      for(var28 = 0; var28 < var27; var28++) {
        var29 = tablelookupbyrow(var24, var1, 1 + var28 * 4);

        if(var29 != "") {
          var30 = tablelookup(var26, 0, var29, 1);

          if(var30 != "") {
            level.weaponattachments[var31][var30] = var30;
          }
        }
      }

      var1++;
      var25 = tablelookupbyrow(var24, var1, 0);
      var29 = tablelookupbyrow(var24, var1, 1);
    }
  }

  level.attachmentmap_attachtoperk = [];
  level.carrier_remove_carriable_weapon = [];
  level.carry_ref = [];
  level.carryobjects_onjuggernaut = [];
  var32 = getattachmentlistuniquenames();

  foreach(var34 in var32) {
    var35 = tablelookup("mp/attachmenttable.csv", 4, var34, 2);
    var36 = scripts\mp\utility\weapon::attachmentmap_tobase(var34);

    if(var35 != "" && isDefined(var36)) {
      var37 = level.carry_ref[var36];

      if(!isDefined(var37)) {
        level.carry_ref[var36] = var35;
      } else if(var35 != var37) {
        level.carryobjects_onjuggernaut[var34] = var35;
      }
    }

    var38 = tablelookup("mp/attachmenttable.csv", 4, var34, 12);

    if(var38 != "") {
      level.attachmentmap_attachtoperk[var34] = var38;
    }

    var39 = tablelookup("mp/attachmenttable.csv", 4, var34, 13);

    if(var39 != "") {
      level.attachmentmap_uniquetoextra[var34] = var39;
    }

    var40 = tablelookup("mp/attachmenttable.csv", 4, var34, 9);

    if(var40 != "") {
      level.carrier_remove_carriable_weapon[var34] = var40;
    }
  }

  level.carryitem2omnvar = [];
  level.carryitem2omnvar["default"] = fired_missiles("mp/attachmentcombos.csv");
  level.carryitem2omnvar["s4"] = fired_missiles("mp/attachmentcombos_s4.csv");
  level.cash_hud_bink = [];
  level.cash_hud_bink["default"] = "mp/attachmentcombos.csv";
  level.cash_hud_bink["s4"] = "mp/attachmentcombos_s4.csv";
}

function fired_missiles(var0) {
  var4 = [];
  var1 = 1;

  for(var2 = tablelookupbyrow(var0, var1, 0); var2 != ""; var2 = tablelookupbyrow(var0, var1, 0)) {
    var5 = 1;

    for(var3 = tablelookupbyrow(var0, 0, var5); var3 != ""; var3 = tablelookupbyrow(var0, 0, var5)) {
      if(var1 != var5) {
        var6 = tablelookupbyrow(var0, var1, var5);

        if(!isDefined(var4[var2])) {
          var4 = [];
        }

        if(var6 != "") {
          var4[var3] = var6;
        }
      }

      var5++;
    }

    var1++;
  }

  return var4;
}

function getattachmentlistuniquenames() {
  return scripts\mp\utility\weapon::getattachmentlist(4, 1);
}

function track_get_launch_target() {
  level.ref_1459e = [];
  loadweaponsourcetablefromcsv("mp/itemsourcetable.csv");
  loadweaponsourcetablefromcsv("mp/itemsourcetable_ch2.csv");
}

function loadweaponsourcetablefromcsv(var0) {
  for(var1 = 0;; var1++) {
    var2 = tablelookupbyrow(var0, var1, 1);

    if(!isDefined(var2) || var2 == "") {
      break;
    }

    if(var2 != "weapon") {
      var1++;
      continue;
    }

    var3 = tablelookupbyrow(var0, var1, 3);
    var4 = tablelookupbyrow(var0, var1, 2);
    level.ref_1459e[var4] = var3;
  }
}

function safechecknum(var0) {
  if(!isDefined(level.ref_1459e)) {
    track_get_launch_target();
  }

  var1 = level.ref_1459e[var0];

  if(isDefined(var1)) {
    return var1;
  }

  return "iw8";
}

function vehicle_ai_avoidance_cleanup(var0) {
  if(!isDefined(level.ref_1459e)) {
    track_get_launch_target();
  }

  var1 = level.ref_1459e[var0];

  if(isDefined(var1) && (var1 == "t9" || var1 == "s4")) {
    if(!istrue(level.ref_14434)) {
      return false;
    }

    if(!getdvarint("LNLMORMPTS")) {
      return false;
    }

    return true;
  }

  if(isDefined(var1) && var1 != "iw8") {
    return false;
  }

  return true;
}

function buildweaponmap() {
  level.weaponmapdata = [];
  level.ref_14589 = [];
  level.ref_14580 = [];
  var0 = scripts\mp\utility\game::unset_relic_grounded();
  var1 = tablelookupgetnumrows("mp/statstable.csv");

  for(var2 = 0; var2 < var1; var2++) {
    var3 = tablelookupbyrow("mp/statstable.csv", var2, 0);
    var4 = tablelookup("mp/statstable.csv", 0, var3, 4);

    if(var4 == "") {
      continue;
    }

    if(var0 || scripts\cp_mp\utility\weapon_utility::vehicle_ai_script_models(var4) || vehcolignorelist()) {
      level.weaponmapdata[var4] = spawnStruct();
      var5 = tablelookup("mp/statstable.csv", 0, var3, 0);

      if(var5 != "") {
        level.weaponmapdata[var4].number = var5;
      }

      var6 = tablelookup("mp/statstable.csv", 0, var3, 1);

      if(var6 != "") {
        level.weaponmapdata[var4].group = var6;
        var7 = tablelookup("mp/statstable.csv", 0, var3, 41);

        if(var7 != "") {
          var8 = int(var7);
          var9 = 0;
          var10 = tablelookup("mp/statstable.csv", 0, var3, 17);

          if(var10 != "") {
            var9 = getdvarint(var10, 0) == 0;
          }

          if(var8 > -1 && vehicle_ai_avoidance_cleanup(var4) && !var9) {
            if(!isDefined(level.ref_14589[var6])) {
              level.ref_14589[var6] = [];
            }

            level.ref_14589[var6][level.ref_14589[var6].size] = var4;
          } else {
            level.weaponmapdata[var4].ref_13efc = 1;
          }
        }
      }

      if(!istrue(level.weaponmapdata[var4].ref_13efc)) {
        level.ref_14580[var4] = 1;
      }

      var11 = tablelookup("mp/statstable.csv", 0, var3, 2);

      if(var11 != "") {
        level.weaponmapdata[var4].ref_11bd1 = var11;
      }

      var12 = tablelookup("mp/statstable.csv", 0, var3, 5);

      if(var12 != "") {
        level.weaponmapdata[var4].assetname = var12;
      }

      var13 = tablelookup("mp/statstable.csv", 0, var3, 44);

      if(var13 != "") {
        level.weaponmapdata[var4].perk = var13;
      }

      var14 = tablelookup("mp/statstable.csv", 0, var3, 9);
      var15 = parseattachdefaulttoidmap(var14);

      if(isDefined(var15)) {
        level.weaponmapdata[var4].attachdefaulttoidmap = var15;
      }

      var16 = tablelookup("mp/statstable.csv", 0, var3, 8);

      if(var16 != "") {
        var16 = float(var16);
        level.weaponmapdata[var4].speed = var16;
      }

      continue;
    }

    var9 = undefined;

    if(tablelookup("mp/statstable.csv", 0, var3, 1) != "") {
      if(tablelookup("mp/statstable.csv", 0, var3, 41) != "") {
        var10 = tablelookup("mp/statstable.csv", 0, var3, 17);

        if(var10 != "") {
          var9 = getdvarint(var10, 0) == 0;
        }
      }
    }

    if(!istrue(var9)) {
      level.ref_14580[var4] = 1;
    }
  }

  var17 = [];
  level.weaponlootmapdata = [];
  var2 = -1;

  for(;;) {
    var2++;
    var18 = tablelookupbyrow("loot/weapon_ids.csv", var2, 0);

    if(var18 == "") {
      break;
    }

    var4 = tablelookupbyrow("loot/weapon_ids.csv", var2, 1);

    if(!var0 && !scripts\cp_mp\utility\weapon_utility::vehicle_ai_script_models(var4) && !vehcolignorelist()) {
      continue;
    }

    var19 = tablelookupbyrow("loot/weapon_ids.csv", var2, 6);
    var20 = scripts\mp\utility\weapon::getweaponvarianttablename(var4);
    var21 = tablelookup(var20, 1, var19, 0);

    if(var21 == "") {
      continue;
    }

    if(int(var21) > 0) {
      if(!isDefined(var17[var4]) || int(var21) > var17[var4]) {
        var17 = int(var21);
      }
    }

    var22 = var4 + "|" + var21;
    level.weaponlootmapdata[var22] = spawnStruct();
    level.weaponlootmapdata[var22].variantid = int(var21);
    var23 = tablelookup(var20, 1, var19, 3);

    if(var23 != "") {
      level.weaponlootmapdata[var22].assetoverridename = var23;
    }

    var24 = tablelookup("loot/weapon_ids.csv", 6, var19, 5);
    level.weaponlootmapdata[var22].update_focus_fire_objective = int(var21) != 0 && int(var24) == 99;
    level.weaponlootmapdata[var22].tut_bot_nameplate = vehicle_ai_avoidance_cleanup(var4);
    var25 = tablelookup(var20, 1, var19, 4);
    var15 = parseattachdefaulttoidmap(var25);

    if(isDefined(var15)) {
      if(isDefined(level.weaponmapdata[var4].attachdefaulttoidmap)) {
        var15 = scripts\engine\utility::array_combine_unique_keys(var15, level.weaponmapdata[var4].attachdefaulttoidmap);
      }

      level.weaponlootmapdata[var22].attachdefaulttoidmap = var15;
    }

    var26 = [];

    for(var27 = 5; var27 <= 15; var27++) {
      var28 = tablelookup(var20, 1, var19, var27);

      if(var28 != "") {
        var29 = strtok(var28, "|");

        if(var29.size == 2) {
          var26 = int(var29[1]);
        } else {
          var26 = 0;
        }
      }
    }

    if(var26.size > 0) {
      level.weaponlootmapdata[var22].attachcustomtoidmap = var26;
    }

    var30 = tablelookup(var20, 1, var19, 16);

    if(var30 != "") {
      var31 = [];
      var32 = strtok(var30, " ");

      foreach(var34 in var32) {
        var35 = strtok(var34, "|");

        if(var35.size != 2) {
          continue;
        }

        var31 = int(var35[1]);
      }

      if(var31.size > 0) {
        level.weaponlootmapdata[var22].attachextratoidmap = var31;
      }
    }
  }

  foreach(var38 in var17) {
    for(var39 = 1; var39 <= var38; var39++) {
      var40 = var41 + "|" + var39;

      if(!isDefined(level.weaponlootmapdata[var40])) {
        level.weaponlootmapdata[var40] = spawnStruct();
        level.weaponlootmapdata[var40].variantid = var39;
        level.weaponlootmapdata[var40].update_focus_fire_objective = 1;
        level.weaponlootmapdata[var40].tut_bot_nameplate = 0;
      }
    }
  }
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

function grenadestuckto(var0, var1, var2) {
  if(!isDefined(self)) {
    var0.stuckenemyentity = var1;
    var1.stuckbygrenade = var0;
    var1.ref_13935 = var0.owner;
    return;
  }

  if(level.teambased && isDefined(var1.team) && var1.team == self.team) {
    var0.isstuck = "friendly";
    return;
  }

  var3 = undefined;
  var4 = "incoming_stuck";

  switch (var0.weapon_name) {
    case "semtex_mp":
      var3 = "semtex_stuck";
      break;
    case "molotov_mp":
      var3 = "molotov_stuck";
      var4 = "flavor_surprise";
      break;
    case "thermite_mp":
      var3 = "thermite_attacker_stuck";
      var4 = "flavor_surprise";
      break;
  }

  var0.isstuck = "enemy";
  var0.stuckenemyentity = var1;
  var1.stuckbygrenade = var0;
  var1.ref_13935 = var0.owner;
  self notify("grenade_stuck_enemy");
  level thread scripts\mp\battlechatter_mp::trysaylocalsound(var1, var4);

  if(!istrue(var2)) {
    grenadestucktosplash(var3, var1);
    return;
  }
}

function grenadestucktosplash(var0, var1) {
  var2 = self;

  if(isPlayer(var1) && isDefined(var0)) {
    if(isDefined(var2.owner)) {
      var2 = var2.owner;
    }

    var2 scripts\mp\hud_message::showsplash(var0);
  }

  var2 thread scripts\mp\awards::givemidmatchaward("explosive_stick");
}

function outlineequipmentforowner(var0) {}

function outlinesuperequipment(var0, var1) {
  if(level.teambased) {
    thread outlinesuperequipmentforteam(var0, var1);
    return;
  }

  thread outlinesuperequipmentforplayer(var0, var1);
}

function outlinesuperequipmentforteam(var0, var1) {
  var2 = scripts\mp\utility\outline::outlineenableforteam(var0, var1.team, "outline_nodepth_cyan", "killstreak");
  var0 waittill("death");
  scripts\mp\utility\outline::outlinedisable(var2, var0);
}

function outlinesuperequipmentforplayer(var0, var1) {
  var2 = scripts\mp\utility\outline::outlineenableforplayer(var0, var1, "outline_nodepth_cyan", "killstreak");
  var0 waittill("death");
  scripts\mp\utility\outline::outlinedisable(var2, var0);
}

function grenadeheldatdeath() {
  return istrue(self.grenadeheldatdeath);
}

function set_cp_vehicle_health_values() {
  self.grenadeheldatdeath = !nullweapon(self getheldoffhand());
}

function trace_impale(var0, var1) {
  var2 = physics_createcontents(["physicscontents_solid", "physicscontents_glass", "physicscontents_missileclip", "physicscontents_vehicle", "physicscontents_item"]);
  var3 = scripts\engine\trace::ray_trace_detail(var0, var1, level.players, var2, undefined, 1);
  return var3;
}

function impale_endpoint(var0, var1) {
  var2 = var0 + var1 * 4096;
  return var2;
}

function impale(var0, var1, var2, var3, var4, var5, var6, var7, var8) {
  var1 endon("death_or_disconnect");

  if(!isDefined(var1.body)) {
    return;
  }

  playFX(scripts\engine\utility::getfx("penetration_railgun_impact"), var4);
  var9 = impale_endpoint(var4, var5);
  var10 = trace_impale(var4, var9);
  var9 = var10["position"] - var5 * 12;
  var11 = length(var9 - var4);
  var12 = var11 / 1000;
  var12 = max(var12, 0.05);

  if(var10["hittype"] != "hittype_world") {
    var12 = 0;
  }

  var13 = var12 > 0.05;

  if(isDefined(var1)) {
    var1.body startragdoll();
  }

  waitframe();

  if(var13) {
    var14 = var5;
    var15 = anglestoup(var0.angles);
    var16 = vectorcross(var14, var15);
    var17 = scripts\engine\utility::spawn_tag_origin(var4, axistoangles(var14, var16, var15));
    var17 moveTo(var9, var12);
    var18 = spawnragdollconstraint(var1.body, var6, var7, var8);
    var18.origin = var17.origin;
    var18.angles = var17.angles;
    var18 linkTo(var17);

    if(var12 > 1) {
      thread impale_detachaftertime(var18, 1);
    }

    thread impale_cleanup(var1, var17, var12 + 0.25);
    thread impale_effects(var17, var9);
    return;
  }
}

function impale_detachaftertime(var0, var1) {
  wait var1;

  if(isDefined(var0)) {
    var0 delete();
    return;
  }
}

function impale_effects(var0, var1) {
  wait clamp(var1 - 0.05, 0.05, 20);
  playFX(scripts\engine\utility::getfx("vfx_penetration_railgun_impact"), var0);
}

function impale_cleanup(var0, var1, var2) {
  if(isDefined(var0)) {
    var0 scripts\engine\utility::ref_143b9(var2, "death_or_disconnect");
  }

  var1 delete();
}

function codecallback_getprojectilespeedscale(var0, var1) {
  return [1, 1];
}

function setplayerstunned() {
  if(!isDefined(self.isstunned)) {
    self.isstunned = 1;
    return;
  }

  self.isstunned++;
}

function setplayerunstunned() {
  self.isstunned--;
}

function isstunned() {
  return isDefined(self.debuffedbyplayers) && isDefined(self.debuffedbyplayers["concussion_grenade_mp"]);
}

function setplayerblinded() {
  if(!isDefined(self.isblinded)) {
    self.isblinded = 1;
    return;
  }

  self.isblinded++;
}

function setplayerunblinded() {
  self.isblinded--;
}

function isblinded() {
  return isDefined(self.debuffedbyplayers) && isDefined(self.debuffedbyplayers["flash_grenade_mp"]);
}

function tutkioskpurchase(var0) {
  if(!isDefined(var0)) {
    return false;
  }

  var1 = "flash_grenade_mp";
  var2 = var0 getentitynumber();

  if(isDefined(self.debuffedbyplayers) && isDefined(self.debuffedbyplayers[var1]) && isDefined(self.debuffedbyplayers[var1][var2])) {
    return true;
  }

  return false;
}

function using_self_revive(var0) {
  if(!isDefined(var0)) {
    return false;
  }

  var1 = "concussion_grenade_mp";
  var2 = var0 getentitynumber();

  if(isDefined(self.debuffedbyplayers) && isDefined(self.debuffedbyplayers[var1]) && isDefined(self.debuffedbyplayers[var1][var2])) {
    return true;
  }

  return false;
}

function isstunnedorblinded() {
  return isblinded() || isstunned();
}

function cleanupconcussionstun(var0) {
  self endon("death_or_disconnect");
  self endon("started_spawnPlayer");
  level endon("game_ended");
  wait var0;
  setplayerunstunned();
}

function applyweaponsonicstun() {
  self endon("death_or_disconnect");
  wait 0.1;

  if(isDefined(self) && isPlayer(self) && !isbot(self)) {
    self playlocalsound("sonic_shotgun_debuff");
    self setsoundsubmix("sonic_shotgun_impact");
    return;
  }
}

function watchinvalidweaponchange() {
  self endon("death_or_disconnect");

  for(;;) {
    self waittill("weapon_switch_invalid", var0);
    var1 = self getcurrentweapon();

    if(var1.inventorytype == "item" || var1.inventorytype == "exclusive") {
      scripts\cp_mp\utility\inventory_utility::_switchtoweapon(self.lastdroppableweaponobj);
    }
  }
}

function weaponhasselectableoptic(var0) {
  var1 = scripts\mp\utility\weapon::getweaponrootname(var0);
  var2 = getweaponattachments(var0);

  foreach(var4 in var2) {
    var5 = attachmentgroup(var4);

    if(var5 == "rail") {
      var6 = scripts\mp\utility\weapon::attachmentmap_tobase(var4);

      if(scripts\mp\utility\weapon::carriedpunchcard(var1, var6)) {
        return true;
      }
    }
  }

  return false;
}

function watchdropweapons() {
  self endon("disconnect");
  self notify("watchDropWeapons");
  self endon("watchDropWeapons");

  for(;;) {
    self waittill("weapon_dropped", var0, var1);

    if(isDefined(var0) && isDefined(var1) && !scripts\mp\utility\weapon::ismeleeonly(var1) && !scripts\mp\utility\weapon::update_health_bar_to_player(var1) && !scripts\mp\utility\weapon::isknifeonly(var1)) {
      if(var0 physics_getnumbodies() > 0) {
        var0 physics_registerforcollisioncallback();
        thread weapondrop_physics_callback_monitor();
      }
    }
  }
}

function weapondrop_physics_callback_monitor() {
  self endon("death");
  self endon("timeout");
  thread weapondrop_physics_timeout(2);
  self waittill("collision", var0, var1, var2, var3, var4, var5, var6, var7);

  if(isDefined(self.classname) && getsubstr(self.classname, 0, 6) == "weapon") {
    var8 = physics_getsurfacetypefromflags(var3);
    var9 = getsubstr(var8["name"], 9);

    if(var9 == "user_terrain1") {
      var9 = "user_terrain_1";
    }

    if(var9 == "user_terrain5") {
      var9 = "user_terrain_5";
    }

    switch (getsubstr(self.classname, 0, 13)) {
      case "weapon_iw8_ar":
        if(isDefined(self.objweapon)) {
          if(isDefined(self.objweapon.material) && self.objweapon.material == "polymer") {
            self playsurfacesound("weap_drop_med_poly", var9);
          } else {
            self playsurfacesound("weap_drop_med", var9);
          }
        } else {
          self playsurfacesound("weap_drop_med", var9);
        }

        break;
      case "weapon_iw8_sm":
        if(isDefined(self.objweapon)) {
          if(isDefined(self.objweapon.material) && self.objweapon.material == "polymer") {
            self playsurfacesound("weap_drop_small_poly", var9);
          } else {
            self playsurfacesound("weap_drop_small", var9);
          }
        } else {
          self playsurfacesound("weap_drop_small", var9);
        }

        break;
      case "weapon_iw8_lm":
        self playsurfacesound("weap_drop_xlarge", var9);
        break;
      case "weapon_iw8_sh":
        if(isDefined(self.objweapon)) {
          if(isDefined(self.objweapon.material) && self.objweapon.material == "polymer") {
            self playsurfacesound("weap_drop_med_poly", var9);
          } else {
            self playsurfacesound("weap_drop_med", var9);
          }
        } else {
          self playsurfacesound("weap_drop_med", var9);
        }

        break;
      case "weapon_iw8_sn":
        self playsurfacesound("weap_drop_large", var9);
        break;
      case "weapon_iw8_pi":
        if(isDefined(self.objweapon)) {
          if(isDefined(self.objweapon.material) && self.objweapon.material == "polymer") {
            self playsurfacesound("weap_drop_pistol_poly", var9);
          } else {
            self playsurfacesound("weap_drop_pistol", var9);
          }
        } else {
          self playsurfacesound("weap_drop_pistol", var9);
        }

        break;
      case "weapon_iw8_la":
        self playsurfacesound("weap_drop_launcher", var9);
        break;
      default:
        self playsurfacesound("weap_drop_med", var9);
        break;
    }

    return;
  }
}

function weapondrop_physics_timeout(var0) {
  wait var0;
  self notify("timeout");
}

function axedetachfromcorpse(var0) {
  level endon("game_ended");
  var1 = var0 getlinkedchildren();

  foreach(var3 in var1) {
    if(!isDefined(var3)) {
      continue;
    }

    var4 = var3.weapon_name;
    var5 = var3.owner;
    var6 = var3.origin;

    if(isDefined(var4) && scripts\mp\utility\weapon::isaxeweapon(var4)) {
      relaunchaxe(var3, var4, var5);
    }
  }
}

function relaunchaxe(var0, var1) {
  self unlink();
  var2 = scripts\mp\utility\weapon::getweaponbasenamescript(var0);
  var3 = getsubstr(var0, var2.size);
  var4 = var1 scripts\mp\utility\weapon::_launchgrenade("iw7_axe_mp_dummy" + var3, self.origin, (0, 0, 0), 100, 1, self);
  var4 setentityowner(var1);
  var4 thread _utilflare_isvalidflaretype::watchgrenadeaxepickup(var1, self.weapon_name);
}

function callback_finishweaponchange(var0, var1, var2, var3) {
  updateweaponscriptvfx(var0, var1, var2, var3);
  var4 = self.weaponchangecallbacks;

  if(isDefined(var4)) {
    foreach(var6 in var4.callbacks) {
      self[[var6]](var0, var1);
    }

    foreach(var6 in var4.oneshotcallbacks) {
      self[[var6]](var0, var1);
    }

    var4.oneshotcallbacks = [];
    return;
  }
}

function updateweaponscriptvfx(var0, var1, var2, var3) {
  if((var1.basename == "none" || var1.basename == "alt_none") && isDefined(self.lastdroppableweapon)) {
    if(var1 == "alt_none") {
      var3 = 1;
    } else {
      var3 = 0;
    }

    var1 = self.lastdroppableweapon;
  }

  clearweaponscriptvfx(var1, var3);
  runweaponscriptvfx(var0, var2);
}

function runweaponscriptvfx(var0, var1) {
  if(!isDefined(var0)) {
    return;
  }

  if(isDefined(var1) && var1 == 1) {
    var2 = "alt_" + scripts\mp\utility\weapon::getweaponbasenamescript(var0);
    return;
  }

  var2 = scripts\mp\utility\weapon::getweaponbasenamescript(var1);
}

function clearweaponscriptvfx(var0, var1) {
  if(!isDefined(var0)) {
    return;
  }

  if(isDefined(var1) && var1 == 1) {
    var2 = "alt_" + scripts\mp\utility\weapon::getweaponbasenamescript(var0);
  } else {
    var2 = scripts\mp\utility\weapon::getweaponbasenamescript(var1);
  }

  switch (var2) {
    case "iw8_sn_delta_mp":
    case "iw8_sn_alpha50_mp":
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
    case "iw8_ar_mike4_mp":
    case "iw8_la_juliet_mp":
    case "iw8_la_rpapa7_mp":
    case "iw8_la_kgolf_mp":
    case "iw8_la_gromeo_mp":
    case "iw8_la_mike32_mp":
    case "iw8_ar_akilo47_mp":
    case "iw8_la_t9launcher_mp":
    case "iw8_la_t9freefire_mp":
    case "iw8_la_t9standard_mp":
    case "iw8_sm_t9standard_mp":
      break;
  }
}

function updatecamoscripts(var0, var1) {
  if(ref_1458a(var1)) {
    clearcamoscripts(getweaponcamoname(var1));
  }

  runcamoscripts(var0);
}

function runcamoscripts(var0) {
  if(!getdvarint("scr_reactive_camos", 1)) {
    return;
  }

  if(ref_1458a(var0)) {
    thread ref_12a3e(var0);
  } else {
    self setscriptablepartstate("activeCamo", "no_stage");
  }

  var1 = getweaponcamoname(var0);

  if(!isDefined(var1)) {
    return;
  }

  switch (var1) {
    case "camo84":
      thread blood_camo_84();
      break;
  }
}

function clearcamoscripts(var0) {
  self notify("endReactiveCamoThread");
  self setscriptablepartstate("activeCamo", "no_stage");

  if(!isDefined(var0)) {
    return;
  }

  switch (var0) {
    case "camo84":
      self notify("blood_camo_84");
      break;
  }
}

function ref_12a41() {
  scripts\mp\flags::gameflagwait("prematch_done");

  foreach(var1 in level.players) {
    if(isDefined(var1) && isDefined(var1.ref_12a44)) {
      var1.ref_12a44 = undefined;
      var1 notify("endReactiveCamoThread");
    }
  }
}

function ref_12a42(var0, var1, var2) {
  var0.ref_13765 = var1;

  if(var2 == 1) {
    self setscriptablepartstate("activeCamo", "stage" + var0.ref_13765);
    return;
  }

  self setscriptablepartstate("activeCamo", "init_stage" + var0.ref_13765);
}

function ref_12a43(var0) {
  if(!isDefined(self.ref_12a44)) {
    self.ref_12a44 = [];
  }

  if(!isDefined(self.ref_12a44[var0])) {
    self.ref_12a44[var0] = spawnStruct();
    self.ref_12a44[var0].kills = 0;
    self.ref_12a44[var0].ref_13765 = 0;
    return;
  }
}

function ref_12a3e(var0) {
  self endon("disconnect");
  self endon("death");
  self endon("endReactiveCamoThread");

  if(!isDefined(level.ref_12a40) && !scripts\mp\flags::gameflag("prematch_done")) {
    level.ref_12a40 = 1;
    thread ref_12a41();
  }

  var1 = ref_14585(var0);
  ref_12a43(var1);
  var2 = self.ref_12a44[var1];
  ref_12a42(var2, var2.ref_13765, 0);
  var3 = tablelookuprownum("reactive_camos.csv", 0, var1);
  var4 = int(tablelookupbyrow("reactive_camos.csv", var3, 1));
  var5 = strtok(tablelookupbyrow("reactive_camos.csv", var3, 2), "|");

  while(var2.ref_13765 < var4) {
    scripts\engine\utility::waittill_either("got_a_kill", "scr_advancereactivecamo");
    var6 = int(var5[var2.ref_13765 + 1]);
    var2.kills++;

    if(var2.kills >= var6) {
      ref_12a42(var2, var2.ref_13765 + 1, 1);

      if(!self isswitchingweapon()) {
        self playlocalsound("br_active_camo_transition");
      }
    }
  }
}

function blood_camo_84() {
  self endon("death_or_disconnect");
  self endon("blood_camo_84");

  if(isDefined(self.bloodcamokillcount)) {
    self setscriptablepartstate("camo_84", self.bloodcamokillcount + "_kills");
  } else {
    self.bloodcamokillcount = 0;
  }

  while(self.bloodcamokillcount < 13) {
    self waittill("kill_event_buffered");
    self.bloodcamokillcount += 1;
    self setscriptablepartstate("camo_84", self.bloodcamokillcount + "_kills");
  }
}

function ref_14585(var0) {
  return var0.basename + "_v" + var0.variantid;
}

function ref_1458a(var0) {
  if(!isDefined(var0) || !isDefined(var0.variantid)) {
    return false;
  }

  var1 = ref_14585(var0);
  var2 = tablelookuprownum("reactive_camos.csv", 0, var1);

  if(isDefined(var2) && var2 >= 0) {
    return true;
  }

  return false;
}

function getactiveequipmentarray() {
  return scripts\engine\utility::array_remove_duplicates(level.mines);
}

function init_function_refs() {
  level.getactiveequipmentarray = &getactiveequipmentarray;
}

function doesshareammo(var0) {
  return var0.isalternate && !issubstr(var0.underbarrel, "gl") && issubstr(var0.underbarrel, "shotgun");
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
    var0.ticks = scripts\mp\utility\script::roundup(4 * var2);
  }

  var4 = scripts\mp\equipment::getequipmentreffromweapon(var1);

  if(isDefined(var4)) {
    var0.equipmentref = var4;
    var0.isequipment = 1;

    if(var4 == "equip_smoke") {
      var0.owner scripts\mp\utility\stats::incpersstat("smokesUsed", 1);
    }
  }

  var0.threwback = isDefined(var3);
}

function waittill_missile_fire() {
  self waittill("missile_fire", var0, var1);

  if(isDefined(var0)) {
    if(!isDefined(var0.weapon_name)) {
      if(var1.isalternate) {
        var0.weapon_name = scripts\mp\utility\weapon::getaltmodeweapon(var1);
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

function update_jugg_targets(var0) {
  if(var0.basename == "iw8_ar_akilo47_mpdmb2" || var0.basename == "iw8_sm_mpapa7_mpmtx3") {
    return true;
  }

  return false;
}

function update_icon_for_bomb_case_detonator_holder(var0) {
  if(var0.basename == "iw8_ar_anovember94_mpmtx2" || var0.basename == "iw8_sm_papa90_mpmtx3") {
    return true;
  }

  if(isDefined(var0.reargrip) && var0.reargrip == "sword_8bit") {
    return true;
  }

  return false;
}

function ref_11df6(var0) {
  ref_12734("j_shoulder_ri", "teslaLimb");
  ref_12734("j_shoulder_le", "teslaLimb");
  ref_12734("j_elbow_ri", "teslaLimb");
  ref_12734("j_elbow_le", "teslaLimb");
  ref_12734("j_hip_ri", "teslaLimb");
  ref_12734("j_hip_le", "teslaLimb");
  ref_12734("j_knee_ri", "teslaLimb");
  ref_12734("j_knee_le", "teslaLimb");
  ref_12734("j_spineupper", "teslaTorso");
  ref_12734("j_head", "teslaHead");
  self playSound("iw8_mp_tesla_death_sfx");
  var0 hide();
}

function ref_11df5(var0) {
  ref_12734("j_shoulder_ri", "8BitLimb");
  ref_12734("j_shoulder_le", "8BitLimb");
  ref_12734("j_elbow_ri", "8BitLimb");
  ref_12734("j_elbow_le", "8BitLimb");
  ref_12734("j_hip_ri", "8BitLimb");
  ref_12734("j_hip_le", "8BitLimb");
  ref_12734("j_knee_ri", "8BitLimb");
  ref_12734("j_knee_le", "8BitLimb");
  ref_12734("j_spineupper", "8BitTorso");
  ref_12734("j_head", "8BitHead");
  self playSound("8bit_death_sfx");
  var0 hide();
}

function ref_12734(var0, var1) {
  var2 = self gettagorigin(var0);
  var3 = self gettagangles(var0);
  playFX(level._effect[var1], var2, anglesToForward(var3), anglestoup(var3));
}

function enableburnfx(var0, var1) {
  if(!isDefined(self.flare_thread)) {
    self.flare_thread = [];
  }

  if(!isDefined(var1)) {
    var1 = "active";
  }

  if(!istrue(var0)) {
    thread enableburnsfx();
  }

  self.flare_thread[release_mortar_operator(var1)] = var1;
  thread startburnfx();
}

function release_mortar_operator(var0) {
  switch (var0) {
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

function remove_invulnerability(var0) {
  var1 = 3;
  var2 = undefined;

  while(var1 >= 0) {
    if(isDefined(var0[var1])) {
      var2 = var0[var1];
      break;
    }

    var1--;
  }

  return var2;
}

function enableburnsfx() {
  if(!isDefined(self.burnsfxenabled)) {
    self.burnsfxenabled = 0;
  }

  if(!isDefined(self.burnsfx)) {
    self.burnsfx = spawn("script_origin", self.origin);
    self.burnsfx linkTo(self);
    self.burnsfx scripts\cp_mp\ent_manager::registerspawncount(1);
    thread flares_from_structs(self.burnsfx);
    wait 0.05;
  }

  if(self.burnsfxenabled == 0) {
    self.burnsfx playLoopSound("weap_molotov_fire_enemy_burn");
    self.burnsfxenabled = 1;
    return;
  }
}

function flares_from_structs(var0) {
  self endon("burnSFX_deleted");
  self waittill("disconnect");

  if(isDefined(var0)) {
    var0 stoploopsound("weap_molotov_fire_enemy_burn");
    var0 delete();
    return;
  }
}

function enableburnfxfortime(var0, var1) {
  if(!isDefined(var1)) {
    var1 = "active";
  }

  var2 = "endon_burnfxForTime_" + var1;
  self notify(var2);
  self endon("disconnect");
  self endon("clearBurnFX");
  self endon(var2);
  thread enableburnfx(0, var1);
  wait var0;
  thread disableburnfx(0, var1);
}

function disableburnfx(var0, var1) {
  if(isDefined(var1)) {
    if(self.flare_thread[release_mortar_operator(var1)] == var1) {
      self.flare_thread[release_mortar_operator(var1)] = undefined;
    }
  } else {
    self.flare_thread = [];
  }

  if(self.flare_thread.size > 0) {
    thread startburnfx();
    return;
  }

  thread stopburnfx();

  if(!istrue(var0)) {
    thread disable_burnsfx();
    return;
  }
}

function disable_burnsfx() {
  self endon("disconnect");

  if(!isDefined(self.burnsfxenabled)) {
    self.burnsfxenabled = 0;
  }

  wait 0.5;

  if(self.burnsfxenabled == 1) {
    self playSound("weap_molotov_fire_enemy_burn_end");

    if(isDefined(self.burnsfx)) {
      self.burnsfx scripts\cp_mp\ent_manager::deregisterspawn();
      wait 0.15;

      if(isDefined(self.burnsfx)) {
        self notify("burnSFX_deleted");
        self.burnsfx stoploopsound("weap_molotov_fire_enemy_burn");
        self.burnsfx delete();
      }
    }

    self.burnsfxenabled = 0;
    return;
  }
}

function supressburnfx(var0) {
  if(!isDefined(self.burnfxsuppressed)) {
    self.burnfxsupressed = 0;
  }

  if(var0) {
    self.burnfxsuppressed++;
    return;
  }

  self.burnfxsuppressed--;
}

function clearburnfx() {
  self notify("clearBurnFX");
  thread stopburnfx();
  self.burnfxsuppressed = undefined;
  self.burnfxplaying = undefined;
  self.flare_thread = undefined;
}

function startburnfx() {
  self notify("stopBurnFX");
  self endon("disconnect");
  self endon("stopBurnFX");
  var0 = remove_invulnerability(self.flare_thread);

  for(;;) {
    var1 = isDefined(self.burnfxsuppressed) && self.burnfxsuppressed > 0;
    var2 = isDefined(self.burnfxplaying);

    if(var1 && var2) {
      self setscriptablepartstate("burning", "neutral");
      scripts\mp\damage::dequeuecorpsetablefunc("burning");
      self.burnfxplaying = undefined;
    } else if(!var1 && !var2 || var0 != self.burnfxplaying) {
      self setscriptablepartstate("burning", var0);
      self.burnfxplaying = var0;

      if(!var2) {
        scripts\mp\damage::enqueuecorpsetablefunc("burning", &burnfxcorpstablefunc);
      }
    }

    waitframe();
  }
}

function stopburnfx() {
  self notify("stopBurnFX");

  if(isDefined(self.burnfxplaying)) {
    self setscriptablepartstate("burning", "neutral");
    scripts\mp\damage::dequeuecorpsetablefunc("burning");
    self.burnfxplaying = undefined;
    return;
  }
}

function burnfxcorpstablefunc(var0) {
  var0 setscriptablepartstate("burning", "flareUp", 0);
}

function ref_13018(var0) {
  self endon("disconnect");
  var0 endon("death");
  var0 waittill("missile_stuck", var1);

  if(isPlayer(var1)) {
    thread grenadestuckto(var0, var1);

    if(isalive(var1)) {
      thread ref_13016(var0, var1);
      return;
    }

    return;
  }
}

function ref_13016(var0, var1) {
  self endon("disconnect");
  var0 endon("end_explode");
  var1 endon("death_or_disconnect");
  var0 thread scripts\mp\utility\script::notifyafterframeend("death", "end_explode");
  var0 waittill("explode", var2);
  thread ref_13017(var1, var2);
}

function ref_13017(var0, var1) {
  var2 = distancesquared(var1, var0.origin);
  var3 = 5000;

  if(var2 > var3) {
    return;
  }

  var0 scripts\cp_mp\utility\damage_utility::playerplunderbankcallback();
  var0 dodamage(var0.maxhealth, var1, self, undefined, "MOD_EXPLOSIVE", getcompleteweaponname("semtex_mp"));
  var0 scripts\cp_mp\utility\damage_utility::playerplunderbankdeposit();
}