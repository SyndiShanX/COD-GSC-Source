/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\weapons.gsc
***********************************************/

function attachmentgroup(var_0) {
  return tablelookup("mp/attachmenttable.csv", 4, var_0, 2);
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

  var_0 = 25;
  level.sticky_minedetectiondot = cos(var_0);
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
      foreach(var_1 in level.players) {
        if(!isDefined(var_1)) {
          continue;
        }

        if(var_1 scripts\mp\utility\perk::_hasperk("specialty_scrap_weapons")) {
          var_2 = var_1 getcurrentweapon();
          var_1 getcurrentweapon();

          if(!isDefined(var_2)) {
            continue;
          }

          if(!isDefined(var_1.graverobberammo)) {
            var_1.graverobberammo = spawnStruct();
            var_1.graverobberammo = spawnStruct();
            var_1.graverobberammo = spawnStruct();
          }

          if(isDefined(var_1.graverobberammo.currentweapon) && var_1.graverobberammo.currentweapon.weapon.basename != "none" && var_1.graverobberammo.currentweapon.weapon != var_2) {
            var_1.graverobberammo.lastweapon = var_1.graverobberammo.currentweapon;
            var_1.graverobberammo.currentweapon = spawnStruct();
          }

          var_1.graverobberammo.currentweapon = spawnStruct();
          var_1.graverobberammo.currentweapon.weapon = var_2;
          var_1.graverobberammo.currentweapon.rightclip = var_1 getweaponammoclip(var_2, "right");
          var_1.graverobberammo.currentweapon.leftclip = var_1 getweaponammoclip(var_2, "left");
          var_1.graverobberammo.currentweapon.stock = var_1 getweaponammostock(var_2);
          continue;
        }

        var_1.graverobberammo = undefined;
      }
    }

    waitframe();
  }
}

function enablevisibilitycullingforclient(var_0) {
  self hudoutlinedisableforclient(var_0);
}

function onplayerconnect() {
  for(;;) {
    level waittill("connected", var_0);
    var_0.hits = 0;
    scripts\mp\gamelogic::sethasdonecombat(var_0, 0);
    thread watchmissileusage();
  }
}

function watchchangeweapon() {
  self endon("death_or_disconnect");
  self endon("joined_spectators");
  self endon("faux_spawn");
  level endon("game_ended");

  for(;;) {
    var_0 = self getcurrentweapon();

    if(isDefined(var_0)) {
      dochangeweapon(var_0);
    }

    self waittill("weapon_change");
  }
}

function dochangeweapon(var_0) {
  if(istrue(self.get_alive_players)) {
    ref_119ad(var_0);
  }

  self.get_alive_players = 1;
  updatecamoscripts(var_0, self.lastweaponobj);
  updateweaponspeed(var_0);
  updatelastweaponobj(var_0);
  updatelauncherusage();
  updatesniperglint(var_0);
  updateweaponperks();
  ref_13fd2(var_0);
  ref_13ffc(var_0);
  ref_12f87(var_0);
  scripts\mp\perks\perkfunctions::updatedefaultflinchreduction();
  scripts\mp\events::updateweaponchangetime();
  scripts\mp\class::riotshieldonweaponchange(var_0);
  scripts\mp\perks\perkfunctions::updateweaponkick();
  thread scripts\cp_mp\gestures::ref_13e1a();
}

function ref_12f87(var_0) {
  if(istrue(level.loadout_updateammo)) {
    return;
  }

  if(ref_132f2(var_0)) {
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

function ref_13ffc(var_0) {
  var_1 = scripts\mp\utility\weapon::getweaponrootname(var_0);
  var_2 = undefined;

  if(var_1 == "iw8_knife") {
    if(var_0.basename == "iw8_knife_mphatchetv4") {
      var_2 = "flamingHatchet";
    } else if(var_0.basename == "iw8_knife_mpb" && var_0.attachmentvarindices["me_knifeb"] == 9) {
      var_2 = "flamingKnife";
    } else if(var_0.basename == "iw8_knife_mpd" && var_0.attachmentvarindices["me_knifed"] == 1) {
      var_2 = "electricKnife";
    }
  }

  if(isDefined(var_2)) {
    thread ref_11df9(var_2);
  }

  return true;
}

function ref_11df9(var_0) {
  self endon("weapon_change");
  self endon("death_or_disconnect");
  self notify("newMTXVFXStateSet");
  self endon("newMTXVFXStateSet");
  var_1 = "cancel_" + var_0;
  thread ref_11df7(var_1);
  GscBinSkip4(0x35, var_0, var_1);
}

function ref_11dfe(var_0, var_1) {
  for(;;) {
    self waittill("weapon_switch_started");

    if(self isthrowinggrenade()) {
      ref_11dfa(var_1);
      self waittill("offhand_end");
      GscBinSkip4(0x35, var_0, var_1);
    }

    if(self isonladder()) {
      ref_11df8(var_0, var_1);
    }
  }
}

function ref_11dfd(var_0, var_1) {
  for(;;) {
    self waittill("mantle_end");

    if(self isonladder()) {
      ref_11df8(var_0, var_1);
    }
  }
}

function ref_11df8(var_0, var_1) {
  ref_11dfa(var_1);

  while(self isonladder()) {
    waitframe();
  }

  GscBinSkip4(0x35, var_0, var_1);
}

function ref_11dfb(var_0, var_1) {
  self notify(var_1);
  self endon(var_1);
  self.ref_12745 = 1;
  self setscriptablepartstate("weaponVFXViewmodel", var_0);
  self setscriptablepartstate("weaponVFXWorldModel", "neutral");
  var_2 = 0.4;
  wait var_2;
  self setscriptablepartstate("weaponVFXWorldModel", var_0, 0);
}

function ref_11dfc(var_0, var_1) {
  self notify(var_1);
  self endon(var_1);
  self.ref_12745 = 1;
  self setscriptablepartstate("weaponVFXViewmodel", "neutral");
  self setscriptablepartstate("weaponVFXWorldModel", "neutral");
  var_2 = 0.4;
  wait var_2;
  self setscriptablepartstate("weaponVFXViewmodel", var_0, 0);
  self setscriptablepartstate("weaponVFXWorldModel", var_0, 0);
}

function ref_11dfa(var_0) {
  self notify(var_0);

  if(istrue(self.ref_12745)) {
    self setscriptablepartstate("weaponVFXViewmodel", "neutral");
    self setscriptablepartstate("weaponVFXWorldModel", "neutral");
  }

  self.ref_12745 = undefined;
}

function ref_11df7(var_0) {
  self endon("disconnect");
  self endon("newMTXVFXStateSet");
  scripts\engine\utility::ref_143a5("death", "weapon_change");
  ref_11dfa(var_0);
}

function ref_132f2(var_0) {
  var_1 = scripts\mp\utility\weapon::getweaponrootname(var_0);

  if(var_1 == "iw8_lm_sierrax" && var_0 hasattachment("stocksaw_sierrax")) {
    return true;
  }

  return false;
}

function ref_119ad(var_0) {
  var_1 = var_0.basename;
  var_2 = "none";

  if(!isDefined(var_1) || var_1 == "none") {
    return;
  }

  if(isDefined(self.lastweaponobj) && var_0 == self.lastweaponobj) {
    return;
  }

  if(self.equippedweapons.size > 1) {
    var_2 = self.equippedweapons[1].basename;

    if(var_2 == var_1) {
      var_2 = self.equippedweapons[0].basename;
    }
  }

  if(isDefined(self.equippedweapons[0])) {
    self setclientweaponinfo(0, createheadicon(self.equippedweapons[0]));
  }

  if(isDefined(self.equippedweapons[1])) {
    self setclientweaponinfo(1, createheadicon(self.equippedweapons[1]));
  }

  self dlog_recordplayerevent("dlog_event_weapon_change", ["current_weapon", var_1, "secondary_weapon", var_2]);
}

function updateweaponperks() {
  self.prevweaponobj = doweaponperkupdate(self.prevweaponobj);
}

function updatesniperglint(var_0) {
  if(sniperglint_supported(var_0)) {
    GscBinSkip4(0x35);
  }
}

function ref_13fd2(var_0) {
  self notify("end_dragBreath");

  if(scripts\mp\utility\weapon::getweapongroup(var_0) == "weapon_shotgun" || var_0.basename == "iw8_pi_t9pistolshot_mp" || var_0 hasattachment("ammo_incendiary", 1)) {
    if(scripts\cp_mp\killstreaks\nuke::unlockables(var_0)) {
      thread scripts\cp_mp\killstreaks\nuke::terminal_pusher_approach_array(var_0);
      return;
    }

    return;
  }
}

function updatelauncherusage() {
  var_0 = self getcurrentweapon();
  var_1 = scripts\mp\utility\weapon::getweaponrootname(var_0.basename);

  switch (var_1) {
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
    var_2 = weaponclass(var_0.basename) == "rocketlauncher" || var_0.basename == "iw8_la_kgolf_mp";

    if(var_2 && !istrue(self.fastreloadlaunchers)) {
      scripts\mp\utility\perk::giveperk("specialty_fastreload");
      self.fastreloadlaunchers = 1;
    } else if(!var_2 && istrue(self.fastreloadlaunchers)) {
      scripts\mp\utility\perk::removeperk("specialty_fastreload");
      self.fastreloadlaunchers = undefined;
    }
  }

  switch (var_1) {
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
      thread scripts\cp\vehicles\vehicle_damage_cp::initarmor(var_0);
      break;
    case "iw8_sn_xmike109":
      thread scripts\cp_mp\utility\omnvar_utility::ref_1403e(var_0);
      break;
    case "iw8_sh_aalpha12":
      thread scripts\cp\utility\cp_safehouse_util::ref_1403e(var_0);
      break;
    case "iw8_me_t9ballisticknife":
      thread scripts\cp\vehicles\cargo_truck_mg_cp::ref_1403e(var_0);
      break;
  }
}

function ref_1316b(var_0) {
  self.lastdroppableweaponobj = var_0;

  if(isDefined(level.waittillmatch_wait)) {
    self[[level.waittillmatch_wait]]();
    return;
  }
}

function updatelastweaponobj(var_0) {
  var_1 = var_0 getnoaltweapon();

  if(nullweapon(var_1)) {
    var_1 = var_0;
  }

  self.lastweaponobj = var_0;

  if(isnormallastweapon(var_0)) {
    self.lastnormalweaponobj = var_0;
  }

  if(isdroppableweapon(var_1)) {
    ref_1316b(var_1);
  }

  if(scripts\mp\utility\weapon::iscacprimaryorsecondary(var_0)) {
    self.lastcacweaponobj = var_0;
    return;
  }
}

function updateweaponspeed(var_0) {
  if(var_0.basename == "none") {
    return;
  } else if(scripts\mp\utility\weapon::issuperweapon(var_0.basename)) {
    updatemovespeedscale();
    return;
  } else if(scripts\mp\utility\weapon::iskillstreakweapon(var_0.basename)) {
    return;
  } else if(var_0.basename == "iw8_fists_mp_ls") {
    updatemovespeedscale();
    return;
  } else if(var_0.inventorytype != "primary" && var_0.inventorytype != "altmode") {
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
  var_0 = self.primaryinventory;

  foreach(var_2 in var_0) {
    if(!getqueuedspleveltransients(self.primaryweaponobj) && var_2 == self.primaryweaponobj || !getqueuedspleveltransients(self.secondaryweaponobj) && var_2 == self.secondaryweaponobj) {
      if(shouldweaponsavealtstate(var_2) && self isalternatemode(var_2, 1)) {
        var_3 = scripts\mp\utility\weapon::getcompleteweaponnamenoalt(var_2);
        self.pers["altStates"][var_3] = 1;
      }
    }
  }
}

function savetogglescopestates() {
  self.pers["toggleScopeStates"] = [];
  var_0 = self.primaryinventory;

  foreach(var_2 in var_0) {
    if(!getqueuedspleveltransients(self.primaryweaponobj) && var_2 == self.primaryweaponobj || !getqueuedspleveltransients(self.secondaryweaponobj) && var_2 == self.secondaryweaponobj) {
      if(isDefined(var_2.scope) && istogglescope(var_2.scope) && !ref_138b1(var_2.backpiece)) {
        var_3 = scripts\mp\utility\weapon::getcompleteweaponnamenoalt(var_2);
        self.pers["toggleScopeStates"][var_3] = self gethybridscopestate(var_2);
      }
    }
  }
}

function updatetogglescopestate(var_0) {
  var_1 = scripts\mp\utility\weapon::getcompleteweaponnamenoalt(var_0);

  if(isDefined(self.pers["toggleScopeStates"]) && isDefined(self.pers["toggleScopeStates"][var_1])) {
    self sethybridscopestate(var_0, self.pers["toggleScopeStates"][var_1]);
    return;
  }
}

function updatesavedaltstate(var_0) {
  if(isDefined(self.pers["altStates"]) && istrue(var_0.hasalternate)) {
    var_1 = scripts\mp\utility\weapon::getcompleteweaponnamenoalt(var_0);

    if(isDefined(self.pers["altStates"][var_1]) && self.pers["altStates"][var_1]) {
      var_0 = var_0 getaltweapon();
    }
  }

  return var_0;
}

function istogglescope(var_0) {
  var_1 = scripts\mp\utility\weapon::attachmentmap_tobase(var_0);

  switch (var_1) {
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

function ref_138b1(var_0) {
  return isDefined(var_0) && var_0 == "stocksaw_sierrax";
}

function shouldweaponsavealtstate(var_0) {
  if(istrue(var_0.hasalternate)) {
    if(shouldattachmentsavealtstate(var_0.underbarrel)) {
      return true;
    }
  }

  return false;
}

function shouldattachmentsavealtstate(var_0) {
  return turretoverridefunc(var_0);
}

function turretoverridefunc(var_0) {
  var_1 = scripts\mp\utility\weapon::attachmentmap_tobase(var_0);

  switch (var_1) {
    case "selectauto":
    case "selectburst":
    case "selectsemi":
      return 1;
    default:
      return 0;
  }
}

function turretobjweapon(var_0) {
  var_1 = scripts\mp\utility\weapon::attachmentmap_tobase(var_0);

  switch (var_1) {
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

function weaponperkupdate(var_0, var_1) {
  if(!getqueuedspleveltransients(var_1)) {
    var_2 = scripts\mp\utility\weapon::getweaponrootname(var_1.basename);
    var_3 = scripts\mp\utility\weapon::weaponperkmap(var_2);

    if(isDefined(var_3)) {
      scripts\mp\class::loadout_removeperk(var_3);
    }
  }

  if(!getqueuedspleveltransients(var_0)) {
    var_4 = scripts\mp\utility\weapon::getweaponrootname(var_0.basename);
    var_5 = scripts\mp\utility\weapon::weaponperkmap(var_4);

    if(isDefined(var_5)) {
      scripts\mp\class::loadout_giveperk(var_5);
      return;
    }

    return;
  }
}

function weaponattachmentperkupdate(var_0, var_1) {
  var_2 = undefined;
  var_3 = undefined;

  if(!getqueuedspleveltransients(var_1)) {
    var_3 = getweaponattachments(var_1);

    if(isDefined(var_3) && var_3.size > 0) {
      foreach(var_5 in var_3) {
        var_6 = scripts\mp\utility\weapon::attachmentperkmap(var_5);

        if(!isDefined(var_6)) {
          continue;
        }

        if(!scripts\mp\utility\perk::_hasperk(var_6)) {
          continue;
        }

        scripts\mp\class::loadout_removeperk(var_6);
      }
    }
  }

  if(!getqueuedspleveltransients(var_0)) {
    var_2 = getweaponattachments(var_0);

    if(isDefined(var_2) && var_2.size > 0) {
      foreach(var_9 in var_2) {
        var_6 = scripts\mp\utility\weapon::attachmentperkmap(var_9);

        if(!isDefined(var_6)) {
          continue;
        }

        scripts\mp\class::loadout_giveperk(var_6);
      }

      return;
    }

    return;
  }
}

function doweaponperkupdate(var_0) {
  var_1 = self getcurrentweapon();
  weaponattachmentperkupdate(var_1, var_0);
  weaponperkupdate(var_1, var_0);
  return var_1;
}

function watchweaponperkupdates() {
  self endon("death_or_disconnect");
  self endon("faux_spawn");
  self endon("giveLoadout_start");
  var_0 = undefined;

  for(;;) {
    var_0 = doweaponperkupdate(var_0);
    self waittill("weapon_change");
  }
}

function watchsniperuse() {
  self endon("death_or_disconnect");

  for(;;) {
    var_0 = self getcurrentweapon();

    if(sniperglint_supported(var_0)) {
      GscBinSkip4(0x35);
    }

    self waittill("weapon_change");
  }
}

function sniperadsblur_supported(var_0) {
  return scripts\mp\utility\weapon::weaponhasattachment(var_0, "scope") && !issubstr(var_0.basename, "alpha50") && !issubstr(var_0.basename, "mike14");
}

function sniperglint_supported(var_0) {
  if(nullweapon(var_0) || !isDefined(var_0.scope) || weaponclass(var_0) == "rocketlauncher" || weaponclass(var_0) == "smg") {
    return false;
  }

  if(var_0.basename == "s4_mr_gecho43_mp" || var_0.basename == "s4_mr_m1golf_mp" || var_0.basename == "s4_mr_svictor40_mp" || var_0.basename == "s4_mr_malpha1916_mp") {
    return false;
  }

  var_1 = scripts\mp\utility\weapon::attachmentmap_tobase(var_0.scope);

  switch (var_1) {
    case "scope":
      if(var_0.basename == "iw8_ar_t9british_mp") {
        return false;
      } else if(var_0.classname == "sniper" && issubstr(var_0.basename, "s4")) {
        return true;
      }
    case "scopelight":
      if(var_0.classname == "sniper") {
        return true;
      } else {
        return false;
      }
    case "scopenorail":
      if(var_0.classname == "sniper" && issubstr(var_0.basename, "s4")) {
        return true;
      } else {
        return false;
      }
    case "scopenvg":
      if(var_0.classname == "sniper") {
        return true;
      } else {
        return false;
      }
    case "vzscope2":
      if(var_0.classname != "sniper" && issubstr(var_0.basename, "s4")) {
        return false;
      }
    case "thermalvz":
    case "vzscope3":
      return true;
    case "thermal":
      var_2 = scripts\mp\utility\weapon::getweapongroup(var_0);

      if(var_2 == "weapon_sniper") {
        return true;
      } else {
        return false;
      }
    case "acog3":
      if(var_0.classname == "sniper" && issubstr(var_0.basename, "t9")) {
        return true;
      } else {
        return false;
      }
    case "acog4":
      if(issubstr(var_0.basename, "t9")) {
        return true;
      } else {
        return false;
      }
    case "vzscope":
      if(var_0.classname == "sniper" && (issubstr(var_0.basename, "s4") || issubstr(var_0.basename, "t9"))) {
        return true;
      } else if(!issubstr(var_0.basename, "s4") && !issubstr(var_0.basename, "t9")) {
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
    var_0 = getdvarfloat("scr_gunperk_shrouded_zoom_level", 0.85);
  } else {
    var_0 = 0.5;
  }

  for(;;) {
    if(self playerads() > var_0) {
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

function sniperadsblur(var_0) {
  self endon("weapon_change");
  self.sniperblur = 0;

  for(;;) {
    if(self playerads() > 0.65 && !self.sniperblur) {
      thread sniperadsblur_execute(var_0);
    } else if(self playerads() <= 0.65) {
      sniperadsblur_remove();
    }

    waitframe();
  }
}

function sniperadsblur_execute(var_0) {
  self notify("sniperBlurReset");
  self endon("sniperBlurReset");
  self.sniperblur = 1;
  self setblurforplayer(25, 0.1);
  wait 0.1;
  self setblurforplayer(0, getsniperadsblurtime(var_0));
}

function sniperadsblur_remove() {
  self notify("sniperBlurReset");
  self setblurforplayer(0, 0);
  self.sniperblur = 0;
}

function getsniperadsblurtime(var_0) {
  var_1 = 0.3;

  switch (var_0.basename) {
    case "iw8_sn_kilo98_mp":
      var_1 = 0.18;
      break;
    case "iw8_sn_mike14_mp":
      var_1 = 0.12;
      break;
    case "iw8_sn_sbeta_mp":
      var_1 = 0.12;
      break;
  }

  return var_1;
}

function watchsniperboltactionkills() {
  self endon("death_or_disconnect");
  thread watchsniperboltactionkills_ondeath();

  if(!isDefined(self.pers["recoilReduceKills"])) {
    self.pers["recoilReduceKills"] = 0;
  }

  self setclientomnvar("weap_sniper_display_state", self.pers["recoilReduceKills"]);

  for(;;) {
    self waittill("got_a_kill", var_0, var_1, var_2);
    var_3 = asmdevgetallstates(var_1);

    if(isrecoilreducingweapon(var_3)) {
      var_4 = self.pers["recoilReduceKills"] + 1;
      self.pers["recoilReduceKills"] = int(min(var_4, 4));
      self setclientomnvar("weap_sniper_display_state", self.pers["recoilReduceKills"]);

      if(var_4 <= 4) {
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

function isrecoilreducingweapon(var_0) {
  if(!isDefined(var_0) || nullweapon(var_0)) {
    return 0;
  }

  var_1 = 0;

  if(var_0 hasattachment("l115a3scope", 1) || var_0 hasattachment("l115a3vzscope", 1) || var_0 hasattachment("usrscope", 1) || var_0 hasattachment("usrvzscope", 1)) {
    var_1 = 1;
  }

  return var_1;
}

function getrecoilreductionvalue() {
  if(!isDefined(self.pers["recoilReduceKills"])) {
    self.pers["recoilReduceKills"] = 0;
  }

  return self.pers["recoilReduceKills"] * 3;
}

function ishackweapon(var_0) {
  if(var_0 == "radar_mp" || var_0 == "airstrike_mp" || var_0 == "helicopter_mp") {
    return true;
  }

  if(var_0 == "briefcase_bomb_mp") {
    return true;
  }

  return false;
}

function isfistweapon(var_0) {
  var_0 = scripts\mp\utility\weapon::getweaponrootname(var_0);
  return var_0 == "iw8_fists";
}

function isbombplantweapon(var_0) {
  return var_0 == "briefcase_bomb_mp" || var_0 == "briefcase_bomb_defuse_mp" || var_0 == "briefcase_silent_mp" || var_0 == "briefcase_defuse_silent_mp";
}

function dropweaponfordeath(var_0, var_1, var_2, var_3) {
  if(isDefined(level.blockweapondrops)) {
    return;
  }

  if(isDefined(self.droppeddeathweapon)) {
    return;
  }

  if(isDefined(var_0) && var_0 == self || var_1 == "MOD_SUICIDE") {
    return;
  }

  var_4 = self.lastdroppableweaponobj;

  if(isDefined(var_2)) {
    var_4 = var_2;
  }

  if(!isDefined(var_4)) {
    return;
  }

  if(var_4.basename == "none") {
    return;
  }

  if(!self hasweapon(var_4)) {
    return;
  }

  if(isDefined(level.gamemodemaydropweapon) && !self[[level.gamemodemaydropweapon]](var_4)) {
    return;
  }

  var_4 = var_4 getnoaltweapon();
  var_5 = 0;
  var_6 = 0;
  var_7 = 0;

  if(!scripts\mp\riotshield::isriotshield(var_4.basename)) {
    if(!self anyammoforweaponmodes(var_4)) {
      return;
    }

    var_5 = self getweaponammoclip(var_4, "right");
    var_6 = self getweaponammoclip(var_4, "left");

    if(!var_5 && !var_6) {
      return;
    }

    var_7 = self getweaponammostock(var_4);
    var_8 = weaponmaxammo(var_4);

    if(var_7 > var_8) {
      var_7 = var_8;
    }

    var_9 = self dropitem(var_4);

    if(!isDefined(var_9)) {
      return;
    }

    if(istrue(level.clearstockondrop)) {
      var_7 = 0;
    }

    var_9 itemweaponsetammo(var_5, var_7, var_6);
    var_10 = scripts\mp\utility\weapon::getweapongroup(var_4);

    if(var_1 != "MOD_EXECUTION") {
      thread scripts\cp_mp\utility\weapon_utility::dropweaponfordeathlaunch(var_9, var_10, var_3, self.angles);
    }
  } else {
    var_9 = self dropitem(var_5);

    if(!isDefined(var_9)) {
      return;
    }

    var_9 itemweaponsetammo(1, 1, 0);
  }

  var_9 sethintdisplayrange(96);
  var_9 setuserange(96);
  self.droppeddeathweapon = 1;
  var_9.owner = self;
  var_9.targetname = "dropped_weapon";
  var_9.objweapon = var_5;
  thread watchpickup(var_9);
  thread deletepickupafterawhile();
}

function forcedropweapon(var_0) {
  if(isDefined(level.blockweapondrops)) {
    return 0;
  }

  if(isDefined(self.droppeddeathweapon)) {
    return 0;
  }

  var_1 = self.lastdroppableweaponobj;

  if(isDefined(var_0)) {
    var_1 = var_0;
  }

  if(!isDefined(var_1)) {
    return 0;
  }

  if(var_1.basename == "none") {
    return 0;
  }

  if(!self hasweapon(var_1)) {
    return -1;
  }

  if(isDefined(level.gamemodemaydropweapon) && !self[[level.gamemodemaydropweapon]](var_1)) {
    return 0;
  }

  var_1 = var_1 getnoaltweapon();
  var_2 = 0;
  var_3 = 0;
  var_4 = 0;

  if(!scripts\mp\riotshield::isriotshield(var_1.basename)) {
    if(!self anyammoforweaponmodes(var_1)) {
      return 0;
    }

    var_2 = self getweaponammoclip(var_1, "right");
    var_3 = self getweaponammoclip(var_1, "left");

    if(!var_2 && !var_3) {
      return 0;
    }

    var_4 = self getweaponammostock(var_1);
    var_5 = weaponmaxammo(var_1);

    if(var_4 > var_5) {
      var_4 = var_5;
    }

    var_6 = self dropitem(var_1);

    if(!isDefined(var_6)) {
      return 0;
    }

    if(istrue(level.clearstockondrop)) {
      var_4 = 0;
    }

    var_6 itemweaponsetammo(var_2, var_4, var_3);
  } else {
    var_6 = self dropitem(var_2);

    if(!isDefined(var_6)) {
      return 0;
    }

    var_6 itemweaponsetammo(1, 1, 0);
  }

  var_6 sethintdisplayrange(96);
  var_6 setuserange(96);
  var_6.owner = self;
  var_6.targetname = "dropped_weapon";
  var_6.objweapon = var_2;
  thread watchpickup(var_6);
  thread deletepickupafterawhile();
  return 1;
}

function detachifattached(var_0, var_1) {
  var_2 = self getattachsize();
  var_3 = 0;

  while(var_3 < var_2) {
    var_4 = self getattachmodelname(var_3);

    if(var_4 != var_0) {} else {
      var_5 = self getattachtagname(var_3);
      self detach(var_0, var_5);

      if(var_5 != var_1) {
        var_2 = self getattachsize();

        for(var_3 = 0; var_3 < var_2; var_3++) {
          var_5 = self getattachtagname(var_3);

          if(var_5 != var_1) {
            continue;
          }

          var_0 = self getattachmodelname(var_3);
          self detach(var_0, var_5);
          break;
        }
      }

      return true;
    }

    var_4++;
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
  var_0 = self.classname;
  var_1 = getsubstr(var_0, 7);
  return var_1;
}

function watchpickup(var_0) {
  self endon("death");
  level.ref_120ad _calloutmarkerping_handleluinotify_acknowledgedcancel::from(self, var_0, self.objweapon);
  var_1 = getitemweaponname();

  for(;;) {
    self waittill("trigger", var_2, var_3);
    var_4 = undefined;
    var_5 = isDefined(level.cyberemp) && isDefined(level.cyberemp.carrier) && level.cyberemp.carrier == var_2;
    var_6 = scripts\mp\utility\game::getgametype() == "cyber" && (isDefined(var_3) || var_5);

    if(var_6) {
      var_7 = var_2 scripts\cp_mp\utility\inventory_utility::getcurrentprimaryweaponsminusalt();

      if(var_7.size > 2) {
        var_8 = 0;
        var_9 = 0;
        var_10 = 0;

        foreach(var_12 in var_7) {
          if(var_12.basename == "iw8_cyberemp_mp") {
            var_8 = 1;
          }

          if(scripts\mp\utility\weapon::update_health_bar_to_player(var_12)) {
            var_9 = 1;
          }

          if(var_12.basename == "iw8_lm_dblmg_mp") {
            var_10 = 1;
          }
        }

        if(isDefined(var_2.primaryweapon) && var_2.primaryweapon != "iw8_cyberemp_mp") {
          var_4 = var_2.primaryweaponobj;
        } else if(isDefined(var_2.secondaryweapon) && var_2.secondaryweapon != "iw8_cyberemp_mp") {
          var_4 = var_2.secondaryweaponobj;
        }

        var_14 = var_7.size;

        if(var_9) {
          var_14--;
        }

        if(var_10) {
          var_14--;
        }

        if(!var_8 || var_14 > 3) {
          var_15 = undefined;

          if(var_4.basename != "none") {
            var_15 = var_4;
          }

          var_16 = forcedropweapon(var_2, var_15);

          if(var_5) {
            var_2 scripts\common\utility::allow_weapon_switch(0);
            var_2 scripts\common\utility::allow_weapon_pickup(0);
            var_2 scripts\common\utility::allow_usability(0);
            thread waitthengivecyberweapon(var_2);
          }

          if(var_16 == 0) {
            if(var_5) {
              var_2 scripts\common\utility::allow_usability(1);
              var_2 scripts\common\utility::allow_weapon_switch(1);
              var_2 scripts\common\utility::allow_weapon_pickup(1);
            }

            return;
          } else if(var_16 == -1) {}
          LOC_000001eb:
        }
      } else if(var_5) {
        var_2 scripts\common\utility::allow_weapon_switch(0);
        var_2 scripts\common\utility::allow_weapon_pickup(0);
        var_2 scripts\common\utility::allow_usability(0);
        thread waitthengivecyberweapon();
      } else if(isDefined(var_3)) {
        var_4 = var_2.lastdroppableweaponobj;
      } else {
        var_4 = var_2 getcurrentweapon();
      }
    } else if(isDefined(var_3)) {
      var_4 = var_2.lastdroppableweaponobj;
    } else {
      var_4 = var_2 getcurrentweapon();
    }

    var_17 = var_2 scripts\mp\utility\perk::_hasperk("specialty_scrap_weapons") && getdvarint("perk_graverobber_enabled") == 1;
    thread watchpickupcomplete(var_2, self.objweapon, var_4);
    level.ref_120ae _calloutmarkerping_handleluinotify_acknowledgedcancel::from(self, var_2, self.objweapon);
    var_2 notify("weapon_pickup", self.objweapon);

    if(isDefined(var_3)) {
      var_2.lastweaponpickuptime = gettime();
      var_2 scripts\mp\utility\stats::incpersstat("weaponPickups", 1);
    }

    var_18 = fixupplayerweapons(var_2, var_1);

    if(isDefined(var_3) && var_17) {
      var_3 delete();
    }
  }

  LOC_000002f2:
    if(isDefined(var_3)) {
      var_19 = getitemweaponname(var_3);
      var_20 = asmdevgetallstates(var_19);

      if(isDefined(var_2.tookweaponfrom[var_19])) {
        var_3.owner = var_2.tookweaponfrom[var_19];
        var_2.tookweaponfrom[var_19] = undefined;
      }

      var_3.objweapon = var_20;
      var_3.targetname = "dropped_weapon";
      thread watchpickup(var_3);
    }

  var_2.tookweaponfrom[var_1] = self.owner;
}

function waitthengivecyberweapon(var_0) {
  self endon("death_or_disconnect");
  self notify("cancelGiveEmp");
  self endon("cancelGiveEmp");

  while(isDefined(self.currentweapon.basename) && self.currentweapon.basename == "none") {
    waitframe();
  }

  scripts\cp_mp\utility\inventory_utility::_giveweapon("iw8_cyberemp_mp");

  if(!istrue(var_0)) {
    scripts\common\utility::allow_usability(1);
    scripts\common\utility::allow_weapon_switch(1);
    scripts\common\utility::allow_weapon_pickup(1);
    return;
  }
}

function watchpickupcomplete(var_0, var_1, var_2) {
  self endon("death_or_disconnect");
  self notify("watchPickupComplete()");
  self endon("watchPickupComplete()");
  var_3 = self.currentweapon;
  var_4 = 0;
  jumpiffalse(var_3 == var_0) LOC_00000033;
  var_4 = 1;
  goto LOC_00000069;
}

function usegraverobber(var_0, var_1) {
  if(isDefined(var_1)) {
    scripts\cp_mp\utility\inventory_utility::_takeweapon(var_0);
    var_2 = var_1;
    var_3 = safechecknum(var_1.name);
    var_4 = getrandomgraverobberattachment(var_1);

    if(isDefined(var_4)) {
      var_5 = getweaponattachments(var_1);

      foreach(var_7 in var_5) {
        if(!scripts\mp\utility\weapon::attachmentscompatible(var_3, var_7, var_4)) {
          var_5[var_8] = undefined;
        }
      }

      var_5 = scripts\engine\utility::array_removeundefined(var_5);
      var_5 = var_4;
      var_2 = var_1 withattachments(var_5);
    }

    var_9 = scripts\mp\utility\weapon::getweaponfullname(var_2);
    scripts\cp_mp\utility\inventory_utility::_giveweapon(var_2);
    self assignweaponprimaryslot(var_9);
    scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate(var_9);
    fixupplayerweapons(self, var_9);
    self setweaponammoclip(var_2, self.graverobberammo.lastweapon.rightclip, "right");
    self setweaponammoclip(var_2, self.graverobberammo.lastweapon.leftclip, "left");
    self setweaponammostock(var_2, self.graverobberammo.lastweapon.stock);
    var_10 = self getweaponslistprimaries();

    foreach(var_12 in var_10) {
      addscavengercliptoweapon(self, var_12, 0.5);
    }

    if(isDefined(var_4)) {
      wait 0.05;
      var_5 = getweaponattachments(var_2);
      var_14 = scripts\engine\utility::array_find(var_5, var_4);

      if(!isDefined(var_14)) {
        var_14 = 0;
      }

      self setclientomnvar("ui_weapon_pickup", var_14 + 1);
      self playlocalsound("attachment_pickup");
      return;
    }

    return;
  }
}

function getrandomgraverobberattachment(var_0, var_1) {
  if(!isDefined(var_0)) {
    return undefined;
  }

  var_2 = scripts\mp\utility\weapon::getweaponrootname(var_0);
  var_3 = getweaponattachments(var_0);
  var_4 = [];

  if(isDefined(var_1) && var_1.size > 0) {
    var_4 = var_1;
  } else {
    var_4 = scripts\mp\utility\weapon::register_wave_spawner(var_2);
  }

  if(!isDefined(var_4)) {
    return undefined;
  }

  foreach(var_6 in var_3) {
    var_7 = scripts\mp\utility\weapon::attachmentmap_tobase(var_6);

    if(!scripts\mp\utility\weapon::carriedpunchcard(var_0, var_7)) {
      var_3[var_8] = undefined;
    }
  }

  var_4 = scripts\engine\utility::can_be_shot_again(var_4);
  var_4 = scripts\engine\utility::array_randomize(var_4);

  foreach(var_10 in var_4) {
    if(!isgraverobberattachment(var_2, var_10)) {
      continue;
    }

    var_11 = 0;

    foreach(var_6 in var_3) {
      if(scripts\mp\utility\weapon::attachmentsconflict(var_6, var_10, var_0) != "") {
        var_11 = 1;
        break;
      }
    }

    if(var_11) {
      continue;
    }

    return var_10;
  }

  return undefined;
}

function addattachmenttoweapon(var_0, var_1) {
  var_2 = getweaponvariantindex(var_0);
  var_0 = var_0 getnoaltweapon();
  var_3 = var_0.attachmentvarindices;
  var_4 = [];
  var_5 = [];

  foreach(var_9, var_7 in var_3) {
    var_8 = scripts\mp\utility\weapon::attachmentmap_tobase(var_9);
    var_5 = var_8;
    var_4 = var_7;
  }

  var_10 = 0;

  if(scripts\engine\utility::array_contains(var_5, var_1)) {
    var_10 = 1;
  } else {
    var_11 = scripts\mp\utility\weapon::attachmentmap_tounique(var_1, var_0);

    if(!var_0 canuseattachment(var_11)) {
      var_10 = 1;
    }
  }

  if(var_10) {
    return undefined;
  }

  var_5 = scripts\mp\utility\weapon::weaponattachremoveextraattachments(var_5, var_0);
  var_12 = [];

  foreach(var_9 in var_5) {
    var_12 = var_4[var_9];
  }

  var_5 = var_1;
  var_12 = 0;
  var_15 = var_0.camo;
  var_16 = [];

  if(isDefined(var_0.stickerslot0)) {
    GscBinSkip0(0x2e, var_16.size, var_0.stickerslot0);
  }

  if(isDefined(var_0.stickerslot1)) {
    GscBinSkip0(0x2e, var_16.size, var_0.stickerslot1);
  }

  if(isDefined(var_0.stickerslot2)) {
    GscBinSkip0(0x2e, var_16.size, var_0.stickerslot2);
  }

  if(isDefined(var_0.stickerslot3)) {
    GscBinSkip0(0x2e, var_16.size, var_0.stickerslot3);
  }

  var_17 = scripts\cp_mp\utility\game_utility::isnightmap();
  var_0 = scripts\mp\class::buildweapon(scripts\mp\utility\weapon::getweaponrootname(var_0), var_5, var_15, "none", var_2, var_12, undefined, var_16, var_17);
  return var_0;
}

function getammooverride(var_0) {
  var_1 = var_0 getbaseweapon();
  var_2 = weaponclipsize(var_1);
  var_3 = weaponclipsize(var_0);
  var_4 = var_2;

  switch (var_0.basename) {
    case "iw8_lm_mkilo3_mp":
    case "iw8_sh_mike26_mp":
    case "iw8_sn_sksierra_mp":
      break;
    default:
      var_4 = int(min(var_2, var_3));
      break;
  }

  var_5 = scripts\mp\utility\weapon::getweaponrootname(var_0);
  var_6 = 30;

  if(var_0.isalternate) {
    var_7 = scripts\mp\utility\weapon::attachmentmap_tobase(var_0.underbarrel);

    switch (var_7) {
      case "glsnap":
      case "glsemtex":
      case "glincendiary":
      case "glflash":
      case "glconc":
      case "glgas":
      case "glsmoke":
      case "gl":
        var_6 = 1;
        break;
      case "ubshtgn":
        var_6 = 999;
        break;
      default:
        var_6 = 0;
        break;
    }
  } else {
    switch (var_0.classname) {
      case "spread":
        switch (var_5) {
          case "iw8_sh_charlie725":
            var_6 = 6;
            break;
          case "iw8_sh_dpapa12":
            var_6 = 8;
            break;
          default:
            var_6 = int(min(var_4, 30));
            break;
        }

        break;
      case "sniper":
        switch (var_5) {
          case "iw8_sn_crossbow":
            var_6 = 3;
            break;
          default:
            var_6 = int(min(var_4, 30));
            break;
        }

        break;
      default:
        var_6 = int(min(var_4, 30));
        break;
    }
  }

  return var_6;
}

function isgraverobberattachment(var_0, var_1) {
  if(!scripts\mp\utility\weapon::carriedpunchcard(var_0, var_1)) {
    return false;
  }

  switch (var_1) {
    case "laserbalanced":
    case "maxammo":
    case "laserrange":
    case "akimbo":
      return false;
  }

  if(issubstr(var_1, "thermal")) {
    return false;
  }

  if(issubstr(var_1, "burst")) {
    return false;
  }

  if(getsubstr(var_1, 0, 3) == "cal") {
    return false;
  }

  return true;
}

function notifyuiofpickedupweapon() {}

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

function itemremoveammofromaltmodes() {
  var_0 = getitemweaponname();
  var_1 = weaponaltweaponname(var_0);

  for(var_2 = 1; var_1 != "none" && var_1 != var_0; var_2++) {
    self itemweaponsetammo(0, 0, 0, var_2);
    var_1 = weaponaltweaponname(var_1);
  }
}

function ref_12082(var_0) {
  if(isDefined(level.ref_12082)) {
    [[level.ref_12082]](var_0);
    return;
  }

  scavengergiveammo(var_0);
  var_0 scripts\mp\equipment::givescavengerammo();
  var_0 scripts\mp\gametypes\br_plunder::ref_12627(level.™Û sÇ› Ÿ8ùJ #— Õx£ éCÐãkÝ);
}

function handlescavengerbagpickup(var_0) {
  self endon("death");
  level endon("game_ended");

  for(;;) {
    self waittill("scavenger", var_1);

    if(!var_1 scripts\cp_mp\utility\player_utility::isinvehicle()) {
      break;
    }
  }

  var_1 notify("scavenger_pickup");
  ref_12082(var_1);

  if(!isDefined(var_1.pers["scavengerPickedUp"])) {
    var_1.pers["scavengerPickedUp"] = 0;
  }

  var_1 scripts\cp\vehicles\vehicle_compass_cp::ref_1205f("scavengerAmmo", 0);
  var_1 scripts\mp\utility\stats::incpersstat("scavengerPickedUp", 1);
  var_1 scripts\mp\damagefeedback::hudicontype("scavenger");
  var_2 = scripts\mp\utility\game::unset_relic_grounded();

  if(istrue(var_2)) {
    var_1 scripts\mp\equipment::incrementequipmentslotammo("health", 1);
  }

  if(isDefined(self.useobj)) {
    self.useobj delete();
  }

  self notify("death");
}

function scavengergiveammo(var_0) {
  var_1 = var_0 getweaponslistprimaries();

  foreach(var_3 in var_1) {
    addscavengercliptoweapon(var_0, var_3, 1);
  }

  var_5 = scripts\mp\utility\game::unset_relic_grounded();

  if(istrue(var_5)) {
    bbeingelectrocuted(var_0, 1);
    return;
  }
}

function addscavengercliptoweapon(var_0, var_1, var_2) {
  if(!scripts\mp\utility\weapon::iscacprimaryweapon(var_1) && !level.scavenger_secondary) {
    return;
  }

  if(var_1.isalternate) {
    return;
  }

  if(scripts\mp\utility\weapon::getweapongroup(var_1) == "weapon_projectile") {
    return;
  }

  var_3 = var_0 getweaponammostock(var_1);
  var_4 = getammooverride(var_1);
  var_4 = int(ceil(var_2 * var_4));

  if(var_1 hasattachment("akimbo", 1)) {
    var_4 *= 1;
  }

  var_0 setweaponammostock(var_1, var_3 + var_4);
}

function bbeingelectrocuted(var_0, var_1) {
  var_0 scripts\mp\equipment::incrementequipmentslotammo("health", var_1);
}

function scavenger_budget_delete() {
  if(isDefined(self.useobj)) {
    self.useobj delete();
  }

  self delete();
}

function dropscavengerfordeath(var_0, var_1) {
  self endon("spawned_player");
  level endon("game_ended");

  if(!shoulddropscavengerbag(var_0, var_1)) {
    return;
  }

  var_2 = 0;

  if(isDefined(var_1) && var_1 == "MOD_EXECUTION") {
    var_2 = 1.5;
  }

  wait var_2;

  if(var_2 > 0 && !shoulddropscavengerbag(var_0, var_1)) {
    return;
  }

  dropscavengerfordeathinternal(var_0);
}

function dropscavengerfordeathinternal(var_0) {
  var_1 = self dropscavengerbag("scavenger_bag_mp", "j_head");

  if(!isDefined(var_1)) {
    return;
  }

  var_1 scripts\cp_mp\ent_manager::registerspawn(2, &scavenger_budget_delete);
  var_1.owner = var_0;
  var_1.team = var_0.team;
  var_2 = scripts\mp\utility\game::unset_relic_grounded();

  if(istrue(var_2)) {
    var_1.outlineid = scripts\mp\utility\outline::outlineenableforplayer(var_1, var_1.owner, "outline_depth_cyan", "perk");
    thread handlescavengerbagpickup(var_1);
    thread scavengerbagcleanupthink(var_1);
    thread scavengerbagtimeoutthink(var_1);
  } else {
    thread handlescavengerbagpickup(var_1);
    thread scavengerbagcleanupthink();
    thread scavengerbagtimeoutthink();
  }

  if(isDefined(level.bot_funcs) && isDefined(level.bot_funcs["bots_add_scavenger_bag"])) {
    [[level.bot_funcs["bots_add_scavenger_bag"]]](var_1);
    return;
  }
}

function shoulddropscavengerbag(var_0, var_1) {
  if(!isDefined(var_0)) {
    return false;
  }

  if(var_0 == self) {
    return false;
  }

  return true;
}

function scavengerbagcleanupthink(var_0) {
  self endon("death");
  level endon("game_ended");
  self.owner scripts\engine\utility::ref_143a6("death_or_disconnect", "joined_team", "bag_timeout");

  if(isDefined(self)) {
    if(isDefined(self.useobj)) {
      var_1 = scripts\mp\utility\game::unset_relic_grounded();

      if(istrue(var_1)) {
        scripts\mp\utility\outline::outlinedisable(var_0, self);
      }

      self.useobj delete();
    }

    scripts\cp_mp\ent_manager::deregisterspawn();
    self delete();
    return;
  }
}

function scavengerbagtimeoutthink(var_0) {
  self endon("death");
  self.owner endon("disconnect");
  level endon("game_ended");
  var_1 = scripts\mp\utility\game::unset_relic_grounded();
  wait scripts\engine\utility::ter_op(var_1, 60, 20);

  if(istrue(var_1)) {
    scripts\mp\utility\outline::outlinedisable(var_0, self);
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
  var_0 = &"PERKS/HOLD_TO_SCAVENGE";
  self.useobj = scripts\mp\gameobjects::createhintobject(self.origin + anglestoup(self.angles) * 1, "HINT_BUTTON", undefined, var_0, undefined, undefined, "show", 200, 160, 100, 160);
  self.useobj.owner = self.owner;
  self.useobj.team = self.team;
  self.useobj linkTo(self);

  foreach(var_2 in level.players) {
    self.useobj disableplayeruse(var_2);
  }

  thread scavengebagthink();
  thread scavengebagusemonitoring();

  for(;;) {
    self waittill("pickedUpScavengerBag", var_2);

    if(isPlayer(var_2)) {
      var_2 notify("scavenger_pickup");
      ref_12082(var_2);
      var_2 scripts\mp\damagefeedback::hudicontype("scavenger");

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
  var_0 = 1;

  while(var_0) {
    wait 0.1;

    foreach(var_2 in level.players) {
      if(!isDefined(self)) {
        var_0 = 0;
        continue;
      }

      if(var_2.team != self.team || var_2 scripts\mp\utility\perk::_hasperk("specialty_scavenger")) {
        self.useobj disableplayeruse(var_2);
        continue;
      }

      self.useobj enableplayeruse(var_2);
    }
  }
}

function scavengebagthink() {
  self endon("restarting_physics");
  var_0 = self.useobj;
  var_1 = undefined;
  jumpiffalse(istrue(level.gameended) && !isDefined(var_0)) LOC_00000022;
  return;
}

function useholdthink(var_0, var_1) {
  self.curprogress = 0;
  self.inuse = 1;
  self.userate = 0;
  self.usetime = var_1;
  scripts\mp\movers::script_mover_link_to_use_object(var_0);
  var_0 scripts\common\utility::allow_weapon(0);
  var_2 = useholdthinkloop(var_0);

  if(isalive(var_0)) {
    var_0 scripts\common\utility::allow_weapon(1);
  }

  if(isDefined(var_0)) {
    scripts\mp\movers::script_mover_unlink_from_use_object(var_0);
  }

  if(!isDefined(self)) {
    return 0;
  }

  self.inuse = 0;
  self.curprogress = 0;
  return var_2;
}

function useholdthinkloop(var_0) {
  var_1 = internal_useholdthinkloop(var_0);

  if(isDefined(self)) {
    var_0 scripts\mp\gameobjects::updateuiprogress(self, 0);
  }

  return istrue(var_1);
}

function internal_useholdthinkloop(var_0) {
  self endon("endUseHoldThink");

  while(isplayerusing(var_0, self)) {
    if(!var_0 scripts\mp\movers::script_mover_use_can_link(self)) {
      return 0;
    }

    self.curprogress += level.framedurationseconds * self.userate;

    if(isDefined(self.objectivescaler)) {
      self.userate = 1 * self.objectivescaler;
    } else {
      self.userate = 1;
    }

    var_0 scripts\mp\gameobjects::updateuiprogress(self, 1);

    if(self.curprogress >= self.usetime) {
      return scripts\mp\utility\player::isreallyalive(var_0);
    }

    waitframe();
  }

  return 0;
}

function createuseent() {
  var_0 = spawn("script_origin", self.origin);
  var_0.curprogress = 0;
  var_0.usetime = 0;
  var_0.userate = 3000;
  var_0.inuse = 0;
  var_0.id = self.id;
  var_0 linkTo(self);
  thread deleteuseent(var_0);
  return var_0;
}

function deleteuseent(var_0) {
  self endon("death");
  var_0 waittill("death");

  if(isDefined(self.usedby)) {
    foreach(var_2 in self.usedby) {
      var_2 setclientomnvar("ui_securing", 0);
      var_2.ui_securing = undefined;
    }
  }

  self delete();
}

function isplayerusing(var_0) {
  return !level.gameended && isDefined(var_0) && scripts\mp\utility\player::isreallyalive(self) && self useButtonPressed() && !self isonladder() && !self meleeButtonPressed() && var_0.curprogress < var_0.usetime && (!isDefined(self.teleporting) || !self.teleporting);
}

function weaponcanstoreaccuracystats(var_0) {
  if(scripts\mp\utility\weapon::iscacmeleeweapon(var_0.basename)) {
    return false;
  }

  return scripts\mp\utility\weapon::iscacprimaryweapon(var_0.basename) || scripts\mp\utility\weapon::iscacsecondaryweapon(var_0.basename);
}

function setweaponstat(var_0, var_1, var_2) {
  scripts\mp\gamelogic::setweaponstat(var_0, var_1, var_2);
}

function watchweaponusage(var_0) {
  self endon("death_or_disconnect");
  self endon("faux_spawn");
  level endon("game_ended");

  for(;;) {
    self waittill("weapon_fired", var_1);
    onweaponfired(var_1);
  }
}

function onweaponfired(var_0) {
  scripts\mp\gamelogic::sethasdonecombat(self, 1);
  var_1 = gettime();

  if(!isDefined(self.lastshotfiredtime)) {
    self.lastshotfiredtime = 0;
  }

  var_2 = gettime() - self.lastshotfiredtime;
  self.lastshotfiredtime = var_1;

  if(isai(self)) {
    return;
  }

  if(!weaponcanstoreaccuracystats(var_0)) {
    return;
  }

  thread watchformiss(var_0);

  if(scripts\mp\utility\game::onlinestatsenabled()) {
    var_3 = scripts\mp\playerstats_interface::getplayerstat("combatStats", "totalShots") + 1;
    var_4 = scripts\mp\playerstats_interface::getplayerstat("combatStats", "hits");
    scripts\mp\playerstats_interface::setplayerstatbuffered(var_3, "combatStats", "totalShots");
    scripts\mp\playerstats_interface::setplayerstatbuffered(int(var_3 - var_4), "combatStats", "misses");
  }

  var_5 = 1;
  setweaponstat(var_0, var_5, "shots");
  setweaponstat(var_0, self.hits, "hits");
  scripts\mp\utility\stats::incpersstat("shotsFired", 1);
  self.hits = 0;

  if(self getweaponammoclip(var_0) == 0 && self getweaponammostock(var_0) == 0) {
    level thread scripts\mp\battlechatter_mp::trysaylocalsound(self, "flavor_negative");
    return;
  }
}

function watchformiss(var_0) {
  self endon("death_or_disconnect");
  var_1 = createheadicon(var_0);
  self endon("watchForMiss_" + var_1);
  waitframe();
  self.consecutivehitsperweapon[var_1] = 0;
  scripts\mp\events::shotmissed();
}

function clearmiss(var_0) {
  self endon("death_or_disconnect");
  var_1 = createheadicon(var_0);
  self notify("watchForMiss_" + var_1);
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

function checkhit(var_0, var_1) {
  self endon("disconnect");

  if(var_0.isalternate) {
    var_2 = scripts\mp\utility\weapon::getweaponattachmentsbasenames(var_0);

    if(scripts\engine\utility::array_contains(var_2, "shotgun") || scripts\engine\utility::array_contains(var_2, "gl") || scripts\engine\utility::array_contains(var_2, "glsmoke") || scripts\engine\utility::array_contains(var_2, "glgas") || scripts\engine\utility::array_contains(var_2, "glconc") || scripts\engine\utility::array_contains(var_2, "glflash") || scripts\engine\utility::array_contains(var_2, "glincendiary") || scripts\engine\utility::array_contains(var_2, "glsemtex") || scripts\engine\utility::array_contains(var_2, "glsnap")) {
      self.hits = 1;
    }
  }

  if(!weaponcanstoreaccuracystats(var_0)) {
    return;
  }

  if(self meleeButtonPressed() && var_0.basename != "iw8_knife_mp") {
    return;
  }

  switch (weaponclass(var_0)) {
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

  var_3 = createheadicon(var_0);

  if(scripts\mp\riotshield::isriotshield(var_0.basename) || var_0.basename == "iw8_knife_mp") {
    thread scripts\mp\gamelogic::threadedsetweaponstatbyname(var_3, self.hits, "hits");
    self.hits = 0;
  }

  waittillframeend();
  thread clearmiss(var_0);

  if(!isDefined(self.lasthittime[var_3])) {
    self.lasthittime[var_3] = 0;
  }

  if(self.lasthittime[var_3] == gettime()) {
    return;
  }

  self.lasthittime[var_3] = gettime();

  if(!isDefined(self.consecutivehitsperweapon) || !isDefined(self.consecutivehitsperweapon[var_3])) {
    self.consecutivehitsperweapon[var_3] = 1;
  } else {
    self.consecutivehitsperweapon[var_3]++;
    scripts\cp\vehicles\vehicle_compass_cp::ref_12007(var_0, self.consecutivehitsperweapon[var_3]);
  }

  if(scripts\mp\utility\game::onlinestatsenabled()) {
    var_4 = scripts\mp\playerstats_interface::getplayerstat("combatStats", "totalShots");
    var_5 = scripts\mp\playerstats_interface::getplayerstat("combatStats", "hits") + 1;

    if(var_5 <= var_4) {
      scripts\mp\playerstats_interface::setplayerstatbuffered(var_5, "combatStats", "hits");
      scripts\mp\playerstats_interface::setplayerstatbuffered(int(var_4 - var_5), "combatStats", "misses");
    }
  }

  thread scripts\cp\vehicles\vehicle_compass_cp::onsuccessfulhit(var_0);
  thread scripts\mp\events::shothit();
  var_6 = scripts\mp\utility\weapon::getweapongroup(var_0.basename);

  if(var_6 == "weapon_lmg") {
    if(!isDefined(self.shotslandedlmg)) {
      self.shotslandedlmg = 1;
    } else {
      self.shotslandedlmg++;
    }
  }

  var_7 = gettime();
  self.lastdamagetime = var_7;

  if(isDefined(var_1)) {
    var_1.lasttimedamaged = var_7;
    return;
  }
}

function friendlyfirecheck(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_0)) {
    return true;
  }

  if(!level.teambased) {
    return true;
  }

  var_4 = level.friendlyfire;

  if(isDefined(var_2)) {
    var_4 = var_2;
  }

  if(var_4 != 0) {
    return true;
  }

  if(var_1 == var_0 || isDefined(var_1.owner) && var_1.owner == var_0) {
    return true;
  }

  var_5 = undefined;

  if(isDefined(var_1.owner)) {
    var_5 = var_1.owner.team;
  } else if(isDefined(var_1.team)) {
    var_5 = var_1.team;
  }

  if(!isDefined(var_5)) {
    return true;
  }

  if(var_5 != var_0.team) {
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
  var_0 = scripts\mp\utility\dvars::getintproperty("scr_deleteexplosivesonspawn", 1) && (!scripts\mp\utility\perk::_hasperk("specialty_rugged_eqp") || !checkequipforrugged());

  if(var_0) {
    deleteplacedequipment();
  }

  var_1 = self.plantedtacticalequip.size;
  var_2 = self.plantedlethalequip.size;
  var_3 = self.plantedsuperequip.size;
  var_4 = self.plantedhackedequip.size;
  var_5 = var_1 && var_2 && var_3 && var_4;

  if(scripts\mp\utility\perk::_hasperk("specialty_rugged_eqp") && var_5) {
    thread scripts\mp\perks\perkfunctions::feedbackruggedeqp(var_2, var_1, var_3, var_4);
    return;
  }
}

function getallequip() {
  var_0 = [];

  if(isDefined(self.plantedlethalequip)) {
    var_0 = scripts\engine\utility::array_combine(var_0, self.plantedlethalequip);
  }

  if(isDefined(self.plantedtacticalequip)) {
    var_0 = scripts\engine\utility::array_combine(var_0, self.plantedtacticalequip);
  }

  if(isDefined(self.plantedsuperequip)) {
    var_0 = scripts\engine\utility::array_combine(var_0, self.plantedsuperequip);
  }

  if(isDefined(self.plantedhackedequip)) {
    var_0 = scripts\engine\utility::array_combine(var_0, self.plantedhackedequip);
  }

  return var_0;
}

function removeequip(var_0) {
  if(isDefined(self.plantedlethalequip)) {
    self.plantedlethalequip = scripts\engine\utility::array_remove(self.plantedlethalequip, var_0);
  }

  if(isDefined(self.plantedtacticalequip)) {
    self.plantedtacticalequip = scripts\engine\utility::array_remove(self.plantedtacticalequip, var_0);
  }

  if(isDefined(self.plantedsuperequip)) {
    self.plantedsuperequip = scripts\engine\utility::array_remove(self.plantedsuperequip, var_0);
  }

  if(isDefined(self.plantedhackedequip)) {
    self.plantedhackedequip = scripts\engine\utility::array_remove(self.plantedhackedequip, var_0);
    return;
  }
}

function checkequipforrugged() {
  var_0 = scripts\engine\utility::array_combine(self.plantedtacticalequip, self.plantedlethalequip);

  foreach(var_2 in var_0) {
    if(isDefined(var_2.hasruggedeqp)) {
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
  var_0 = _utilflare_isvalidflaretype::waittill_grenade_throw();

  if(!isDefined(var_0)) {
    return;
  }

  if(!isDefined(var_0.weapon_name)) {
    return;
  }

  setweaponstat(var_0.weapon_name, 1, "shots");
  var_1 = scripts\mp\equipment::isequipmentlethal(var_0.weapon_name);
  var_2 = isDefined(var_0.equipmentref) && scripts\mp\equipment::isequipmenttactical(var_0.equipmentref);
  scripts\mp\potg_events::grenadethrownevent(var_1);
  scripts\mp\battlechatter_mp::ongrenadeuse(var_0);
  scripts\mp\gamelogic::sethasdonecombat(self, 1);

  if(var_2 && self isthrowingbackgrenade() && getdvarint("scr_infinite_tacticals_cleanup", 1)) {
    self method_87a9();
    var_3 = getcompleteweaponname(var_0.weapon_name);
    var_4 = self getweaponammoclip(var_3);
    var_5 = int(max(var_4 - 1, 0));
    self setweaponammoclip(var_3, var_5);
  }

  if(scripts\mp\utility\weapon::isaxeweapon(var_0.weapon_name)) {
    var_0 thread _utilflare_isvalidflaretype::watchgrenadeaxepickup(self);
    return;
  }

  var_0 thread scripts\mp\battlechatter_mp::grenadeproximitytracking();
  var_0.spawnpos = var_0.origin;

  switch (var_0.weapon_name) {
    case "frag_grenade_mp":
      if(var_0.ticks >= 1) {
        var_0.iscooked = 1;
      }

      var_0.originalowner = self;
      var_0 thread scripts\mp\shellshock::grenade_earthquake();
      break;
    case "pop_rocket_mp":
      if(var_0.ticks >= 1) {
        var_0.iscooked = 1;
      }

      var_0.originalowner = self;
      thread scripts\mp\equipment\wristrocket::wristrocketused(var_0);
      var_0 thread scripts\mp\shellshock::grenade_earthquake(0.6);
      break;
    case "semtex_mp":
      thread ref_13018(var_0);
      var_0 thread scripts\mp\shellshock::grenade_earthquake();
      break;
    case "c4_mp_p":
      thread scripts\mp\equipment\c4::c4_used(var_0);
      break;
    case "emp_grenade_mp":
      thread scripts\mp\equipment\emp_grenade::emp_grenade_used(var_0);
      break;
    case "snapshot_grenade_mp":
      thread scripts\mp\equipment\snapshot_grenade::snapshot_grenade_used(var_0, 0);
      break;
    case "smoke_grenade_mp":
      thread smokegrenadeused();
      break;
    case "trophy_mp":
      thread scripts\mp\equipment\trophy_system::trophy_used(var_0);
      break;
    case "decon_station_mp":
      thread _debug_rooftop_heli_start::jeep_initomnvars(var_0);
      break;
    case "claymore_mp":
      thread scripts\mp\equipment\claymore::claymore_use(var_0);
      break;
    case "at_mine_mp":
      thread scripts\mp\equipment\at_mine::at_mine_use(var_0);
      break;
    case "throwingknife_fire_mp":
    case "throwingknife_electric_mp":
    case "throwingknife_drill_mp":
    case "throwingknife_mp":
      thread scripts\cp_mp\equipment\throwing_knife::throwing_knife_used(var_0);
      break;
    case "molotov_mp":
      var_0 thread scripts\mp\shellshock::grenade_earthquake();
      thread scripts\mp\equipment\molotov::molotov_used(var_0);
      break;
    case "thermite_mp":
      thread scripts\mp\equipment\thermite::thermite_used(var_0);
      break;
    case "tac_ops_spawn_grenade_mp":
      thread scripts\mp\supers\spawnbeacon::thrown(var_0);
      break;
    case "tac_ops_supply_pack_grenade_mp":
      thread scripts\mp\tac_ops\roles_utility::throwsupplypack(var_0);
      break;
    case "support_box_mp":
      thread scripts\mp\equipment\support_box::supportbox_used(var_0);
      break;
    case "armor_box_mp":
      thread scripts\mp\equipment\support_box::calloutmarkerpingvo_playpredictivepingadded(var_0);
      break;
    case "decoy_grenade_mp":
      thread scripts\mp\equipment\decoy_grenade::decoy_used(var_0);
      break;
    case "gas_mp":
      thread scripts\mp\equipment\gas_grenade::gas_used(var_0);
      break;
    case "hb_sensor_mp":
      thread scripts\mp\equipment\hb_sensor::hb_sensor_used(var_0);
      break;
    case "geiger_counter_mp":
      thread _determinelocationarray::postspawn_juggernaut(var_0);
      break;
    case "offhand_spotter_scope_mp":
      thread _debug_rooftop_activesat::colmodel(var_0);
      break;
    case "tac_cover_mp":
      thread scripts\mp\equipment\tactical_cover::tac_cover_used(var_0);
      break;
    case "flare_mp":
      thread scripts\mp\equipment\tac_insert::tacinsert_used(var_0);
      break;
    case "advanced_supply_drop_marker_mp":
      thread scripts\mp\equipment\advanced_supply_drop::advanced_supply_drop_marker_used(var_0);
      break;
    case "advanced_vehicle_drop_marker_mp":
      thread scripts\mp\equipment\advanced_supply_drop::binoculars_onstatelospendingupdate(var_0);
      break;
    case "advanced_loot_drop_marker_mp":
      thread scripts\mp\equipment\advanced_supply_drop::binoculars_onstateinvalidupdate(var_0);
      break;
    case "deploy_weapondrop_mp":
      thread scripts\mp\equipment\weapon_drop::weapondrop_used(var_0);
      break;
    case "kiosk_drop_marker_mp":
      thread _findgivearmoramountanddropleftovers::wait_between_combat_action(var_0);
      break;
    case "concussion_grenade_mp":
      thread hoopty_truck_initdamage();
      break;
    case "jammer_br":
      thread _donewithcorpse::vehicle_compass_instanceisregistered(var_0);
      break;
    case "emp_gadget_mp":
      thread _debug_rooftop_raid_exfil::morsenumber(var_0);
      break;
    case "numbers_grenade_mp":
      thread scripts\mp\equipment\numbers_grenade::numbers_grenade_used(var_0);
      break;
    default:
      if(isDefined(level.ref_1203b)) {
        [[level.ref_1203b]](var_0.weapon_name, var_0);
      }

      break;
  }

  ref_119b0(var_0.weapon_name);
}

function ref_119b0(var_0) {
  if(!isDefined(var_0)) {
    return;
  }

  var_1 = scripts\mp\utility\weapon::getequipmenttype(var_0);

  if(!isDefined(var_1)) {
    var_1 = "none";
  }

  self dlog_recordplayerevent("dlog_event_equipment_use", ["weapon_used", var_0, "equipment_type", var_1]);
}

function hoopty_truck_initdamage() {
  thread scripts\mp\utility\script::notifyafterframeend("death", "end_explode");
  self endon("end_explode");
  var_0 = self.owner;
  self waittill("explode", var_1);
  thread scripts\mp\equipment\concussion_grenade::ref_12031(var_0, var_1);
}

function smokegrenadeused(var_0) {
  thread scripts\mp\utility\script::notifyafterframeend("death", "end_explode");
  self endon("end_explode");
  jumpiffalse(istrue(var_0)) LOC_00000054;
  self waittill("missile_stuck", var_1, var_2, var_3, var_4, var_5, var_6);
  thread ref_13426(var_5);
  thread scripts\mp\bots\bots::init_leave_cave(var_5);
  goto LOC_00000060;
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

function smokegrenadeexplode(var_0) {
  wait 1;
  thread smokegrenadegiveblindeye(var_0);
  var_1 = scripts\mp\utility\outline::addoutlineoccluder(var_0, 330);
  wait 8.25;
  scripts\mp\utility\outline::removeoutlineoccluder(var_1);
}

function ref_13426(var_0, var_1) {
  playFX(scripts\engine\utility::getfx("glsmoke"), var_0, anglestoup((0, 90, 0)));
}

function smokegrenadegiveblindeye(var_0) {
  var_1 = spawnStruct();
  var_1.blindeyerecipients = [];
  smokegrenademonitorblindeyerecipients(var_1, var_0);

  foreach(var_3 in var_1.blindeyerecipients) {
    if(isDefined(var_3) && scripts\mp\utility\player::isreallyalive(var_3)) {
      var_3 scripts\mp\utility\perk::removeperk("specialty_blindeye");
    }
  }
}

function smokegrenademonitorblindeyerecipients(var_0, var_1) {
  level endon("game_ended");
  var_2 = gettime() + 8250;
  var_3 = [];

  while(gettime() < var_2) {
    var_3 = scripts\mp\utility\player::getplayersinradius(var_1, 330);

    foreach(var_7, var_5 in var_0.blindeyerecipients) {
      if(!isDefined(var_5)) {
        var_0.blindeyerecipients[var_7] = undefined;
        continue;
      }

      var_6 = scripts\engine\utility::array_find(var_3, var_5);

      if(!isDefined(var_6) || !scripts\mp\utility\player::isreallyalive(var_5)) {
        if(var_5 scripts\mp\utility\perk::_hasperk("specialty_blindeye")) {
          var_5 scripts\mp\utility\perk::removeperk("specialty_blindeye");
        }

        var_0.blindeyerecipients[var_7] = undefined;
      }

      if(isDefined(var_6)) {
        var_3[var_6] = undefined;
      }
    }

    foreach(var_9 in var_3) {
      if(!isDefined(var_9)) {
        continue;
      }

      var_9.lastinsmoketime = gettime();

      if(isDefined(var_0.blindeyerecipients[var_9 getentitynumber()])) {
        continue;
      }

      if(!scripts\mp\utility\player::isreallyalive(var_9) || scripts\mp\utility\entity::isspidergrenade(var_9)) {
        continue;
      }

      var_9 scripts\mp\utility\perk::giveperk("specialty_blindeye");
      var_0.blindeyerecipients[var_9 getentitynumber()] = var_9;
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
  var_0 = scripts\engine\utility::ref_143b9(9.25, "death");
  self.hasactivesmokegrenade = 0;
  scripts\mp\utility\print::printgameaction("smoke grenade deactivated", self);
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
        if(isDefined(var_8) && isDefined(var_8.affectedbylockon) && (var_8.team != self.team || var_2)) {
          var_1 = var_8;
        }
      }
    }

    jumpiffalse(isDefined(level.cratedropdata)) LOC_00000131;
    jumpiffalse(isDefined(level.cratedropdata.ac130s)) LOC_00000131;

    foreach(var_11 in level.cratedropdata.ac130s) {
      if(isDefined(var_11) && (var_11.team != self.team || var_2)) {
        var_1 = var_11;
      }
    }

    foreach(var_14 in var_3) {
      var_15 = scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_getgameinstances(var_14);

      foreach(var_17 in var_15) {
        if(isDefined(var_17) && (!scripts\cp_mp\vehicles\vehicle::ref_141b9(var_17, self) || var_2)) {
          var_1 = var_17;
        }
      }
    }
  } else {
    if(isDefined(var_3) && var_3 == 1) {
      foreach(var_5 in level.characters) {
        if((!isDefined(var_5) || !isalive(var_5)) && !var_15) {
          continue;
        }

        var_14 = var_5;
      }
    }

    if(isDefined(level.activekillstreaks)) {
      foreach(var_8 in level.activekillstreaks) {
        if(isDefined(var_8.affectedbylockon) && (isDefined(var_8.owner) && var_8.owner != self || var_15)) {
          var_14 = var_8;
        }
      }
    }

    jumpiffalse(isDefined(level.cratedropdata)) LOC_000002b2;
    jumpiffalse(isDefined(level.cratedropdata.ac130s)) LOC_000002b2;

    foreach(var_11 in level.cratedropdata.ac130s) {
      if(var_11.owner != self || var_15) {
        var_14 = var_11;
      }
    }

    foreach(var_14 in var_17) {
      var_15 = scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_getgameinstances(var_14);

      foreach(var_17 in var_15) {
        if(!isDefined(var_17.owner)) {
          var_14 = var_17;
          continue;
        }

        if(var_17.owner != self || var_15) {
          var_14 = var_17;
        }
      }
    }
  }

  return var_14;
}

function lockonlaunchers_gettargetvehiclerefs() {
  var_0 = ["apc_russian", "atv", "big_bird", "cargo_truck", "cargo_truck_mg", "cop_car", "hoopty", "hoopty_truck", "jeep", "large_transport", "light_tank", "little_bird", "little_bird_mg", "medium_transport", "pickup_truck", "tac_rover", "technical", "van", "loot_chopper", "motorcycle", "veh_a10fd", "veh_bt", "veh_indigo", "open_jeep_carpoc"];

  if(isDefined(level.playerzombieupdatetagobjectives)) {
    var_0 = level.playerzombieupdatetagobjectives;
  }

  return var_0;
}

function watchmissileusage() {
  self endon("disconnect");

  for(;;) {
    var_0 = waittill_missile_fire();
    updatemissilefire(var_0);
  }
}

function updatemissilefire(var_0) {
  var_1 = undefined;
  var_2 = 0;

  switch (var_0.weapon_name) {
    case "iw8_la_gromeoks_mp":
    case "iw8_la_rpapa7_mp":
    case "iw8_la_gromeo_mp":
    case "iw8_la_t9freefire_mp":
    case "iw8_la_t9standard_mp":
      var_1 = self.missilelaunchertarget;
      level thread scripts\mp\battlechatter_mp::watchbrsquadleaderdisconnect(var_0);
      level thread scripts\mp\battlechatter_mp::trysaylocalsound(self, "use_rocket", undefined, 0.5);
      break;
    case "iw8_la_juliet_mp":
      var_1 = self.javelin.target;
      level thread scripts\mp\battlechatter_mp::javelinfired(self.team, self.javelin.target.origin);
      level thread scripts\mp\battlechatter_mp::trysaylocalsound(self, "use_rocket", undefined, 0.5);
      break;
    case "gl":
      var_2 = 1;
      break;
    case "glsmoke":
      var_2 = 1;
      thread smokegrenadeused(var_0);
      break;
    case "glgas":
      var_2 = 1;
      thread scripts\mp\equipment\gas_grenade::gas_used(var_0);
      break;
    case "glflash":
    case "glconc":
      var_2 = 1;
      break;
    case "glincendiary":
      var_2 = 1;
      var_0 thread scripts\mp\shellshock::grenade_earthquake();
      thread scripts\mp\equipment\thermite::thermite_used(var_0, 1);
      break;
    case "glsemtex":
      var_2 = 1;
      break;
    case "glsnap":
      var_2 = 1;
      thread scripts\mp\equipment\snapshot_grenade::snapshot_grenade_used(var_0, var_2);
      break;
    default:
      break;
  }

  if(scripts\cp_mp\utility\weapon_utility::islockonlauncher(var_0.weapon_name) && isDefined(var_1)) {
    var_0.ref_119a0 = var_1;
    level notify("stinger_fired", self, var_0, var_1);
    thread scripts\cp_mp\utility\weapon_utility::watchtargetlockedontobyprojectile(var_1, var_0);
  }

  if(isPlayer(self)) {
    var_0.adsfire = scripts\mp\utility\player::isplayerads();
  }

  if(!var_2 && isexplosivemissile(var_0.weapon_name)) {
    var_3 = 1;

    if(issmallmissile(var_0.weapon_name)) {
      var_3 = 0.65;
    }

    var_0 thread scripts\mp\shellshock::grenade_earthquake(var_3);
  }

  scripts\mp\events::missilefired(var_0);
}

function issmallmissile(var_0) {
  return false;
}

function isexplosivemissile(var_0) {
  var_1 = getweaponbasename(var_0);

  switch (var_1) {
    case "pop_rocket_proj_mp":
    case "ac130_25mm_mp":
    case "ac130_40mm_mp":
    case "ac130_105mm_mp":
      return false;
  }

  return true;
}

function movingplatformdetonate(var_0) {
  if(!isDefined(var_0.lasttouchedplatform) || !isDefined(var_0.lasttouchedplatform.destroyexplosiveoncollision) || var_0.lasttouchedplatform.destroyexplosiveoncollision) {
    self notify("detonateExplosive");
    return;
  }
}

function monitordisownedequipment(var_0, var_1, var_2) {
  level endon("game_ended");
  var_1 endon("death");
  var_1 notify("monitorDisownedEquipment()");
  var_1 endon("monitorDisownedEquipment()");

  if(istrue(var_2)) {
    var_0 scripts\engine\utility::ref_143a5("joined_team", "disconnect");
  } else {
    var_0 scripts\engine\utility::ref_143a6("joined_team", "joined_spectators", "disconnect");
  }

  deleteexplosive(var_1);
}

function monitordisownedgrenade(var_0, var_1) {
  level endon("game_ended");
  var_1 endon("death");
  var_1 endon("mine_planted");
  scripts\engine\utility::waittill_any_ents(var_0, "joined_team", var_0, "joined_spectators", var_0, "disconnect", level, "prematch_cleanup");

  if(isDefined(var_1)) {
    var_1 delete();
    return;
  }
}

function isplantedequipment(var_0) {
  return isDefined(level.mines[var_0 getentitynumber()]) || istrue(var_0.planted);
}

function getmaxplantedlethalequip(var_0) {
  var_1 = 2;

  if(scripts\mp\utility\perk::_hasperk("specialty_extra_planted_equipment")) {
    var_1++;
  }

  return var_1;
}

function getmaxplantedtacticalequip(var_0) {
  var_1 = 2;

  if(scripts\mp\utility\perk::_hasperk("specialty_extra_planted_equipment")) {
    var_1++;
  }

  return var_1;
}

function getmaxplantedsuperequip(var_0) {
  return true;
}

function getmaxplantedhackedequip() {
  return 3;
}

function onequipmentplanted(var_0, var_1, var_2) {
  var_0.equipmentref = var_1;
  var_0.deletefunc = var_2;
  var_0.planted = 1;
  updateplantedarray(var_0);
  var_3 = var_0 getentitynumber();
  level.mines[var_3] = var_0;

  if(var_1 != "equip_tac_cover") {
    var_0 enableplayermarks("equipment");

    if(level.teambased) {
      var_0 filteroutplayermarks(self.team);
    } else {
      var_0 filteroutplayermarks(self);
    }
  }

  var_0 notify("mine_planted");
}

function updateplantedarray(var_0) {
  var_1 = undefined;
  var_2 = 0;
  var_3 = scripts\mp\equipment::findequipmentslot(var_0.equipmentref);

  if(istrue(var_0.ishacked)) {
    var_1 = var_0.owner.plantedhackedequip;
    var_2 = getmaxplantedhackedequip();
  } else if(istrue(var_0.issuper)) {
    var_1 = var_0.owner.plantedsuperequip;
    var_2 = getmaxplantedsuperequip(var_0.equipmentref);
  } else if(isDefined(var_3) && var_3 == "primary" || scripts\mp\equipment::isequipmentlethal(var_0.equipmentref)) {
    var_1 = var_0.owner.plantedlethalequip;
    var_2 = getmaxplantedlethalequip(self);
  } else if(isDefined(var_3) && var_3 == "secondary" || scripts\mp\equipment::isequipmenttactical(var_0.equipmentref)) {
    var_1 = var_0.owner.plantedtacticalequip;
    var_2 = getmaxplantedtacticalequip(self);
  }

  if(!isDefined(var_1)) {
    var_4 = "isSuper: " + var_0.issuper + ", slot: " + scripts\engine\utility::ter_op(isDefined(var_3), var_3, "undefined") + ", equipmentRef: " + var_0.equipmentref + ", allowed: " + scripts\mp\equipment::is_equipment_slot_allowed("super");
    scripts\mp\utility\script::laststand_dogtags(var_4);
  }

  if(var_1.size > 0) {
    if(var_1.size && var_1.size >= var_2) {
      var_5 = var_1[0];
      var_1 = scripts\engine\utility::array_remove(var_1, var_5);
      deleteexplosive(var_5);
    }
  }

  var_1 = var_0;

  if(istrue(var_0.ishacked)) {
    var_0.owner.plantedhackedequip = var_1;
    return;
  }

  if(istrue(var_0.issuper)) {
    var_0.owner.plantedsuperequip = var_1;
    return;
  }

  if(isDefined(var_3) && var_3 == "primary" || scripts\mp\equipment::isequipmentlethal(var_0.equipmentref)) {
    var_0.owner.plantedlethalequip = var_1;
    return;
  }

  if(isDefined(var_3) && var_3 == "secondary" || scripts\mp\equipment::isequipmenttactical(var_0.equipmentref)) {
    var_0.owner.plantedtacticalequip = var_1;
    return;
  }
}

function setplantedequipmentuse(var_0) {
  var_1 = getallequip();

  foreach(var_3 in var_1) {
    if(isDefined(var_3.trigger) && isDefined(var_3.owner)) {
      if(var_0) {
        var_3.trigger enableplayeruse(var_3.owner);
        continue;
      }

      var_3.trigger disableplayeruse(var_3.owner);
    }
  }
}

function cleanupequipment(var_0, var_1, var_2) {
  if(isDefined(var_0)) {
    level.mines[var_0] = undefined;
  }

  if(isDefined(var_1)) {
    var_1 delete();
  }

  if(isDefined(var_2)) {
    var_2 delete();
    return;
  }
}

function equipmenthit(var_0, var_1, var_2, var_3) {
  if(scripts\cp_mp\utility\player_utility::playersareenemies(var_1, var_0)) {
    if(!isDefined(var_2)) {
      return;
    }

    if(scripts\mp\utility\weapon::iskillstreakweapon(var_2.basename)) {
      return;
    }

    var_4 = createheadicon(var_2);

    if(!isDefined(var_1.lasthittime)) {
      var_1.lasthittime = [];
    }

    if(!isDefined(var_1.lasthittime[var_4])) {
      var_1.lasthittime[var_4] = 0;
    }

    if(var_1.lasthittime[var_4] == gettime()) {
      return;
    }

    var_1.lasthittime[var_4] = gettime();
    var_1 thread scripts\mp\gamelogic::threadedsetweaponstatbyname(var_4, 1, "hits");

    if(scripts\mp\utility\game::onlinestatsenabled()) {
      var_5 = var_1 scripts\mp\playerstats_interface::getplayerstat("combatStats", "totalShots");
      var_6 = var_1 scripts\mp\playerstats_interface::getplayerstat("combatStats", "hits") + 1;

      if(var_6 <= var_5) {
        scripts\mp\playerstats_interface::setplayerstatbuffered(var_6, "combatStats", "hits");
        scripts\mp\playerstats_interface::setplayerstatbuffered(int(var_5 - var_6), "combatStats", "misses");
      }
    }

    if(isDefined(var_3) && scripts\engine\utility::isbulletdamage(var_3) || scripts\mp\utility\damage::isprojectiledamage(var_3)) {
      var_1.lastdamagetime = gettime();
      var_7 = scripts\mp\utility\weapon::getweapongroup(var_2.basename);

      if(var_7 == "weapon_lmg") {
        if(!isDefined(var_1.shotslandedlmg)) {
          var_1.shotslandedlmg = 1;
          return;
        }

        var_1.shotslandedlmg++;
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
  var_0 = self getentitynumber();
  level.mines[var_0] = undefined;
  self disableplayermarks("equipment");

  if(isDefined(self.deletefunc)) {
    self thread[[self.deletefunc]]();
    self notify("deleted_equipment");
    return;
  }

  var_1 = self.killcament;
  var_2 = self.trigger;
  cleanupequipment(var_0, var_1, var_2);
  self notify("deleted_equipment");
  self delete();
}

function makeexplosiveusable(var_0) {
  self setotherent(self.owner);

  if(!isDefined(var_0)) {
    var_0 = 10;
  }

  var_1 = spawn("script_origin", self.origin + var_0 * anglestoup(self.angles));
  var_1 linkTo(self);
  self.trigger = var_1;
  var_1.owner = self;
  thread makeexplosiveusableinternal();
  return var_1;
}

function makeexplosiveusableinternal() {
  self endon("makeExplosiveUnusable");
  var_0 = self.trigger;
  watchexplosiveusable();

  if(isDefined(self)) {
    var_0 = self.trigger;
    self.trigger = undefined;
  }

  if(isDefined(var_0)) {
    var_0 delete();
    return;
  }
}

function makeexplosiveunusable() {
  self notify("makeExplosiveUnusable");
  var_0 = self.trigger;
  self.trigger = undefined;

  if(isDefined(var_0)) {
    var_0 delete();
    return;
  }
}

function watchexplosiveusable() {
  var_0 = self.owner;
  var_1 = self.trigger;
  self endon("death");
  var_1 endon("death");
  var_0 endon("disconnect");
  level endon("game_ended");
  var_1 setCursorHint("HINT_NOICON");
  var_1 scripts\mp\utility\usability::setselfusable(var_0);
  var_1 childthread scripts\mp\utility\usability::notusableforjoiningplayers(var_0);
  var_1 childthread scripts\mp\utility\usability::notusableafterownerchange(var_0, self);
  setexplosiveusablehintstring(var_1, self.weapon_name);
  var_1 waittillmatch("trigger", var_0);

  if(isDefined(self.weapon_name)) {
    switch (self.weapon_name) {
      case "trophy_mp":
        thread scripts\mp\equipment\trophy_system::trophy_pickup();
        break;
    }

    var_0 thread scripts\mp\equipment\c4::c4_resetaltdetonpickup();
  }

  var_0 playlocalsound("scavenger_pack_pickup");
  var_0 notify("scavenged_ammo", self.weapon_name);
  var_2 = scripts\mp\equipment::getequipmentreffromweapon(getcompleteweaponname(self.weapon_name));

  if(isDefined(var_2) && self.owner scripts\mp\equipment::hasequipment(var_2)) {
    self.owner scripts\mp\equipment::incrementequipmentammo(var_2, 1);
  }

  thread deleteexplosive();
}

function makeexplosiveusabletag(var_0, var_1) {
  self endon("death");
  self endon("makeExplosiveUnusable");
  var_2 = self.owner;
  var_3 = self.weapon_name;

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  if(var_1) {
    self enablemissilehint(1);
  } else {
    self setCursorHint("HINT_NOICON");
  }

  self sethinttag(var_0);
  self setuserange(72);
  setexplosiveusablehintstring(self.weapon_name);
  scripts\mp\utility\usability::setselfusable(var_2);
  childthread scripts\mp\utility\usability::notusableforjoiningplayers(var_2);
  childthread scripts\mp\utility\usability::notusableafterownerchange(var_2, self);

  for(;;) {
    self waittillmatch("trigger", var_2);

    if(istrue(var_2.isjuggernaut)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
        var_2[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/JUGG_CANNOT_BE_PICKED_UP");
      }

      continue;
    }

    if(isDefined(var_3)) {
      switch (var_3) {
        case "trophy_mp":
          thread scripts\mp\equipment\trophy_system::trophy_pickup();
          break;
        case "decon_station_mp":
          thread _debug_rooftop_heli_start::jugg_health_debug();
          break;
      }

      var_2 thread scripts\mp\equipment\c4::c4_resetaltdetonpickup();
    }

    var_2 playlocalsound("scavenger_pack_pickup");
    var_2 notify("scavenged_ammo", var_3);
    var_4 = scripts\mp\equipment::getequipmentreffromweapon(getcompleteweaponname(var_3));

    if(isDefined(var_4)) {
      if(self.owner scripts\mp\equipment::hasequipment(var_4)) {
        self.owner scripts\mp\equipment::incrementequipmentammo(var_4, 1);
      } else if(isDefined(level.ref_1205c)) {
        [[level.ref_1205c]](self.owner, var_4);
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

function setexplosiveusablehintstring(var_0) {
  switch (var_0) {
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

function explosivehandlemovers(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.linkparent = var_0;
  var_2.deathoverridecallback = &movingplatformdetonate;
  var_2.endonstring = "death";

  if(_calloutmarkerping_handleluinotify_enemyrepinged::tugofwar_tank(var_0)) {
    var_2.ref_123b4 = 1;
    self method_87bb(1);
  }

  if(!isDefined(var_1) || !var_1) {
    var_2.invalidparentoverridecallback = &scripts\mp\movers::moving_platform_empty_func;
  }

  thread scripts\mp\movers::handle_moving_platforms(var_2);
}

function explosivetrigger(var_0, var_1, var_2) {
  if(isPlayer(var_0) && var_0 scripts\mp\utility\perk::_hasperk("specialty_delaymine")) {
    var_0 thread scripts\cp\vehicles\vehicle_compass_cp::triggereddelayedexplosion();
    var_1 = level.delayminetime;
  }

  wait var_1;
}

function getdamageableents(var_0, var_1, var_2, var_3) {
  var_4 = [];

  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  if(!isDefined(var_3)) {
    var_3 = 0;
  }

  var_5 = var_1 * var_1;
  var_6 = level.players;

  for(var_7 = 0; var_7 < var_6.size; var_7++) {
    if(!isalive(var_6[var_7]) || var_6[var_7].sessionstate != "playing") {
      continue;
    }

    var_8 = scripts\mp\utility\damage::get_damageable_player_pos(var_6[var_7]);
    var_9 = distancesquared(var_0, var_8);

    if(var_9 < var_5 && (!var_2 || weapondamagetracepassed(var_0, var_8, var_3, var_6[var_7]))) {
      var_4 = scripts\mp\utility\damage::get_damageable_player(var_6[var_7], var_8);
    }
  }

  var_10 = getEntArray("grenade", "classname");

  for(var_7 = 0; var_7 < var_10.size; var_7++) {
    var_11 = scripts\mp\utility\damage::get_damageable_grenade_pos(var_10[var_7]);
    var_9 = distancesquared(var_0, var_11);

    if(var_9 < var_5 && (!var_2 || weapondamagetracepassed(var_0, var_11, var_3, var_10[var_7]))) {
      var_4 = scripts\mp\utility\damage::get_damageable_grenade(var_10[var_7], var_11);
    }
  }

  var_12 = getEntArray("destructible", "targetname");

  for(var_7 = 0; var_7 < var_12.size; var_7++) {
    var_11 = var_12[var_7].origin;
    var_9 = distancesquared(var_0, var_11);

    if(var_9 < var_5 && (!var_2 || weapondamagetracepassed(var_0, var_11, var_3, var_12[var_7]))) {
      var_13 = spawnStruct();
      var_13.isplayer = 0;
      var_13.isadestructable = 0;
      var_13.entity = var_12[var_7];
      var_13.damagecenter = var_11;
      var_4 = var_13;
    }
  }

  var_14 = getEntArray("destructable", "targetname");

  for(var_7 = 0; var_7 < var_14.size; var_7++) {
    var_11 = var_14[var_7].origin;
    var_9 = distancesquared(var_0, var_11);

    if(var_9 < var_5 && (!var_2 || weapondamagetracepassed(var_0, var_11, var_3, var_14[var_7]))) {
      var_13 = spawnStruct();
      var_13.isplayer = 0;
      var_13.isadestructable = 1;
      var_13.entity = var_14[var_7];
      var_13.damagecenter = var_11;
      var_4 = var_13;
    }
  }

  var_15 = getEntArray("misc_turret", "classname");

  foreach(var_17 in var_15) {
    var_11 = var_17.origin + (0, 0, 32);
    var_9 = distancesquared(var_0, var_11);

    if(var_9 < var_5 && (!var_2 || weapondamagetracepassed(var_0, var_11, var_3, var_17))) {
      switch (var_17.model) {
        case "vehicle_ugv_talon_gun_mp":
        case "mp_scramble_turret":
        case "mp_sam_turret":
        case "sentry_minigun_weak":
          var_4 = scripts\mp\utility\damage::get_damageable_sentry(var_17, var_11);
          break;
      }
    }
  }

  var_19 = getEntArray("script_model", "classname");

  foreach(var_21 in var_19) {
    if(var_21.model != "projectile_bouncing_betty_grenade" && var_21.model != "ims_scorpion_body") {
      continue;
    }

    var_11 = var_21.origin + (0, 0, 32);
    var_9 = distancesquared(var_0, var_11);

    if(var_9 < var_5 && (!var_2 || weapondamagetracepassed(var_0, var_11, var_3, var_21))) {
      var_4 = scripts\mp\utility\damage::get_damageable_mine(var_21, var_11);
    }
  }

  return var_4;
}

function weapondamagetracepassed(var_0, var_1, var_2, var_3) {
  var_4 = undefined;
  var_5 = var_1 - var_0;

  if(lengthsquared(var_5) < var_2 * var_2) {
    return true;
  }

  var_6 = vectorNormalize(var_5);
  var_4 = var_0 + (var_6[0] * var_2, var_6[1] * var_2, var_6[2] * var_2);
  var_7 = scripts\engine\trace::_bullet_trace(var_4, var_1, 0, var_3);

  if(getdvarint("scr_damage_debug") != 0 || getdvarint("scr_debugMines") != 0) {
    thread debugprint(var_0, ".dmg");

    if(isDefined(var_3)) {
      thread debugprint(var_1, "." + var_3.classname);
    } else {
      thread debugprint(var_1, ".undefined");
    }

    if(var_7["fraction"] == 1) {
      thread debugline(var_4, var_1, (1, 1, 1));
    } else {
      thread debugline(var_4, var_7["position"], (1, 0.9, 0.8));
      thread debugline(var_7["position"], var_1, (1, 0.4, 0.3));
    }
  }

  return var_7["fraction"] == 1;
}

function damageent(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(self.isplayer) {
    self.damageorigin = var_5;
    self.entity thread[[level.callbackplayerdamage]](var_0, var_1, var_2, 0, var_3, var_4, var_5, var_6, "none", 0);
    return;
  }

  if(self.isadestructable && (var_4.basename == "artillery_mp" || var_4.basename == "claymore_mp" || var_4.basename == "stealth_bomb_mp")) {
    return;
  }

  self.entity notify("damage", var_2, var_1, (0, 0, 0), (0, 0, 0), "MOD_EXPLOSIVE", "", "", "", undefined, var_4);
}

function debugline(var_0, var_1, var_2) {
  for(var_3 = 0; var_3 < 600; var_3++) {
    wait 0.05;
  }
}

function debugcircle(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3)) {
    var_3 = 16;
  }

  var_4 = 360 / var_3;
  var_5 = [];

  for(var_6 = 0; var_6 < var_3; var_6++) {
    var_7 = var_4 * var_6;
    var_8 = cos(var_7) * var_1;
    var_9 = sin(var_7) * var_1;
    var_10 = var_0[0] + var_8;
    var_11 = var_0[1] + var_9;
    var_12 = var_0[2];
    var_5 = (var_10, var_11, var_12);
  }

  for(var_6 = 0; var_6 < var_5.size; var_6++) {
    var_13 = var_5[var_6];

    if(var_6 + 1 >= var_5.size) {
      var_14 = var_5[0];
    } else {
      var_14 = var_5[var_6 + 1];
    }

    thread debugline(var_13, var_14, var_2);
  }
}

function debugprint(var_0, var_1) {
  for(var_2 = 0; var_2 < 600; var_2++) {
    wait 0.05;
  }
}

function onweapondamage(var_0, var_1, var_2, var_3, var_4) {
  self endon("death_or_disconnect");

  if(!scripts\mp\utility\player::isreallyalive(self)) {
    return;
  }

  switch (var_1.basename) {
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
      scripts\mp\shellshock::shellshockondamage(var_2, var_3);
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
    self waittill("weapon_change", var_0);
    self.lastweaponobj = var_0;

    if(isnormallastweapon(var_0)) {
      self.lastnormalweaponobj = var_0;
    }

    if(isdroppableweapon(var_0)) {
      ref_1316b(var_0);
    }

    if(scripts\mp\utility\weapon::iscacprimaryorsecondary(var_0)) {
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

  if(scripts\mp\utility\weapon::issuperweapon(var_0.basename)) {
    return false;
  }

  if(scripts\mp\utility\weapon::iskillstreakweapon(var_0.basename)) {
    return false;
  }

  if(scripts\mp\utility\weapon::isspecialmeleeweapon(var_0)) {
    return false;
  }

  if(var_0.inventorytype != "primary" && var_0.inventorytype != "altmode") {
    return false;
  }

  return true;
}

function isdroppableweapon(var_0) {
  if(var_0.basename == "none") {
    return false;
  }

  if(isfistweapon(var_0.basename)) {
    return false;
  }

  if(isbombplantweapon(var_0.basename)) {
    return false;
  }

  if(scripts\mp\utility\weapon::iskillstreakweapon(var_0.basename)) {
    return false;
  }

  if(scripts\mp\utility\weapon::issuperweapon(var_0.basename)) {
    return false;
  }

  if(var_0.inventorytype != "primary") {
    return false;
  }

  if(var_0.classname == "turret") {
    return false;
  }

  if(!scripts\mp\utility\weapon::iscacprimaryweapon(var_0.basename) && !scripts\mp\utility\weapon::iscacsecondaryweapon(var_0.basename)) {
    return false;
  }

  return true;
}

function updatemovespeedonweaponchange() {
  self endon("death_or_disconnect");
  self endon("faux_spawn");

  for(;;) {
    self waittill("weapon_change", var_0);

    if(var_0.basename == "none") {
      continue;
    } else if(scripts\mp\utility\weapon::issuperweapon(var_0.basename)) {
      updatemovespeedscale();
      continue;
    } else if(scripts\mp\utility\weapon::iskillstreakweapon(var_0.basename)) {
      continue;
    } else if(var_0.basename == "iw8_fists_mp_ls") {
      updatemovespeedscale();
      continue;
    } else if(var_0.inventorytype != "primary" && var_0.inventorytype != "altmode") {
      continue;
    }

    updatemovespeedscale();
  }
}

function getweaponspeedslowest() {
  var_0 = 2;
  self.weaponlist = self getweaponslistprimaries();

  if(self.weaponlist.size) {
    foreach(var_2 in self.weaponlist) {
      if(scripts\mp\utility\weapon::issuperweapon(var_2)) {
        var_3 = scripts\mp\supers::getmovespeedforsuperweapon(var_2);
      } else if(scripts\mp\utility\weapon::isgamemodeweapon(var_2)) {
        var_3 = getgamemodeweaponspeed(var_2);
      } else {
        var_3 = getweaponspeed(var_2);
      }

      if(var_3 == 0) {
        continue;
      }

      if(var_3 < var_0) {
        var_0 = var_3;
      }
    }
  } else {
    var_0 = 0.85;
  }

  var_0 = clampweaponspeed(var_0);
  return var_0;
}

function getweaponspeed(var_0) {
  var_1 = scripts\mp\utility\weapon::getweaponrootname(var_0);

  if(!isDefined(var_1) || !isDefined(level.weaponmapdata[var_1]) || !isDefined(level.weaponmapdata[var_1].speed)) {
    return 1;
  }

  return level.weaponmapdata[var_1].speed;
}

function getgamemodeweaponspeed(var_0) {
  return 0.93;
}

function clampweaponspeed(var_0) {
  return clamp(var_0, 0, 1);
}

function updateviewkickscale(var_0) {
  if(isDefined(var_0)) {
    self.viewkickscale = var_0;
  }

  var_1 = self getcurrentweapon();

  if(isDefined(self.overchargeviewkickscale)) {
    var_0 = self.overchargeviewkickscale;
  } else if(isDefined(self.overrideviewkickscale)) {
    var_0 = self.overrideviewkickscale;
    var_2 = scripts\mp\utility\weapon::ref_14584(var_1);

    if(var_2 == 1) {
      var_0 = self.overrideviewkickscalepistol;
    } else if(var_2 == 4) {
      var_0 = self.ref_1218d;
    } else if(var_2 == 2) {
      var_0 = self.ref_1218e;
    } else if(var_2 == 3) {
      var_0 = self.ref_1218f;
    } else if(var_2 == 5) {
      var_0 = self.overrideviewkickscalesniper;
    }
  } else if(isDefined(self.viewkickscale)) {
    var_0 = self.viewkickscale;
  } else {
    var_0 = 1;
  }

  if(weaponclass(var_1) == "sniper" && isDefined(level.debug_unlock_silo) && level.debug_unlock_silo == 1) {
    if(var_1 hasattachment("reargrip_bakelite", 1) && var_1 hasattachment("bar_xl_heavy", 1)) {
      var_0 *= 0.7;
    } else if(var_1 hasattachment("bar_xl_heavy", 1)) {
      var_0 *= 0.85;
    } else if(var_1 hasattachment("reargrip_bakelite", 1)) {
      var_0 *= 0.8;
    } else if(var_1 hasattachment("mixhandle_sn", 1)) {
      var_0 *= 0.85;
    } else if(var_1 hasattachment("handle_sn", 1)) {
      var_0 *= 0.75;
    } else if(isDefined(self.viewkickscale)) {
      var_0 = self.viewkickscale;
    } else {
      var_0 = 1;
    }
  }

  var_0 = clamp(var_0, 0, 1);
  self setviewkickscale(var_0);
}

function updatemovespeedscale() {
  var_0 = undefined;

  if(isDefined(self.playerstreakspeedscale)) {
    var_0 = 1;
    var_0 += self.playerstreakspeedscale;
  } else {
    var_0 = getplayerspeedbyweapon(self);

    if(isDefined(self.overrideweaponspeed_speedscale)) {
      var_0 = self.overrideweaponspeed_speedscale;
    }

    var_1 = self.chill_data;

    if(isDefined(var_1) && isDefined(var_1.speedmod)) {
      var_0 += var_1.speedmod;
    }

    if(isDefined(self.gasspeedmod)) {
      var_0 += self.gasspeedmod;
    }

    if(isDefined(self.disabledspeedmod)) {
      var_0 += self.disabledspeedmod;
    }

    if(isDefined(self.speedonkillmod)) {
      var_0 += self.speedonkillmod;
    }

    if(isDefined(self.momentumspeedincrease)) {
      var_0 += self.momentumspeedincrease;
    }
  }

  self.weaponspeed = var_0;

  if(!isDefined(self.combatspeedscalar)) {
    self.combatspeedscalar = 1;
  }

  var_0 += self.movespeedscaler - 1;
  var_0 += self.combatspeedscalar - 1;
  var_0 = clamp(var_0, 0, 1.08);

  if(isDefined(self.fastcrouchspeedmod)) {
    var_0 += self.fastcrouchspeedmod;
  }

  self setmovespeedscale(var_0);
}

function getplayerspeedbyweapon(var_0) {
  var_1 = 1;
  self.weaponlist = self getweaponslistprimaries();

  if(!self.weaponlist.size) {
    var_1 = 0.85;
  } else {
    var_2 = self getcurrentweapon();

    if(!isDefined(var_2)) {
      var_1 = getweaponspeedslowest();
    } else if(scripts\mp\utility\weapon::issuperweapon(var_2.basename)) {
      var_1 = scripts\mp\supers::getmovespeedforsuperweapon(var_2);
    } else if(scripts\mp\utility\weapon::isgamemodeweapon(var_2.basename)) {
      var_1 = getgamemodeweaponspeed(var_2);
    } else if(scripts\mp\utility\weapon::iskillstreakweapon(var_2.basename)) {
      var_1 = 0.85;
    } else if(scripts\mp\utility\weapon::unset_relic_mythic(var_2.basename)) {
      var_1 = 0.85;
    } else {
      if(var_2.inventorytype != "primary" && var_2.inventorytype != "altmode" || scripts\mp\utility\weapon::update_health_bar_to_player(var_2)) {
        if(isDefined(self.lastnormalweaponobj)) {
          var_2 = self.lastnormalweaponobj;
        } else {
          var_2 = undefined;
        }
      }

      if(!self hasweapon(var_2)) {
        var_1 = getweaponspeedslowest();
      } else {
        var_1 = getweaponspeed(var_2);
      }
    }
  }

  var_1 = clampweaponspeed(var_1);
  return var_1;
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
    var_3 = scripts\mp\utility\weapon::getweapongroup(var_1);

    if(var_3 == "weapon_lmg") {
      scripts\mp\utility\weapon::setrecoilscale(0, 0);
      return;
    }

    if(var_3 == "weapon_sniper") {
      if(var_1 hasattachment("barrelbored", 1)) {
        scripts\mp\utility\weapon::setrecoilscale(0, 0 + var_2);
        return;
      }

      scripts\mp\utility\weapon::setrecoilscale(0, 0 + var_2);
      return;
    }

    scripts\mp\utility\weapon::setrecoilscale();
    return;
  }

  if(var_0 == "crouch") {
    var_3 = scripts\mp\utility\weapon::getweapongroup(var_1);

    if(var_3 == "weapon_lmg") {
      scripts\mp\utility\weapon::setrecoilscale(0, 0);
      return;
    }

    if(var_3 == "weapon_sniper") {
      if(var_1 hasattachment("barrelbored", 1)) {
        scripts\mp\utility\weapon::setrecoilscale(0, 0 + var_2);
        return;
      }

      scripts\mp\utility\weapon::setrecoilscale(0, 0 + var_2);
      return;
    }

    scripts\mp\utility\weapon::setrecoilscale();
    return;
  }

  if(var_2 > 0) {
    scripts\mp\utility\weapon::setrecoilscale(0, var_2);
    return;
  }

  scripts\mp\utility\weapon::setrecoilscale();
}

function deleteallgrenades() {
  if(isDefined(level.grenades)) {
    foreach(var_1 in level.grenades) {
      if(isDefined(var_1) && !istrue(var_1.exploding) && !isplantedequipment(var_1)) {
        var_1 delete();
      }
    }
  }

  if(isDefined(level.missiles)) {
    foreach(var_4 in level.missiles) {
      if(isDefined(var_4) && !istrue(var_4.exploding) && !isplantedequipment(var_4)) {
        var_4 delete();
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
  var_0 = undefined;
  var_1 = 1;
  var_2 = "hitequip";

  for(;;) {
    self waittill("damage", var_3, var_0, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14, var_15);
    var_11 = scripts\mp\utility\weapon::mapweapon(var_11, var_15);
    var_16 = var_0;

    if(!isPlayer(var_0) && !isagent(var_0)) {
      if(isDefined(var_0.owner) && isPlayer(var_0.owner)) {
        var_16 = var_0.owner;
      }
    }

    if(!isPlayer(var_16) && !isagent(var_16)) {
      continue;
    }

    if(isDefined(var_11) && isendstr(var_11.basename, "betty_mp")) {
      continue;
    }

    if(!friendlyfirecheck(self.owner, var_16)) {
      continue;
    }

    if(scripts\mp\utility\damage::non_player_should_ignore_damage(var_16, var_11, var_15, var_6)) {
      continue;
    }

    var_17 = scripts\engine\utility::ter_op(scripts\mp\utility\damage::isfmjdamage(var_11, var_6, 1) || var_3 >= 80, 2, 1);
    var_1 -= var_17;
    equipmenthit(self.owner, var_16, var_11, var_6);

    if(var_1 <= 0) {
      break;
    }

    var_16 scripts\mp\damagefeedback::updatedamagefeedback(var_2);
  }

  self notify("mine_destroyed");

  if(isDefined(var_6) && (issubstr(var_6, "MOD_GRENADE") || issubstr(var_6, "MOD_EXPLOSIVE"))) {
    self.waschained = 1;
  }

  if(isDefined(var_10) && var_10 &level.idflags_penetration) {
    self.wasdamagedfrombulletpenetration = 1;
  }

  if(isDefined(var_10) && var_10 &level.idflags_ricochet) {
    self.wasdamagedfrombulletricochet = 1;
  }

  self.wasdamaged = 1;

  if(isDefined(var_16)) {
    self.damagedby = var_16;
  }

  if(isDefined(self.killcament)) {
    self.killcament.damagedby = var_16;
  }

  if(isPlayer(var_16)) {
    var_16 scripts\mp\damagefeedback::updatedamagefeedback(var_2);

    if(var_16 != self.owner && var_16.team != self.owner.team) {
      var_16 scripts\mp\killstreaks\killstreaks::givescoreforequipment(self, var_11);
      var_16 scripts\mp\battlechatter_mp::equipmentdestroyed(self);
      scripts\cp\vehicles\vehicle_compass_cp::equipmentdestroyed(var_15, var_0, var_3, var_10, undefined, var_11, undefined, var_16.modifiers);
    }
  }

  if(level.teambased) {
    if(isDefined(var_16) && isDefined(var_16.pers["team"]) && isDefined(self.owner) && isDefined(self.owner.pers["team"])) {
      if(var_16.pers["team"] != self.owner.pers["team"]) {
        var_16 notify("destroyed_equipment");
      }
    }
  } else if(isDefined(self.owner) && isDefined(var_16) && var_16 != self.owner) {
    var_16 notify("destroyed_equipment");
  }

  scripts\cp\vehicles\vehicle_compass_cp::minedestroyed(self, var_16, var_6);
  self notify("detonateExplosive", var_16);
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
  waitframe();

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
  playFX(var_4, var_3);
  var_5 = scripts\engine\utility::ter_op(isDefined(var_1.minedamagemin), var_1.minedamagemin, level.minedamagemin);
  var_6 = scripts\engine\utility::ter_op(isDefined(var_1.minedamagemax), var_1.minedamagemax, level.minedamagemax);
  var_7 = scripts\engine\utility::ter_op(isDefined(var_1.minedamageradius), var_1.minedamageradius, level.minedamageradius);

  if(var_6 > 0) {
    self radiusdamage(self.origin, var_7, var_6, var_5, var_0, "MOD_EXPLOSIVE", self.weapon_name);
  }

  if(isDefined(self.owner)) {
    self.owner thread scripts\mp\utility\dialog::leaderdialogonplayer("mine_destroyed", undefined, undefined, self.origin);
  }

  wait 0.2;
  deleteexplosive();
}

function deleteplacedequipment(var_0) {
  if(isDefined(self.plantedlethalequip)) {
    foreach(var_2 in self.plantedlethalequip) {
      if(isDefined(var_2)) {
        deleteexplosive(var_2);
      }
    }
  }

  self.plantedlethalequip = [];

  if(isDefined(self.plantedtacticalequip)) {
    foreach(var_2 in self.plantedtacticalequip) {
      if(isDefined(var_2)) {
        deleteexplosive(var_2);
      }
    }
  }

  self.plantedtacticalequip = [];
  var_6 = scripts\mp\utility\game::isanymlgmatch() || istrue(var_0);

  if(isDefined(self.plantedhackedequip)) {
    foreach(var_8, var_2 in self.plantedhackedequip) {
      if(isDefined(var_2) && (!var_6 || !istrue(var_2.issuper))) {
        deleteexplosive(var_2);
        self.plantedhackedequip[var_8] = undefined;
      }
    }

    self.plantedhackedequip = scripts\engine\utility::array_removeundefined(self.plantedhackedequip);
  }

  if(var_6 && isDefined(self.plantedsuperequip)) {
    foreach(var_2 in self.plantedsuperequip) {
      deleteexplosive(var_2);
      self.plantedsuperequip[var_8] = undefined;
    }

    self.plantedsuperequip = scripts\engine\utility::array_removeundefined(self.plantedsuperequip);
    return;
  }
}

function deletedisparateplacedequipment() {
  var_0 = scripts\mp\equipment::getcurrentequipment("primary");

  foreach(var_2 in self.plantedlethalequip) {
    if(isDefined(var_2)) {
      if(!isDefined(var_2.equipmentref) || !isDefined(var_0) || var_2.equipmentref != var_0) {
        deleteexplosive(var_2);
      }
    }
  }

  var_4 = scripts\mp\equipment::getcurrentequipment("secondary");

  foreach(var_2 in self.plantedtacticalequip) {
    if(isDefined(var_2)) {
      if(!isDefined(var_2.equipmentref) || !isDefined(var_4) || var_2.equipmentref != var_4) {
        deleteexplosive(var_2);
      }
    }
  }
}

function equipmentdeletevfx(var_0, var_1) {
  if(isDefined(var_0)) {
    if(isDefined(var_1)) {
      var_2 = anglesToForward(var_1);
      var_3 = anglestoup(var_1);
      playFX(scripts\engine\utility::getfx("equipment_explode"), var_0, var_2, var_3);
      playFX(scripts\engine\utility::getfx("equipment_smoke"), var_0, var_2, var_3);
    } else {
      playFX(scripts\engine\utility::getfx("equipment_explode"), var_0);
      playFX(scripts\engine\utility::getfx("equipment_smoke"), var_0);
    }

    playsoundatpos(var_0, "mp_killstreak_disappear");
    return;
  }

  if(isDefined(self)) {
    var_4 = self.origin;
    var_2 = anglesToForward(self.angles);
    var_3 = anglestoup(self.angles);
    playFX(scripts\engine\utility::getfx("equipment_explode"), var_4, var_2, var_3);
    playFX(scripts\engine\utility::getfx("equipment_smoke"), var_4, var_2, var_3);
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
  var_0 = [];
  var_1 = 1;
  var_2 = tablelookupbyrow("mp/attachmentmap.csv", var_1, 0);
  var_3 = scripts\mp\utility\game::unset_relic_grounded();

  while(var_2 != "") {
    if(var_3 || scripts\cp_mp\utility\weapon_utility::vehicle_ai_script_models(var_2) || vehcolignorelist()) {
      var_0 = var_2;
    }

    var_1++;
    var_2 = tablelookupbyrow("mp/attachmentmap.csv", var_1, 0);
  }

  var_4 = [];
  var_5 = 1;

  for(var_6 = tablelookupbyrow("mp/attachmentmap.csv", 0, var_5); var_6 != ""; var_6 = tablelookupbyrow("mp/attachmentmap.csv", 0, var_5)) {
    var_4 = var_5;
    var_5++;
  }

  level.attachmentmap_basetounique = [];

  foreach(var_2 in var_0) {
    foreach(var_11, var_9 in var_4) {
      var_10 = tablelookup("mp/attachmentmap.csv", 0, var_2, var_9);

      if(var_10 == "") {
        continue;
      }

      if(!isDefined(level.attachmentmap_basetounique[var_2])) {
        level.attachmentmap_basetounique[var_2] = [];
      }

      level.attachmentmap_basetounique[var_2][var_11] = var_10;

      if(!isDefined(level.attachmentmap_uniquetobase[var_10])) {
        level.attachmentmap_uniquetobase[var_10] = var_11;
        continue;
      }

      if(level.attachmentmap_uniquetobase[var_10] != var_11) {}
    }
  }

  level.carryingplayer = [];
  var_13 = [];
  var_1 = 1;

  for(var_14 = tablelookupbyrow("mp/attachmentmap_comboOverrides.csv", var_1, 0); var_14 != ""; var_14 = tablelookupbyrow("mp/attachmentmap_comboOverrides.csv", var_1, 0)) {
    var_13 = var_14;
    var_1++;
  }

  var_15 = [];
  var_5 = 1;

  for(var_16 = tablelookupbyrow("mp/attachmentmap_comboOverrides.csv", 0, var_5); var_16 != ""; var_16 = tablelookupbyrow("mp/attachmentmap_comboOverrides.csv", 0, var_5)) {
    var_15 = var_16;
    var_5++;
  }

  foreach(var_14 in var_13) {
    foreach(var_9, var_16 in var_15) {
      var_19 = tablelookup("mp/attachmentmap_comboOverrides.csv", 0, var_14, var_9 + 1);

      if(var_19 == "") {
        continue;
      }

      if(!isDefined(level.carryingplayer[var_14])) {
        level.carryingplayer[var_14] = [];
      }

      level.carryingplayer[var_14][var_16] = var_19;
    }
  }

  foreach(var_31, var_22 in level.weaponmapdata) {
    var_23 = var_31;

    if(getsubstr(var_31, 0, 4) == "iw8_") {
      var_23 = getsubstr(var_31, 4);
    }

    var_24 = "mp/gunsmith/" + var_23 + "_progression.csv";

    if(!tableexists(var_24)) {
      continue;
    }

    level.weaponattachments[var_31] = [];
    var_1 = 1;
    var_25 = tablelookupbyrow(var_24, var_1, 0);
    var_26 = var_23 + "_attachment_ids.csv";

    if(getsubstr(var_23, 0, 3) == "s4_") {
      var_26 = "loot/" + var_26;
    } else {
      var_26 = "loot/iw8_" + var_26;
    }

    while(var_25 != "") {
      var_27 = getdvarint("scr_maxAttachmentUnlocksPerLevel", 3);

      for(var_28 = 0; var_28 < var_27; var_28++) {
        var_29 = tablelookupbyrow(var_24, var_1, 1 + var_28 * 4);

        if(var_29 != "") {
          var_30 = tablelookup(var_26, 0, var_29, 1);

          if(var_30 != "") {
            level.weaponattachments[var_31][var_30] = var_30;
          }
        }
      }

      var_1++;
      var_25 = tablelookupbyrow(var_24, var_1, 0);
      var_29 = tablelookupbyrow(var_24, var_1, 1);
    }
  }

  level.attachmentmap_attachtoperk = [];
  level.carrier_remove_carriable_weapon = [];
  level.carry_ref = [];
  level.carryobjects_onjuggernaut = [];
  var_32 = getattachmentlistuniquenames();

  foreach(var_34 in var_32) {
    var_35 = tablelookup("mp/attachmenttable.csv", 4, var_34, 2);
    var_36 = scripts\mp\utility\weapon::attachmentmap_tobase(var_34);

    if(var_35 != "" && isDefined(var_36)) {
      var_37 = level.carry_ref[var_36];

      if(!isDefined(var_37)) {
        level.carry_ref[var_36] = var_35;
      } else if(var_35 != var_37) {
        level.carryobjects_onjuggernaut[var_34] = var_35;
      }
    }

    var_38 = tablelookup("mp/attachmenttable.csv", 4, var_34, 12);

    if(var_38 != "") {
      level.attachmentmap_attachtoperk[var_34] = var_38;
    }

    var_39 = tablelookup("mp/attachmenttable.csv", 4, var_34, 13);

    if(var_39 != "") {
      level.attachmentmap_uniquetoextra[var_34] = var_39;
    }

    var_40 = tablelookup("mp/attachmenttable.csv", 4, var_34, 9);

    if(var_40 != "") {
      level.carrier_remove_carriable_weapon[var_34] = var_40;
    }
  }

  level.carryitem2omnvar = [];
  level.carryitem2omnvar["default"] = fired_missiles("mp/attachmentcombos.csv");
  level.carryitem2omnvar["s4"] = fired_missiles("mp/attachmentcombos_s4.csv");
  level.cash_hud_bink = [];
  level.cash_hud_bink["default"] = "mp/attachmentcombos.csv";
  level.cash_hud_bink["s4"] = "mp/attachmentcombos_s4.csv";
}

function fired_missiles(var_0) {
  var_4 = [];
  var_1 = 1;

  for(var_2 = tablelookupbyrow(var_0, var_1, 0); var_2 != ""; var_2 = tablelookupbyrow(var_0, var_1, 0)) {
    var_5 = 1;

    for(var_3 = tablelookupbyrow(var_0, 0, var_5); var_3 != ""; var_3 = tablelookupbyrow(var_0, 0, var_5)) {
      if(var_1 != var_5) {
        var_6 = tablelookupbyrow(var_0, var_1, var_5);

        if(!isDefined(var_4[var_2])) {
          var_4 = [];
        }

        if(var_6 != "") {
          var_4[var_3] = var_6;
        }
      }

      var_5++;
    }

    var_1++;
  }

  return var_4;
}

function getattachmentlistuniquenames() {
  return scripts\mp\utility\weapon::getattachmentlist(4, 1);
}

function track_get_launch_target() {
  level.ref_1459e = [];
  loadweaponsourcetablefromcsv("mp/itemsourcetable.csv");
  loadweaponsourcetablefromcsv("mp/itemsourcetable_ch2.csv");
}

function loadweaponsourcetablefromcsv(var_0) {
  for(var_1 = 0;; var_1++) {
    var_2 = tablelookupbyrow(var_0, var_1, 1);

    if(!isDefined(var_2) || var_2 == "") {
      break;
    }

    if(var_2 != "weapon") {
      var_1++;
      continue;
    }

    var_3 = tablelookupbyrow(var_0, var_1, 3);
    var_4 = tablelookupbyrow(var_0, var_1, 2);
    level.ref_1459e[var_4] = var_3;
  }
}

function safechecknum(var_0) {
  if(!isDefined(level.ref_1459e)) {
    track_get_launch_target();
  }

  var_1 = level.ref_1459e[var_0];

  if(isDefined(var_1)) {
    return var_1;
  }

  return "iw8";
}

function vehicle_ai_avoidance_cleanup(var_0) {
  if(!isDefined(level.ref_1459e)) {
    track_get_launch_target();
  }

  var_1 = level.ref_1459e[var_0];

  if(isDefined(var_1) && (var_1 == "t9" || var_1 == "s4")) {
    if(!istrue(level.ref_14434)) {
      return false;
    }

    if(!getdvarint("LNLMORMPTS")) {
      return false;
    }

    return true;
  }

  if(isDefined(var_1) && var_1 != "iw8") {
    return false;
  }

  return true;
}

function buildweaponmap() {
  level.weaponmapdata = [];
  level.ref_14589 = [];
  level.ref_14580 = [];
  var_0 = scripts\mp\utility\game::unset_relic_grounded();
  var_1 = tablelookupgetnumrows("mp/statstable.csv");

  for(var_2 = 0; var_2 < var_1; var_2++) {
    var_3 = tablelookupbyrow("mp/statstable.csv", var_2, 0);
    var_4 = tablelookup("mp/statstable.csv", 0, var_3, 4);

    if(var_4 == "") {
      continue;
    }

    if(var_0 || scripts\cp_mp\utility\weapon_utility::vehicle_ai_script_models(var_4) || vehcolignorelist()) {
      level.weaponmapdata[var_4] = spawnStruct();
      var_5 = tablelookup("mp/statstable.csv", 0, var_3, 0);

      if(var_5 != "") {
        level.weaponmapdata[var_4].number = var_5;
      }

      var_6 = tablelookup("mp/statstable.csv", 0, var_3, 1);

      if(var_6 != "") {
        level.weaponmapdata[var_4].group = var_6;
        var_7 = tablelookup("mp/statstable.csv", 0, var_3, 41);

        if(var_7 != "") {
          var_8 = int(var_7);
          var_9 = 0;
          var_10 = tablelookup("mp/statstable.csv", 0, var_3, 17);

          if(var_10 != "") {
            var_9 = getdvarint(var_10, 0) == 0;
          }

          if(var_8 > -1 && vehicle_ai_avoidance_cleanup(var_4) && !var_9) {
            if(!isDefined(level.ref_14589[var_6])) {
              level.ref_14589[var_6] = [];
            }

            level.ref_14589[var_6][level.ref_14589[var_6].size] = var_4;
          } else {
            level.weaponmapdata[var_4].ref_13efc = 1;
          }
        }
      }

      if(!istrue(level.weaponmapdata[var_4].ref_13efc)) {
        level.ref_14580[var_4] = 1;
      }

      var_11 = tablelookup("mp/statstable.csv", 0, var_3, 2);

      if(var_11 != "") {
        level.weaponmapdata[var_4].ref_11bd1 = var_11;
      }

      var_12 = tablelookup("mp/statstable.csv", 0, var_3, 5);

      if(var_12 != "") {
        level.weaponmapdata[var_4].assetname = var_12;
      }

      var_13 = tablelookup("mp/statstable.csv", 0, var_3, 44);

      if(var_13 != "") {
        level.weaponmapdata[var_4].perk = var_13;
      }

      var_14 = tablelookup("mp/statstable.csv", 0, var_3, 9);
      var_15 = parseattachdefaulttoidmap(var_14);

      if(isDefined(var_15)) {
        level.weaponmapdata[var_4].attachdefaulttoidmap = var_15;
      }

      var_16 = tablelookup("mp/statstable.csv", 0, var_3, 8);

      if(var_16 != "") {
        var_16 = float(var_16);
        level.weaponmapdata[var_4].speed = var_16;
      }

      continue;
    }

    var_9 = undefined;

    if(tablelookup("mp/statstable.csv", 0, var_3, 1) != "") {
      if(tablelookup("mp/statstable.csv", 0, var_3, 41) != "") {
        var_10 = tablelookup("mp/statstable.csv", 0, var_3, 17);

        if(var_10 != "") {
          var_9 = getdvarint(var_10, 0) == 0;
        }
      }
    }

    if(!istrue(var_9)) {
      level.ref_14580[var_4] = 1;
    }
  }

  var_17 = [];
  level.weaponlootmapdata = [];
  var_2 = -1;

  for(;;) {
    var_2++;
    var_18 = tablelookupbyrow("loot/weapon_ids.csv", var_2, 0);

    if(var_18 == "") {
      break;
    }

    var_4 = tablelookupbyrow("loot/weapon_ids.csv", var_2, 1);

    if(!var_0 && !scripts\cp_mp\utility\weapon_utility::vehicle_ai_script_models(var_4) && !vehcolignorelist()) {
      continue;
    }

    var_19 = tablelookupbyrow("loot/weapon_ids.csv", var_2, 6);
    var_20 = scripts\mp\utility\weapon::getweaponvarianttablename(var_4);
    var_21 = tablelookup(var_20, 1, var_19, 0);

    if(var_21 == "") {
      continue;
    }

    if(int(var_21) > 0) {
      if(!isDefined(var_17[var_4]) || int(var_21) > var_17[var_4]) {
        var_17 = int(var_21);
      }
    }

    var_22 = var_4 + "|" + var_21;
    level.weaponlootmapdata[var_22] = spawnStruct();
    level.weaponlootmapdata[var_22].variantid = int(var_21);
    var_23 = tablelookup(var_20, 1, var_19, 3);

    if(var_23 != "") {
      level.weaponlootmapdata[var_22].assetoverridename = var_23;
    }

    var_24 = tablelookup("loot/weapon_ids.csv", 6, var_19, 5);
    level.weaponlootmapdata[var_22].update_focus_fire_objective = int(var_21) != 0 && int(var_24) == 99;
    level.weaponlootmapdata[var_22].tut_bot_nameplate = vehicle_ai_avoidance_cleanup(var_4);
    var_25 = tablelookup(var_20, 1, var_19, 4);
    var_15 = parseattachdefaulttoidmap(var_25);

    if(isDefined(var_15)) {
      if(isDefined(level.weaponmapdata[var_4].attachdefaulttoidmap)) {
        var_15 = scripts\engine\utility::array_combine_unique_keys(var_15, level.weaponmapdata[var_4].attachdefaulttoidmap);
      }

      level.weaponlootmapdata[var_22].attachdefaulttoidmap = var_15;
    }

    var_26 = [];

    for(var_27 = 5; var_27 <= 15; var_27++) {
      var_28 = tablelookup(var_20, 1, var_19, var_27);

      if(var_28 != "") {
        var_29 = strtok(var_28, "|");

        if(var_29.size == 2) {
          var_26 = int(var_29[1]);
        } else {
          var_26 = 0;
        }
      }
    }

    if(var_26.size > 0) {
      level.weaponlootmapdata[var_22].attachcustomtoidmap = var_26;
    }

    var_30 = tablelookup(var_20, 1, var_19, 16);

    if(var_30 != "") {
      var_31 = [];
      var_32 = strtok(var_30, " ");

      foreach(var_34 in var_32) {
        var_35 = strtok(var_34, "|");

        if(var_35.size != 2) {
          continue;
        }

        var_31 = int(var_35[1]);
      }

      if(var_31.size > 0) {
        level.weaponlootmapdata[var_22].attachextratoidmap = var_31;
      }
    }
  }

  foreach(var_38 in var_17) {
    for(var_39 = 1; var_39 <= var_38; var_39++) {
      var_40 = var_41 + "|" + var_39;

      if(!isDefined(level.weaponlootmapdata[var_40])) {
        level.weaponlootmapdata[var_40] = spawnStruct();
        level.weaponlootmapdata[var_40].variantid = var_39;
        level.weaponlootmapdata[var_40].update_focus_fire_objective = 1;
        level.weaponlootmapdata[var_40].tut_bot_nameplate = 0;
      }
    }
  }
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

function grenadestuckto(var_0, var_1, var_2) {
  if(!isDefined(self)) {
    var_0.stuckenemyentity = var_1;
    var_1.stuckbygrenade = var_0;
    var_1.ref_13935 = var_0.owner;
    return;
  }

  if(level.teambased && isDefined(var_1.team) && var_1.team == self.team) {
    var_0.isstuck = "friendly";
    return;
  }

  var_3 = undefined;
  var_4 = "incoming_stuck";

  switch (var_0.weapon_name) {
    case "semtex_mp":
      var_3 = "semtex_stuck";
      break;
    case "molotov_mp":
      var_3 = "molotov_stuck";
      var_4 = "flavor_surprise";
      break;
    case "thermite_mp":
      var_3 = "thermite_attacker_stuck";
      var_4 = "flavor_surprise";
      break;
  }

  var_0.isstuck = "enemy";
  var_0.stuckenemyentity = var_1;
  var_1.stuckbygrenade = var_0;
  var_1.ref_13935 = var_0.owner;
  self notify("grenade_stuck_enemy");
  level thread scripts\mp\battlechatter_mp::trysaylocalsound(var_1, var_4);

  if(!istrue(var_2)) {
    grenadestucktosplash(var_3, var_1);
    return;
  }
}

function grenadestucktosplash(var_0, var_1) {
  var_2 = self;

  if(isPlayer(var_1) && isDefined(var_0)) {
    if(isDefined(var_2.owner)) {
      var_2 = var_2.owner;
    }

    var_2 scripts\mp\hud_message::showsplash(var_0);
  }

  var_2 thread scripts\mp\awards::givemidmatchaward("explosive_stick");
}

function outlineequipmentforowner(var_0) {}

function outlinesuperequipment(var_0, var_1) {
  if(level.teambased) {
    thread outlinesuperequipmentforteam(var_0, var_1);
    return;
  }

  thread outlinesuperequipmentforplayer(var_0, var_1);
}

function outlinesuperequipmentforteam(var_0, var_1) {
  var_2 = scripts\mp\utility\outline::outlineenableforteam(var_0, var_1.team, "outline_nodepth_cyan", "killstreak");
  var_0 waittill("death");
  scripts\mp\utility\outline::outlinedisable(var_2, var_0);
}

function outlinesuperequipmentforplayer(var_0, var_1) {
  var_2 = scripts\mp\utility\outline::outlineenableforplayer(var_0, var_1, "outline_nodepth_cyan", "killstreak");
  var_0 waittill("death");
  scripts\mp\utility\outline::outlinedisable(var_2, var_0);
}

function grenadeheldatdeath() {
  return istrue(self.grenadeheldatdeath);
}

function set_cp_vehicle_health_values() {
  self.grenadeheldatdeath = !nullweapon(self getheldoffhand());
}

function trace_impale(var_0, var_1) {
  var_2 = physics_createcontents(["physicscontents_solid", "physicscontents_glass", "physicscontents_missileclip", "physicscontents_vehicle", "physicscontents_item"]);
  var_3 = scripts\engine\trace::ray_trace_detail(var_0, var_1, level.players, var_2, undefined, 1);
  return var_3;
}

function impale_endpoint(var_0, var_1) {
  var_2 = var_0 + var_1 * 4096;
  return var_2;
}

function impale(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_1 endon("death_or_disconnect");

  if(!isDefined(var_1.body)) {
    return;
  }

  playFX(scripts\engine\utility::getfx("penetration_railgun_impact"), var_4);
  var_9 = impale_endpoint(var_4, var_5);
  var_10 = trace_impale(var_4, var_9);
  var_9 = var_10["position"] - var_5 * 12;
  var_11 = length(var_9 - var_4);
  var_12 = var_11 / 1000;
  var_12 = max(var_12, 0.05);

  if(var_10["hittype"] != "hittype_world") {
    var_12 = 0;
  }

  var_13 = var_12 > 0.05;

  if(isDefined(var_1)) {
    var_1.body startragdoll();
  }

  waitframe();

  if(var_13) {
    var_14 = var_5;
    var_15 = anglestoup(var_0.angles);
    var_16 = vectorcross(var_14, var_15);
    var_17 = scripts\engine\utility::spawn_tag_origin(var_4, axistoangles(var_14, var_16, var_15));
    var_17 moveTo(var_9, var_12);
    var_18 = spawnragdollconstraint(var_1.body, var_6, var_7, var_8);
    var_18.origin = var_17.origin;
    var_18.angles = var_17.angles;
    var_18 linkTo(var_17);

    if(var_12 > 1) {
      thread impale_detachaftertime(var_18, 1);
    }

    thread impale_cleanup(var_1, var_17, var_12 + 0.25);
    thread impale_effects(var_17, var_9);
    return;
  }
}

function impale_detachaftertime(var_0, var_1) {
  wait var_1;

  if(isDefined(var_0)) {
    var_0 delete();
    return;
  }
}

function impale_effects(var_0, var_1) {
  wait clamp(var_1 - 0.05, 0.05, 20);
  playFX(scripts\engine\utility::getfx("vfx_penetration_railgun_impact"), var_0);
}

function impale_cleanup(var_0, var_1, var_2) {
  if(isDefined(var_0)) {
    var_0 scripts\engine\utility::ref_143b9(var_2, "death_or_disconnect");
  }

  var_1 delete();
}

function codecallback_getprojectilespeedscale(var_0, var_1) {
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

function tutkioskpurchase(var_0) {
  if(!isDefined(var_0)) {
    return false;
  }

  var_1 = "flash_grenade_mp";
  var_2 = var_0 getentitynumber();

  if(isDefined(self.debuffedbyplayers) && isDefined(self.debuffedbyplayers[var_1]) && isDefined(self.debuffedbyplayers[var_1][var_2])) {
    return true;
  }

  return false;
}

function using_self_revive(var_0) {
  if(!isDefined(var_0)) {
    return false;
  }

  var_1 = "concussion_grenade_mp";
  var_2 = var_0 getentitynumber();

  if(isDefined(self.debuffedbyplayers) && isDefined(self.debuffedbyplayers[var_1]) && isDefined(self.debuffedbyplayers[var_1][var_2])) {
    return true;
  }

  return false;
}

function isstunnedorblinded() {
  return isblinded() || isstunned();
}

function cleanupconcussionstun(var_0) {
  self endon("death_or_disconnect");
  self endon("started_spawnPlayer");
  level endon("game_ended");
  wait var_0;
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
    self waittill("weapon_switch_invalid", var_0);
    var_1 = self getcurrentweapon();

    if(var_1.inventorytype == "item" || var_1.inventorytype == "exclusive") {
      scripts\cp_mp\utility\inventory_utility::_switchtoweapon(self.lastdroppableweaponobj);
    }
  }
}

function weaponhasselectableoptic(var_0) {
  var_1 = scripts\mp\utility\weapon::getweaponrootname(var_0);
  var_2 = getweaponattachments(var_0);

  foreach(var_4 in var_2) {
    var_5 = attachmentgroup(var_4);

    if(var_5 == "rail") {
      var_6 = scripts\mp\utility\weapon::attachmentmap_tobase(var_4);

      if(scripts\mp\utility\weapon::carriedpunchcard(var_1, var_6)) {
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
    self waittill("weapon_dropped", var_0, var_1);

    if(isDefined(var_0) && isDefined(var_1) && !scripts\mp\utility\weapon::ismeleeonly(var_1) && !scripts\mp\utility\weapon::update_health_bar_to_player(var_1) && !scripts\mp\utility\weapon::isknifeonly(var_1)) {
      if(var_0 physics_getnumbodies() > 0) {
        var_0 physics_registerforcollisioncallback();
        thread weapondrop_physics_callback_monitor();
      }
    }
  }
}

function weapondrop_physics_callback_monitor() {
  self endon("death");
  self endon("timeout");
  thread weapondrop_physics_timeout(2);
  self waittill("collision", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7);

  if(isDefined(self.classname) && getsubstr(self.classname, 0, 6) == "weapon") {
    var_8 = physics_getsurfacetypefromflags(var_3);
    var_9 = getsubstr(var_8["name"], 9);

    if(var_9 == "user_terrain1") {
      var_9 = "user_terrain_1";
    }

    if(var_9 == "user_terrain5") {
      var_9 = "user_terrain_5";
    }

    switch (getsubstr(self.classname, 0, 13)) {
      case "weapon_iw8_ar":
        if(isDefined(self.objweapon)) {
          if(isDefined(self.objweapon.material) && self.objweapon.material == "polymer") {
            self playsurfacesound("weap_drop_med_poly", var_9);
          } else {
            self playsurfacesound("weap_drop_med", var_9);
          }
        } else {
          self playsurfacesound("weap_drop_med", var_9);
        }

        break;
      case "weapon_iw8_sm":
        if(isDefined(self.objweapon)) {
          if(isDefined(self.objweapon.material) && self.objweapon.material == "polymer") {
            self playsurfacesound("weap_drop_small_poly", var_9);
          } else {
            self playsurfacesound("weap_drop_small", var_9);
          }
        } else {
          self playsurfacesound("weap_drop_small", var_9);
        }

        break;
      case "weapon_iw8_lm":
        self playsurfacesound("weap_drop_xlarge", var_9);
        break;
      case "weapon_iw8_sh":
        if(isDefined(self.objweapon)) {
          if(isDefined(self.objweapon.material) && self.objweapon.material == "polymer") {
            self playsurfacesound("weap_drop_med_poly", var_9);
          } else {
            self playsurfacesound("weap_drop_med", var_9);
          }
        } else {
          self playsurfacesound("weap_drop_med", var_9);
        }

        break;
      case "weapon_iw8_sn":
        self playsurfacesound("weap_drop_large", var_9);
        break;
      case "weapon_iw8_pi":
        if(isDefined(self.objweapon)) {
          if(isDefined(self.objweapon.material) && self.objweapon.material == "polymer") {
            self playsurfacesound("weap_drop_pistol_poly", var_9);
          } else {
            self playsurfacesound("weap_drop_pistol", var_9);
          }
        } else {
          self playsurfacesound("weap_drop_pistol", var_9);
        }

        break;
      case "weapon_iw8_la":
        self playsurfacesound("weap_drop_launcher", var_9);
        break;
      default:
        self playsurfacesound("weap_drop_med", var_9);
        break;
    }

    return;
  }
}

function weapondrop_physics_timeout(var_0) {
  wait var_0;
  self notify("timeout");
}

function axedetachfromcorpse(var_0) {
  level endon("game_ended");
  var_1 = var_0 getlinkedchildren();

  foreach(var_3 in var_1) {
    if(!isDefined(var_3)) {
      continue;
    }

    var_4 = var_3.weapon_name;
    var_5 = var_3.owner;
    var_6 = var_3.origin;

    if(isDefined(var_4) && scripts\mp\utility\weapon::isaxeweapon(var_4)) {
      relaunchaxe(var_3, var_4, var_5);
    }
  }
}

function relaunchaxe(var_0, var_1) {
  self unlink();
  var_2 = scripts\mp\utility\weapon::getweaponbasenamescript(var_0);
  var_3 = getsubstr(var_0, var_2.size);
  var_4 = var_1 scripts\mp\utility\weapon::_launchgrenade("iw7_axe_mp_dummy" + var_3, self.origin, (0, 0, 0), 100, 1, self);
  var_4 setentityowner(var_1);
  var_4 thread _utilflare_isvalidflaretype::watchgrenadeaxepickup(var_1, self.weapon_name);
}

function callback_finishweaponchange(var_0, var_1, var_2, var_3) {
  updateweaponscriptvfx(var_0, var_1, var_2, var_3);
  var_4 = self.weaponchangecallbacks;

  if(isDefined(var_4)) {
    foreach(var_6 in var_4.callbacks) {
      self[[var_6]](var_0, var_1);
    }

    foreach(var_6 in var_4.oneshotcallbacks) {
      self[[var_6]](var_0, var_1);
    }

    var_4.oneshotcallbacks = [];
    return;
  }
}

function updateweaponscriptvfx(var_0, var_1, var_2, var_3) {
  if((var_1.basename == "none" || var_1.basename == "alt_none") && isDefined(self.lastdroppableweapon)) {
    if(var_1 == "alt_none") {
      var_3 = 1;
    } else {
      var_3 = 0;
    }

    var_1 = self.lastdroppableweapon;
  }

  clearweaponscriptvfx(var_1, var_3);
  runweaponscriptvfx(var_0, var_2);
}

function runweaponscriptvfx(var_0, var_1) {
  if(!isDefined(var_0)) {
    return;
  }

  if(isDefined(var_1) && var_1 == 1) {
    var_2 = "alt_" + scripts\mp\utility\weapon::getweaponbasenamescript(var_0);
    return;
  }

  var_2 = scripts\mp\utility\weapon::getweaponbasenamescript(var_1);
}

function clearweaponscriptvfx(var_0, var_1) {
  if(!isDefined(var_0)) {
    return;
  }

  if(isDefined(var_1) && var_1 == 1) {
    var_2 = "alt_" + scripts\mp\utility\weapon::getweaponbasenamescript(var_0);
  } else {
    var_2 = scripts\mp\utility\weapon::getweaponbasenamescript(var_1);
  }

  switch (var_2) {
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

function updatecamoscripts(var_0, var_1) {
  if(ref_1458a(var_1)) {
    clearcamoscripts(getweaponcamoname(var_1));
  }

  runcamoscripts(var_0);
}

function runcamoscripts(var_0) {
  if(!getdvarint("scr_reactive_camos", 1)) {
    return;
  }

  if(ref_1458a(var_0)) {
    thread ref_12a3e(var_0);
  } else {
    self setscriptablepartstate("activeCamo", "no_stage");
  }

  var_1 = getweaponcamoname(var_0);

  if(!isDefined(var_1)) {
    return;
  }

  switch (var_1) {
    case "camo84":
      thread blood_camo_84();
      break;
  }
}

function clearcamoscripts(var_0) {
  self notify("endReactiveCamoThread");
  self setscriptablepartstate("activeCamo", "no_stage");

  if(!isDefined(var_0)) {
    return;
  }

  switch (var_0) {
    case "camo84":
      self notify("blood_camo_84");
      break;
  }
}

function ref_12a41() {
  scripts\mp\flags::gameflagwait("prematch_done");

  foreach(var_1 in level.players) {
    if(isDefined(var_1) && isDefined(var_1.ref_12a44)) {
      var_1.ref_12a44 = undefined;
      var_1 notify("endReactiveCamoThread");
    }
  }
}

function ref_12a42(var_0, var_1, var_2) {
  var_0.ref_13765 = var_1;

  if(var_2 == 1) {
    self setscriptablepartstate("activeCamo", "stage" + var_0.ref_13765);
    return;
  }

  self setscriptablepartstate("activeCamo", "init_stage" + var_0.ref_13765);
}

function ref_12a43(var_0) {
  if(!isDefined(self.ref_12a44)) {
    self.ref_12a44 = [];
  }

  if(!isDefined(self.ref_12a44[var_0])) {
    self.ref_12a44[var_0] = spawnStruct();
    self.ref_12a44[var_0].kills = 0;
    self.ref_12a44[var_0].ref_13765 = 0;
    return;
  }
}

function ref_12a3e(var_0) {
  self endon("disconnect");
  self endon("death");
  self endon("endReactiveCamoThread");

  if(!isDefined(level.ref_12a40) && !scripts\mp\flags::gameflag("prematch_done")) {
    level.ref_12a40 = 1;
    thread ref_12a41();
  }

  var_1 = ref_14585(var_0);
  ref_12a43(var_1);
  var_2 = self.ref_12a44[var_1];
  ref_12a42(var_2, var_2.ref_13765, 0);
  var_3 = tablelookuprownum("reactive_camos.csv", 0, var_1);
  var_4 = int(tablelookupbyrow("reactive_camos.csv", var_3, 1));
  var_5 = strtok(tablelookupbyrow("reactive_camos.csv", var_3, 2), "|");

  while(var_2.ref_13765 < var_4) {
    scripts\engine\utility::waittill_either("got_a_kill", "scr_advancereactivecamo");
    var_6 = int(var_5[var_2.ref_13765 + 1]);
    var_2.kills++;

    if(var_2.kills >= var_6) {
      ref_12a42(var_2, var_2.ref_13765 + 1, 1);

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

function ref_14585(var_0) {
  return var_0.basename + "_v" + var_0.variantid;
}

function ref_1458a(var_0) {
  if(!isDefined(var_0) || !isDefined(var_0.variantid)) {
    return false;
  }

  var_1 = ref_14585(var_0);
  var_2 = tablelookuprownum("reactive_camos.csv", 0, var_1);

  if(isDefined(var_2) && var_2 >= 0) {
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

function doesshareammo(var_0) {
  return var_0.isalternate && !issubstr(var_0.underbarrel, "gl") && issubstr(var_0.underbarrel, "shotgun");
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
    var_0.ticks = scripts\mp\utility\script::roundup(4 * var_2);
  }

  var_4 = scripts\mp\equipment::getequipmentreffromweapon(var_1);

  if(isDefined(var_4)) {
    var_0.equipmentref = var_4;
    var_0.isequipment = 1;

    if(var_4 == "equip_smoke") {
      var_0.owner scripts\mp\utility\stats::incpersstat("smokesUsed", 1);
    }
  }

  var_0.threwback = isDefined(var_3);
}

function waittill_missile_fire() {
  self waittill("missile_fire", var_0, var_1);

  if(isDefined(var_0)) {
    if(!isDefined(var_0.weapon_name)) {
      if(var_1.isalternate) {
        var_0.weapon_name = scripts\mp\utility\weapon::getaltmodeweapon(var_1);
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

function update_jugg_targets(var_0) {
  if(var_0.basename == "iw8_ar_akilo47_mpdmb2" || var_0.basename == "iw8_sm_mpapa7_mpmtx3") {
    return true;
  }

  return false;
}

function update_icon_for_bomb_case_detonator_holder(var_0) {
  if(var_0.basename == "iw8_ar_anovember94_mpmtx2" || var_0.basename == "iw8_sm_papa90_mpmtx3") {
    return true;
  }

  if(isDefined(var_0.reargrip) && var_0.reargrip == "sword_8bit") {
    return true;
  }

  return false;
}

function ref_11df6(var_0) {
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
  var_0 hide();
}

function ref_11df5(var_0) {
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
  var_0 hide();
}

function ref_12734(var_0, var_1) {
  var_2 = self gettagorigin(var_0);
  var_3 = self gettagangles(var_0);
  playFX(level._effect[var_1], var_2, anglesToForward(var_3), anglestoup(var_3));
}

function enableburnfx(var_0, var_1) {
  if(!isDefined(self.flare_thread)) {
    self.flare_thread = [];
  }

  if(!isDefined(var_1)) {
    var_1 = "active";
  }

  if(!istrue(var_0)) {
    thread enableburnsfx();
  }

  self.flare_thread[release_mortar_operator(var_1)] = var_1;
  thread startburnfx();
}

function release_mortar_operator(var_0) {
  switch (var_0) {
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

function remove_invulnerability(var_0) {
  var_1 = 3;
  var_2 = undefined;

  while(var_1 >= 0) {
    if(isDefined(var_0[var_1])) {
      var_2 = var_0[var_1];
      break;
    }

    var_1--;
  }

  return var_2;
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

function flares_from_structs(var_0) {
  self endon("burnSFX_deleted");
  self waittill("disconnect");

  if(isDefined(var_0)) {
    var_0 stoploopsound("weap_molotov_fire_enemy_burn");
    var_0 delete();
    return;
  }
}

function enableburnfxfortime(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = "active";
  }

  var_2 = "endon_burnfxForTime_" + var_1;
  self notify(var_2);
  self endon("disconnect");
  self endon("clearBurnFX");
  self endon(var_2);
  thread enableburnfx(0, var_1);
  wait var_0;
  thread disableburnfx(0, var_1);
}

function disableburnfx(var_0, var_1) {
  if(isDefined(var_1)) {
    if(self.flare_thread[release_mortar_operator(var_1)] == var_1) {
      self.flare_thread[release_mortar_operator(var_1)] = undefined;
    }
  } else {
    self.flare_thread = [];
  }

  if(self.flare_thread.size > 0) {
    thread startburnfx();
    return;
  }

  thread stopburnfx();

  if(!istrue(var_0)) {
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

function supressburnfx(var_0) {
  if(!isDefined(self.burnfxsuppressed)) {
    self.burnfxsupressed = 0;
  }

  if(var_0) {
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
  var_0 = remove_invulnerability(self.flare_thread);

  for(;;) {
    var_1 = isDefined(self.burnfxsuppressed) && self.burnfxsuppressed > 0;
    var_2 = isDefined(self.burnfxplaying);

    if(var_1 && var_2) {
      self setscriptablepartstate("burning", "neutral");
      scripts\mp\damage::dequeuecorpsetablefunc("burning");
      self.burnfxplaying = undefined;
    } else if(!var_1 && !var_2 || var_0 != self.burnfxplaying) {
      self setscriptablepartstate("burning", var_0);
      self.burnfxplaying = var_0;

      if(!var_2) {
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

function burnfxcorpstablefunc(var_0) {
  var_0 setscriptablepartstate("burning", "flareUp", 0);
}

function ref_13018(var_0) {
  self endon("disconnect");
  var_0 endon("death");
  var_0 waittill("missile_stuck", var_1);

  if(isPlayer(var_1)) {
    thread grenadestuckto(var_0, var_1);

    if(isalive(var_1)) {
      thread ref_13016(var_0, var_1);
      return;
    }

    return;
  }
}

function ref_13016(var_0, var_1) {
  self endon("disconnect");
  var_0 endon("end_explode");
  var_1 endon("death_or_disconnect");
  var_0 thread scripts\mp\utility\script::notifyafterframeend("death", "end_explode");
  var_0 waittill("explode", var_2);
  thread ref_13017(var_1, var_2);
}

function ref_13017(var_0, var_1) {
  var_2 = distancesquared(var_1, var_0.origin);
  var_3 = 5000;

  if(var_2 > var_3) {
    return;
  }

  var_0 scripts\cp_mp\utility\damage_utility::playerplunderbankcallback();
  var_0 dodamage(var_0.maxhealth, var_1, self, undefined, "MOD_EXPLOSIVE", getcompleteweaponname("semtex_mp"));
  var_0 scripts\cp_mp\utility\damage_utility::playerplunderbankdeposit();
}