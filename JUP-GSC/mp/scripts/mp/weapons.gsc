/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\weapons.gsc
***********************************************/

#using script_13865ca76df87ea;
#using script_15eddb0fac236a22;
#using script_202d9f0ea7db3a23;
#using script_2d9d24f7c63ac143;
#using script_32c2f4a699e57e1e;
#using script_4a6760982b403bad;
#using script_528b573c2e6fc70a;
#using script_681c3db54537afa6;
#using script_cbb0697de4c5728;
#using scripts\common\ai;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\cp_mp\challenges;
#using scripts\cp_mp\crossbow;
#using scripts\cp_mp\damagefeedback;
#using scripts\cp_mp\dragonsbreath;
#using scripts\cp_mp\emp_debuff;
#using scripts\cp_mp\ent_manager;
#using scripts\cp_mp\equipment\breacher_drone;
#using scripts\cp_mp\equipment\geiger_counter;
#using scripts\cp_mp\equipment\thermal_phone;
#using scripts\cp_mp\equipment\throwing_knife;
#using scripts\cp_mp\equipment\throwstar;
#using scripts\cp_mp\gestures;
#using scripts\cp_mp\killstreaks\airdrop_escort;
#using scripts\cp_mp\killstreaks\chopper_gunner;
#using scripts\cp_mp\killstreaks\gunship;
#using scripts\cp_mp\killstreaks\hover_jet;
#using scripts\cp_mp\talking_gun;
#using scripts\cp_mp\utility\callback_group;
#using scripts\cp_mp\utility\damage_utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\cp_mp\utility\killstreak_utility;
#using scripts\cp_mp\utility\loot;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\utility\shellshock_utility;
#using scripts\cp_mp\utility\train_utility;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\vehicles\vehicle_occupancy;
#using scripts\cp_mp\vehicles\vehicle_tracking;
#using scripts\cp_mp\weapon;
#using scripts\cp_mp\xmike109;
#using scripts\engine\throttle;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\battlechatter_mp;
#using scripts\mp\class;
#using scripts\mp\codcasterclientmatchdata;
#using scripts\mp\damage;
#using scripts\mp\equipment;
#using scripts\mp\equipment\advanced_supply_drop;
#using scripts\mp\equipment\at_mine;
#using scripts\mp\equipment\battlerage;
#using scripts\mp\equipment\binoculars;
#using scripts\mp\equipment\bunkerbuster;
#using scripts\mp\equipment\butterfly_mine;
#using scripts\mp\equipment\c4;
#using scripts\mp\equipment\claymore;
#using scripts\mp\equipment\combataxe;
#using scripts\mp\equipment\concussion_grenade;
#using scripts\mp\equipment\decoy_grenade;
#using scripts\mp\equipment\deployed_decoy;
#using scripts\mp\equipment\gas_grenade;
#using scripts\mp\equipment\ied;
#using scripts\mp\equipment\iodine_pills;
#using scripts\mp\equipment\molotov;
#using scripts\mp\equipment\proximity_alarm;
#using scripts\mp\equipment\shock_stick;
#using scripts\mp\equipment\smoke_grenade;
#using scripts\mp\equipment\snapshot_grenade;
#using scripts\mp\equipment\sonar_pulse;
#using scripts\mp\equipment\sound_veil;
#using scripts\mp\equipment\spycam;
#using scripts\mp\equipment\support_box;
#using scripts\mp\equipment\tac_insert;
#using scripts\mp\equipment\tactical_camera;
#using scripts\mp\equipment\tactical_cover;
#using scripts\mp\equipment\thermite;
#using scripts\mp\equipment\tracker_grenade;
#using scripts\mp\equipment\trophy_system;
#using scripts\mp\equipment\weapon_drop;
#using scripts\mp\equipment\wristrocket;
#using scripts\mp\events;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\gameobjects;
#using scripts\mp\gamescore;
#using scripts\mp\gametypes\br_pickups;
#using scripts\mp\gametypes\infect;
#using scripts\mp\gametypes\war;
#using scripts\mp\hostmigration;
#using scripts\mp\hud_message;
#using scripts\mp\javelin;
#using scripts\mp\killstreaks\juggernaut_mp;
#using scripts\mp\killstreaks\killstreaks;
#using scripts\mp\killstreaks\remotetank;
#using scripts\mp\missilelauncher;
#using scripts\mp\movers;
#using scripts\mp\perks\perkfunctions;
#using scripts\mp\perks\perks;
#using scripts\mp\perks\weaponpassives;
#using scripts\mp\persistence;
#using scripts\mp\playerstats_interface;
#using scripts\mp\pmc_missions;
#using scripts\mp\potg_events;
#using scripts\mp\sentientpoolmanager;
#using scripts\mp\shellshock;
#using scripts\mp\supers;
#using scripts\mp\supers\blindingturret;
#using scripts\mp\supers\gas_trap;
#using scripts\mp\supers\loadout_drop;
#using scripts\mp\supers\spawnbeacon;
#using scripts\mp\supers\vehicle_drop;
#using scripts\mp\utility\damage;
#using scripts\mp\utility\debug;
#using scripts\mp\utility\dialog;
#using scripts\mp\utility\dvars;
#using scripts\mp\utility\entity;
#using scripts\mp\utility\game;
#using scripts\mp\utility\killstreak;
#using scripts\mp\utility\outline;
#using scripts\mp\utility\perk;
#using scripts\mp\utility\player;
#using scripts\mp\utility\points;
#using scripts\mp\utility\print;
#using scripts\mp\utility\script;
#using scripts\mp\utility\spawn_event_aggregator;
#using scripts\mp\utility\stats;
#using scripts\mp\utility\usability;
#using scripts\mp\utility\weapon;
#using scripts\mp\weapons;
#namespace weapons;

function attachmentgroup(attachmentname) {
  return tablelookup("mp/attachmenttable.csv", 4, attachmentname, 2);
}

function init() {
  level.var_b2b35840c12ce55c = utility::default_to(level.var_b2b35840c12ce55c, []);
  level.scavenger_altmode = 1;
  level.scavenger_secondary = 1;
  level.maxperplayerexplosives = max(dvars::getintproperty(@ "hash_b62eac49cca8c84b", 2), 1);
  level.riotshieldxpbullets = dvars::getintproperty(@ "hash_ecd162ffa953cac1", 15);
  level.var_34777cc7c85edbe6 = getdvarint(@ "hash_17eb9db052738f30", 96);

  switch (dvars::getintproperty(@ "hash_efe12003ddfaa46e", 0)) {
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

  weapon::function_5238382582ce39fa();
  level._effect["emp_stun"] = loadfx("vfx/core/mp/equipment/vfx_emp_grenade");
  level._effect["equipment_explode"] = loadfx("vfx/iw7/_requests/mp/vfx_generic_equipment_exp.vfx");
  level._effect["equipment_smoke"] = loadfx("vfx/core/mp/killstreaks/vfx_sg_damage_blacksmoke");
  level._effect["equipment_sparks"] = loadfx("vfx/core/mp/killstreaks/vfx_sentry_gun_explosion");
  level._effect["glsmoke"] = loadfx("vfx/iw8_mp/equipment/smoke_grenade/vfx_smoke_gren_ch");
  level._effect["xmike109ThermiteBounce"] = loadfx("vfx/iw8_mp/equipment/vfx_xmike109_thermite_bounce");
  level._effect["penetration_railgun_impact"] = loadfx("vfx/iw7/_requests/mp/vfx_penetration_railgun_impact.vfx");
  level._effect["sentry_gun_stun_fx"] = loadfx("vfx/jup/ob/gameplay/zm/vfx_sentry_emp_disable.vfx");
  level._effect["vfx_snap_gren_pulse"] = loadfx("vfx/core/equipment/vfx_snap_gren_pulse.vfx");
  entity::placeequipmentfailedinit();
  level.weaponconfigs = [];

  if(!isDefined(level.weapondropfunction)) {
    level.weapondropfunction = &dropweaponfordeath;
  }

  var_7522d80d673f6f7 = 25;
  level.sticky_minedetectiondot = cos(var_7522d80d673f6f7);
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
  spawn_event_aggregator::registeronplayerspawncallback(&onplayerspawned);
  level thread onplayerconnect();
  outline::initoutlineoccluders();
  init_function_refs();
  level.onweapondropcreated = callback_group::callback_create();
  level.onweapondroppickedup = callback_group::callback_create();
  level.var_30b163d5fb8dc7d9 = scripts\engine\throttle::throttle_initialize("DroneLauncher", 10, level.framedurationseconds, 50);
  level.weaponnone = makeweapon("none");

  if(getdvarint(@ "hash_eb1e94069d5150f2") == 1) {
    level thread savegraverobberammo();
  }

  registersharedfunc("weapons", "recommendedStatusBySeason", &recommendedstatusbyseason);
  registersharedfunc("weapons", "snapshot_bolt_detect", &scripts\mp\equipment\snapshot_grenade::snapshot_grenade_detect);

  setdevdvar(@ "hash_10368af4dee3ba2c", 0);
  setdevdvarifuninitialized(@ "hash_eb7d16d9fa10a208", 625000000);
}

function savegraverobberammo() {
  while(true) {
    if(isDefined(level.players)) {
      foreach(player in level.players) {
        if(!isDefined(player)) {
          continue;
        }

        if(player perk::_hasperk("specialty_scrap_weapons")) {
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

function enablevisibilitycullingforclient(client) {
  self hudoutlinedisableforclient(client);
}

function onplayerconnect() {
  for(;;) {
    level waittill("connected", player);
    player.hits = [];
    player.agenthits = [];
    player.playerhits = [];
    gamelogic::sethasdonecombat(player, 0);
    player thread watchmissileusage();
    player thread function_6989a64fc49d022();

    if(getdvarint(@ "hash_7a52196ce3c53c73", 0) && game_utility::function_2d79a7a3b91c4c3e()) {
      player thread function_627adf66cf046c65();
    }
  }
}

function function_627adf66cf046c65() {
  self endon("disconnect");
  logstring("watch_mobile_cheat_loadouts finished setup.");

  while(true) {
    self waittill("luinotifyserver", message, var_2150015540242e9e);

    if(message == "mobile_debug_give_killstreak") {
      killstreakref = undefined;

      switch (var_2150015540242e9e) {
        case 0:
          killstreakref = "toma_strike";
          break;
        case 1:
          killstreakref = "precision_airstrike";
          break;
        case 2:
          killstreakref = "uav";
          break;
        case 4:
          killstreakref = "scrambler_drone_guard";
          break;
        case 5:
          killstreakref = "directional_uav";
          break;
        case 6:
          killstreakref = "assault_drone";
          break;
        case 7:
          killstreakref = "airdrop";
          break;
        case 8:
          killstreakref = "fuel_airstrike";
          break;
        case 9:
          killstreakref = "hover_jet";
          break;
        case 10:
          killstreakref = "airdrop_escort";
          break;
        case 11:
          killstreakref = "auto_drone";
          break;
        case 12:
          killstreakref = "chopper_gunner";
          break;
        case 13:
          killstreakref = "airdrop_multiple";
          break;
        case 14:
          killstreakref = "gunship";
          break;
        case 15:
          killstreakref = "juggernaut";
          break;
        case 16:
          killstreakref = "cruise_predator";
          break;
        case 17:
          killstreakref = "sentry_gun";
          break;
        case 18:
          killstreakref = "pac_sentry";
          break;
      }

      if(isDefined(killstreakref)) {
        killstreaks::awardkillstreak(killstreakref, "other");
      }

      continue;
    }

    if(message == "mobile_debug_give_fieldupgrade") {
      var_d782e69ca6374ba6 = undefined;

      switch (var_2150015540242e9e) {
        case 0:
          var_d782e69ca6374ba6 = "super_tac_cover";
          break;
        case 1:
          var_d782e69ca6374ba6 = "super_trophy";
          break;
        case 2:
          var_d782e69ca6374ba6 = "super_deadsilence";
          break;
        case 3:
          var_d782e69ca6374ba6 = "super_support_box";
          break;
        case 4:
          var_d782e69ca6374ba6 = "super_ammo_drop";
          break;
        case 5:
          var_d782e69ca6374ba6 = "super_armor_drop";
          break;
        case 6:
          var_d782e69ca6374ba6 = "super_battlerage";
          break;
      }

      if(isDefined(var_d782e69ca6374ba6)) {
        supers::givesuper(var_d782e69ca6374ba6, 0, 1);
      }

      continue;
    }

    if(message == "mobile_debug_give_equipment") {
      equipmentref = undefined;

      switch (var_2150015540242e9e) {
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
        slot = equipment::getdefaultslot(equipmentref);
        equipment::giveequipment(equipmentref, slot);
      }
    }
  }
}

function watchchangeweapon() {
  self endon("death_or_disconnect");
  self endon("joined_spectators");
  self endon("faux_spawn");
  level endon("game_ended");
  var_8d9fb0db0c319184 = spawnStruct();

  for(lastweapon = undefined; true; lastweapon = objweapon) {
    objweapon = self getcurrentweapon();

    if(isDefined(objweapon)) {
      dochangeweapon(objweapon);
      var_8d9fb0db0c319184.lastweapon = lastweapon;
      var_8d9fb0db0c319184.weapon = objweapon;
      callback::callback("player_weapon_change", var_8d9fb0db0c319184);
    }

    self waittill("weapon_change");

    if(getdvarint(@ "hash_4b664c074a868ac5", 0) && isminigunweapon(self getcurrentweapon()) && !isjuggernaut()) {
      if(isDefined(self getcurrentweapon()) && self getcurrentweapon() hasattachment("ammo_762n_vortex")) {
        thread namespace_dfe80adf32f5c14a::function_eead174f423bccd();
        self.var_ba741e9ed3e80f03 = 1;
      }
    } else if(getdvarint(@ "hash_cdc976b132fb2d84", 0)) {
      currentweapon = self getcurrentweapon();

      if(currentweapon.basename == "jup_jp31_dm_compound_mp") {
        thread function_130230f6bb9e9666();
      }
    } else if(istrue(self.var_ba741e9ed3e80f03)) {
      self notify("end_minigun_heal");
      self.var_ba741e9ed3e80f03 = 0;
    }

    currentweapon = self getcurrentweapon();

    if(isDefined(currentweapon) && currentweapon.basename == "jup_jp23_me_spear_mp") {
      thread function_450edf11cb278f66();
    }
  }
}

function dochangeweapon(objweapon) {
  logchangeweapon(objweapon);
  updateweaponspeed(objweapon);
  function_c49a0d832ace8e5e();
  updatelastweaponobj(objweapon);
  savealtstates();
  updatelauncherusage();
  updateweaponperks();
  updatesniperglint(objweapon);
  namespace_e2785bb1da360f91::function_b939bc4f3a6d4fdc(objweapon);
  scriptedmountdisable(objweapon);
  perkfunctions::updatedefaultflinchreduction();
  events::updateweaponchangetime();
  class::riotshieldonweaponchange(objweapon);
  perkfunctions::updateweaponkick();
  thread gestures::tryreenablescriptablevfx();
  function_82a0e6138ba06718(objweapon);
}

function scriptedmountdisable(objweapon) {
  if(istrue(level.disablemount)) {
    return;
  }

  if(function_dd461671d4007c1f(objweapon)) {
    val::set("scriptedMountDisable", "mount_top", 0);
    val::set("scriptedMountDisable", "mount_side", 0);
    thread function_5845dd5192f930b7();
  }
}

function function_5845dd5192f930b7() {
  self endon("disconnect");
  utility::waittill_any_2("death", "weapon_change");
  val::reset_all("scriptedMountDisable");
}

function function_dd461671d4007c1f(objweapon) {
  rootname = weapon::getweaponrootname(objweapon);

  if(rootname == "iw8_lm_sierrax" && objweapon hasattachment("stocksaw_sierrax")) {
    return true;
  }

  return false;
}

function logchangeweapon(objweapon) {
  if(!istrue(self.canlogchangeweapon)) {
    self.canlogchangeweapon = 1;
    return;
  }

  currentweaponname = objweapon.basename;
  secondaryweaponname = "none";

  if(!isDefined(currentweaponname) || currentweaponname == "none") {
    return;
  }

  if(isDefined(self.lastweaponobj) && objweapon == self.lastweaponobj) {
    return;
  }

  if(self.equippedweapons.size > 1) {
    secondaryweaponname = self.equippedweapons[1].basename;

    if(secondaryweaponname == currentweaponname) {
      secondaryweaponname = self.equippedweapons[0].basename;
    }
  }

  if(isDefined(self.primaryweaponobj)) {
    self setclientweaponinfo(0, getcompleteweaponname(self.primaryweaponobj));
  }

  if(isDefined(self.secondaryweaponobj)) {
    self setclientweaponinfo(1, getcompleteweaponname(self.secondaryweaponobj));
  }

  if(getdvarint(@ "hash_4b12bceaccf1e3bb", 0) == 1) {
    self dlog_recordplayerevent("dlog_event_weapon_change", ["current_weapon", currentweaponname, "secondary_weapon", secondaryweaponname]);
  }
}

function updateweaponperks() {
  self.prevweaponobj = doweaponperkupdate(self.prevweaponobj);
}

function updatesniperglint(objweapon) {
  if(sniperglint_supported(objweapon)) {
    childthread sniperglint_manage(objweapon);
  }
}

function function_daef03172b217e78(objweapon) {
  if(true) {
    usefirst = function_b3e5f50a0d4a9c86(objweapon);
    function_a7adacdb4c7641c9(usefirst);
  }
}

function updatelauncherusage() {
  weapon = self getcurrentweapon();
  var_21c8aabcb09f7094 = isDefined(game["inLiveLobby"]);

  if(!var_21c8aabcb09f7094 && !flags::gameflag("prematch_done") && weapon_utility::islockonlauncher(weapon)) {
    val::set("prematch", "ads", 0);
  }

  rootname = weapon::getweaponrootname(weapon.basename);

  switch (rootname) {
    default:
      break;
    case #"hash_1f15297cd7a481c1":
    case #"hash_326dc2026394652a":
      thread missilelauncher::initmissilelauncherusage();
      break;
    case #"hash_60bbbd68c3990680":
      thread javelin::javelin_reset();
      break;
    case #"hash_40af6e6a958292d9":
    case #"hash_8d9ae5e5dd390b4b":
      thread crossbow::initcrossbowusage();
      break;
    case #"hash_d2b54efbd2b4a293":
      thread namespace_4d6911a5d970ff49::initcrossbowusage();
      break;
  }

  self notify("end_launcher");

  if(perk::_hasperk("specialty_fastreload_launchers")) {
    islauncher = weaponclass(weapon.basename) == "rocketlauncher" || weapon.basename == "iw8_la_kgolf_mp";

    if(islauncher && !istrue(self.fastreloadlaunchers)) {
      perk::giveperk("specialty_fastreload");
      self.fastreloadlaunchers = 1;
    } else if(istrue(self.fastreloadlaunchers)) {
      perk::removeperk("specialty_fastreload");
      self.fastreloadlaunchers = undefined;
    }
  }

  switch (weapon.basename) {
    default:
      break;
    case #"hash_13a265ac820ea0df":
    case #"hash_3e782fd775b72022":
    case #"hash_a9e31b8ffd42a67b":
      thread missilelauncher::missilelauncherusageloop();
      break;
    case #"hash_5c272c0617caebf0":
    case #"hash_5cbb3a1a84d47f1d":
      thread javelin::javelinusageloop();
      break;
    case #"hash_59f63acb4f4ad607":
    case #"hash_87262a67e163f7c9":
    case #"hash_9a855bc1e9e860f6":
      thread crossbow::crossbowusageloop(weapon);
      break;
    case #"hash_377cd64db0638901":
      thread namespace_4d6911a5d970ff49::crossbowusageloop(weapon);
      break;
    case #"hash_78063db94e7df144":
      thread xmike109::usageloop(weapon);
      break;
  }
}

function setlastdroppableweaponobj(weaponobj) {
  self.lastdroppableweaponobj = weaponobj;

  if(isDefined(level.lastdroppableweaponchanged)) {
    self[[level.lastdroppableweaponchanged]]();
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

  if(weapon::iscacprimaryorsecondary(objnewweapon)) {
    self.lastcacweaponobj = objnewweapon;
  }
}

function updateweaponspeed(objnewweapon) {
  function_9085d7f0321ea2a4(objnewweapon);

  if(objnewweapon.basename == "none") {
    return;
  } else if(weapon::issuperweapon(objnewweapon.basename)) {
    updatemovespeedscale();
    return;
  } else if(weapon::iskillstreakweapon(objnewweapon.basename)) {
    updatemovespeedscale();
    return;
  } else if(objnewweapon.basename == "iw9_me_fists_mp_ls") {
    updatemovespeedscale();
    return;
  } else if(objnewweapon.inventorytype != "primary" && objnewweapon.inventorytype != "altmode") {
    return;
  }

  updatemovespeedscale();
}

function function_9085d7f0321ea2a4(objweapon) {
  var_de17420c437b06b3 = 1;

  if(weapon_utility::isriotshield(objweapon.basename)) {
    var_de17420c437b06b3 = 0;
  }

  val::set("weaponJogState", "jog", var_de17420c437b06b3);
}

function function_c49a0d832ace8e5e() {
  if(isDefined(self.lastweaponobj)) {
    weaponname = self.lastweaponobj.basename;
    strstart = getsubstr(weaponname, 0, 3);

    if(strstart == "iw8" || strstart == "s4_") {
      weaponname = weapon::getweaponrootname(self.lastweaponobj);
    }

    currenttime = namespace_c45ac99c4997e722::function_1b15450e092933cf(gettime()) / 1000;
    initpersstat("currentWeaponStartTime");
    totaltime = currenttime - scripts\mp\utility\stats::getpersstat("currentWeaponStartTime");
    var_7e2c53b0bcf117d9 = spawnStruct();
    var_7e2c53b0bcf117d9.weaponname = weaponname;
    var_7e2c53b0bcf117d9.fullweaponname = getcompleteweaponname(self.lastweaponobj);
    var_7e2c53b0bcf117d9.statname = "timeUsed";
    var_7e2c53b0bcf117d9.incvalue = totaltime;
    var_7e2c53b0bcf117d9.variantid = getweaponvariantindex(self.lastweaponobj);
    var_7e2c53b0bcf117d9.weaponobj = self.lastweaponobj;
    namespace_c45ac99c4997e722::function_80820d6d364c1836("callback_update_weapon_stats", var_7e2c53b0bcf117d9);
    self.pers["currentWeaponStartTime"] = currenttime;
  }
}

function onplayerspawned() {
  gamelogic::sethasdonecombat(self, 0);

  if(!isDefined(self.trackingweapon)) {
    persistence::persclear_stats();
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

  if(game_utility::onlinestatsenabled()) {
    thread watchfornearmisswhizby();
  }

  if(!game_utility::runleanthreadmode()) {
    thread watchdropweapons();
  }

  self.lasthittime = [];
  self.droppeddeathweapon = undefined;
  self.tookweaponfrom = [];
  self.lastnormalweaponobj = utility::ter_op(isDefined(self.spawnweaponobj), self.spawnweaponobj, nullweapon());
  self.lastweaponobj = utility::ter_op(isDefined(self.spawnweaponobj), self.spawnweaponobj, nullweapon());
  self.lastcacweaponobj = utility::ter_op(isDefined(self.spawnweaponobj) && weapon::iscacprimaryorsecondary(self.spawnweaponobj), self.spawnweaponobj, nullweapon());
  setlastdroppableweaponobj(utility::ter_op(isDefined(self.spawnweaponobj), self.spawnweaponobj, nullweapon()));
  gamescore::initassisttrackers();
  currentcamo = getweaponcamoname(self getcurrentweapon());
  thread runcamoscripts(currentcamo);
  self.var_85dc59c6a906819f = undefined;
}

function savealtstates() {
  self.pers["altStates"] = [];
  weapons = self.primaryinventory;

  foreach(objweapon in weapons) {
    if(!isundefinedweapon(self.primaryweaponobj) && objweapon == self.primaryweaponobj || !isundefinedweapon(self.secondaryweaponobj) && objweapon == self.secondaryweaponobj) {
      if(shouldweaponsavealtstate(objweapon) && self isalternatemode(objweapon, 1)) {
        var_366b0ecc2f28aead = weapon::getcompleteweaponnamenoalt(objweapon);
        self.pers["altStates"][var_366b0ecc2f28aead] = 1;
      }
    }
  }
}

function savetogglescopestates() {
  self.pers["toggleScopeStates"] = [];
  self.pers["tacticalADSStates"] = [];
  weapons = self.primaryinventory;

  foreach(objweapon in weapons) {
    if(!isundefinedweapon(self.primaryweaponobj) && objweapon == self.primaryweaponobj || !isundefinedweapon(self.secondaryweaponobj) && objweapon == self.secondaryweaponobj) {
      var_366b0ecc2f28aead = undefined;

      if(isDefined(objweapon.scope) && istogglescope(objweapon, objweapon.scope)) {
        var_366b0ecc2f28aead = weapon::getcompleteweaponnamenoalt(objweapon);
        self.pers["toggleScopeStates"][var_366b0ecc2f28aead] = self gethybridscopestate(objweapon);
      }

      if(self function_f033d1a86348766a(objweapon)) {
        if(!isDefined(var_366b0ecc2f28aead)) {
          var_366b0ecc2f28aead = weapon::getcompleteweaponnamenoalt(objweapon);
        }

        self.pers["tacticalADSStates"][var_366b0ecc2f28aead] = self function_c603bed3b1c8d11(objweapon, 1);

        if(!isalive(self) && self function_ad155da412bac439()) {
          if(self.pers["tacticalADSStates"][var_366b0ecc2f28aead] != 0) {
            self function_9378bae9f62493fe();
            self.pers["tacticalADSStates"][var_366b0ecc2f28aead] = 0;
          }
        }
      }
    }
  }
}

function updatetogglescopestate(objweapon) {
  var_366b0ecc2f28aead = weapon::getcompleteweaponnamenoalt(objweapon);

  if(isDefined(scripts\mp\utility\stats::getpersstat("toggleScopeStates")) && isDefined(scripts\mp\utility\stats::getpersstat("toggleScopeStates")[var_366b0ecc2f28aead])) {
    self sethybridscopestate(objweapon, scripts\mp\utility\stats::getpersstat("toggleScopeStates")[var_366b0ecc2f28aead]);
  } else if(function_dab7bc436f0b0bde(objweapon)) {
    self sethybridscopestate(objweapon, 1);
  }

  if(isDefined(scripts\mp\utility\stats::getpersstat("tacticalADSStates")) && isDefined(scripts\mp\utility\stats::getpersstat("tacticalADSStates")[var_366b0ecc2f28aead]) && self function_f033d1a86348766a(objweapon)) {
    self function_ed96bc79d7607d3d(objweapon, scripts\mp\utility\stats::getpersstat("tacticalADSStates")[var_366b0ecc2f28aead]);
  }
}

function function_dab7bc436f0b0bde(objweapon) {
  if(isDefined(objweapon.scope) && (objweapon.scope == "hybrid03" || objweapon.scope == "hybridtherm01" || objweapon.scope == "hybridrange01")) {
    return true;
  }

  return false;
}

function updatesavedaltstate(objweapon) {
  assertex(!objweapon.isalternate, "<dev string:x1c>");

  if(isDefined(self.pers["altStates"]) && istrue(objweapon.hasalternate)) {
    var_366b0ecc2f28aead = weapon::getcompleteweaponnamenoalt(objweapon);

    if(isDefined(self.pers["altStates"][var_366b0ecc2f28aead]) && self.pers["altStates"][var_366b0ecc2f28aead]) {
      objweapon = objweapon getaltweapon();
    }
  }

  return objweapon;
}

function istogglescope(weapon, attachment) {
  if(!isDefined(attachment)) {
    return false;
  }

  basetype = function_7c612ac92ba98dcb(weapon, attachment);
  return basetype == "hybrid";
}

function shouldweaponsavealtstate(objweapon) {
  if(istrue(objweapon.hasalternate) && !isaxeweapon(objweapon)) {
    if(shouldattachmentsavealtstate(objweapon, objweapon.underbarrel)) {
      return true;
    }
  }

  return false;
}

function shouldattachmentsavealtstate(objweapon, attachunique) {
  return isattachmentselectfire(objweapon, attachunique);
}

function isattachmentselectfire(weapon, attachment) {
  basetype = function_7c612ac92ba98dcb(weapon, attachment);
  return basetype == "selectfire";
}

function isattachmentgrenadelauncher(attachunique) {
  return false;
}

function weaponperkupdate(currweaponobj, prevweaponobj) {
  if(!isundefinedweapon(prevweaponobj)) {
    var_9586602ebc60b765 = weapon::getweaponrootname(prevweaponobj.basename);
    perkremove = weapon::weaponperkmap(var_9586602ebc60b765);

    if(isDefined(perkremove)) {
      function_ec132c173d4532ee(perkremove);
    }
  }

  if(!isundefinedweapon(currweaponobj)) {
    var_98efd9d21da41d1a = weapon::getweaponrootname(currweaponobj.basename);
    perkadd = weapon::weaponperkmap(var_98efd9d21da41d1a);

    if(isDefined(perkadd)) {
      weapon_giveperk(perkadd);
    }
  }
}

function weaponattachmentperkupdate(currweaponobj, prevweaponobj) {
  newattachments = undefined;
  oldattachments = undefined;

  if(!isundefinedweapon(prevweaponobj)) {
    oldattachments = getweaponattachments(prevweaponobj);

    if(isDefined(oldattachments) && oldattachments.size > 0) {
      foreach(oldattach in oldattachments) {
        perks = weapon::attachmentperkmap(prevweaponobj, oldattach);

        if(!isDefined(perks)) {
          continue;
        }

        foreach(perk in perks) {
          function_ec132c173d4532ee(perk);
        }
      }
    }
  }

  if(!isundefinedweapon(currweaponobj)) {
    newattachments = getweaponattachments(currweaponobj);

    if(isDefined(newattachments) && newattachments.size > 0) {
      foreach(newattach in newattachments) {
        perks = weapon::attachmentperkmap(currweaponobj, newattach);

        if(!isDefined(perks)) {
          continue;
        }

        foreach(perk in perks) {
          weapon_giveperk(perk);
        }
      }
    }
  }
}

function doweaponperkupdate(prevweaponobj) {
  currweaponobj = self getcurrentweapon();
  weaponattachmentperkupdate(currweaponobj, prevweaponobj);
  weaponperkupdate(currweaponobj, prevweaponobj);
  return currweaponobj;
}

function watchweaponperkupdates() {
  self endon("death_or_disconnect");
  self endon("faux_spawn");
  self endon("giveLoadout_start");
  prevweaponobj = undefined;

  while(true) {
    prevweaponobj = doweaponperkupdate(prevweaponobj);
    self waittill("weapon_change");
  }
}

function function_a7adacdb4c7641c9(usefirstperson) {
  if(usefirstperson) {
    self function_5762cf97c6f1a2c1("first_person");
    return;
  }

  self function_5762cf97c6f1a2c1("third_person");
}

function sniperglint_supported(weapon) {
  if(isnullweapon(weapon) || !isDefined(weapon.scope) || weaponclass(weapon) == "rocketlauncher") {
    return 0;
  }

  class = weaponclass(weapon);

  if(self isalternatemode(weapon) && (class == "grenade" || class == "spread")) {
    return 0;
  }

  return function_cb81eb90ddc79ab7();
}

function function_cb81eb90ddc79ab7() {
  if(perk::_hasperk("specialty_glintxsml") || perk::_hasperk("specialty_glintsml") || perk::_hasperk("specialty_glintmed") || perk::_hasperk("specialty_glintlrg") || perk::_hasperk("specialty_glintxlrg")) {
    return true;
  }

  return false;
}

function function_b3e5f50a0d4a9c86(weapon) {
  if(isnullweapon(weapon) || !isDefined(weapon.scope)) {
    return false;
  }

  if(issubstr(weapon.scope, "snprscope") || issubstr(weapon.scope, "vzscope") || issubstr(weapon.scope, "thermal")) {
    return true;
  }

  return false;
}

function sniperglint_manage(objweapon) {
  self notify("manageSniperGlint");
  self endon("manageSniperGlint");
  self endon("weapon_change");
  waitframe();
  thread sniperglint_cleanup();
  self.glinton = 0;
  istogglescope = istogglescope(objweapon, objweapon.scope);

  while(true) {
    if(self playerads() > 0.5 && self hasweapon(objweapon) && !(istogglescope && self gethybridscopestate(objweapon))) {
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
  utility::waittill_any_2("death_or_disconnect", "weapon_change");

  if(isDefined(self.glinton) && self.glinton) {
    sniperglint_remove();
    self.glinton = undefined;
  }
}

function sniperglint_add() {
  assertex(isDefined(self.glinton), "<dev string:x58>");
  assertex(!isDefined(self.glinton) || self.glinton == 0, "<dev string:x95>");

  if(_hasperk("specialty_glintxsml")) {
    self setscriptablepartstate("sniperGlint", "sniperGlintXsml", 0);
  } else if(_hasperk("specialty_glintsml")) {
    self setscriptablepartstate("sniperGlint", "sniperGlintSml", 0);
  } else if(_hasperk("specialty_glintmed")) {
    self setscriptablepartstate("sniperGlint", "sniperGlintMed", 0);
  } else if(_hasperk("specialty_glintlrg")) {
    self setscriptablepartstate("sniperGlint", "sniperGlintLrg", 0);
  } else if(_hasperk("specialty_glintxlrg")) {
    self setscriptablepartstate("sniperGlint", "sniperGlintXlrg", 0);
  }

  self.glinton = 1;
}

function sniperglint_remove() {
  assertex(isDefined(self.glinton), "<dev string:xd6>");
  assertex(!isDefined(self.glinton) || self.glinton == 1, "<dev string:x116>");

  if(isDefined(self)) {
    self setscriptablepartstate("sniperGlint", "sniperGlintOff", 0);
    self.glinton = 0;
  }
}

function sniperadsblur(weapon) {
  self endon("weapon_change");
  self.sniperblur = 0;

  while(true) {
    if(self playerads() > 0.65 && !self.sniperblur) {
      thread sniperadsblur_execute(weapon);
    } else if(self playerads() <= 0.65) {
      sniperadsblur_remove();
    }

    waitframe();
  }
}

function sniperadsblur_execute(weapon) {
  self notify("sniperBlurReset");
  self endon("sniperBlurReset");
  self.sniperblur = 1;
  self setblurforplayer(25, 0.1);
  wait 0.1;
  self setblurforplayer(0, getsniperadsblurtime(weapon));
}

function sniperadsblur_remove() {
  self notify("sniperBlurReset");
  self setblurforplayer(0, 0);
  self.sniperblur = 0;
}

function getsniperadsblurtime(weapon) {
  blurtime = 0.3;

  switch (weapon.basename) {
    case #"hash_720415103e03ae2":
      blurtime = 0.18;
      break;
    case #"hash_b9e0da8080aefc13":
      blurtime = 0.12;
      break;
    case #"hash_1c4e9e71e522fc4f":
      blurtime = 0.12;
      break;
  }

  return blurtime;
}

function watchsniperboltactionkills() {
  self endon("death_or_disconnect");
  thread watchsniperboltactionkills_ondeath();

  if(!isDefined(self.pers["recoilReduceKills"])) {
    self.pers["recoilReduceKills"] = 0;
  }

  self setclientomnvar("weap_sniper_display_state", self.pers["recoilReduceKills"]);

  while(true) {
    self waittill("got_a_kill", victim, sweapon, meansofdeath);
    weapon = makeweaponfromstring(sweapon);

    if(isrecoilreducingweapon(weapon)) {
      kills = self.pers["recoilReduceKills"] + 1;
      self.pers["recoilReduceKills"] = int(min(kills, 4));
      self setclientomnvar("weap_sniper_display_state", self.pers["recoilReduceKills"]);

      if(kills <= 4) {
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

function isrecoilreducingweapon(weapon) {
  return false;
}

function getrecoilreductionvalue() {
  if(!isDefined(self.pers["recoilReduceKills"])) {
    self.pers["recoilReduceKills"] = 0;
  }

  return self.pers["recoilReduceKills"] * 3;
}

function ishackweapon(weapon) {
  if(weapon == "radar_mp" || weapon == "airstrike_mp" || weapon == "helicopter_mp") {
    return true;
  }

  if(weapon == "briefcase_bomb_mp") {
    return true;
  }

  return false;
}

function isfistweapon(weapon) {
  weapon = getweaponrootname(weapon);
  return weapon == "iw9_me_fists";
}

function isbombplantweapon(weapon) {
  return weapon == "briefcase_bomb_mp" || weapon == "briefcase_bomb_defuse_mp" || weapon == "briefcase_silent_mp" || weapon == "briefcase_defuse_silent_mp" || weapon == "briefcase_bomb_mp_nuke";
}

function dropweaponfordeath(attacker, smeansofdeath, weaponoverride, damage) {
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

  if(isDefined(weaponoverride)) {
    objweapon = weaponoverride;
  }

  if(!isDefined(objweapon)) {
    if(getDvar(@ "scr_dropdebug") == "<dev string:x15b>") {
      println("<dev string:x160>");
    }

    return;
  }

  if(objweapon.basename == "none") {
    if(getDvar(@ "scr_dropdebug") == "<dev string:x15b>") {
      println("<dev string:x183>");
    }

    return;
  }

  if(!self hasweapon(objweapon)) {
    if(getDvar(@ "scr_dropdebug") == "<dev string:x15b>") {
      println("<dev string:x1a9>" + objweapon.basename + "<dev string:x1d8>");
    }

    return;
  }

  if(isDefined(level.gamemodemaydropweapon) && !self[[level.gamemodemaydropweapon]](objweapon)) {
    return;
  }

  objweapon = objweapon getnoaltweapon();
  clipammor = 0;
  clipammol = 0;
  stockammo = 0;

  if(!isriotshield(objweapon.basename)) {
    if(!self anyammoforweaponmodes(objweapon)) {
      return;
    }

    clipammor = self getweaponammoclip(objweapon, "right");
    clipammol = self getweaponammoclip(objweapon, "left");

    if(!clipammor && !clipammol) {
      return;
    }

    stockammo = self getweaponammostock(objweapon);
    stockmax = weaponmaxammo(objweapon);

    if(stockammo > stockmax) {
      stockammo = stockmax;
    }

    item = self dropitem(objweapon);

    if(!isDefined(item)) {
      return;
    }

    if(istrue(level.clearstockondrop)) {
      stockammo = 0;
    }

    item itemweaponsetammo(clipammor, stockammo, clipammol);
    weapongroup = scripts\mp\utility\weapon::getweapongroup(objweapon);

    if(smeansofdeath != "MOD_EXECUTION") {
      thread dropweaponfordeathlaunch(item, weapongroup, damage, self.angles);
    }
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
  item thread function_ea90a9bb06631b2b(self);
  item thread function_aeabbb3b58e1d822(self);
}

function function_ea90a9bb06631b2b(player) {
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
  deletedist = level.var_34777cc7c85edbe6;

  if(distsq < deletedist * deletedist) {
    pickupdelete(self);
  }
}

function forcedropweapon(weaponoverride) {
  if(isDefined(level.blockweapondrops)) {
    return 0;
  }

  if(isDefined(self.droppeddeathweapon)) {
    return 0;
  }

  objweapon = self.lastdroppableweaponobj;

  if(isDefined(weaponoverride)) {
    objweapon = weaponoverride;
  }

  if(!isDefined(objweapon)) {
    if(getDvar(@ "scr_dropdebug") == "<dev string:x15b>") {
      println("<dev string:x160>");
    }

    return 0;
  }

  if(objweapon.basename == "none") {
    if(getDvar(@ "scr_dropdebug") == "<dev string:x15b>") {
      println("<dev string:x183>");
    }

    return 0;
  }

  if(!self hasweapon(objweapon)) {
    if(getDvar(@ "scr_dropdebug") == "<dev string:x15b>") {
      println("<dev string:x1a9>" + objweapon.basename + "<dev string:x1d8>");
    }

    return -1;
  }

  if(isDefined(level.gamemodemaydropweapon) && !self[[level.gamemodemaydropweapon]](objweapon)) {
    return 0;
  }

  objweapon = objweapon getnoaltweapon();
  clipammor = 0;
  clipammol = 0;
  stockammo = 0;

  if(!isriotshield(objweapon.basename)) {
    if(!self anyammoforweaponmodes(objweapon)) {
      return 0;
    }

    clipammor = self getweaponammoclip(objweapon, "right");
    clipammol = self getweaponammoclip(objweapon, "left");

    if(!clipammor && !clipammol) {
      return 0;
    }

    stockammo = self getweaponammostock(objweapon);
    stockmax = weaponmaxammo(objweapon);

    if(stockammo > stockmax) {
      stockammo = stockmax;
    }

    item = self dropitem(objweapon);

    if(!isDefined(item)) {
      return 0;
    }

    if(istrue(level.clearstockondrop)) {
      stockammo = 0;
    }

    item itemweaponsetammo(clipammor, stockammo, clipammol);
  } else {
    item = self dropitem(objweapon);

    if(!isDefined(item)) {
      return 0;
    }

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

function detachifattached(model, basetag) {
  attachsize = self getattachsize();

  for(i = 0; i < attachsize; i++) {
    attach = self getattachmodelname(i);

    if(attach != model) {
      continue;
    }

    tag = self getattachtagname(i);
    self detach(model, tag);

    if(tag != basetag) {
      attachsize = self getattachsize();

      for(i = 0; i < attachsize; i++) {
        tag = self getattachtagname(i);

        if(tag != basetag) {
          continue;
        }

        model = self getattachmodelname(i);
        self detach(model, tag);
        break;
      }
    }

    return true;
  }

  return false;
}

function deletepickupafterawhile() {
  self endon("death");
  wait 60;
  pickupdelete(self);
}

function function_aeabbb3b58e1d822(player) {
  self endon("death");
  player endon("death_or_disconnect");
  player waittill("trigger_removed");
  pickupdelete(self);
}

function pickupdelete(pickup) {
  if(!isDefined(pickup)) {
    return;
  }

  pickup notify("weapon_pickup_cancelled");
  pickup delete();
}

function getitemweaponname() {
  classname = self.classname;
  assert(getsubstr(classname, 0, 7) == "<dev string:x1dd>");
  weapname = getsubstr(classname, 7);
  return weapname;
}

function watchpickup(droppingplayer) {
  self endon("weapon_pickup_cancelled");
  weaponowner = self.owner;
  weaponobj = self.objweapon;
  level.onweapondropcreated callback_trigger(self, droppingplayer, weaponobj);
  weapname = getitemweaponname();

  while(true) {
    self waittill("trigger", player, droppeditem);
    previousweapon = undefined;
    var_70582da4ff904336 = isDefined(level.cyberemp) && isDefined(level.cyberemp.carrier) && level.cyberemp.carrier == player;
    var_280079773a9459a5 = getgametype() == "cyber" && (isDefined(droppeditem) || var_70582da4ff904336) && istrue(level.allowempweapon);

    if(var_280079773a9459a5) {
      weapons = player scripts\cp_mp\utility\inventory_utility::getcurrentprimaryweaponsminusalt();

      if(weapons.size > 2) {
        var_66c1bf2eadf04d65 = 0;
        var_4819a5499215519 = 0;
        var_fc41e0bc6c702a3a = 0;
        var_964b30d2f3cdedc4 = 0;
        var_5b70a9307f104360 = 0;

        foreach(weapon in weapons) {
          if(weapon.basename == "iw9_cyberemp_mp") {
            var_66c1bf2eadf04d65 = 1;
          }

          if(ismeleeoverrideweapon(weapon)) {
            var_4819a5499215519 = 1;
          }

          if(isunderwaterweapon(weapon)) {
            var_fc41e0bc6c702a3a = 1;
          }

          if(isclimbweapon(weapon)) {
            var_964b30d2f3cdedc4 = 1;
          }

          if(weapon.basename == "iw8_lm_dblmg_mp") {
            var_5b70a9307f104360 = 1;
          }
        }

        if(isDefined(player.primaryweapon) && player.primaryweapon != "iw9_cyberemp_mp") {
          previousweapon = player.primaryweaponobj;
        } else if(isDefined(player.secondaryweapon) && player.secondaryweapon != "iw9_cyberemp_mp") {
          previousweapon = player.secondaryweaponobj;
        }

        weaponcount = weapons.size;

        if(var_4819a5499215519) {
          weaponcount--;
        }

        if(var_5b70a9307f104360) {
          weaponcount--;
        }

        if(var_fc41e0bc6c702a3a) {
          weaponcount--;
        }

        if(var_964b30d2f3cdedc4) {
          weaponcount--;
        }

        if(!var_66c1bf2eadf04d65 || weaponcount > 3) {
          var_ae8c4b58168da1a2 = undefined;

          if(previousweapon.basename != "none") {
            var_ae8c4b58168da1a2 = previousweapon;
          }

          result = player forcedropweapon(var_ae8c4b58168da1a2);

          if(var_70582da4ff904336) {
            player val::set("cyber_emp", "weapon_switch", 0);
            player val::set("cyber_emp", "weapon_pickup", 0);
            player val::set("cyber_emp", "usability", 0);
            player thread waitthengivecyberweapon(result == 0);
          }

          if(result == 1) {} else if(result == 0) {
            player val::reset_all("cyber_emp");
            return;
          } else if(result == -1) {}
        }
      } else if(var_70582da4ff904336) {
        player val::set("cyber_emp", "weapon_switch", 0);
        player val::set("cyber_emp", "weapon_pickup", 0);
        player val::set("cyber_emp", "usability", 0);
        player thread waitthengivecyberweapon();
      } else if(isDefined(droppeditem)) {
        previousweapon = player.lastdroppableweaponobj;
      } else {
        previousweapon = player getcurrentweapon();
      }
    } else if(isDefined(droppeditem)) {
      previousweapon = player.lastdroppableweaponobj;
    } else {
      previousweapon = player getcurrentweapon();
    }

    var_fee12400d8814b47 = player _hasperk("specialty_scrap_weapons") && getdvarint(@ "hash_eb1e94069d5150f2") == 1;
    player thread watchpickupcomplete(weaponobj, previousweapon, var_fee12400d8814b47);
    level.onweapondroppickedup callback_trigger(self, player, weaponobj);
    player notify("weapon_pickup", weaponobj, droppeditem);

    if(isDefined(droppeditem)) {
      player.lastweaponpickuptime = gettime();
      player scripts\mp\utility\stats::incpersstat("weaponPickups", 1);
    }

    dirty = scripts\cp_mp\weapon::fixupplayerweapons(player, weapname);

    if(dirty) {
      if(weaponobj.basename == player.primaryweaponobj.basename) {
        player namespace_6b49ddb858f34366::function_adcb155953291ec7(1, 0);
      } else if(weaponobj.basename == player.secondaryweaponobj.basename) {
        player namespace_6b49ddb858f34366::function_adcb155953291ec7(0, 0);
      }
    }

    if(isDefined(droppeditem) && var_fee12400d8814b47) {
      droppeditem delete();
    }

    if(isDefined(droppeditem) || dirty) {
      break;
    }
  }

  assert(isDefined(player.tookweaponfrom));

  if(isDefined(droppeditem)) {
    droppedweaponname = droppeditem getitemweaponname();
    objweapon = makeweaponfromstring(droppedweaponname);

    if(isDefined(player.tookweaponfrom[droppedweaponname])) {
      droppeditem.owner = player.tookweaponfrom[droppedweaponname];
      player.tookweaponfrom[droppedweaponname] = undefined;
    } else {
      droppeditem.owner = player;
    }

    droppeditem.objweapon = objweapon;
    droppeditem.targetname = "dropped_weapon";
    droppeditem thread watchpickup(player);
  }

  player.tookweaponfrom[weapname] = weaponowner;
}

function waitthengivecyberweapon(var_8a5abcce61604b23) {
  self endon("death_or_disconnect");
  self notify("cancelGiveEmp");
  self endon("cancelGiveEmp");

  while(isDefined(self.currentweapon.basename) && self.currentweapon.basename == "none") {
    waitframe();
  }

  _giveweapon("iw9_cyberemp_mp");

  if(!istrue(var_8a5abcce61604b23)) {
    val::reset_all("cyber_emp");
  }
}

function watchpickupcomplete(desiredweapon, previousweapon, var_fee12400d8814b47) {
  self endon("death_or_disconnect");
  self notify("watchPickupComplete()");
  self endon("watchPickupComplete()");
  startingweapon = self.currentweapon;
  success = 0;

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
    if(isminigunweapon(desiredweapon)) {
      scripts\mp\killstreaks\juggernaut_mp::juggernautweaponpickedup(desiredweapon, previousweapon);
    }

    thread notifyuiofpickedupweapon();

    if(isDefined(level.onweapontaken)) {
      [[level.onweapontaken]](desiredweapon);
    }
  }
}

function getrandomgraverobberattachment(currentweapon, var_79583f5b5010a954) {
  return undefined;
}

function addattachmenttoweapon(newweapon, var_effb4ae1788a8b10) {
  variantid = getweaponvariantindex(newweapon);
  newweapon = newweapon getnoaltweapon();
  attachmenttoidmap = newweapon.attachmentvarindices;
  attachments = [];

  foreach(attachment, id in attachmenttoidmap) {
    attachments[attachments.size] = attachment;
  }

  failed = 0;

  if(array_contains(attachments, var_effb4ae1788a8b10)) {
    failed = 1;
  } else if(!newweapon canuseattachment(var_effb4ae1788a8b10)) {
    failed = 1;
  }

  if(failed) {
    return undefined;
  }

  attachments = scripts\cp_mp\weapon::weaponattachremoveextraattachments(attachments);
  var_7809ad191e44fe6a = [];

  foreach(idx, attachment in attachments) {
    var_7809ad191e44fe6a[idx] = attachmenttoidmap[attachment];
  }

  attachments[attachments.size] = var_effb4ae1788a8b10;
  var_7809ad191e44fe6a[var_7809ad191e44fe6a.size] = 0;
  camo = newweapon.camo;
  stickers = [];

  if(isDefined(newweapon.stickerslot0)) {
    stickers[stickers.size] = newweapon.stickerslot0;
  }

  if(isDefined(newweapon.stickerslot1)) {
    stickers[stickers.size] = newweapon.stickerslot1;
  }

  if(isDefined(newweapon.stickerslot2)) {
    stickers[stickers.size] = newweapon.stickerslot2;
  }

  if(isDefined(newweapon.stickerslot3)) {
    stickers[stickers.size] = newweapon.stickerslot3;
  }

  if(isDefined(newweapon.var_b39ac546cc8621f8)) {
    stickers[stickers.size] = newweapon.var_b39ac546cc8621f8;
  }

  hasnvg = scripts\cp_mp\utility\game_utility::function_d2d2b803a7b741a4();
  attachment1slot = function_4add228b999c26aa(newweapon, var_effb4ae1788a8b10);

  foreach(idx, a in attachments) {
    attachment2slot = function_4add228b999c26aa(newweapon, attachments[idx]);

    if(attachment1slot == attachment2slot && attachment1slot != "other") {
      attachments[idx] = var_effb4ae1788a8b10;
    }
  }

  newweapon = scripts\cp_mp\weapon::buildweapon(getweaponrootname(newweapon), attachments, camo, "none", variantid, var_7809ad191e44fe6a, undefined, stickers, hasnvg);
  return newweapon;
}

function function_71dc088dc384ef8d(weaponname, numattachments, var_a4d5e0f6b90df7eb) {
  var_72672cd81ec1093d = weaponname;
  newweaponobj = undefined;

  if(!isweapon(weaponname)) {
    var_72672cd81ec1093d = makeweapon(weaponname);
  }

  attachments = function_8df87e6b1d13c15a(var_72672cd81ec1093d, numattachments, var_a4d5e0f6b90df7eb);

  foreach(attachment in attachments) {
    newweaponobj = addattachmenttoweapon(var_72672cd81ec1093d, attachment);

    if(isDefined(newweaponobj)) {
      var_72672cd81ec1093d = newweaponobj;
    }

    if(!isDefined(newweaponobj)) {
      iprintlnbold("<dev string:x1e8>" + weaponname + "<dev string:x1fe>" + attachment);
    }
  }

  return var_72672cd81ec1093d;
}

function function_8df87e6b1d13c15a(weaponobj, numattachments, var_a4d5e0f6b90df7eb, excludeslots, minpriority) {
  random_attachments = [];
  var_738063f99716d177 = weapon::function_c471a035d22df5eb();
  var_738063f99716d177 = utility::array_randomize(var_738063f99716d177);

  if(isDefined(excludeslots)) {
    foreach(slot in excludeslots) {
      if(array_contains(var_738063f99716d177, slot)) {
        var_738063f99716d177 = array_remove(var_738063f99716d177, slot);
      }
    }
  }

  foreach(slotkey in var_738063f99716d177) {
    if(istrue(var_a4d5e0f6b90df7eb) && slotkey == "scope") {
      continue;
    }

    attachment_array = function_75b035199842693d(weaponobj, slotkey);

    if(attachment_array.size > 0 && random_attachments.size < numattachments) {
      if(isDefined(minpriority)) {
        var_e4d2b96bef75b948 = getcompleteweaponname(weaponobj);
        var_6121d10df35555a6 = [];

        foreach(attachment in attachment_array) {
          attachpriority = function_1dd1f56bc3d72b7e(var_e4d2b96bef75b948, attachment);

          if(attachpriority < minpriority) {
            continue;
          }

          var_6121d10df35555a6[var_6121d10df35555a6.size] = attachment;
        }

        attachment_array = var_6121d10df35555a6;
      }

      if(attachment_array.size > 0) {
        arrayindex = randomint(attachment_array.size);
        random_attachments = utility::array_add(random_attachments, attachment_array[arrayindex]);
      }
    }

    if(random_attachments.size >= numattachments) {
      break;
    }
  }

  if(istrue(var_a4d5e0f6b90df7eb)) {
    array_scope = function_75b035199842693d(weaponobj, "scope");

    if(array_scope.size > 0) {
      arrayindex = randomint(array_scope.size);
      random_attachments = utility::array_add(random_attachments, array_scope[arrayindex]);

      if(random_attachments.size > numattachments) {
        random_attachments = utility::array_remove_index(random_attachments, 0);
      }
    }
  }

  return random_attachments;
}

function getammooverride(weaponobj, forceclipsize) {
  if(!isDefined(forceclipsize)) {
    forceclipsize = 0;
  }

  if(forceclipsize) {
    return weaponclipsize(weaponobj);
  }

  baseweapon = weaponobj getbaseweapon();
  baseclipsize = weaponclipsize(baseweapon);
  var_2be3302e3767cc7d = weaponclipsize(weaponobj);
  clipsize = baseclipsize;

  if(getweaponhasperk(weaponobj, "specialty_smags")) {
    clipsize = int(max(baseclipsize, var_2be3302e3767cc7d));
  }

  rootname = weapon::getweaponrootname(weaponobj);
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
          case #"hash_ed18de054b1e0b57":
            ammooverride = 7;
            break;
          default:
            ammooverride = int(min(clipsize, 30));
            break;
        }

        break;
      case #"hash_6191aaef9f922f96":
        switch (rootname) {
          case #"hash_8d9ae5e5dd390b4b":
            ammooverride = 3;
            break;
          case #"hash_40af6e6a958292d9":
            ammooverride = 3;
            break;
          case #"hash_ed18de054b1e0b57":
            ammooverride = 7;
            break;
          case #"hash_5bb46b3b952f6b2a":
            ammooverride = 5;
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

function isgraverobberattachment(weapon, attachmentbasename) {
  if(!weapon::attachmentisselectable(weapon, attachmentbasename)) {
    return false;
  }

  switch (attachmentbasename) {
    case #"hash_46abc44d4b683c0c":
    case #"hash_ae7694515b4b215c":
    case #"hash_cace574b66d79951":
      return false;
  }

  if(issubstr(attachmentbasename, "thermal")) {
    return false;
  }

  if(issubstr(attachmentbasename, "burst")) {
    return false;
  }

  if(getsubstr(attachmentbasename, 0, 3) == "cal") {
    return false;
  }

  return true;
}

function notifyuiofpickedupweapon() {}

function itemremoveammofromaltmodes() {
  var_b2cac67dce789126 = getitemweaponname();
  var_f3a75b200cedf31f = weaponaltweaponname(var_b2cac67dce789126);

  for(altindex = 1; var_f3a75b200cedf31f != "none" && var_f3a75b200cedf31f != var_b2cac67dce789126; altindex++) {
    self itemweaponsetammo(0, 0, 0, altindex);
    var_f3a75b200cedf31f = weaponaltweaponname(var_f3a75b200cedf31f);
  }
}

function function_7e895e1c85354e17(attacker, meansofdeath) {
  self endon("spawned_player");
  level endon("game_ended");

  if(!function_8380039e393ec43a(attacker, meansofdeath)) {
    return;
  }

  if(isDefined(meansofdeath) && (meansofdeath == "MOD_EXECUTION" || meansofdeath == "MOD_MELEE_TAKEDOWN")) {
    wait 1.5;

    if(!function_8380039e393ec43a(attacker, meansofdeath)) {
      return;
    }
  }

  function_1e5278055e7032ee(attacker);
}

function function_8380039e393ec43a(attacker, meansofdeath) {
  if(!isDefined(attacker)) {
    return false;
  }

  if(attacker == self) {
    return false;
  }

  if(!isPlayer(attacker)) {
    return false;
  }

  return true;
}

function function_1e5278055e7032ee(attacker) {
  if(!isDefined(self)) {
    return;
  }

  droparmor = self dropscavengerbag("armor_mp", "j_head");

  if(!isDefined(droparmor)) {
    return;
  }

  droparmor ent_manager::registerspawn(2, &function_a642b6997daab69a);
  droparmor function_dfb78b3e724ad620(0);
  droparmor showonlytoplayer(attacker);
  droparmor.owner = attacker;
  droparmor.team = attacker.team;
  droparmor.count = 1;
  droparmor thread function_40c995b337d540b5();
  droparmor thread function_cb9c3a8ed8dae404();
  droparmor thread function_6b7147d3c072f4bd();
  droparmor thread function_8dd67f32058884cf();
  outlineid = outline::outlineenableforplayer(droparmor, attacker, "shimmer_default", "level_script");
}

function armoronuse(player) {
  self.armorref notify("scavenger", player);
}

function function_40c995b337d540b5() {
  self endon("armorRemoved");
  level endon("game_ended");
  player = undefined;

  while(true) {
    self waittill("scavenger_armor", player);
    assert(isDefined(player));

    if(player == self.owner && !player player_utility::isinvehicle()) {
      break;
    }
  }

  player = self.owner;
  player notify("armor_pickup");
  result = player function_2be53701abcf1e63(self);

  if(!isDefined(player.pers["armorPickedUp"])) {
    player.pers["armorPickedUp"] = 0;
  }

  player stats::incpersstat("armorPickedUp", 1);

  if(isDefined(self.useobj)) {
    self.useobj delete();
  }

  self notify("death");
  self notify("armorRemoved");
}

function function_2be53701abcf1e63(armor) {
  if(br_pickups::pickupissameasequipmentslot("equip_armorplate", "health")) {
    if(perk::_hasperk("specialty_fast_armor") && isDefined(self.armorhealth) && isDefined(self.maxarmorhealth) && self.armorhealth < self.maxarmorhealth) {
      result = perkfunctions::function_c5d5909e07c87005(armor);

      if(result == 1) {
        return 1;
      }
    }

    if(function_934801be51b4393f()) {
      var_5324597edfaff57c = equipment::getequipmentslotammo("health");
      var_b5cdf4d935e6ac13 = equipment::getequipmentmaxammo("equip_armorplate");
      var_97c23a1323acc7df = var_b5cdf4d935e6ac13 - var_5324597edfaff57c;
      equipment::incrementequipmentslotammo("health", 1);
      return 1;
    } else {
      return 0;
    }

    return;
  }

  if(!isDefined(self.equipment["health"]) || equipment::getequipmentslotammo("health") == 0) {
    var_b5cdf4d935e6ac13 = equipment::getequipmentmaxammo("equip_armorplate");
    equipment::giveequipment("equip_armorplate", "health");
    equipment::setequipmentammo("equip_armorplate", 1);
    return 1;
  }

  return 0;
}

function function_a642b6997daab69a() {
  if(isDefined(self.useobj)) {
    self.useobj delete();
  }

  self delete();
}

function function_cb9c3a8ed8dae404() {
  self endon("death");
  level endon("game_ended");
  utility::waittill_any_2("armorRemoved", "armor_timeout");

  if(isDefined(self)) {
    if(isDefined(self.useobj)) {
      self.useobj delete();
    }

    ent_manager::deregisterspawn();
    self delete();
  }
}

function function_6b7147d3c072f4bd() {
  self endon("death");
  self.owner endon("disconnect");
  level endon("game_ended");
  wait 30;

  if(isDefined(self)) {
    self notify("armor_timeout");
  }
}

function function_8dd67f32058884cf() {
  self endon("armorRemoved");
  level endon("game_ended");
  self waittill("death");
  waittillframeend();
  self notify("armorRemoved");
}

function function_934801be51b4393f() {
  if(equipment::getequipmentslotammo("health") < equipment::getequipmentmaxammo("equip_armorplate")) {
    return true;
  }

  return false;
}

function onscavengerbagpickup(player) {
  if(isDefined(level.onscavengerbagpickup)) {
    [[level.onscavengerbagpickup]](player);
    return;
  }

  var_9d8419379ac383f1 = self.owner perk::_hasperk("specialty_intel_jacker");
  var_943425e20021c5e1 = self.owner perk::_hasperk("specialty_scavenger_plus");

  if(var_943425e20021c5e1) {
    scavengergiveammo(player);
    player equipment::function_312cbcf07904565d();
  }

  if(var_9d8419379ac383f1) {
    player function_722431104048241d(player.origin);

    if(istrue(level.teambased)) {
      var_1ff5e84e31eebd6b = scripts\mp\utility\player::getplayersinradius(player.origin, 700, player.team, player);
      var_ddccd08a9a9f2c00 = [];

      foreach(ally in var_1ff5e84e31eebd6b) {
        if(isDefined(ally.var_78ede70519cfb53b)) {
          var_ddccd08a9a9f2c00 = array_combine_unique(var_ddccd08a9a9f2c00, ally.var_78ede70519cfb53b);

          if(ally != player) {
            var_ddccd08a9a9f2c00 = function_6d6af8144a5131f1(var_ddccd08a9a9f2c00, ally);
          }
        }
      }

      var_ddccd08a9a9f2c00 = array_remove(var_ddccd08a9a9f2c00, player);

      foreach(ent in var_ddccd08a9a9f2c00) {
        ent function_722431104048241d(player.origin);
      }
    }
  }

  if(function_44e99168f6830136(player)) {
    player equipment::givescavengerammo();
  }
}

function private function_44e99168f6830136(player) {
  var_9dffd6323feab1e8 = 0;
  var_7e245bdd13045367 = player perk::_hasperk("specialty_scavenger_equipment");

  if(istrue(var_7e245bdd13045367)) {
    var_9dffd6323feab1e8 = 1;
  }

  return var_9dffd6323feab1e8;
}

function handlescavengerbagpickup(scrplayer) {
  self endon("scavengerBagRemoved");
  level endon("game_ended");
  assert(isDefined(scrplayer));
  player = undefined;

  while(true) {
    self waittill("scavenger", player);
    assert(isDefined(player));

    if(!player player_utility::isinvehicle()) {
      break;
    }
  }

  player notify("scavenger_pickup");
  onscavengerbagpickup(player);
  player stats::initpersstat("scavengerPickedUp");
  player stats::incpersstat("scavengerPickedUp", 1);
  player perks::activateperk("specialty_scavenger_plus");
  challenges::function_8a0395089290faf6(player);

  if(isDefined(self.useobj)) {
    self.useobj delete();
  }

  self notify("death");
  self notify("scavengerBagRemoved");
}

function function_208e1193f12b970a() {
  self endon("scavengerBagRemoved");
  level endon("game_ended");
  self waittill("death");
  waittillframeend();
  self notify("scavengerBagRemoved");
}

function function_722431104048241d(location) {
  triggerportableradarping(location, self, 1300);
}

function scavengergiveammo(player) {
  primaryweapons = player getweaponslistprimaries();

  foreach(primary in primaryweapons) {
    addscavengercliptoweapon(player, primary, 1);
  }
}

function addscavengercliptoweapon(player, weapon, numclips) {
  if(!weapon::iscacprimaryweapon(weapon) && !level.scavenger_secondary) {
    return;
  }

  if(weapon.isalternate) {
    return;
  }

  if(weapon::getweapongroup(weapon) == "weapon_projectile") {
    return;
  }

  if(weapon.basename == "iw9_pi_stimpistol_mp") {
    return;
  }

  currentstockammo = player getweaponammostock(weapon);
  addstockammo = getammooverride(weapon);
  addstockammo = int(ceil(numclips * addstockammo));

  if(weapon.isdualwield) {
    addstockammo *= 1;
  }

  newammo = currentstockammo + addstockammo;
  player setweaponammostock(weapon, newammo);
}

function scavenger_budget_delete() {
  if(isDefined(self.useobj)) {
    self.useobj delete();
  }

  self delete();
}

function dropscavengerfordeath(attacker, meansofdeath) {
  self endon("spawned_player");
  level endon("game_ended");

  if(!shoulddropscavengerbag(attacker, meansofdeath)) {
    return;
  }

  delay = 0;

  if(isDefined(meansofdeath) && (meansofdeath == "MOD_EXECUTION" || meansofdeath == "MOD_MELEE_TAKEDOWN")) {
    delay = 1.5;
  }

  wait delay;

  if(delay > 0 && !shoulddropscavengerbag(attacker, meansofdeath)) {
    return;
  }

  if(isDefined(level.var_d1df695cab85185c)) {
    self[[level.var_d1df695cab85185c]](attacker);
    return;
  }

  dropscavengerfordeathinternal(attacker);
}

function dropscavengerfordeathinternal(attacker) {
  if(!isDefined(self)) {
    return;
  }

  dropbag = self dropscavengerbag("scavenger_bag_mp", "j_head");

  if(!isDefined(dropbag)) {
    return;
  }

  dropbag ent_manager::registerspawn(2, &scavenger_budget_delete);
  dropbag function_dfb78b3e724ad620(0);
  dropbag.owner = attacker;
  dropbag.team = attacker.team;
  dropbag thread handlescavengerbagpickup(self);
  dropbag thread scavengerbagcleanupthink();
  dropbag thread scavengerbagtimeoutthink();
  dropbag thread function_208e1193f12b970a();
  function_653e9f15896017ed(self);

  if(isDefined(level.bot_funcs) && isDefined(level.bot_funcs["bots_add_scavenger_bag"])) {
    [[level.bot_funcs["bots_add_scavenger_bag"]]](dropbag);
  }
}

function shoulddropscavengerbag(attacker, meansofdeath) {
  if(!isDefined(attacker)) {
    return false;
  }

  if(attacker == self) {
    return false;
  }

  return true;
}

function scavengerbagcleanupthink() {
  self endon("death");
  level endon("game_ended");
  self.owner utility::waittill_any_3("death_or_disconnect", "joined_team", "bag_timeout");

  if(isDefined(self)) {
    if(isDefined(self.useobj)) {
      self.useobj delete();
    }

    ent_manager::deregisterspawn();
    self delete();
  }
}

function scavengerbagtimeoutthink() {
  self endon("death");
  self.owner endon("disconnect");
  level endon("game_ended");
  wait 20;

  if(isDefined(self)) {
    self.owner notify("bag_timeout");
  }
}

function scavengerbagusesetup() {
  self endon("death");
  self.owner endon("disconnect");
  level endon("game_ended");
  hintstring = &"PERKS/HOLD_TO_SCAVENGE";
  self.useobj = gameobjects::createhintobject(self.origin + anglestoup(self.angles) * 1, "HINT_BUTTON", undefined, hintstring, undefined, undefined, "show", 200, 160, 100, 160);
  self.useobj.owner = self.owner;
  self.useobj.team = self.team;
  self.useobj linkTo(self);

  foreach(player in level.players) {
    self.useobj disableplayeruse(player);
  }

  thread scavengebagthink();
  thread scavengebagusemonitoring();

  for(;;) {
    self waittill("pickedUpScavengerBag", player);

    if(isPlayer(player)) {
      player notify("scavenger_pickup");
      onscavengerbagpickup(player);
      player perks::activateperk("specialty_scavenger_plus");

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
  var_e82152475c1ca370 = 1;

  while(var_e82152475c1ca370) {
    wait 0.1;

    foreach(player in level.players) {
      if(!isDefined(self)) {
        var_e82152475c1ca370 = 0;
        continue;
      }

      if(player.team != self.team || player perk::_hasperk("specialty_scavenger")) {
        self.useobj disableplayeruse(player);
        continue;
      }

      self.useobj enableplayeruse(player);
    }
  }
}

function scavengebagthink() {
  self endon("restarting_physics");
  usetrigger = self.useobj;
  useent = undefined;

  if(istrue(level.gameended) && !isDefined(usetrigger)) {
    return;
  }

  while(isDefined(self)) {
    usetrigger waittill("trigger", player);
    player.iscapturingcrate = 1;
    useent = createuseent();
    useent.id = "use";
    result = useent useholdthink(player, getdvarfloat(@ "hash_e9cbdb751424e4ab"));

    if(!isDefined(player)) {
      return;
    }

    player.iscapturingcrate = 0;

    if(result) {
      self notify("pickedUpScavengerBag", player);
    }
  }
}

function function_653e9f15896017ed(victim) {
  if(!getmatchrulesdata("brData", "scavengerGiveArmor")) {
    return;
  }

  if(isDefined(victim)) {
    dropinfo = br_pickups::getitemdropinfo(victim.origin);
    br_pickups::spawnpickup("brloot_armor_plate", dropinfo);
  }
}

function useholdthink(player, usetime) {
  self.curprogress = 0;
  self.inuse = 1;
  self.userate = 0;
  self.usetime = usetime;
  movers::script_mover_link_to_use_object(player);
  player val::set("useHold", "weapon", 0);
  result = useholdthinkloop(player);

  if(isalive(player)) {
    player val::reset_all("useHold");
  }

  if(isDefined(player)) {
    movers::script_mover_unlink_from_use_object(player);
  }

  if(!isDefined(self)) {
    return 0;
  }

  self.inuse = 0;
  self.curprogress = 0;
  return result;
}

function useholdthinkloop(player) {
  result = internal_useholdthinkloop(player);

  if(isDefined(self)) {
    player gameobjects::updateuiprogress(self, 0);
  }

  return istrue(result);
}

function internal_useholdthinkloop(player) {
  self endon("endUseHoldThink");

  while(player isplayerusing(self)) {
    if(!player movers::script_mover_use_can_link(self)) {
      return 0;
    }

    self.curprogress += level.framedurationseconds * self.userate;

    if(isDefined(self.objectivescaler)) {
      self.userate = 1 * self.objectivescaler;
    } else {
      self.userate = 1;
    }

    player gameobjects::updateuiprogress(self, 1);

    if(self.curprogress >= self.usetime) {
      return player::isreallyalive(player);
    }

    waitframe();
  }

  return 0;
}

function createuseent() {
  useent = spawn("script_origin", self.origin);
  useent.curprogress = 0;
  useent.usetime = 0;
  useent.userate = 3000;
  useent.inuse = 0;
  useent.id = self.id;
  useent linkTo(self);
  useent thread deleteuseent(self);
  return useent;
}

function deleteuseent(owner) {
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

function isplayerusing(weapon) {
  return !level.gameended && isDefined(weapon) && player::isreallyalive(self) && self useButtonPressed() && !self isonladder() && !self meleeButtonPressed() && weapon.curprogress < weapon.usetime && (!isDefined(self.teleporting) || !self.teleporting);
}

function weaponcanstoreaccuracystats(objweapon) {
  if(iscacmeleeweapon(objweapon.basename)) {
    return false;
  }

  return iscacprimaryweapon(objweapon.basename) || iscacsecondaryweapon(objweapon.basename);
}

function setweaponstat(weapon, incvalue, statname, otherent) {
  scripts\mp\gamelogic::setweaponstat(weapon, incvalue, statname, otherent);
}

function watchweaponusage(weaponhand) {
  self endon("death_or_disconnect");
  self endon("faux_spawn");
  level endon("game_ended");

  for(;;) {
    self waittill("weapon_fired", objweapon);

    if(weaponclass(objweapon) == "rocketlauncher") {
      continue;
    }

    if(weaponclass(objweapon) == "grenade") {
      if(issubstr(objweapon.basename, "la_mike32")) {
        setweaponstat(objweapon, 1, "shots");
        scripts\mp\utility\stats::incpersstat("shotsFired", 1);
        thread namespace_6b49ddb858f34366::function_298b6dd0b26f13bd();
        thread namespace_6b49ddb858f34366::function_2efd6926efd58b49(0);
        continue;
      }
    }

    onweaponfired(objweapon);
  }
}

function onweaponfired(objweapon, missileent) {
  scripts\mp\gamelogic::sethasdonecombat(self, 1);
  self.lastshotfiredtime = gettime();
  scripts\mp\codcasterclientmatchdata::function_1882f80b14421089(0, 1);

  if(!istrue(self.var_d4102e2eff8e8a45)) {
    self.var_d4102e2eff8e8a45 = 1;
    scripts\mp\utility\stats::initpersstat("shotsFired");
  }

  if(isai(self)) {
    if(istrue(level.var_c1d58bf29dcae79)) {
      scripts\mp\utility\stats::incpersstat("shotsFired", 1);
    }

    var_366b0ecc2f28aead = getcompleteweaponname(objweapon);

    if(issubstr(var_366b0ecc2f28aead, "jup_jp22_la_dromeo")) {
      self setweaponammoclip(objweapon, 999);
      var_a2cfbc2c4f504a0e = getgametype() == "ob";

      if(var_a2cfbc2c4f504a0e) {
        thread function_aa3939ed0f60d04e(objweapon, missileent);
        return;
      }

      thread function_e0780928b2591268(objweapon, missileent);
    }

    return;
  }

  thread processactiveshots(objweapon, missileent);
}

function processactiveshots(objweapon, missileent) {
  self endon("disconnect");
  var_366b0ecc2f28aead = getcompleteweaponname(objweapon);
  self notify("processActiveShots_" + var_366b0ecc2f28aead);
  self endon("processActiveShots_" + var_366b0ecc2f28aead);

  if(!isDefined(self.activeshots)) {
    self.activeshots = [];
  }

  if(!isDefined(self.activeshots[var_366b0ecc2f28aead])) {
    self.activeshots[var_366b0ecc2f28aead] = 0;
  }

  self.activeshots[var_366b0ecc2f28aead]++;

  if(!isDefined(self.activemissiles)) {
    self.activemissiles = [];
  }

  if(issubstr(var_366b0ecc2f28aead, "jup_jp22_la_dromeo") && !objweapon hasattachment("jup_dromeo_rec_amp")) {
    self setweaponammoclip(objweapon, 999);
    var_a2cfbc2c4f504a0e = getgametype() == "ob";

    if(var_a2cfbc2c4f504a0e) {
      thread function_aa3939ed0f60d04e(objweapon, missileent);
    } else {
      thread function_e0780928b2591268(objweapon, missileent);
    }
  }

  if(isDefined(missileent)) {
    if(!isDefined(self.activemissiles[var_366b0ecc2f28aead])) {
      self.activemissiles[var_366b0ecc2f28aead] = [];
    }

    self.activemissiles[var_366b0ecc2f28aead][self.activemissiles[var_366b0ecc2f28aead].size] = missileent;
  }

  setweaponstat(objweapon, 1, "shots");
  scripts\mp\utility\stats::incpersstat("shotsFired", 1);
  thread namespace_6b49ddb858f34366::function_298b6dd0b26f13bd();
  thread namespace_6b49ddb858f34366::function_2efd6926efd58b49(0);
  watchformiss(objweapon, var_366b0ecc2f28aead);
  totalshots = self.activeshots[var_366b0ecc2f28aead];
  hitshots = isDefined(self.hits[var_366b0ecc2f28aead]) ? self.hits[var_366b0ecc2f28aead] : 0;
  var_a35ea66201ac92e8 = isDefined(self.agenthits[var_366b0ecc2f28aead]) ? self.agenthits[var_366b0ecc2f28aead] : 0;
  var_202acce87e9d7f6 = isDefined(self.playerhits[var_366b0ecc2f28aead]) ? self.playerhits[var_366b0ecc2f28aead] : 0;
  missedshots = totalshots - hitshots;

  if(weaponcanstoreaccuracystats(objweapon)) {
    setweaponstat(objweapon, hitshots, "hits");
    setweaponstat(objweapon, var_a35ea66201ac92e8, "ai_hits");
    setweaponstat(objweapon, var_202acce87e9d7f6, "player_hits");

    if(onlinestatsenabled()) {
      shotstat = getplayerstat("combatStats", "totalShots");
      missstat = getplayerstat("combatStats", "misses");
      setplayerstatbuffered(shotstat + totalshots, "combatStats", "totalShots");
      setplayerstatbuffered(missstat + missedshots, "combatStats", "misses");
    }
  }

  scripts\mp\events::shotmissed(totalshots, hitshots);
  scripts\mp\events::function_cf1cfbbec7d07d44(totalshots, missedshots);
  self.activeshots[var_366b0ecc2f28aead] = 0;
  self.hits[var_366b0ecc2f28aead] = 0;
  self.agenthits[var_366b0ecc2f28aead] = 0;
  self.playerhits[var_366b0ecc2f28aead] = 0;

  if(isDefined(self.activemissiles[var_366b0ecc2f28aead])) {
    self.activemissiles[var_366b0ecc2f28aead] = [];
  }
}

function private watchformiss(objweapon, var_366b0ecc2f28aead) {
  self endon("disconnect");

  if(isDefined(self.activemissiles[var_366b0ecc2f28aead])) {
    while(true) {
      activemissiles = 0;

      foreach(missile in self.activemissiles[var_366b0ecc2f28aead]) {
        if(isDefined(missile)) {
          activemissiles++;
        }
      }

      if(activemissiles == 0) {
        break;
      }

      waitframe();
    }

    return;
  }

  wait 6;
}

function watchfornearmisswhizby() {
  self endon("death_or_disconnect");
  self endon("faux_spawn");
  level endon("game_ended");

  while(true) {
    self waittill("attackerbulletwhizby");
    addtoplayerstatbuffered(1, "combatStats", "nearMisses");
  }
}

function checkhit(objweapon, victim, shitloc, idamage) {
  self endon("disconnect");

  if(function_483cc81bff18273b(self)) {
    return;
  }

  var_366b0ecc2f28aead = getcompleteweaponname(objweapon);

  if(objweapon.isalternate) {
    attachments = getweaponattachments(objweapon);

    if(array_contains(attachments, "shotgun") || array_contains(attachments, "gl") || array_contains(attachments, "glsmoke") || array_contains(attachments, "glgas") || array_contains(attachments, "glconc") || array_contains(attachments, "glflash") || array_contains(attachments, "glincendiary") || array_contains(attachments, "glsemtex") || array_contains(attachments, "glsnap")) {
      self.hits[var_366b0ecc2f28aead] = 1;

      if(isDefined(victim)) {
        if(isagent(victim)) {
          self.agenthits[var_366b0ecc2f28aead] = 1;
        } else if(isPlayer(victim)) {
          self.playerhits[var_366b0ecc2f28aead] = 1;
        }
      }
    }
  }

  if(!weaponcanstoreaccuracystats(objweapon)) {
    return;
  }

  var_881576b7106f54ce = self meleeButtonPressed();

  if(var_881576b7106f54ce && objweapon.basename != "iw8_knife_mp") {
    return;
  }

  if(!isDefined(self.hits[var_366b0ecc2f28aead])) {
    self.hits[var_366b0ecc2f28aead] = 0;
  }

  if(!isDefined(self.agenthits[var_366b0ecc2f28aead])) {
    self.agenthits[var_366b0ecc2f28aead] = 0;
  }

  if(!isDefined(self.playerhits[var_366b0ecc2f28aead])) {
    self.playerhits[var_366b0ecc2f28aead] = 0;
  }

  switch (weaponclass(objweapon)) {
    case #"hash_6191aaef9f922f96":
    case #"hash_719417cb1de832b6":
    case #"hash_8cdaf2e4ecfe5b51":
    case #"hash_900cb96c552c5e8e":
    case #"hash_fa24dff6bd60a12d":
      self.hits[var_366b0ecc2f28aead]++;

      if(isagent(victim)) {
        self.agenthits[var_366b0ecc2f28aead]++;
      } else if(isPlayer(victim)) {
        self.playerhits[var_366b0ecc2f28aead]++;
      }

      break;
    case #"hash_690c0d6a821b42e":
      self.hits[var_366b0ecc2f28aead] = 1;

      if(isagent(victim)) {
        self.agenthits[var_366b0ecc2f28aead] = 1;
      } else if(isPlayer(victim)) {
        self.playerhits[var_366b0ecc2f28aead] = 1;
      }

      break;
    case #"hash_61e969dacaaf9881":
      self.hits[var_366b0ecc2f28aead] = 1;

      if(isagent(victim)) {
        self.agenthits[var_366b0ecc2f28aead] = 1;
      } else if(isPlayer(victim)) {
        self.playerhits[var_366b0ecc2f28aead] = 1;
      }

      break;
    case #"hash_e224d0b635d0dadd":
      self.hits[var_366b0ecc2f28aead] = 1;

      if(isagent(victim)) {
        self.agenthits[var_366b0ecc2f28aead] = 1;
      } else if(isPlayer(victim)) {
        self.playerhits[var_366b0ecc2f28aead] = 1;
      }

      break;
    default:
      break;
  }

  if(isriotshield(objweapon.basename) || objweapon.basename == "iw8_knife_mp") {
    thread scripts\mp\gamelogic::threadedsetweaponstatbyname(var_366b0ecc2f28aead, self.hits[var_366b0ecc2f28aead], "hits");
    self.hits[var_366b0ecc2f28aead] = 0;
    thread scripts\mp\gamelogic::threadedsetweaponstatbyname(var_366b0ecc2f28aead, self.agenthits[var_366b0ecc2f28aead], "ai_hits");
    self.agenthits[var_366b0ecc2f28aead] = 0;
    thread scripts\mp\gamelogic::threadedsetweaponstatbyname(var_366b0ecc2f28aead, self.playerhits[var_366b0ecc2f28aead], "player_hits");
    self.playerhits[var_366b0ecc2f28aead] = 0;
  }

  if(!var_881576b7106f54ce) {
    scripts\mp\codcasterclientmatchdata::function_1882f80b14421089(1, 1);
  }

  if(!isDefined(self.lasthittime[var_366b0ecc2f28aead])) {
    self.lasthittime[var_366b0ecc2f28aead] = 0;
  }

  if(self.lasthittime[var_366b0ecc2f28aead] == gettime()) {
    return;
  }

  self.lasthittime[var_366b0ecc2f28aead] = gettime();

  if(onlinestatsenabled()) {
    totalshots = getplayerstat("combatStats", "totalShots");
    hits = getplayerstat("combatStats", "hits") + 1;

    if(hits <= totalshots) {
      setplayerstatbuffered(hits, "combatStats", "hits");
      setplayerstatbuffered(int(totalshots - hits), "combatStats", "misses");
    }
  }

  thread scripts\mp\events::shothit();
  thread scripts\mp\events::function_2fca19675eb69f1a(victim, shitloc, idamage);
  weapongroup = getweapongroup(objweapon.basename);

  if(weapongroup == "weapon_lmg") {
    if(!isDefined(self.shotslandedlmg)) {
      self.shotslandedlmg = 1;
    } else {
      self.shotslandedlmg++;
    }
  }

  currenttime = gettime();
  self.pers["lastDamageTime"] = currenttime;

  if(isDefined(victim)) {
    victim.lasttimedamaged = currenttime;

    if(istrue(victim.var_381cb6b216dfa1a5) && !isinlaststand(victim)) {
      victim.lastshottime = currenttime;
    }
  }
}

function friendlyfirecheck(owner, attacker, forcedfriendlyfirerule, forced) {
  if(!isDefined(owner) || !isDefined(owner.team)) {
    return true;
  }

  if(!level.teambased) {
    return true;
  }

  friendlyfirerule = level.friendlyfire;

  if(isDefined(forcedfriendlyfirerule)) {
    friendlyfirerule = forcedfriendlyfirerule;
  }

  if(friendlyfirerule != 0) {
    return true;
  }

  if(attacker == owner || isDefined(attacker.owner) && attacker.owner == owner) {
    return true;
  }

  attackerteam = undefined;

  if(isDefined(attacker.owner)) {
    attackerteam = attacker.owner.team;
  } else if(isDefined(attacker.team)) {
    attackerteam = attacker.team;
  }

  if(!isDefined(attackerteam)) {
    return true;
  }

  if(attackerteam != owner.team) {
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
  var_7a9a49126147a952 = getintproperty(@ "scr_deleteexplosivesonspawn", 1) && (!_hasperk("specialty_rugged_eqp") || !checkequipforrugged());

  if(var_7a9a49126147a952) {
    deleteplacedequipment();
  }

  var_194edbe6d906c4e6 = self.plantedtacticalequip.size;
  var_c7e5188314606729 = self.plantedlethalequip.size;
  var_9df2225241e8340a = self.plantedsuperequip.size;
  var_a81b9997da958d97 = self.plantedhackedequip.size;
}

function getallequip() {
  allequip = [];

  if(isDefined(self.plantedlethalequip)) {
    allequip = array_combine(allequip, self.plantedlethalequip);
  }

  if(isDefined(self.plantedtacticalequip)) {
    allequip = array_combine(allequip, self.plantedtacticalequip);
  }

  if(isDefined(self.plantedsuperequip)) {
    allequip = array_combine(allequip, self.plantedsuperequip);
  }

  if(isDefined(self.plantedhackedequip)) {
    allequip = array_combine(allequip, self.plantedhackedequip);
  }

  return allequip;
}

function removeequip(equip) {
  if(isDefined(self.plantedlethalequip)) {
    self.plantedlethalequip = array_remove(self.plantedlethalequip, equip);
  }

  if(isDefined(self.plantedtacticalequip)) {
    self.plantedtacticalequip = array_remove(self.plantedtacticalequip, equip);
  }

  if(isDefined(self.plantedsuperequip)) {
    self.plantedsuperequip = array_remove(self.plantedsuperequip, equip);
  }

  if(isDefined(self.plantedhackedequip)) {
    self.plantedhackedequip = array_remove(self.plantedhackedequip, equip);
  }
}

function checkequipforrugged() {
  equipment = array_combine(self.plantedtacticalequip, self.plantedlethalequip);

  foreach(equip in equipment) {
    if(isDefined(equip.hasruggedeqp)) {
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

  while(true) {
    watchgrenadethrows();
  }
}

function watchgrenadethrows() {
  grenade = waittill_grenade_throw();
  grenadeused(grenade);

  if(isDefined(grenade)) {
    grenade function_5226227bce83ebe9(3, self.team);
  }
}

function registerusedcallback(weaponrootstring, callback) {
  if(!isDefined(level.var_b2b35840c12ce55c)) {
    level.var_b2b35840c12ce55c = [];
  }

  assertex(!isDefined(level.var_b2b35840c12ce55c[weaponrootstring]), "<dev string:x203>");
  level.var_b2b35840c12ce55c[weaponrootstring] = callback;
}

function grenadeused(grenade) {
  if(!isDefined(grenade)) {
    return;
  }

  if(!isDefined(grenade.weapon_name)) {
    return;
  }

  weaponrootname = getweaponrootstring(grenade.weapon_object);

  if(weaponrootname == "deploy_weapondrop") {
    return;
  }

  if(isPlayer(self)) {
    setweaponstat(grenade.weapon_object, 1, "shots");
    scripts\mp\battlechatter_mp::ongrenadeuse(grenade);
    scripts\mp\gamelogic::sethasdonecombat(self, 1);

    if(isDefined(grenade.equipmentref)) {
      islethal = scripts\mp\equipment::isequipmentlethal(grenade.equipmentref);
      istactical = scripts\mp\equipment::isequipmenttactical(grenade.equipmentref);
      scripts\mp\potg_events::grenadethrownevent(islethal);

      if(isDefined(istactical) && self isthrowingbackgrenade() && getdvarint(@ "hash_61a8d5707f364581", 1)) {
        self function_9b5704d0633b87fa();
        objweapon = makeweapon(grenade.weapon_name);
        ammo = self getweaponammoclip(objweapon);
        newammo = int(max(ammo - 1, 0));
        self setweaponammoclip(objweapon, newammo);
      }

      blueprintindex = grenade.weapon_object.variantid;

      if(!isDefined(blueprintindex)) {
        blueprintindex = 0;
      }

      if(blueprintindex > 0) {
        tableinfo = getequipmenttableinfo(grenade.equipmentref);
        var_9b32d1936831f5aa = function_71efed8bf57f1d39(tableinfo.bundle, blueprintindex);

        if(isDefined(var_9b32d1936831f5aa)) {
          self function_9bc014e7042e8339(var_9b32d1936831f5aa);
        }
      }
    }

    scripts\cp_mp\talking_gun::function_ef6885141252869(self, grenade);

    if(scripts\mp\utility\weapon::issuperweapon(grenade.weapon_object)) {
      if(!scripts\common\values::get("supers") || istrue(self.var_859654e0445a36d9)) {
        if(scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
          if(isinlaststand(self)) {
            superref = scripts\mp\supers::getsuperrefforsuperweapon(grenade.weapon_object);
            self.var_a188fba649ffd953 = superref;
          }
        }

        grenade delete();
        return;
      }
    }
  }

  if(isaxeweapon(grenade.weapon_name)) {
    grenade thread watchgrenadeaxepickup(self);
    return;
  }

  grenade thread scripts\mp\battlechatter_mp::grenadeproximitytracking();
  grenade.spawnpos = grenade.origin;
  scripts\mp\pmc_missions::ongrenadeused(grenade, self, weaponrootname);

  if(isDefined(level.var_b2b35840c12ce55c[weaponrootname])) {
    self thread[[level.var_b2b35840c12ce55c[weaponrootname]]](grenade);
  } else {
    switch (weaponrootname) {
      case #"hash_7c03088193266bc4":
        if(grenade.ticks >= 1) {
          grenade.iscooked = 1;
        }

        grenade.originalowner = self;
        grenade thread scripts\mp\shellshock::grenade_earthquake();
        break;
      case #"hash_965fb4c0595f06cd":
        if(grenade.ticks >= 1) {
          grenade.iscooked = 1;
        }

        grenade.originalowner = self;
        thread scripts\mp\equipment\wristrocket::wristrocketused(grenade);
        grenade thread scripts\mp\shellshock::grenade_earthquake(0.6);
        break;
      case #"hash_5d11ac1131cddab1":
        thread semtex_used(grenade);
        grenade thread scripts\mp\shellshock::grenade_earthquake();
        break;
      case #"hash_fa4b81880311c2b":
        thread scripts\mp\equipment\c4::c4_used(grenade);
        var_d7b337718e8ecf0e = spawnStruct();
        var_d7b337718e8ecf0e.grenade = grenade;
        callback("dao_c4_used", var_d7b337718e8ecf0e);
        break;
      case #"hash_fa1e80f6bd5b8e72":
        thread scripts\mp\equipment\c4::c4_used(grenade);
        break;
      case #"hash_3c2d21aea30374d4":
        thread function_f3bb4f4911a1beb2("emp_grenade", "emp_grenade_used", grenade);
        break;
      case #"hash_42dcb6ce7ecb709c":
        thread scripts\mp\equipment\snapshot_grenade::snapshot_grenade_used(grenade, 0);
        break;
      case #"hash_e1f6f84e4cd950eb":
        grenade thread scripts\mp\equipment\smoke_grenade::smokegrenadeused(0);
        break;
      case #"hash_13d1f84d0ae96a5f":
        if(isPlayer(self)) {
          thread trophy_used(grenade);
        }

        break;
      case #"hash_36b7174a04de8799":
        if(isagent(self)) {
          thread namespace_d4389b4b98ee0dc0::function_af4eb22319ad376(grenade);
        } else {
          thread scripts\mp\equipment\claymore::claymore_use(grenade);
        }

        break;
      case #"hash_9d57562863499a06":
        thread scripts\mp\equipment\at_mine::at_mine_use(grenade);
        break;
      case #"hash_530ba8d82158ca97":
        thread scripts\mp\equipment\combataxe::function_81863480a8885799(grenade);
        break;
      case #"hash_b7f5380094623046":
      case #"hash_2ab98cab4066a74e":
        thread scripts\cp_mp\equipment\throwing_knife::throwing_knife_used(grenade);
        break;
      case #"hash_c9a436974fe60919":
        grenade thread scripts\mp\shellshock::grenade_earthquake();
        thread scripts\mp\equipment\molotov::molotov_used(grenade);
        break;
      case #"hash_a0319e349a692b8f":
        thread scripts\mp\equipment\thermite::thermite_used(grenade);
        break;
      case #"hash_3cc897796b318cd9":
        thread scripts\mp\supers\spawnbeacon::thrown(grenade);
        break;
      case #"hash_c840f84ccc359da4":
      case #"hash_7a494a6441a8df6":
      case #"hash_7e0a03ed7c4c87be":
      case #"hash_6bc36a1e4f485a79":
      case #"hash_69bb92722794d72f":
      case #"hash_526718f50b85440e":
      case #"hash_cd2d060ee0632a30":
      case #"hash_f0c0b9ea65729629":
        thread scripts\mp\equipment\support_box::supportbox_used(grenade);
        break;
      case #"hash_333525cef39d0c66":
        thread scripts\mp\equipment\decoy_grenade::decoy_used(grenade);
        break;
      case #"hash_fb36696c0708bf42":
        thread scripts\mp\equipment\gas_grenade::gas_used(grenade);
        break;
      case #"hash_7983828e72e83a3e":
      case #"hash_cedad6d52b2b36c2":
        if(issharedfuncdefined("super_hb_sensor", "hb_sensor_used")) {
          thread function_f3bb4f4911a1beb2("super_hb_sensor", "hb_sensor_used", grenade);
        }

        break;
      case #"hash_e61f1a05dec2770":
        thread scripts\mp\equipment\binoculars::binoculars_used(grenade);
        break;
      case #"hash_17d5fde761fc574b":
        thread scripts\mp\equipment\tactical_cover::tac_cover_used(grenade);
        break;
      case #"hash_7fd9546fa84e64a5":
      case #"hash_a68928468343f517":
        if(istrue(self.var_8e61d4338428b3bd)) {
          self.var_8e61d4338428b3bd = 0;
          grenade delete();
          break;
        }

        thread scripts\mp\equipment\tac_insert::tacinsert_used(grenade);
        break;
      case #"hash_e5163523e542c46c":
        thread scripts\mp\equipment\advanced_supply_drop::advanced_supply_drop_marker_used(grenade);
        break;
      case #"hash_26f2bb279cde043f":
        if(isDefined(level.var_ff4bbeb786042d78)) {
          self thread[[level.var_ff4bbeb786042d78]](grenade);
        }

        break;
      case #"hash_8596111ca1d99c77":
        thread scripts\mp\equipment\advanced_supply_drop::function_f3e74468f0e5f521(grenade);
        break;
      case #"hash_8ae2b02f9a08357a":
        thread scripts\mp\equipment\weapon_drop::weapondrop_used(grenade);
        break;
      case #"hash_8670ac083666f3a4":
        grenade thread concussionused();
        break;
      case #"hash_c749c88b18be256f":
        thread scripts\mp\equipment\tactical_camera::function_dbeca4d95f44293d(grenade);
        break;
      case #"hash_64358af9c6c1edea":
        thread scripts\mp\equipment\sonar_pulse::function_2d117eeb564f6ea3(grenade);
        break;
      case #"hash_1ff8309cfb0a09c5":
        if(isagent(self)) {
          thread namespace_ade096b4b575e46c::function_7b988e1bb56ca747(grenade);
        } else {
          thread scripts\mp\equipment\sound_veil::function_6d91f8514005d18(grenade);
        }

        break;
      case #"hash_d197e38e5fa659dd":
        thread scripts\cp_mp\equipment\geiger_counter::function_3d5c1674387c936e(grenade);
        break;
      case #"hash_2994f46753d1edff":
        if(issharedfuncdefined("equip_aethercounter", "used")) {
          thread function_f3bb4f4911a1beb2("equip_aethercounter", "used", grenade);
        }

        break;
      case #"hash_b97f84c02b147504":
        thread scripts\mp\equipment\deployed_decoy::function_255bed505249bc85(grenade);
        break;
      case #"hash_11a03a12f93f62b2":
        thread scripts\mp\equipment\shock_stick::function_54655641d3957e3(grenade, 0);
        break;
      case #"hash_d9108a0595d7d0b9":
        thread scripts\mp\equipment\bunkerbuster::function_3d78dd516c25ef77(grenade);
        break;
      case #"hash_4714926c2f3e2d15":
        thread scripts\mp\equipment\ied::ied_used(grenade);
        break;
      case #"hash_f7d2b3d20ecdcc2c":
        thread scripts\mp\equipment\proximity_alarm::function_477d655fc0ede218(grenade);
        break;
      case #"hash_2d5c96c5718a6446":
        grenade thread scripts\mp\shellshock::grenade_earthquake();
        break;
      case #"hash_15c765aa76e58c8a":
        if(issharedfuncdefined(#"super_landmine", #"use", 1)) {
          damage = [[getsharedfunc(#"super_landmine", #"use")]](grenade);
        }

        break;
      case #"hash_94584bc84d5262fb":
        thread scripts\mp\supers\gas_trap::function_9eb2b20f81d7c464(grenade);
        break;
      case #"hash_41250f0591c8ecae":
        thread scripts\mp\supers\blindingturret::function_b02438cf4822a79e(grenade);
        break;
      case #"hash_72d6951f1472c8b3":
        thread scripts\mp\supers\loadout_drop::function_4ca6b5feba808692(grenade);
        break;
      case #"hash_85d7e1863dca54c4":
        thread scripts\mp\equipment\iodine_pills::function_7214173379da1591(grenade);
        break;
      case #"hash_22dbe57b7df54899":
      case #"hash_c03ed6f6f4fe9dad":
        self thread[[scripts\engine\utility::getsharedfunc(weaponrootname, "grenadeUsed")]](grenade);
        break;
      case #"hash_8747706404533493":
        thread scripts\cp_mp\equipment\throwstar::function_709581d70ebb07cd(grenade);
        break;
      case #"hash_f219d5163a73c117":
        thread scripts\cp_mp\equipment\thermal_phone::function_230403b8cf5ea1e8(grenade);
        break;
      case #"hash_444e24c19329aec0":
        thread scripts\engine\utility::function_f3bb4f4911a1beb2("pmc_missions", "onFlarePlaced", grenade);
        break;
      case #"hash_151a2c18538b6dc4":
        thread scripts\mp\equipment\spycam::function_ba4f176b24eb2f54(grenade);
        break;
      case #"hash_4091bf4696831b2a":
        thread scripts\mp\equipment\tracker_grenade::function_b46c661d38c61aa2(grenade);
        break;
      case #"hash_849c32fe9df2b823":
        if(scripts\engine\utility::issharedfuncdefined("super_capture_bot", "captureBot_used")) {
          self thread[[scripts\engine\utility::getsharedfunc("super_capture_bot", "captureBot_used")]](grenade);
        }

        break;
      case #"hash_5f29cda9550e6a3a":
        thread scripts\mp\equipment\butterfly_mine::function_539f38f444d5b41a(grenade);
        break;
      case #"hash_17c70dc48424ba92":
        if(issharedfuncdefined("breacher_drone", "breacher_drone_used")) {
          self thread[[getsharedfunc("breacher_drone", "breacher_drone_used")]](grenade);
        }

        break;
      case #"hash_37f0e5959e7222f":
        if(scripts\engine\utility::issharedfuncdefined("super_med_box", "medBox_used")) {
          self thread[[scripts\engine\utility::getsharedfunc("super_med_box", "medBox_used")]](grenade);
        }

        break;
      case #"hash_606cb2a6a1a3bd0a":
        if(issharedfuncdefined("thermobaric_grenade", "thermobaric_grenade_used")) {
          self thread[[getsharedfunc("thermobaric_grenade", "thermobaric_grenade_used")]](grenade);
        }

        break;
      case #"hash_80e255f3c96bc326":
        thread scripts\mp\equipment\battlerage::function_905b7bada6fd91cb();
        break;
      case #"hash_24fa33b49ea5081":
        if(issharedfuncdefined("super_comm_scrambler", "commScrambler_used")) {
          self thread[[getsharedfunc("super_comm_scrambler", "commScrambler_used")]](grenade);
        }

        break;
      case #"hash_ed63836c000de77f":
        if(issharedfuncdefined("super_evg", "evg_used")) {
          self thread[[getsharedfunc("super_evg", "evg_used")]](grenade);
        }

        break;
      case #"hash_74ea92f6d496465f":
        thread scripts\mp\supers\vehicle_drop::function_604ed6f2f8323ea6(grenade);
        break;
      case #"hash_d111e0af321b440f":
        thread function_f3bb4f4911a1beb2("equip_tracker_mine", "tracker_mine_used", grenade);
        break;
      default:
        if(isDefined(level.ongrenadeused)) {
          [[level.ongrenadeused]](grenade.weapon_name, grenade);
        }

        break;
    }
  }

  if(isPlayer(self)) {
    logequipmentuse(grenade);
  }
}

function logequipmentuse(grenade) {
  if(!isDefined(grenade)) {
    return;
  }

  equipment_type = getequipmenttype(grenade.weapon_object);

  if(!isDefined(equipment_type)) {
    equipment_type = "none";
  }

  self dlog_recordplayerevent("dlog_event_equipment_use", ["weapon_used", grenade.weapon_name, "equipment_type", equipment_type]);
}

function concussionused() {
  thread notifyafterframeend("death", "end_explode");
  self endon("end_explode");
  owner = self.owner;
  self waittill("explode", position);
  thread scripts\mp\equipment\concussion_grenade::onexplode(owner, position);
}

function watchgrenadedeath() {
  self waittill("death");

  if(isDefined(self.knife_trigger)) {
    self.knife_trigger delete();
  }

  if(isDefined(self.useobj_trigger)) {
    self.useobj_trigger delete();
  }
}

function function_e00b77a9cb4d8322(target) {
  if(!isDefined(level.special_lockon_target_list)) {
    level.special_lockon_target_list = [];
  }

  level.special_lockon_target_list[level.special_lockon_target_list.size] = target;
}

function function_1a33bd42949ccbda(target) {
  if(!isDefined(level.special_lockon_target_list)) {
    level.special_lockon_target_list = [];
  }

  level.special_lockon_target_list = scripts\engine\utility::array_remove(level.special_lockon_target_list, target);
}

function lockonlaunchers_gettargetarray(addcharacters) {
  targets = [];
  var_e688b198aa9a4b3f = 0;

  var_e688b198aa9a4b3f = getdvarint(@ "hash_10368af4dee3ba2c", 0);

  if(isDefined(level.special_lockon_target_list)) {
    level.special_lockon_target_list = array_removeundefined(level.special_lockon_target_list);

    foreach(special_target in level.special_lockon_target_list) {
      targets[targets.size] = special_target;
    }
  }

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
        if(isDefined(streak) && isDefined(streak.affectedbylockon) && (streak.team != self.team || var_e688b198aa9a4b3f)) {
          targets[targets.size] = streak;
        }
      }
    }

    if(isDefined(level.cratedropdata)) {
      if(isDefined(level.cratedropdata.ac130s)) {
        foreach(ac130 in level.cratedropdata.ac130s) {
          if(isDefined(ac130) && (ac130.team != self.team || var_e688b198aa9a4b3f)) {
            targets[targets.size] = ac130;
          }
        }
      }
    }

    foreach(vehicleref in scripts\cp_mp\vehicles\vehicle::function_9005b7fc076293f8()) {
      vehicles = scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_getgameinstances(vehicleref);

      foreach(vehicle in vehicles) {
        if(isDefined(vehicle) && !istrue(vehicle.disablelockon) && (!scripts\cp_mp\vehicles\vehicle::vehicle_isfriendlytoplayer(vehicle, self) || var_e688b198aa9a4b3f)) {
          targets[targets.size] = vehicle;
        }
      }
    }

    if(isDefined(level.loot_choppers)) {
      foreach(lootchopper in level.loot_choppers) {
        if(isDefined(lootchopper)) {
          targets[targets.size] = lootchopper;
        }
      }
    }

    if(isDefined(level.var_cbfdb6b806e34512)) {
      foreach(locktarget in level.var_cbfdb6b806e34512) {
        targets[targets.size] = locktarget;
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
        if(istrue(vehicle.disablelockon)) {
          continue;
        }

        if(!isDefined(vehicle.owner)) {
          targets[targets.size] = vehicle;
          continue;
        }

        if(vehicle.owner != self || var_e688b198aa9a4b3f) {
          targets[targets.size] = vehicle;
        }
      }
    }

    if(isDefined(level.var_cbfdb6b806e34512)) {
      foreach(locktarget in level.var_cbfdb6b806e34512) {
        targets[targets.size] = locktarget;
      }
    }
  }

  return targets;
}

function watchmissileusage() {
  self endon("disconnect");

  for(;;) {
    [objweapon, missile] = waittill_missile_fire();
    updatemissilefire(missile);
    onweaponfired(objweapon, missile);
  }
}

function updatemissilefire(missile) {
  missiletarget = undefined;
  var_54a24336cc9a143d = 0;

  switch (missile.weapon_name) {
    case #"hash_13a265ac820ea0df":
    case #"hash_3e782fd775b72022":
      missiletarget = self.missilelaunchertarget;
      level thread scripts\mp\battlechatter_mp::launcherfired(missile);
      break;
    case #"hash_5c272c0617caebf0":
      missiletarget = self.javelin.target;
      level thread scripts\mp\battlechatter_mp::javelinfired(self.team, self.javelin.target.origin);
      break;
    case #"hash_c072f6a196dbf40":
    case #"hash_d691d2856bc1a843":
    case #"hash_bf9c1865fe3169c8":
    case #"hash_38dc6dbb8eff7509":
    case #"hash_b47addb656374bd0":
    case #"hash_4abff18a90f4694d":
    case #"hash_a8d2c4797815ac75":
    case #"hash_4ecb6207eebc4cec":
    case #"hash_a9624944fea13b90":
    case #"hash_c7fd45d736bb0811":
    case #"hash_d09faed5f3b6a217":
    case #"hash_d37e55e926fd69e0":
    case #"hash_db59530b972470ab":
      var_54a24336cc9a143d = 1;
      break;
    case #"hash_6839e0fa25920b48":
    case #"hash_76330cd4249843b0":
    case #"hash_b1efce72d7907146":
      var_54a24336cc9a143d = 1;
      missile thread scripts\mp\equipment\smoke_grenade::smokegrenadeused(1);
      break;
    case #"hash_1ebf04f1936c518":
    case #"hash_4782fb1d8fe443b3":
    case #"hash_3402dcecc4fdd15e":
    case #"hash_52bcd2bfaa128ca2":
      var_54a24336cc9a143d = 1;
      thread scripts\mp\equipment\gas_grenade::gas_used(missile);
      break;
    case #"hash_bf9186d366bb0638":
    case #"hash_46f5e5d5dcc40a15":
    case #"hash_4adaf4a688093960":
    case #"hash_d376328b0052cc6d":
    case #"hash_4aeb965aa988c369":
    case #"hash_d78170432d48ea13":
    case #"hash_91c4e6c99dbd12fa":
    case #"hash_e6645051b5b4b0d4":
      var_54a24336cc9a143d = 1;
      break;
    case #"hash_9bdd4a77de2178e1":
    case #"hash_1e9751b75f7cf232":
    case #"hash_a29ecb3d754c1403":
    case #"hash_a3991996e09eb513":
      var_54a24336cc9a143d = 1;
      missile thread scripts\mp\shellshock::grenade_earthquake();
      thread scripts\mp\equipment\thermite::thermite_used(missile, 1);
      break;
    case #"hash_1f2ad6f0a8a0da6b":
    case #"hash_a54bf40834af0df5":
    case #"hash_64b33ac96ed2f791":
    case #"hash_4d0defb6d4c7dd6c":
      var_54a24336cc9a143d = 1;
      break;
    case #"hash_f8bbf06ce7865e4":
    case #"hash_9d6247f9047b296c":
    case #"hash_c3d0fe2d2f18a4fa":
    case #"hash_75e72e81c0590e87":
    case #"hash_e1e8d438ee4215de":
      var_54a24336cc9a143d = 1;
      thread scripts\mp\equipment\bunkerbuster::function_d5fe78860931c577(missile);
      break;
    default:
      break;
  }

  if(isDefined(missile) && isDefined(missile.weapon_name) && missile.weapon_name == "jup_jp26_la_mike32_mp" && isDefined(missile.weapon_object)) {
    thread function_2d2bee2ee8b4efee(missile);
  }

  if(islockonlauncher(missile.weapon_name) && isDefined(missiletarget)) {
    missile.lockontarget = missiletarget;
    level notify("stinger_fired", self, missile, missiletarget);
    thread watchtargetlockedontobyprojectile(missiletarget, missile);
  }

  if(isPlayer(self)) {
    missile.adsfire = isplayerads();
  }

  if(!var_54a24336cc9a143d && isexplosivemissile(missile.weapon_name) && !function_63de97cb47983c1b(missile.weapon_name)) {
    scale = 1;

    if(issmallmissile(missile.weapon_name)) {
      scale = 0.65;
    }

    if(missile.weapon_name == "jup_jp26_la_mike32_mp") {
      scale = 0.4;
    }

    if(missile.weapon_name == "jup_pi_goldengun_mp") {
      scale = getdvarfloat(@ "hash_76a9ec5284933d62", 0.2);
      missile thread scripts\mp\shellshock::grenade_earthquake(scale);
    } else if(missile.weapon_name == "jup_cp01_sh_aromeo410_mp") {
      missile thread scripts\mp\shellshock::grenade_earthquake(0.3);
    } else {
      missile thread scripts\mp\shellshock::grenade_earthquake(scale);
    }
  }

  scripts\mp\events::missilefired(missile);
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

function function_63de97cb47983c1b(weapon_name) {
  if(!isDefined(level.var_f1339ee09ea219d8)) {
    return false;
  }

  if(isDefined(weapon_name) && array_contains(level.var_f1339ee09ea219d8, weapon_name)) {
    return true;
  }

  return false;
}

function function_d24bf01d284ef941(objweapon) {
  if(!isDefined(objweapon)) {
    return false;
  }

  var_366b0ecc2f28aead = getcompleteweaponname(objweapon);
  return istrue(issubstr(var_366b0ecc2f28aead, "jup_jp22_la_dromeo"));
}

function movingplatformdetonate(data) {
  if(!isDefined(data.lasttouchedplatform) || !isDefined(data.lasttouchedplatform.destroyexplosiveoncollision) || data.lasttouchedplatform.destroyexplosiveoncollision) {
    self notify("detonateExplosive");
  }
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

function monitordisownedgrenade(player, grenade) {
  level endon("game_ended");
  grenade endon("death");
  grenade endon("mine_planted");
  waittill_any_ents(player, "joined_team", player, "joined_spectators", player, "disconnect", level, "prematch_cleanup");

  if(isDefined(grenade)) {
    grenade delete();
  }
}

function isplantedequipment(ent) {
  return isDefined(level.mines[ent getentitynumber()]) || istrue(ent.planted);
}

function getmaxplantedlethalequip(player) {
  var_e416de928081866d = default_to(level.gamemodebundle.maxplantedlethalequip, 2);

  if(_hasperk("specialty_extra_planted_equipment")) {
    var_e416de928081866d++;
  }

  overridemax = getdvarint(@ "hash_f35cb6d0fbb90304", 0);

  if(overridemax > 0) {
    var_e416de928081866d = overridemax;
  }

  var_e416de928081866d = getdvarint(@ "hash_f378eaa0e2c019fa", var_e416de928081866d);
  return var_e416de928081866d;
}

function getmaxplantedtacticalequip(player) {
  var_30dc1c5e4b8568b0 = default_to(level.gamemodebundle.maxplantedtacticalequip, 2);

  if(_hasperk("specialty_extra_planted_equipment")) {
    var_30dc1c5e4b8568b0++;
  }

  overridemax = getdvarint(@ "hash_fa291a82a43e1ab1", 0);

  if(overridemax > 0) {
    var_30dc1c5e4b8568b0 = overridemax;
  }

  return var_30dc1c5e4b8568b0;
}

function getmaxplantedsuperequip(equipmentref) {
  if(scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    return 1;
  }

  return 2;
}

function function_80809994f5a396d0() {
  return 2;
}

function getmaxplantedhackedequip() {
  return 3;
}

function onequipmentplanted(newequipment, equipmentref, deletefunc, isagentowned) {
  newequipment.equipmentref = equipmentref;
  newequipment.deletefunc = deletefunc;
  newequipment.planted = 1;

  if(!istrue(isagentowned)) {
    updateplantedarray(newequipment);
  }

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

function updateplantedarray(equipment) {
  plantedarray = undefined;
  maxsize = 0;
  slot = scripts\mp\equipment::findequipmentslot(equipment.equipmentref);

  if(istrue(equipment.ishacked)) {
    plantedarray = equipment.owner.plantedhackedequip;
    maxsize = getmaxplantedhackedequip();
  } else if(istrue(equipment.issuper)) {
    if(equipment.equipmentref == "equip_tac_cover") {
      maxsize = function_80809994f5a396d0();
      plantedarray = equipment.owner.plantedsuperequip;
    } else {
      plantedarray = equipment.owner.plantedsuperequip;
      maxsize = getmaxplantedsuperequip(equipment.equipmentref);
    }
  } else if(isDefined(slot) && slot == "primary" || scripts\mp\equipment::isequipmentlethal(equipment.equipmentref)) {
    plantedarray = equipment.owner.plantedlethalequip;
    maxsize = getmaxplantedlethalequip(self);
  } else if(isDefined(slot) && slot == "secondary" || scripts\mp\equipment::isequipmenttactical(equipment.equipmentref)) {
    plantedarray = equipment.owner.plantedtacticalequip;
    maxsize = getmaxplantedtacticalequip(self);
  }

  if(!isDefined(plantedarray)) {
    issuper = equipment.issuper;
    equipmentref = equipment.equipmentref;

    if(!isDefined(issuper)) {
      issuper = "undefined";
    }

    if(!isDefined(slot)) {
      slot = "undefined";
    }

    if(!isDefined(equipmentref)) {
      equipmentref = "undefined";
    }

    message = "isSuper: " + issuper + ", slot: " + slot + ", equipmentRef: " + equipmentref + ", allowed: " + scripts\mp\equipment::is_equipment_slot_allowed("super");
    scripts\mp\utility\script::demoforcesre(message);
    return;
  }

  if(plantedarray.size > 0) {
    if(plantedarray.size && plantedarray.size >= maxsize) {
      var_e472d6dedb41acfd = plantedarray[0];
      plantedarray = array_remove(plantedarray, var_e472d6dedb41acfd);
      var_e472d6dedb41acfd deleteexplosive();
    }
  }

  plantedarray[plantedarray.size] = equipment;

  if(istrue(equipment.ishacked)) {
    equipment.owner.plantedhackedequip = plantedarray;
    return;
  }

  if(istrue(equipment.issuper)) {
    equipment.owner.plantedsuperequip = plantedarray;
    return;
  }

  if(isDefined(slot) && slot == "primary" || scripts\mp\equipment::isequipmentlethal(equipment.equipmentref)) {
    equipment.owner.plantedlethalequip = plantedarray;
    return;
  }

  if(isDefined(slot) && slot == "secondary" || scripts\mp\equipment::isequipmenttactical(equipment.equipmentref)) {
    equipment.owner.plantedtacticalequip = plantedarray;
  }
}

function setplantedequipmentuse(enabled) {
  allequip = getallequip();

  foreach(equip in allequip) {
    if(isDefined(equip.trigger) && isDefined(equip.owner)) {
      if(enabled) {
        equip.trigger enableplayeruse(equip.owner);
        continue;
      }

      equip.trigger disableplayeruse(equip.owner);
    }
  }
}

function cleanupequipment(equipnum, equipkillcament, equiptrigger) {
  if(isDefined(equipnum)) {
    level.mines[equipnum] = undefined;
  }

  if(isDefined(equipkillcament)) {
    equipkillcament delete();
  }

  if(isDefined(equiptrigger)) {
    equiptrigger delete();
  }
}

function equipmenthit(owner, attacker, objweapon, meansofdeath) {
  if(scripts\cp_mp\utility\player_utility::playersareenemies(attacker, owner)) {
    if(!isDefined(objweapon)) {
      return;
    }

    if(iskillstreakweapon(objweapon.basename)) {
      return;
    }

    var_366b0ecc2f28aead = getcompleteweaponname(objweapon);

    if(!isDefined(attacker.lasthittime)) {
      attacker.lasthittime = [];
    }

    if(!isDefined(attacker.lasthittime[var_366b0ecc2f28aead])) {
      attacker.lasthittime[var_366b0ecc2f28aead] = 0;
    }

    if(attacker.lasthittime[var_366b0ecc2f28aead] == gettime()) {
      return;
    }

    attacker.lasthittime[var_366b0ecc2f28aead] = gettime();
    attacker thread scripts\mp\gamelogic::threadedsetweaponstatbyname(var_366b0ecc2f28aead, 1, "hits");

    if(onlinestatsenabled()) {
      totalshots = attacker getplayerstat("combatStats", "totalShots");
      hits = attacker getplayerstat("combatStats", "hits") + 1;

      if(hits <= totalshots) {
        setplayerstatbuffered(hits, "combatStats", "hits");
        setplayerstatbuffered(int(totalshots - hits), "combatStats", "misses");
      }
    }

    if(isDefined(meansofdeath) && isbulletdamage(meansofdeath) || isprojectiledamage(meansofdeath)) {
      attacker.pers["lastDamageTime"] = gettime();
      weapongroup = getweapongroup(objweapon.basename);

      if(weapongroup == "weapon_lmg") {
        if(!isDefined(attacker.shotslandedlmg)) {
          attacker.shotslandedlmg = 1;
          return;
        }

        attacker.shotslandedlmg++;
      }
    }
  }
}

function deleteexplosive() {
  if(!isDefined(self)) {
    return;
  }

  scripts\mp\sentientpoolmanager::unregistersentient(self.sentientpool, self.sentientpoolindex);
  equipnum = self getentitynumber();
  level.mines[equipnum] = undefined;
  self disableplayermarks("equipment");

  if(isDefined(self.deletefunc)) {
    self thread[[self.deletefunc]]();
    self notify("deleted_equipment");
    return;
  }

  equipkillcament = self.killcament;
  equiptrigger = self.trigger;
  cleanupequipment(equipnum, equipkillcament, equiptrigger);
  self notify("deleted_equipment");
  self delete();
}

function makeexplosiveusable(offset) {
  assert(isDefined(self.owner));
  self setotherent(self.owner);

  if(!isDefined(offset)) {
    offset = 10;
  }

  trigger = spawn("script_origin", self.origin + offset * anglestoup(self.angles));
  trigger linkTo(self);
  self.trigger = trigger;
  trigger.owner = self;
  thread makeexplosiveusableinternal();
  return trigger;
}

function makeexplosiveusableinternal() {
  self endon("makeExplosiveUnusable");
  trigger = self.trigger;
  watchexplosiveusable();

  if(isDefined(self)) {
    trigger = self.trigger;
    self.trigger = undefined;
  }

  if(isDefined(trigger)) {
    trigger delete();
  }
}

function makeexplosiveunusable() {
  self notify("makeExplosiveUnusable");
  trigger = self.trigger;
  self.trigger = undefined;

  if(isDefined(trigger)) {
    trigger delete();
  }
}

function watchexplosiveusable() {
  owner = self.owner;
  trigger = self.trigger;
  self endon("death");
  trigger endon("death");
  owner endon("disconnect");
  level endon("game_ended");
  trigger setCursorHint("HINT_NOICON");
  trigger setselfusable(owner);
  trigger childthread notusableforjoiningplayers(owner);
  trigger childthread notusableafterownerchange(owner, self);
  trigger setexplosiveusablehintstring(self.weapon_name);

  while(true) {
    trigger waittillmatch("trigger", owner);

    if(isDefined(self.weapon_name)) {
      switch (self.weapon_name) {
        case #"hash_5e3fa526a48eaaa5":
          thread scripts\mp\equipment\trophy_system::trophy_pickup();
          break;
      }

      owner thread scripts\mp\equipment\c4::c4_resetaltdetonpickup();
    }

    owner playlocalsound("scavenger_pack_pickup");
    owner notify("scavenged_ammo", self.weapon_name);
    equipmentref = scripts\mp\equipment::getequipmentreffromweapon(makeweapon(self.weapon_name));

    if(isDefined(equipmentref) && self.owner scripts\mp\equipment::hasequipment(equipmentref)) {
      self.owner scripts\mp\equipment::incrementequipmentammo(equipmentref, 1);
    }

    thread deleteexplosive();
    return;
  }
}

function private function_1d982537b9dcb924(player) {
  if(!isPlayer(player)) {
    return false;
  }

  if(issharedfuncdefined("game", "isCommonItemEnabled")) {
    if(!function_f3bb4f4911a1beb2("game", "isCommonItemEnabled")) {
      return false;
    }

    if(!(issharedfuncdefined("game", "obtainItemEquip") && issharedfuncdefined("game", "getItemBundleNameFromRef"))) {
      return false;
    }

    return true;
  }

  return false;
}

function makeexplosiveusabletag(tagname, isgrenade) {
  self endon("death");
  self endon("makeExplosiveUnusable");
  owner = self.owner;
  weaponname = self.weapon_name;

  if(!isDefined(isgrenade)) {
    isgrenade = 0;
  }

  setselfusable(owner);

  if(isgrenade) {
    self enablemissilehint(1);
  } else {
    self setCursorHint("HINT_NOICON");
  }

  self sethinttag(tagname);
  self setuserange(72);
  setexplosiveusablehintstring(self.weapon_name);
  childthread notusableforjoiningplayers(owner);
  childthread notusableafterownerchange(owner, self);

  while(true) {
    self waittillmatch("trigger", owner);

    if(!isDefined(owner)) {
      continue;
    }

    if(istrue(owner.isjuggernaut)) {
      if(scripts\engine\utility::issharedfuncdefined("hud", "showErrorMessage")) {
        owner[[scripts\engine\utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/JUGG_CANNOT_BE_PICKED_UP");
      }

      continue;
    }

    objweapon = undefined;

    if(isDefined(weaponname)) {
      switch (weaponname) {
        case #"hash_5e3fa526a48eaaa5":
          thread scripts\mp\equipment\trophy_system::trophy_pickup();
          break;
      }

      owner thread scripts\mp\equipment\c4::c4_resetaltdetonpickup();
      owner notify("scavenged_ammo", weaponname);
      attachments = function_6527364c1ecca6c6(weaponname);
      objweapon = makeweapon(weaponname, attachments);
    }

    if(isDefined(objweapon)) {
      equipmentref = scripts\mp\equipment::getequipmentreffromweapon(objweapon);

      if(isDefined(equipmentref)) {
        if(owner scripts\mp\equipment::hasequipment(equipmentref)) {
          if(scripts\cp_mp\utility\game_utility::isbrstylegametype() && namespace_aead94004cf4c147::function_7e103028c464ab9a(scripts\cp_mp\utility\loot::function_b88cfb4893ceedac(equipmentref)) && owner scripts\mp\equipment::getequipmentammo(equipmentref) >= owner scripts\mp\equipment::getequipmentmaxammo(equipmentref)) {
            lootid = scripts\cp_mp\utility\loot::getlootidfromref(equipmentref);
            result = owner namespace_aead94004cf4c147::function_e01d9736b2d100ac(lootid, 1);

            if(istrue(result)) {
              fakepickup = spawnStruct();
              fakepickup.scriptablename = scripts\cp_mp\utility\loot::getscriptablefromlootid(lootid);
              fakepickup.count = 1;
              owner namespace_aead94004cf4c147::additemtobackpack(lootid, fakepickup);
            }
          } else if(owner scripts\mp\equipment::getequipmentammo(equipmentref) < owner scripts\mp\equipment::getequipmentmaxammo(equipmentref)) {
            owner scripts\mp\equipment::incrementequipmentammo(equipmentref, 1);
          } else {
            self.owner scripts\mp\hud_message::showerrormessage("MP/DENY_EQUIP_PICKUP");
            continue;
          }
        } else if(isDefined(level.onnewequipmentpickup)) {
          [[level.onnewequipmentpickup]](self.owner, equipmentref);
        } else if(function_1d982537b9dcb924(self.owner)) {
          itembundlename = function_f3bb4f4911a1beb2("game", "getItemBundleNameFromRef", equipmentref);
          itembundle = getscriptbundle("itemspawnentry:" + itembundlename);
          fakeitem = spawnStruct();
          fakeitem.count = 1;
          fakeitem.type = itembundle.scriptable;
          self.owner function_f3bb4f4911a1beb2("game", "obtainItemEquip", fakeitem, 0);
        }
      }
    }

    if(isDefined(weaponname)) {
      switch (weaponname) {
        case #"hash_5e8f81314553dd36":
          pickup_sfx = "iw9_proximity_mine_pickup";
          break;
        case #"hash_56ee829cc162271a":
          pickup_sfx = "iw9_c4_pickup";
          break;
        case #"hash_6a2e4f9c54756dc7":
          pickup_sfx = "iw9_claymore_pickup";
          break;
        case #"hash_432644fc4753dde9":
        case #"hash_435258fc47768fa7":
          pickup_sfx = "iw9_claymore_pickup";
          break;
        default:
          pickup_sfx = "scavenger_pack_pickup";
          break;
      }

      owner playlocalsound(pickup_sfx);
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

function setexplosiveusablehintstring(weaponname) {
  switch (weaponname) {
    case #"hash_56ee829cc162271a":
    case #"hash_a6444ed2a144f878":
    case #"hash_c45d19aa870ab607":
    case #"hash_c466ffaa8712dbde":
    case #"hash_c46d19aa871781fa":
      self setHintString(&"EQUIPMENT_HINTS/PICKUP_C4");
      break;
    case #"hash_5e8f81314553dd36":
    case #"hash_e651e30fb2abcd7a":
      self setHintString(&"EQUIPMENT_HINTS/PICKUP_AT_MINE");
      break;
    case #"hash_434c3afc4771e33f":
    case #"hash_6a2e4f9c54756dc7":
      self setHintString(&"EQUIPMENT_HINTS/PICKUP_CLAYMORE");
      break;
    case #"hash_cac2107b8e726d9d":
      self setHintString(&"EQUIPMENT_HINTS/PICKUP_GAS_GRENADE");
      break;
    case #"hash_5e3fa526a48eaaa5":
      self setHintString(&"EQUIPMENT_HINTS/PICKUP_TROPHY");
      break;
    case #"hash_1e5a5abc540b109f":
    case #"hash_1e6066bc540fa0b1":
    case #"hash_1e6744bc54157b59":
      self setHintString(&"EQUIPMENT_HINTS/PICKUP_TRACKER_MINE");
      break;
  }
}

function explosivehandlemovers(parent, var_b5f7c0806632d99b) {
  data = spawnStruct();
  data.linkparent = parent;
  data.deathoverridecallback = &movingplatformdetonate;
  data.endonstring = "death";

  if(scripts\cp_mp\utility\train_utility::is_train_ent(parent)) {
    data.var_49cb2c45d3230ed8 = 1;
    self function_7e73001e97fe87b9(1);
  }

  if(!isDefined(var_b5f7c0806632d99b) || !var_b5f7c0806632d99b) {
    data.invalidparentoverridecallback = &scripts\mp\movers::moving_platform_empty_func;
  }

  thread scripts\mp\movers::handle_moving_platforms(data);
}

function explosivetrigger(target, graceperiod, notifystr) {
  if(isPlayer(target) && target _hasperk("specialty_delaymine")) {
    target thread scripts\cp_mp\challenges::triggereddelayedexplosion();
    graceperiod = level.delayminetime;
  }

  wait graceperiod;
}

function getdamageableents(pos, radius, dolos, startradius) {
  ents = [];

  if(!isDefined(dolos)) {
    dolos = 0;
  }

  if(!isDefined(startradius)) {
    startradius = 0;
  }

  radiussq = radius * radius;
  players = level.players;

  for(i = 0; i < players.size; i++) {
    if(!isalive(players[i]) || players[i].sessionstate != "playing") {
      continue;
    }

    playerpos = get_damageable_player_pos(players[i]);
    distsq = distancesquared(pos, playerpos);

    if(distsq < radiussq && (!dolos || weapondamagetracepassed(pos, playerpos, startradius, players[i]))) {
      ents[ents.size] = get_damageable_player(players[i], playerpos);
    }
  }

  grenades = getEntArray("grenade", "classname");

  for(i = 0; i < grenades.size; i++) {
    entpos = get_damageable_grenade_pos(grenades[i]);
    distsq = distancesquared(pos, entpos);

    if(distsq < radiussq && (!dolos || weapondamagetracepassed(pos, entpos, startradius, grenades[i]))) {
      ents[ents.size] = get_damageable_grenade(grenades[i], entpos);
    }
  }

  destructibles = getEntArray("destructible", "targetname");

  for(i = 0; i < destructibles.size; i++) {
    entpos = destructibles[i].origin;
    distsq = distancesquared(pos, entpos);

    if(distsq < radiussq && (!dolos || weapondamagetracepassed(pos, entpos, startradius, destructibles[i]))) {
      newent = spawnStruct();
      newent.isplayer = 0;
      newent.isadestructable = 0;
      newent.entity = destructibles[i];
      newent.damagecenter = entpos;
      ents[ents.size] = newent;
    }
  }

  destructables = getEntArray("destructable", "targetname");

  for(i = 0; i < destructables.size; i++) {
    entpos = destructables[i].origin;
    distsq = distancesquared(pos, entpos);

    if(distsq < radiussq && (!dolos || weapondamagetracepassed(pos, entpos, startradius, destructables[i]))) {
      newent = spawnStruct();
      newent.isplayer = 0;
      newent.isadestructable = 1;
      newent.entity = destructables[i];
      newent.damagecenter = entpos;
      ents[ents.size] = newent;
    }
  }

  sentries = getEntArray("misc_turret", "classname");

  foreach(sentry in sentries) {
    entpos = sentry.origin + (0, 0, 32);
    distsq = distancesquared(pos, entpos);

    if(distsq < radiussq && (!dolos || weapondamagetracepassed(pos, entpos, startradius, sentry))) {
      switch (sentry.model) {
        case #"hash_599bc2324c763cb":
        case #"hash_b0754ce41d06cdb":
        case #"hash_cc323017c363eb7d":
        case #"hash_fb287221737ad80c":
          ents[ents.size] = get_damageable_sentry(sentry, entpos);
          break;
      }
    }
  }

  mines = getEntArray("script_model", "classname");

  foreach(mine in mines) {
    if(mine.model != "projectile_bouncing_betty_grenade" && mine.model != "ims_scorpion_body") {
      continue;
    }

    entpos = mine.origin + (0, 0, 32);
    distsq = distancesquared(pos, entpos);

    if(distsq < radiussq && (!dolos || weapondamagetracepassed(pos, entpos, startradius, mine))) {
      ents[ents.size] = get_damageable_mine(mine, entpos);
    }
  }

  return ents;
}

function weapondamagetracepassed(from, to, startradius, ent) {
  midpos = undefined;
  diff = to - from;

  if(lengthsquared(diff) < startradius * startradius) {
    return true;
  }

  dir = vectorNormalize(diff);
  midpos = from + (dir[0] * startradius, dir[1] * startradius, dir[2] * startradius);
  trace = scripts\engine\trace::_bullet_trace(midpos, to, 0, ent);

  if(getdvarint(@ "scr_damage_debug") != 0 || getdvarint(@ "hash_135469cd54831746") != 0) {
    thread debugprint(from, ".dmg");

    if(isDefined(ent)) {
      thread debugprint(to, "." + ent.classname);
    } else {
      thread debugprint(to, ".undefined");
    }

    if(trace["fraction"] == 1) {
      thread debugline(midpos, to, (1, 1, 1));
    } else {
      thread debugline(midpos, trace["position"], (1, 0.9, 0.8));
      thread debugline(trace["position"], to, (1, 0.4, 0.3));
    }
  }

  return trace["fraction"] == 1;
}

function damageent(einflictor, eattacker, idamage, smeansofdeath, objweapon, damagepos, damagedir) {
  if(isPlayer(self)) {
    self.damageorigin = damagepos;
    self.entity thread[[level.callbackplayerdamage]](einflictor, eattacker, idamage, 0, smeansofdeath, objweapon, damagepos, damagedir, "none", 0);
    return;
  }

  if(self.isadestructable && (objweapon.basename == "artillery_mp" || objweapon.basename == "claymore_mp" || objweapon.basename == "jup_claymore_mp" || objweapon.basename == "jup_claymore_cp" || objweapon.basename == "stealth_bomb_mp")) {
    return;
  }

  self.entity notify("damage", idamage, eattacker, (0, 0, 0), (0, 0, 0), "MOD_EXPLOSIVE", "", "", "", undefined, objweapon);
}

function debugline(a, b, color) {
  for(i = 0; i < 600; i++) {
    line(a, b, color);
    wait 0.05;
  }
}

function debugcircle(center, radius, color, segments) {
  if(!isDefined(segments)) {
    segments = 16;
  }

  anglefrac = 360 / segments;
  circlepoints = [];

  for(i = 0; i < segments; i++) {
    angle = anglefrac * i;
    xadd = cos(angle) * radius;
    yadd = sin(angle) * radius;
    x = center[0] + xadd;
    y = center[1] + yadd;
    z = center[2];
    circlepoints[circlepoints.size] = (x, y, z);
  }

  for(i = 0; i < circlepoints.size; i++) {
    start = circlepoints[i];

    if(i + 1 >= circlepoints.size) {
      end = circlepoints[0];
    } else {
      end = circlepoints[i + 1];
    }

    thread debugline(start, end, color);
  }
}

function debugprint(pt, txt) {
  for(i = 0; i < 600; i++) {
    print3d(pt, txt);
    wait 0.05;
  }
}

function onweapondamage(einflictor, objweapon, meansofdeath, damage, eattacker) {
  self endon("death_or_disconnect");

  if(!isreallyalive(self)) {
    return;
  }

  weaponrootname = getweaponrootstring(objweapon);

  switch (weaponrootname) {
    case #"hash_cd288ca229b9529":
    case #"hash_45125a8f171b4fb9":
    case #"hash_4c57dd619266bfc9":
    case #"hash_4c57df619266c2ef":
    case #"hash_8670ac083666f3a4":
    case #"hash_89a5836ac6557236":
    case #"hash_c9a436974fe60919":
    case #"hash_e042760d17966848":
      break;
    case #"hash_582fe5fd91d16d23":
    case #"hash_a0319e349a692b8f":
      _shellshock("thermite_mp", "explosion", 0.5);
      break;
    case #"hash_36b7174a04de8799":
    case #"hash_5d11ac1131cddab1":
    case #"hash_7c03088193266bc4":
    case #"hash_9d57562863499a06":
    case #"hash_fa1e80f6bd5b8e72":
      _shellshock("frag_grenade_mp", "explosion", 2);
      break;
    case #"hash_76e24481ceb557a7":
      _shellshock("light_damage_mp", "damage", 0.2);
      break;
    default:
      scripts\mp\shellshock::shellshockondamage(meansofdeath, damage);
      break;
  }
}

function updatelastweapon() {
  self endon("death_or_disconnect");
  self endon("faux_spawn");
  self.lastnormalweaponobj = ter_op(isDefined(self.spawnweaponobj), self.spawnweaponobj, nullweapon());
  self.lastweaponobj = ter_op(isDefined(self.spawnweaponobj), self.spawnweaponobj, nullweapon());
  self.lastcacweaponobj = ter_op(isDefined(self.spawnweaponobj) && iscacprimaryorsecondary(self.spawnweaponobj), self.spawnweaponobj, nullweapon());
  setlastdroppableweaponobj(ter_op(isDefined(self.spawnweaponobj), self.spawnweaponobj, nullweapon()));

  while(true) {
    self waittill("weapon_change", objnewweapon);
    self.lastweaponobj = objnewweapon;

    if(isnormallastweapon(objnewweapon)) {
      self.lastnormalweaponobj = objnewweapon;
    }

    if(isdroppableweapon(objnewweapon)) {
      setlastdroppableweaponobj(objnewweapon);
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

  if(isspecialmeleeweapon(objweapon)) {
    return false;
  }

  if(isgunlessweapon(objweapon)) {
    return false;
  }

  if(isclimbweapon(objweapon)) {
    return false;
  }

  if(isbackuppistol(objweapon)) {
    return false;
  }

  if(objweapon.inventorytype != "primary" && objweapon.inventorytype != "altmode") {
    return false;
  }

  return true;
}

function isdroppableweapon(objweapon) {
  if(objweapon.basename == "none") {
    return false;
  }

  if(isfistweapon(objweapon.basename)) {
    return false;
  }

  if(isbombplantweapon(objweapon.basename)) {
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

  if(scripts\cp_mp\weapon::isbackuppistol(objweapon)) {
    return false;
  }

  return true;
}

function updatemovespeedonweaponchange() {
  self endon("death_or_disconnect");
  self endon("faux_spawn");

  while(true) {
    self waittill("weapon_change", objnewweapon);

    if(objnewweapon.basename == "none") {
      continue;
    } else if(issuperweapon(objnewweapon.basename)) {
      updatemovespeedscale();
      continue;
    } else if(iskillstreakweapon(objnewweapon.basename)) {
      continue;
    } else if(objnewweapon.basename == "iw9_me_fists_mp_ls") {
      updatemovespeedscale();
      continue;
    } else if(objnewweapon.inventorytype != "primary" && objnewweapon.inventorytype != "altmode") {
      continue;
    }

    updatemovespeedscale();
  }
}

function getweaponspeedslowest() {
  var_6155ff1652d3374f = 2;
  self.weaponlist = self getweaponslistprimaries();

  if(self.weaponlist.size) {
    foreach(weapon in self.weaponlist) {
      if(issuperweapon(weapon)) {
        weaponspeed = scripts\mp\supers::getmovespeedforsuperweapon(weapon);
      } else if(iskillstreakweapon(weapon)) {
        weaponspeed = scripts\cp_mp\utility\killstreak_utility::function_3f76336d7d0b7587(weapon);
      } else if(isgamemodeweapon(weapon)) {
        weaponspeed = getgamemodeweaponspeed(weapon);
      } else {
        weaponspeed = getweaponspeed(weapon);
      }

      if(weaponspeed == 0) {
        continue;
      }

      if(weaponspeed < var_6155ff1652d3374f) {
        var_6155ff1652d3374f = weaponspeed;
      }
    }

    if(var_6155ff1652d3374f == 2) {
      assertmsg("<dev string:x229>");
    }
  } else {
    var_6155ff1652d3374f = 0.85;
  }

  var_6155ff1652d3374f = clampweaponspeed(var_6155ff1652d3374f);
  return var_6155ff1652d3374f;
}

function getweaponspeed(weapon) {
  rootweapon = getweaponrootname(weapon);

  if(isDefined(rootweapon) && (!isDefined(level.weaponmapdata[rootweapon]) || !isDefined(level.weaponmapdata[rootweapon].speed))) {
    println("<dev string:x249>" + rootweapon + "<dev string:x275>");
    return 1;
  }

  if(!isDefined(rootweapon) || !isDefined(level.weaponmapdata[rootweapon]) || !isDefined(level.weaponmapdata[rootweapon].speed)) {
    assertmsg("<dev string:x297>" + rootweapon);
    return 1;
  }

  return level.weaponmapdata[rootweapon].speed;
}

function getgamemodeweaponspeed(weapon) {
  return 0.93;
}

function clampweaponspeed(value) {
  assertex(value >= 0 && value <= 1, "<dev string:x2c6>" + value);
  return clamp(value, 0, 1);
}

function updateviewkickscale(perc) {
  if(isDefined(perc)) {
    self.viewkickscale = perc;
  }

  if(isDefined(self.overchargeviewkickscale)) {
    perc = self.overchargeviewkickscale;
  } else if(isDefined(self.overrideviewkickscale)) {
    perc = self.overrideviewkickscale;
    flinchtype = weapon::weapongetflinchtype(self getcurrentweapon());

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

  assertex(perc >= 0 && perc <= 1, "<dev string:x2f3>");
  perc = clamp(perc, 0, 1);
  self setviewkickscale(perc);
}

function updatemovespeedscale() {
  speedperc = undefined;

  if(isDefined(self.playerstreakspeedscale)) {
    speedperc = 1;
    speedperc += self.playerstreakspeedscale;
  } else {
    speedperc = getplayerspeedbyweapon(self);

    if(isDefined(self.overrideweaponspeed_speedscale)) {
      speedperc = self.overrideweaponspeed_speedscale;
    }

    chilldata = self.chill_data;

    if(isDefined(chilldata) && isDefined(chilldata.speedmod)) {
      speedperc += chilldata.speedmod;
    }

    if(isDefined(self.gasspeedmod)) {
      speedperc += self.gasspeedmod;
    }

    if(isDefined(self.var_2ceb4ad39cf2f904)) {
      speedperc += self.var_2ceb4ad39cf2f904;
    }

    if(isDefined(self.disabledspeedmod)) {
      speedperc += self.disabledspeedmod;
    }

    if(isDefined(self.var_529eb36595b1d4bf)) {
      speedperc += self.var_529eb36595b1d4bf;
    }

    if(isDefined(self.var_db8213973d2bb844)) {
      speedperc += self.var_db8213973d2bb844;
    }

    if(isDefined(self.speedonkillmod)) {
      speedperc += self.speedonkillmod;
    }

    if(isDefined(self.momentumspeedincrease)) {
      speedperc += self.momentumspeedincrease;
    }
  }

  self.weaponspeed = speedperc;
  assert(isDefined(self.weaponspeed));
  assert(isDefined(self.movespeedscaler));

  if(!isDefined(self.combatspeedscalar)) {
    self.combatspeedscalar = 1;
  }

  speedperc += self.movespeedscaler - 1;
  speedperc += self.combatspeedscalar - 1;

  if(isDefined(self.var_aa6c008d413b90cb)) {
    foreach(extraspeed in self.var_aa6c008d413b90cb) {
      speedperc += extraspeed;
    }
  }

  if(isDefined(self.var_c2549f6bfa6abbd7)) {
    foreach(var_e6e22cd7f000a9f8 in self.var_c2549f6bfa6abbd7) {
      speedperc *= var_e6e22cd7f000a9f8;
    }
  }

  maxspeedboost = ter_op(_hasperk("specialty_super_speed_script"), getdvarfloat(@ "hash_94084550cb0f64e7", 2), 1.08);
  speedperc = clamp(speedperc, 0, maxspeedboost);

  if(isDefined(self.var_86d77db605c0c948)) {
    speedperc += self.var_86d77db605c0c948 - 1;
  }

  if(isDefined(self.fastcrouchspeedmod)) {
    speedperc += self.fastcrouchspeedmod;
  }

  if(!isDefined(self.playerstreakspeedscale) && isDefined(self.var_740c1298f33f5910)) {
    speedperc += self.var_740c1298f33f5910;
  }

  if(isDefined(self.adrenalinespeed)) {
    speedperc += self.adrenalinespeed;
  }

  if(isDefined(self.var_4d52ef6a17e52924) && istrue(self.inlaststand) && !isDefined(self.ishaywire)) {
    speedperc += self.var_4d52ef6a17e52924;
  }

  if(isDefined(self.var_ce58e8eff85f7366)) {
    speedperc += self.var_ce58e8eff85f7366;
  }

  if(isDefined(self.var_7e94104134f2f40b)) {
    speedperc += self.var_7e94104134f2f40b;
  }

  if(isDefined(self.var_26beacac25790313)) {
    speedperc += self.var_26beacac25790313;
  }

  if(isDefined(self.var_888e1b218afd8fde)) {
    speedperc += self.var_888e1b218afd8fde;
  }

  self setmovespeedscale(speedperc);
}

function addextramovespeed(str_id, value) {
  if(!isDefined(self.var_aa6c008d413b90cb)) {
    self.var_aa6c008d413b90cb = [];
  }

  self.var_aa6c008d413b90cb[str_id] = value;
}

function removeextramovespeed(str_id) {
  assert(isDefined(self.var_aa6c008d413b90cb), "<dev string:x333>");
  self.var_aa6c008d413b90cb = utility::array_remove_key(self.var_aa6c008d413b90cb, str_id);
}

function function_6ebef9d9e0d137b2(str_id, value) {
  if(!isDefined(self.var_c2549f6bfa6abbd7)) {
    self.var_c2549f6bfa6abbd7 = [];
  }

  self.var_c2549f6bfa6abbd7[str_id] = value;
}

function function_20187c06010f854f(str_id) {
  assert(isDefined(self.var_c2549f6bfa6abbd7), "<dev string:x35a>");
  self.var_c2549f6bfa6abbd7 = utility::array_remove_key(self.var_c2549f6bfa6abbd7, str_id);
}

function function_e5642864900c1064() {}

function weapon_giveperk(perkname) {
  if(!isDefined(self.weaponperks)) {
    self.weaponperks = [];
  }

  if(array_contains(self.weaponperks, perkname)) {
    return;
  }

  perk::giveperk(perkname);
  self.weaponperks[self.weaponperks.size] = perkname;
}

function function_ec132c173d4532ee(perkname) {
  if(isDefined(self.weaponperks)) {
    perkremoved = 0;
    var_716f88efb2a15bfd = [];

    foreach(_perkname in self.weaponperks) {
      if(!perkremoved) {
        if(_perkname == perkname) {
          perk::removeperk(_perkname);
          perkremoved = 1;
          continue;
        }
      }

      var_716f88efb2a15bfd[var_716f88efb2a15bfd.size] = _perkname;
    }

    self.weaponperks = var_716f88efb2a15bfd;
  }
}

function weapon_hasperk(perkname) {
  if(!isDefined(self.weaponperks)) {
    return 0;
  }

  return array_contains(self.weaponperks, perkname);
}

function getplayerspeedbyweapon(player) {
  weaponspeed = 1;
  self.weaponlist = self getweaponslistprimaries();

  if(!self.weaponlist.size) {
    weaponspeed = 0.85;
  } else {
    objweapon = self getcurrentweapon();

    if(!isDefined(objweapon)) {
      weaponspeed = getweaponspeedslowest();
    } else if(weapon::issuperweapon(objweapon.basename)) {
      weaponspeed = supers::getmovespeedforsuperweapon(objweapon);
    } else if(weapon::isgamemodeweapon(objweapon.basename)) {
      weaponspeed = getgamemodeweaponspeed(objweapon);
    } else if(weapon::iskillstreakweapon(objweapon.basename)) {
      weaponspeed = killstreak_utility::function_3f76336d7d0b7587(objweapon);
    } else if(weapon::isgunlessweapon(objweapon.basename)) {
      weaponspeed = 0.85;
    } else {
      if(objweapon.inventorytype != "primary" && objweapon.inventorytype != "altmode" || weapon::ismeleeoverrideweapon(objweapon)) {
        if(isDefined(self.lastnormalweaponobj)) {
          objweapon = self.lastnormalweaponobj;
        } else {
          objweapon = undefined;
        }
      }

      if(!self hasweapon(objweapon)) {
        weaponspeed = getweaponspeedslowest();
      } else {
        weaponspeed = getweaponspeed(objweapon);

        if(!isDefined(weaponspeed) || weaponspeed == 0) {
          weaponspeed = 1;
        }

        if(game_utility::function_b2c4b42f9236924()) {
          class = weaponclass(objweapon);

          if(isDefined(level.var_26109c02a53cea84) && isDefined(level.var_26109c02a53cea84[class])) {
            weaponspeed = level.var_26109c02a53cea84[class];
          }
        }
      }
    }
  }

  weaponspeed = clampweaponspeed(weaponspeed);
  return weaponspeed;
}

function stancerecoiladjuster() {
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
    utility::waittill_any_3("adjustedStance", "sprint_begin", "weapon_change");
    wait 0.5;
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
    weapgroup = weapon::getweapongroup(weapon);

    if(weapgroup == "weapon_lmg") {
      weapon::setrecoilscale(0, 0);
    } else if(weapgroup == "weapon_sniper") {
      if(weapon hasattachment("barrelbored")) {
        weapon::setrecoilscale(0, 0 + sniperreduction);
      } else {
        weapon::setrecoilscale(0, 0 + sniperreduction);
      }
    } else {
      weapon::setrecoilscale();
    }

    return;
  }

  if(stance == "crouch") {
    weapgroup = weapon::getweapongroup(weapon);

    if(weapgroup == "weapon_lmg") {
      weapon::setrecoilscale(0, 0);
    } else if(weapgroup == "weapon_sniper") {
      if(weapon hasattachment("barrelbored")) {
        weapon::setrecoilscale(0, 0 + sniperreduction);
      } else {
        weapon::setrecoilscale(0, 0 + sniperreduction);
      }
    } else {
      weapon::setrecoilscale();
    }

    return;
  }

  if(sniperreduction > 0) {
    weapon::setrecoilscale(0, sniperreduction);
    return;
  }

  weapon::setrecoilscale();
}

function deleteallgrenades() {
  if(isDefined(level.grenades)) {
    foreach(grenade in level.grenades) {
      if(isDefined(grenade) && !istrue(grenade.exploding) && !isplantedequipment(grenade)) {
        grenade delete();
      }
    }
  }

  if(isDefined(level.missiles)) {
    foreach(missile in level.missiles) {
      if(isDefined(missile) && !istrue(missile.exploding) && !isplantedequipment(missile)) {
        missile delete();
      }
    }
  }
}

function minegettwohitthreshold() {
  return 80;
}

function minedamagemonitor(hitsmax) {
  self endon("mine_selfdestruct");
  self endon("death");
  self setCanDamage(1);
  self.maxhealth = 100000;
  self.health = self.maxhealth;
  attacker = undefined;
  hits = utility::default_to(hitsmax, 1);
  damagefeedback = "hitequip";

  while(true) {
    self waittill("damage", damage, attacker, direction_vec, point, type, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor);
    objweapon = weapon::mapweapon(objweapon, inflictor);
    attackerplayer = attacker;

    if(!isPlayer(attacker) && !isagent(attacker)) {
      if(isDefined(attacker.owner) && isPlayer(attacker.owner)) {
        attackerplayer = attacker.owner;
      }
    }

    if(!isPlayer(attackerplayer) && !isagent(attackerplayer)) {
      continue;
    }

    if(isDefined(objweapon) && isendstr(objweapon.basename, "betty_mp")) {
      continue;
    }

    if(!friendlyfirecheck(self.owner, attackerplayer)) {
      continue;
    }

    if(damage::non_player_should_ignore_damage(attackerplayer, objweapon, inflictor, type)) {
      continue;
    }

    if(istrue(objweapon.isemp)) {
      continue;
    }

    incominghits = damage::isfmjdamage(objweapon, type) || damage >= 80 ? 2 : 1;
    hits -= incominghits;
    equipmenthit(self.owner, attackerplayer, objweapon, type);

    if(hits <= 0) {
      break;
    }

    attackerplayer damagefeedback::updatedamagefeedback(damagefeedback);
  }

  self notify("mine_destroyed");
  self notify("enemy_destroyed_equipment", attacker);

  if(isDefined(type) && (issubstr(type, "MOD_GRENADE") || issubstr(type, "MOD_EXPLOSIVE"))) {
    self.waschained = 1;
  }

  if(isDefined(idflags) && idflags & 8) {
    self.wasdamagedfrombulletpenetration = 1;
  }

  if(isDefined(idflags) && idflags & 256) {
    self.wasdamagedfrombulletricochet = 1;
  }

  self.wasdamaged = 1;

  if(isDefined(attackerplayer)) {
    self.damagedby = attackerplayer;
  }

  if(isDefined(self.killcament)) {
    self.killcament.damagedby = attackerplayer;
  }

  if(isPlayer(attackerplayer)) {
    attackerplayer damagefeedback::updatedamagefeedback(damagefeedback);

    if(attackerplayer != self.owner && isDefined(self.owner.team) && attackerplayer.team != self.owner.team) {
      attackerplayer killstreaks::givescoreforequipment(self, objweapon);
      attackerplayer battlechatter_mp::equipmentdestroyed(self);
      challenges::equipmentdestroyed(inflictor, attacker, damage, idflags, undefined, objweapon, undefined, attackerplayer.modifiers);
    }
  }

  if(level.teambased) {
    if(!istrue(self.var_e926abd3e5970492) && isDefined(attackerplayer) && isDefined(attackerplayer.pers) && isDefined(attackerplayer.pers["team"]) && isDefined(self.owner) && isDefined(self.owner.pers) && isDefined(self.owner.pers["team"])) {
      if(attackerplayer.pers["team"] != self.owner.pers["team"]) {
        attackerplayer notify("destroyed_equipment");
      }
    }
  } else if(isDefined(self.owner) && isDefined(attackerplayer) && attackerplayer != self.owner) {
    attackerplayer notify("destroyed_equipment");
  }

  challenges::minedestroyed(self, attackerplayer, type);
  self notify("detonateExplosive", attackerplayer);
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
  waitframe();

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

  onexplodevfx = utility::ter_op(isDefined(config.onexplodevfx), config.onexplodevfx, level.mine_explode);
  playFX(onexplodevfx, tagorigin);
  minedamagemin = utility::ter_op(isDefined(config.minedamagemin), config.minedamagemin, level.minedamagemin);
  minedamagemax = utility::ter_op(isDefined(config.minedamagemax), config.minedamagemax, level.minedamagemax);
  minedamageradius = utility::ter_op(isDefined(config.minedamageradius), config.minedamageradius, level.minedamageradius);

  if(minedamagemax > 0) {
    self radiusdamage(self.origin, minedamageradius, minedamagemax, minedamagemin, attacker, "MOD_EXPLOSIVE", self.weapon_name);
  }

  if(isDefined(self.owner)) {
    self.owner thread dialog::leaderdialogonplayer("mine_destroyed", undefined, undefined, self.origin);
  }

  wait 0.2;
  deleteexplosive();
}

function deleteplacedequipment(var_475474534fba73ef) {
  if(isDefined(self.plantedlethalequip)) {
    foreach(equip in self.plantedlethalequip) {
      if(isDefined(equip)) {
        if(!isDefined(equip.equipmentref) || equip.equipmentref != "equip_at_mine" || getdvarint(@ "hash_225e942096726fc0", 1) == 1) {
          equip deleteexplosive();
        }
      }
    }
  }

  if(isDefined(self.plantedlethalequip) && scripts\mp\gametypes\war::function_22ba3797e41fc607()) {
    foreach(equip in self.plantedlethalequip) {
      if(isDefined(equip) && isDefined(equip.equipmentref) && equip.equipmentref == "equip_at_mine" && getdvarint(@ "hash_225e942096726fc0", 1) == 0) {
        continue;
      }

      self.plantedlethalequip = array_remove(self.plantedlethalequip, equip);
    }
  } else {
    self.plantedlethalequip = [];
  }

  if(isDefined(self.plantedtacticalequip)) {
    foreach(equip in self.plantedtacticalequip) {
      if(isDefined(equip)) {
        equip deleteexplosive();
      }
    }
  }

  self.plantedtacticalequip = [];
  var_8442dbb6e918259f = game_utility::isanymlgmatch() || istrue(level.superglobals.var_5b66ed80c98f795b);

  if(isDefined(var_475474534fba73ef)) {
    var_8442dbb6e918259f = var_475474534fba73ef;
  }

  if(isDefined(self.plantedhackedequip)) {
    foreach(index, equip in self.plantedhackedequip) {
      if(isDefined(equip) && (!var_8442dbb6e918259f || !istrue(equip.issuper))) {
        equip deleteexplosive();
        self.plantedhackedequip[index] = undefined;
      }
    }

    self.plantedhackedequip = utility::array_removeundefined(self.plantedhackedequip);
  }

  if(var_8442dbb6e918259f && isDefined(self.plantedsuperequip)) {
    foreach(index, equip in self.plantedsuperequip) {
      equip deleteexplosive();
      self.plantedsuperequip[index] = undefined;
    }

    self.plantedsuperequip = utility::array_removeundefined(self.plantedsuperequip);
  }
}

function deletedisparateplacedequipment() {
  lethal = equipment::getcurrentequipment("primary");

  foreach(equip in self.plantedlethalequip) {
    if(isDefined(equip)) {
      if(!isDefined(equip.equipmentref) || !isDefined(lethal) || equip.equipmentref != lethal) {
        if(equip.equipmentref != "equip_at_mine" || getdvarint(@ "hash_225e942096726fc0", 1) == 1) {
          equip deleteexplosive();
        }
      }
    }
  }

  tactical = equipment::getcurrentequipment("secondary");

  foreach(equip in self.plantedtacticalequip) {
    if(isDefined(equip)) {
      if(!isDefined(equip.equipmentref) || !isDefined(tactical) || equip.equipmentref != tactical) {
        equip deleteexplosive();
      }
    }
  }
}

function equipmentdeletevfx(position, angles) {
  if(isDefined(position)) {
    if(isDefined(angles)) {
      forward = anglesToForward(angles);
      up = anglestoup(angles);
      playFX(utility::getfx("equipment_explode"), position, forward, up);
      playFX(utility::getfx("equipment_smoke"), position, forward, up);
    } else {
      playFX(utility::getfx("equipment_explode"), position);
      playFX(utility::getfx("equipment_smoke"), position);
    }

    playsoundatpos(position, "mp_killstreak_disappear");
    return;
  }

  if(isDefined(self)) {
    origin = self.origin;
    forward = anglesToForward(self.angles);
    up = anglestoup(self.angles);
    playFX(utility::getfx("equipment_explode"), origin, forward, up);
    playFX(utility::getfx("equipment_smoke"), origin, forward, up);
    self playSound("mp_killstreak_disappear");
  }
}

function grenadestuckto(grenade, stuckto, ignoresplash) {
  if(!isDefined(grenade)) {
    return;
  }

  if(!isDefined(self)) {
    grenade.stuckenemyentity = stuckto;
    stuckto.stuckbygrenade = grenade;
    stuckto.stuckbygrenadeowner = grenade.owner;
    return;
  }

  if(level.teambased && utility::is_equal(stuckto.team, self.team)) {
    grenade.isstuck = "friendly";
    return;
  }

  var_d658f0b6bc4fd513 = undefined;
  var_d5f11d86f917656 = undefined;

  if(isDefined(grenade.weapon_name)) {
    switch (grenade.weapon_name) {
      case #"hash_4b87af60037f526f":
        var_d658f0b6bc4fd513 = "semtex_stuck";
        var_d5f11d86f917656 = #"bc_flavor_player_surprise";
        break;
      case #"hash_ab3485fa6834de47":
        var_d658f0b6bc4fd513 = "molotov_stuck";
        var_d5f11d86f917656 = #"bc_flavor_player_surprise";
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
      case #"hash_c4b9b21ecac2ced4":
      case #"hash_d6565ec12efca627":
        var_d658f0b6bc4fd513 = "bunkerbuster_stuck";
        var_d5f11d86f917656 = #"bc_flavor_player_surprise";
        break;
    }
  }

  grenade.isstuck = "enemy";
  grenade.stuckenemyentity = stuckto;
  stuckto.stuckbygrenade = grenade;
  stuckto.stuckbygrenadeowner = grenade.owner;
  self notify("grenade_stuck_enemy");

  if(isDefined(var_d5f11d86f917656)) {
    level thread battlechatter_mp::trysaylocalsound(stuckto, var_d5f11d86f917656);
  }

  if(!istrue(ignoresplash)) {
    grenadestucktosplash(var_d658f0b6bc4fd513, stuckto);
  }
}

function grenadestucktosplash(var_d658f0b6bc4fd513, stuckto) {
  player = self;

  if((isPlayer(stuckto) || isagent(stuckto)) && isDefined(var_d658f0b6bc4fd513)) {
    if(isDefined(player.owner)) {
      player = player.owner;
    }

    if(function_3cb5da19764baa3() != "JUP") {
      player hud_message::showsplash(var_d658f0b6bc4fd513, undefined, undefined, undefined, 1, undefined, 1);
    }
  }

  player thread points::doscoreevent(#"explosive_stick");
}

function outlineequipmentforowner(equipment) {}

function outlinesuperequipment(equipment, player) {
  if(level.teambased) {
    thread outlinesuperequipmentforteam(equipment, player);
    return;
  }

  thread outlinesuperequipmentforplayer(equipment, player);
}

function outlinesuperequipmentforteam(equipment, player) {
  id = outline::outlineenableforteam(equipment, player.team, "outline_nodepth_cyan", "killstreak");
  equipment waittill("death");
  outline::outlinedisable(id, equipment);
}

function outlinesuperequipmentforplayer(equipment, player) {
  id = outline::outlineenableforplayer(equipment, player, "outline_nodepth_cyan", "killstreak");
  equipment waittill("death");
  outline::outlinedisable(id, equipment);
}

function grenadeheldatdeath() {
  return istrue(self.grenadeheldatdeath);
}

function grenadehealthatdeathframeupdatecallback() {
  self.grenadeheldatdeath = !isnullweapon(self getheldoffhand());
}

function trace_impale(vpoint, endpoint) {
  contents = physics_createcontents(["physicscontents_glass", "physicscontents_missileclip", "physicscontents_vehicle", "physicscontents_item"]);
  trace = trace::ray_trace_detail(vpoint, endpoint, level.players, contents, undefined, 1);
  return trace;
}

function impale_endpoint(vpoint, vdir) {
  endpoint = vpoint + vdir * 4096;
  return endpoint;
}

function impale(eattacker, evictim, objweapon, vpointclient, vpoint, vdir, shitloc, spartname, var_19f6f25777706f34, var_d3564b2364cb59e6, var_a4d8eb0a63f60f6b, isagent) {
  evictim endon("death_or_disconnect");

  if(!isDefined(evictim)) {
    return;
  }

  if(istrue(isagent)) {
    corpse = evictim;
  } else if(isDefined(evictim.body)) {
    corpse = evictim.body;
  } else {
    return;
  }

  if(istrue(isagent)) {
    if(isDefined(corpse.aicategory) && (corpse.aicategory == "special" || corpse.aicategory == "elite" || corpse.aicategory == "boss")) {
      return;
    }

    if(isDefined(corpse.subclass) && corpse.subclass == "zombie_hellhound") {
      return;
    }
  }

  isprojectile = isDefined(var_d3564b2364cb59e6);

  if(isprojectile) {
    isimpaling = 1;
  } else {
    playFX(utility::getfx("penetration_railgun_impact"), vpoint);
    endpoint = impale_endpoint(vpoint, vdir);
    trace = trace_impale(vpoint, endpoint);
    endpoint = trace["position"] - vdir * 12;
    flightdist = length(endpoint - vpoint);
    flighttime = flightdist / 1000;
    flighttime = max(flighttime, 0.05);
    assertex(flightdist / flighttime <= 1100, "<dev string:x381>");

    if(trace["hittype"] != "hittype_world") {
      flighttime = 0;
    }

    isimpaling = flighttime > 0.05;
  }

  corpse startragdoll();
  waitframe();

  if(isimpaling) {
    linkoffset = (0, 0, 0);
    linkangles = (0, 0, 0);

    if(isprojectile) {
      if(!isDefined(var_d3564b2364cb59e6)) {
        println("<dev string:x3c4>");
        return;
      }

      linktoent = var_d3564b2364cb59e6;
      tag = var_d3564b2364cb59e6 function_557f8f6e8a4de1af(0);
      var_cdb50dd2ec640205 = function_21c2f68a46b12403(objweapon);
      offset = var_a4d8eb0a63f60f6b - var_cdb50dd2ec640205;
      linkoffset = (offset * 20, 0, 0);
    } else {
      var_a0480a10ee4e345f = vdir;
      var_c323f0cb880a051f = anglestoup(eattacker.angles);
      var_c1148ff802be2880 = vectorcross(var_a0480a10ee4e345f, var_c323f0cb880a051f);
      railent = utility::spawn_tag_origin(vpoint, axistoangles(var_a0480a10ee4e345f, var_c1148ff802be2880, var_c323f0cb880a051f));
      tag = "tag_origin";
      railent moveTo(endpoint, flighttime);
      linktoent = railent;
    }

    constraint = spawnragdollconstraint(corpse, shitloc, spartname, var_19f6f25777706f34, !isDefined(var_d3564b2364cb59e6));

    if(!isDefined(constraint)) {
      return;
    }

    constraint.origin = linktoent.origin;
    constraint.angles = linktoent.angles;
    constraint linkTo(linktoent, tag, linkoffset, linkangles);

    if(isprojectile) {
      thread function_ac635aad489c4eb3(var_d3564b2364cb59e6, constraint);
      thread function_a4ae1baa56b9f490(corpse, var_d3564b2364cb59e6, objweapon, shitloc);
      return;
    }

    if(flighttime > 1) {
      thread impale_detachaftertime(constraint, 1);
    }

    thread impale_cleanup(evictim, linktoent, flighttime + 0.25);
    linktoent thread impale_effects(endpoint, flighttime);
  }
}

function function_a4ae1baa56b9f490(corpsetable, var_d3564b2364cb59e6, objweapon, shitloc) {
  if(!isDefined(objweapon) || !isDefined(objweapon.basename) || !isDefined(objweapon.variantid)) {
    return;
  }

  if(objweapon.basename != "jup_jp23_me_spear_mp") {
    return;
  }

  state = "none";

  if(objweapon.variantid == 1) {
    state = "gilmanMelee";
  } else if(objweapon.variantid == 2) {
    state = "blackcell_s5Melee";
  } else {
    return;
  }

  level endon("game_ended");
  var_d3564b2364cb59e6 endon("death");
  var_d3564b2364cb59e6 waittill_any_timeout_1(6, "missile_stuck");
  var_6d3083f40dbe196c = "mtxDeath";

  if(corpsetable isscriptable() && corpsetable getscriptablehaspart(var_6d3083f40dbe196c) && corpsetable getscriptableparthasstate(var_6d3083f40dbe196c, state)) {
    corpsetable setscriptablepartstate(var_6d3083f40dbe196c, state, 0);
  }
}

function launch(eattacker, evictim, objweapon, vdir, magnitude, shitloc, isagent) {
  if(!isDefined(evictim)) {
    return;
  }

  if(isagent) {
    corpse = evictim;
  } else if(isDefined(evictim.body)) {
    corpse = evictim.body;
  } else {
    return;
  }

  if(isagent) {
    if(isDefined(corpse.aicategory) && (corpse.aicategory == "special" || corpse.aicategory == "elite" || corpse.aicategory == "boss")) {
      return;
    }
  }

  corpse startragdollfromimpact(shitloc, vdir * magnitude);
}

function function_ac635aad489c4eb3(var_d3564b2364cb59e6, constraint) {
  level endon("game_ended");
  var_d3564b2364cb59e6 waittill("death");

  if(isDefined(constraint)) {
    constraint delete();
  }
}

function impale_detachaftertime(constraint, time) {
  wait time;

  if(isDefined(constraint)) {
    constraint delete();
  }
}

function impale_effects(endpoint, time) {
  wait clamp(time - 0.05, 0.05, 20);
  playFX(utility::getfx("penetration_railgun_impact"), endpoint);
}

function impale_cleanup(evictim, railent, time) {
  if(isDefined(evictim)) {
    evictim utility::waittill_any_timeout_1(time, "death_or_disconnect");
  }

  railent delete();
}

function codecallback_getprojectilespeedscale(attackerentity, objweapon) {
  return [1, 1];
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
  assertex(isDefined(self.isblinded), "<dev string:x3fb>");
  assertex(self.isblinded > 0, "<dev string:x44e>");
  self.isblinded--;
}

function isblinded() {
  return isDefined(self.debuffedbyplayers) && isDefined(self.debuffedbyplayers["flash_grenade_mp"]);
}

function isblindedby(player) {
  if(!isDefined(player)) {
    return false;
  }

  weapon = "flash_grenade_mp";
  entnum = player getentitynumber();

  if(isDefined(self.debuffedbyplayers) && isDefined(self.debuffedbyplayers[weapon]) && isDefined(self.debuffedbyplayers[weapon][entnum])) {
    return true;
  }

  return false;
}

function isstunnedby(player) {
  if(!isDefined(player)) {
    return false;
  }

  weapon = "concussion_grenade_mp";
  entnum = player getentitynumber();

  if(isDefined(self.debuffedbyplayers) && isDefined(self.debuffedbyplayers[weapon]) && isDefined(self.debuffedbyplayers[weapon][entnum])) {
    return true;
  }

  return false;
}

function isstunnedorblinded() {
  return isblinded() || isstunned();
}

function applyweaponsonicstun() {
  self endon("death_or_disconnect");
  wait 0.1;

  if(isDefined(self) && isPlayer(self) && !isbot(self)) {
    self playlocalsound("sonic_shotgun_debuff");
    self setsoundsubmix("sonic_shotgun_impact");
  }
}

function watchinvalidweaponchange() {
  self endon("death_or_disconnect");

  while(true) {
    self waittill("weapon_switch_invalid", invalidweapon);
    currentweapon = self getcurrentweapon();

    if(currentweapon.inventorytype == "item" || currentweapon.inventorytype == "exclusive") {
      inventory_utility::_switchtoweapon(self.lastdroppableweaponobj);
    }
  }
}

function weaponhasselectableoptic(fullweaponname) {
  rootweapon = weapon::getweaponrootname(fullweaponname);
  attachments = getweaponattachments(fullweaponname);

  foreach(attachment in attachments) {
    group = attachmentgroup(attachment);

    if(group == "rail") {
      if(weapon::attachmentisselectable(rootweapon, attachment)) {
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

  while(true) {
    self waittill("weapon_dropped", droppedent, objweapon);

    if(isDefined(droppedent) && isDefined(objweapon) && (!weapon::ismeleeonly(objweapon) && !weapon::ismeleeoverrideweapon(objweapon) && !weapon_utility::isknifeonly(objweapon) || weapon_utility::function_f0cf737b5d0ccda5(objweapon))) {
      if(droppedent physics_getnumbodies() > 0) {
        droppedent physics_registerforcollisioncallback();
        droppedent thread weapondrop_physics_callback_monitor();
      }
    }
  }
}

function weapondrop_physics_callback_monitor() {
  self endon("death");
  self endon("timeout");
  thread weapondrop_physics_timeout(2);
  self waittill("collision", body0, body1, flag0, flag1, position, normal, impulse, ent);
  surface = physics_getsurfacetypefromflags(flag1);
  surfacetype = utility::default_to(surface["name"], "");
  wpn_name = self.classname;
  wpn_material = "";

  if(isDefined(self.objweapon) && isstring(self.objweapon.basename) && isstring(self.objweapon.material)) {
    wpn_name = self.objweapon.basename;
    wpn_material = self.objweapon.material;
  }

  function_e7dbbe9220d5e27b(surfacetype);
}

function function_e7dbbe9220d5e27b(surfacetype) {
  assertex(isstring(surfacetype), "<dev string:x4cf>");
  surfacetype = function_2e84a570d6af300a(surfacetype, "surftype_");

  if(isstartstr(surfacetype, "user_terrain")) {
    user_number = removesubstr(function_2e84a570d6af300a(surfacetype, "user_terrain"), "_");
    surfacetype = "user_terrain_" + user_number;
  }

  self function_7d738013c1cfbc9d(surfacetype);
}

function weapondrop_physics_timeout(time) {
  wait time;
  self notify("timeout");
}

function watchgrenadeaxepickup(player, weaponnameoverride) {
  self endon("death");
  level endon("game_ended");

  if(!isDefined(self.weapon_name) && isDefined(weaponnameoverride)) {
    self.weapon_name = weaponnameoverride;
  }

  self waittill("missile_stuck", stuckto, stuckpart);

  if(isDefined(stuckto) && (isPlayer(stuckto) || isagent(stuckto))) {
    hitnormalshield = stuckpart == "tag_flicker";
    var_853178727321999c = stuckto perk::_hasperk("specialty_rearguard") && stuckpart == "tag_origin";
    hitshield = isDefined(stuckpart) && (hitnormalshield || var_853178727321999c);
    hitweapon = isDefined(stuckpart) && stuckpart == "tag_weapon";

    if(hitshield) {
      playFX(utility::getfx("shield_metal_impact"), self.origin);

      if(isDefined(self.owner)) {
        weaponowner = self.owner;
        relaunchaxe(self.weapon_name, weaponowner);
        return;
      }
    } else if(!istrue(hitshield) && isPlayer(stuckto) && !player::isreallyalive(stuckto) && (level.mapname == "mp_neon" || istrue(level.ragdollzerog))) {
      return;
    }
  }

  axetimeout = 45;
  thread watchaxetimeout(axetimeout);
  thread watchgrenadedeath();
  objweapon = self.weapon_object;
  thread watchaxeuse(player, objweapon);
  thread watchaxeautopickup(player, objweapon);
}

function axedetachfromcorpse(stuckent) {
  level endon("game_ended");
  corpseents = stuckent getlinkedchildren();

  foreach(ent in corpseents) {
    if(!isDefined(ent)) {
      continue;
    }

    weaponname = ent.weapon_name;
    weaponowner = ent.owner;
    stuckpoint = ent.origin;

    if(isDefined(weaponname) && isaxeweapon(weaponname)) {
      ent relaunchaxe(weaponname, weaponowner);
    }
  }
}

function relaunchaxe(weaponname, weaponowner) {
  self unlink();
  axebasename = weapon::getweaponbasenamescript(weaponname);
  var_61d4c6a9eee46112 = getsubstr(weaponname, axebasename.size);
  newaxe = weaponowner weapon::_launchgrenade("iw7_axe_mp_dummy" + var_61d4c6a9eee46112, self.origin, (0, 0, 0), 100, 1, self);
  newaxe setentityowner(weaponowner);
  newaxe thread watchgrenadeaxepickup(weaponowner, self.weapon_name);
}

function watchaxetimeout(timeoutduration) {
  self endon("death");
  level endon("game_ended");
  hostmigration::waitlongdurationwithhostmigrationpause(timeoutduration);
  self delete();
}

function watchaxeautopickup(player, weapon) {
  self endon("death");
  level endon("game_ended");
  trigger = spawn("trigger_radius", self.origin - (0, 0, 40), 0, 64, 64);
  trigger enablelinkTo();
  trigger linkTo(self);
  self.knife_trigger = trigger;
  trigger endon("death");

  while(true) {
    trigger waittill("trigger", player);

    if(!isPlayer(player)) {
      continue;
    }

    if(player playercanautopickupaxe(self)) {
      success = player playerpickupaxe(weapon, 1);

      if(istrue(success)) {
        self delete();
        break;
      }
    }
  }
}

function watchaxeuse(player, weapon) {
  self endon("death");
  level endon("game_ended");
  useobj = spawn("script_model", self.origin);
  useobj linkTo(self);
  self.useobj_trigger = useobj;
  useobj makeusable();
  useobj setCursorHint("HINT_NOICON");
  useobj sethintonobstruction("show");
  rootname = getweaponrootname(weapon);

  if(rootname == "jup_jp23_me_spear") {
    useobj setHintString(&"WEAPON/PICKUP_SPEAR");
  } else {
    useobj setHintString(&"WEAPON/PICKUP_AXE");
  }

  useobj sethintdisplayfov(360);
  useobj setusefov(360);
  useobj sethintdisplayrange(64);
  useobj setuserange(64);
  useobj setusepriority(0);

  while(true) {
    useobj waittill("trigger", player);
    success = player playerpickupaxe(weapon, 0);

    if(istrue(success)) {
      self delete();
      break;
    }
  }
}

function playercanautopickupaxe(axeent) {
  if(isDefined(axeent.owner) && self != axeent.owner) {
    return 0;
  }

  if(scripts\mp\gametypes\infect::function_dbead865fbbae378() && isDefined(self.team) && self.team == "axis") {
    return 0;
  }

  currentweapons = self getweaponslistprimaries();
  var_d2472bb1c9e89dee = 0;
  primarycount = 0;

  foreach(weapon in currentweapons) {
    if(isaxeweapon(weapon) && self getweaponammoclip(weapon) < weaponclipsize(weapon)) {
      var_d2472bb1c9e89dee = 1;
      break;
    }

    if(issubstr(weapon.basename, "iw9_me_fists_mp")) {
      var_d2472bb1c9e89dee = 1;
      break;
    }

    if(!weapon.isalternate) {
      primarycount++;
    }
  }

  if(primarycount < 2) {
    var_d2472bb1c9e89dee = 1;
  }

  return var_d2472bb1c9e89dee;
}

function function_2cd4f9393314e60a() {
  if(scripts\mp\gametypes\infect::function_dbead865fbbae378() && isDefined(self.team) && self.team == "axis") {
    if(issharedfuncdefined("hud", "showErrorMessage")) {
      self[[getsharedfunc("hud", "showErrorMessage")]]("MP_INGAME_ONLY/AXE_CANNOT_PICKUP");
    }

    return false;
  }

  if(isjuggernaut()) {
    function_f3bb4f4911a1beb2("hud", "showErrorMessage", "KILLSTREAKS/JUGG_CANNOT_BE_USED");
    return false;
  }

  return true;
}

function playerpickupaxe(objweapon, isautopickup) {
  assert(isweapon(objweapon));

  if(!function_2cd4f9393314e60a()) {
    return false;
  }

  var_aaa00e27a60773a1 = objweapon getnoaltweapon();
  currentweapon = self getcurrentweapon();
  currentweapons = self getweaponslistprimaries();

  if(self hasweapon(objweapon)) {
    ammoinclip = self getweaponammoclip(objweapon);
    clipsize = weaponclipsize(objweapon);

    if(!isautopickup && ammoinclip > 0) {
      if(clipsize == 1) {
        self dropitem(objweapon);
        inventory_utility::_giveweapon(var_aaa00e27a60773a1);
      }
    }

    var_3bcedee676d43cf1 = self getweaponammoclip(currentweapon) == 0 && isaxeweapon(currentweapon);
    var_8a1ef5886931af59 = issubstr(currentweapon.basename, "iw9_me_fists_mp");

    if(!isautopickup || var_8a1ef5886931af59 || var_3bcedee676d43cf1) {
      inventory_utility::_switchtoweapon(var_aaa00e27a60773a1);
    }

    newammo = int(min(clipsize, ammoinclip + 1));
    self setweaponammoclip(var_aaa00e27a60773a1, newammo);

    if(currentweapon.basename == "jup_jp23_me_spear_mp") {
      self playsoundtoplayer("weap_pickup_spear_plr", self);
      self playsoundtoteam("weap_pickup_spear", self.team, self);
      self playsoundtoteam("weap_pickup_spear", getotherteam(self.team)[0], self);
    }

    return true;
  }

  preferreddropweapon = undefined;
  primaryweaponcount = 0;

  foreach(weapon in currentweapons) {
    if(weapon.isalternate) {
      continue;
    }

    if(issubstr(weapon.basename, "uplinkball")) {
      continue;
    }

    if(scripts\mp\utility\weapon::isunderwaterweapon(weapon) || scripts\mp\utility\weapon::isclimbweapon(weapon)) {
      continue;
    }

    var_cb54202af3c4e5b8 = self getweaponammoclip(weapon) == 0 && isaxeweapon(weapon);

    if(!isDefined(preferreddropweapon) && (weaponispreferreddrop(weapon) || var_cb54202af3c4e5b8)) {
      preferreddropweapon = weapon;
    }

    primaryweaponcount++;
  }

  assert(!isautopickup || isDefined(preferreddropweapon) || primaryweaponcount < 2);
  var_ec22a950f210e39 = undefined;

  if(isDefined(preferreddropweapon)) {
    var_ec22a950f210e39 = preferreddropweapon;
  } else if(primaryweaponcount >= 2) {
    var_ec22a950f210e39 = currentweapon;
  }

  var_107f42911b64ccb4 = !isautopickup || isDefined(var_ec22a950f210e39) && issubstr(currentweapon.basename, var_ec22a950f210e39.basename);

  if(isDefined(var_ec22a950f210e39)) {
    var_cb54202af3c4e5b8 = self getweaponammoclip(var_ec22a950f210e39) == 0 && isaxeweapon(var_ec22a950f210e39);
    var_4dc7fa49d0968728 = var_ec22a950f210e39.basename == "iw9_me_fists_mp";
    candrop = weaponcandrop(var_ec22a950f210e39) && !var_cb54202af3c4e5b8;

    if(candrop) {
      droppeditem = self dropitem(var_ec22a950f210e39);

      if(isDefined(droppeditem)) {
        dropweaponname = getcompleteweaponname(var_ec22a950f210e39);

        if(isDefined(self.tookweaponfrom[dropweaponname])) {
          droppeditem.owner = self.tookweaponfrom[dropweaponname];
          self.tookweaponfrom[dropweaponname] = undefined;
        } else {
          droppeditem.owner = self;
        }

        droppeditem.targetname = "dropped_weapon";
        droppeditem.objweapon = var_ec22a950f210e39;
        droppeditem thread watchpickup(self);
        droppeditem thread deletepickupafterawhile();
      }
    } else if(!candrop && !(var_4dc7fa49d0968728 && primaryweaponcount < 2) && !(var_cb54202af3c4e5b8 && primaryweaponcount < 2)) {
      self takeweapon(var_ec22a950f210e39);
    }
  }

  inventory_utility::_giveweapon(var_aaa00e27a60773a1);
  self setweaponammoclip(var_aaa00e27a60773a1, 1);

  if(var_107f42911b64ccb4) {
    inventory_utility::_switchtoweapon(var_aaa00e27a60773a1);
  }

  weapon::fixupplayerweapons(self, var_aaa00e27a60773a1);
  return true;
}

function callback_finishweaponchange(objnewweapon, objoldweapon, var_6f14f21684b6976d, var_14f4860c3d155d12) {
  updatecamoscripts(objnewweapon, objoldweapon);
  updateweaponscriptvfx(objnewweapon, objoldweapon, var_6f14f21684b6976d, var_14f4860c3d155d12);
  callbackdata = self.weaponchangecallbacks;

  if(isDefined(callbackdata)) {
    foreach(callback in callbackdata.callbacks) {
      self[[callback]](objnewweapon, objoldweapon);
    }

    foreach(callback in callbackdata.oneshotcallbacks) {
      self[[callback]](objnewweapon, objoldweapon);
    }

    callbackdata.oneshotcallbacks = [];
  }
}

function updateweaponscriptvfx(newweapon, oldweapon, var_6f14f21684b6976d, var_14f4860c3d155d12) {
  if((oldweapon.basename == "none" || oldweapon.basename == "alt_none") && isDefined(self.lastdroppableweapon)) {
    if(oldweapon == "alt_none") {
      var_14f4860c3d155d12 = 1;
    } else {
      var_14f4860c3d155d12 = 0;
    }

    oldweapon = self.lastdroppableweapon;
  }

  clearweaponscriptvfx(oldweapon, var_14f4860c3d155d12);
  runweaponscriptvfx(newweapon, var_6f14f21684b6976d);
}

function runweaponscriptvfx(newweapon, var_6f14f21684b6976d) {
  if(!isDefined(newweapon)) {
    return;
  }

  if(isDefined(var_6f14f21684b6976d) && var_6f14f21684b6976d == 1) {
    xweapon = "alt_" + weapon::getweaponbasenamescript(newweapon);
    return;
  }

  xweapon = weapon::getweaponbasenamescript(newweapon);
}

function clearweaponscriptvfx(oldweapon, var_14f4860c3d155d12) {
  if(!isDefined(oldweapon)) {
    return;
  }

  if(isDefined(var_14f4860c3d155d12) && var_14f4860c3d155d12 == 1) {
    yweapon = "alt_" + weapon::getweaponbasenamescript(oldweapon);
  } else {
    yweapon = weapon::getweaponbasenamescript(oldweapon);
  }

  switch (yweapon) {
    case #"hash_16a70270ad1be05":
    case #"hash_720415103e03ae2":
    case #"hash_ccb7e0ca94ee5c9":
    case #"hash_1a3a5f8a962ed552":
    case #"hash_1c4e9e71e522fc4f":
    case #"hash_1ca5befa8dd4212c":
    case #"hash_373244181c39a617":
    case #"hash_3aebbd4d39af2e1d":
    case #"hash_3e782fd775b72022":
    case #"hash_4da38b8f68dd24e9":
    case #"hash_55daa19b03d3c0a3":
    case #"hash_5c272c0617caebf0":
    case #"hash_5cbb3a1a84d47f1d":
    case #"hash_5d0a7e04f70f7955":
    case #"hash_69dc59a2931615bb":
    case #"hash_734b74361301068b":
    case #"hash_7c2cc72e0303a1ed":
    case #"hash_802c4ea270fb6875":
    case #"hash_8cc23b82a1e96d05":
    case #"hash_a4d841e3a2ddbb29":
    case #"hash_a9e31b8ffd42a67b":
    case #"hash_ad8e0c890ec0cc34":
    case #"hash_ada149b6511e694f":
    case #"hash_b1d476fe8b4f829a":
    case #"hash_b5e9f2d6fac1a505":
    case #"hash_b9e0da8080aefc13":
    case #"hash_bd614182e9e39950":
    case #"hash_c3b4676d5e812262":
    case #"hash_c7149abad793a9b1":
    case #"hash_cfce2a2737ab1be6":
    case #"hash_d2d2f2854b7d8b7d":
    case #"hash_da6958311b58f75b":
    case #"hash_e1a2fa29b8332d53":
    case #"hash_e704ecf8710c6f57":
    case #"hash_eecff3f23eb2fa44":
    case #"hash_f3248b9b1283bc96":
    case #"hash_f55c20924061bd15":
    case #"hash_f733f426b27679a6":
      break;
  }
}

function updatecamoscripts(objnewweapon, objoldweapon) {
  clearcamoscripts(getweaponcamoname(objoldweapon));
  runcamoscripts(getweaponcamoname(objnewweapon));
}

function runcamoscripts(camo) {
  if(!isDefined(camo)) {
    return;
  }

  switch (camo) {
    case #"hash_321cd27e72303c85":
      thread blood_camo_84();
      break;
  }
}

function clearcamoscripts(camo) {
  if(!isDefined(camo)) {
    return;
  }

  switch (camo) {
    case #"hash_321cd27e72303c85":
      self notify("blood_camo_84");
      break;
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

function getactiveequipmentarray() {
  return utility::array_remove_duplicates(level.mines);
}

function init_function_refs() {
  level.getactiveequipmentarray = &getactiveequipmentarray;
}

function doesshareammo(objweapon) {
  return objweapon.isalternate && !issubstr(objweapon.underbarrel, "gl") && issubstr(objweapon.underbarrel, "shotgun");
}

function waittill_grenade_throw() {
  while(true) {
    self waittill("grenade_fire", grenade, objweapon, tickpercent, originalowner);

    if(!weapon::grenadethrown(grenade)) {
      continue;
    }

    grenadeinitialize(grenade, objweapon, tickpercent, originalowner);

    if(isDefined(originalowner) && originalowner != self) {
      level thread battlechatter_mp::trysaylocalsound(self, #"bc_equipment_action_grenade_throwback");
    }

    self.var_318e9ed18014aada = gettime();
    self.var_9df92c66c8402503 = grenade;
    self notify("grenade_thrown", grenade);
    return grenade;
  }
}

function grenadeinitialize(grenade, weapon_object, tickpercent, originalowner) {
  assert(isDefined(self), "<dev string:x50d>");
  assert(isDefined(grenade), "<dev string:x53d>");

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
    grenade.ticks = script::roundup(4 * tickpercent);
  }

  equipmentref = equipment::getequipmentreffromweapon(weapon_object);

  if(isDefined(equipmentref)) {
    grenade.equipmentref = equipmentref;
    grenade.isequipment = 1;
    grenade.bundle = equipment::function_2113b6f7cb462692(grenade.weapon_name);

    if(equipmentref == "equip_smoke") {
      grenade.owner stats::incpersstat("smokesUsed", 1);
    }
  }

  grenade.threwback = isDefined(originalowner);
}

function waittill_missile_fire() {
  self waittill("missile_fire", missile, objweapon);

  if(isDefined(missile)) {
    if(!isDefined(missile.weapon_name)) {
      if(objweapon.isalternate) {
        missile.weapon_name = weapon::getaltmodeweapon(objweapon);
        missile.varindex = weapon::function_b53839dc08a64fde(objweapon);
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

    if(!isDefined(missile.weapon_object)) {
      missile.weapon_object = objweapon;
    }
  }

  return [objweapon, missile];
}

function enableburnfx(skip_sound, var_ee8fa35daedf8c6b, var_f65d8a5147a9a0f) {
  if(!isDefined(self.burnfxstates)) {
    self.burnfxstates = [];
  }

  if(!isDefined(var_ee8fa35daedf8c6b)) {
    var_ee8fa35daedf8c6b = "active";
  }

  if(!isDefined(var_f65d8a5147a9a0f)) {
    var_f65d8a5147a9a0f = "burning";
  }

  if(!istrue(skip_sound)) {
    thread enableburnsfx();
  }

  self.burnfxstates[var_f65d8a5147a9a0f][getburnfxstatepriority(var_ee8fa35daedf8c6b)] = var_ee8fa35daedf8c6b;
  startburnfx();
}

function getburnfxstatepriority(state) {
  switch (state) {
    case #"hash_9943bf0047670307":
      return 3;
    case #"hash_7173532436329889":
      return 2;
    case #"hash_bee8aefcdf5a9a8f":
      return 1;
    default:
      return 0;
  }
}

function gethightestpriotiryactiveburnstate(burnfxstates, var_ac89efd5a1a335cb) {
  if(!isDefined(var_ac89efd5a1a335cb)) {
    var_ac89efd5a1a335cb = "burning";
  }

  i = 3;
  higheststate = undefined;

  while(i >= 0) {
    if(isDefined(burnfxstates[var_ac89efd5a1a335cb][i])) {
      higheststate = burnfxstates[var_ac89efd5a1a335cb][i];
      break;
    }

    i--;
  }

  return higheststate;
}

function enableburnsfx() {
  self notify("updateBurnSFX");
  self endon("death_or_disconnect");
  self endon("updateBurnSFX");

  if(!isDefined(self.burnsfxenabled)) {
    self.burnsfxenabled = 0;
  }

  if(!isDefined(self.burnsfx)) {
    self.burnsfx = spawn("script_origin", self.origin);
    self.burnsfx linkTo(self);
    self.burnsfx ent_manager::registerspawncount(1);
    wait 0.05;
  }

  if(self.burnsfxenabled == 0) {
    if(isDefined(self.burnsfx)) {
      self.burnsfx playLoopSound("iw9_weap_molotov_fire_enemy_burn");
      self.burnsfxenabled = 1;
    }
  }
}

function enableburnfxfortime(duration, var_ee8fa35daedf8c6b) {
  if(!isDefined(var_ee8fa35daedf8c6b)) {
    var_ee8fa35daedf8c6b = "active";
  }

  stateendon = "endon_burnfxForTime_" + var_ee8fa35daedf8c6b;
  self notify(stateendon);
  self endon("disconnect");
  self endon("clearBurnFX");
  self endon(stateendon);
  thread enableburnfx(0, var_ee8fa35daedf8c6b);
  wait duration;
  thread disableburnfx(0, var_ee8fa35daedf8c6b);
}

function disableburnfx(skip_sound, burningstate, burningpart) {
  if(!isDefined(self.burnfxstates)) {
    self.burnfxstates = [];
  }

  if(!isDefined(burningpart)) {
    burningpart = "burning";
  }

  if(isDefined(burningstate)) {
    self.burnfxstates[burningpart][getburnfxstatepriority(burningstate)] = undefined;
    self.burnfxstates[burningpart] = utility::array_removeundefined(self.burnfxstates[burningpart]);
  } else {
    self.burnfxstates[burningpart] = [];
  }

  if(self.burnfxstates[burningpart].size > 0) {
    startburnfx();
    return;
  }

  stopburnfx();

  if(!istrue(skip_sound)) {
    thread disable_burnsfx();
  }
}

function disable_burnsfx() {
  self notify("updateBurnSFX");
  self endon("death_or_disconnect");
  self endon("updateBurnSFX");
  wait 0.5;

  if(isDefined(self.burnsfxenabled) && self.burnsfxenabled == 1) {
    if(!isDefined(self.var_aaa78716e99a2760) || self.var_aaa78716e99a2760) {
      self playSound("iw9_weap_molotov_fire_enemy_burn_end");
    }

    self.var_aaa78716e99a2760 = undefined;
    wait 0.15;
    function_d9fcebdb704a67fa();
  }
}

function clearburning(var_f60ee8b9e17970e6) {
  function_9fd9dc9d9d3a0bc4();
  function_22d1fced237d6878();
  clearburnfx(var_f60ee8b9e17970e6);
  function_d9fcebdb704a67fa();
}

function private clearburnfx(var_f60ee8b9e17970e6) {
  self notify("clearBurnFX");
  function_11bc0d93953a155a();

  if(istrue(var_f60ee8b9e17970e6)) {
    if(isDefined(self.corpsetablefuncs) && isDefined(self.corpsetablefuncs["burning"])) {
      scripts\mp\damage::dequeuecorpsetablefunc("burning");
    }

    function_fc27c713595c6a00();
  }

  self.burnfxplaying = undefined;
  self.burnfxstates = undefined;
}

function startburnfx() {
  foreach(part, state in self.burnfxstates) {
    var_ee8fa35daedf8c6b = gethightestpriotiryactiveburnstate(self.burnfxstates, part);

    if(isDefined(var_ee8fa35daedf8c6b)) {
      self setscriptablepartstate(part, var_ee8fa35daedf8c6b);
      self.burnfxplaying = 1;
      function_fc27c713595c6a00(var_ee8fa35daedf8c6b, part);

      if(!isDefined(self.corpsetablefuncs) || !isDefined(self.corpsetablefuncs["burning"])) {
        damage::enqueuecorpsetablefunc("burning", &burnfxcorpstablefunc);
      }
    }
  }

  thread function_4a895aafec5dd891();
}

function function_4a895aafec5dd891() {
  self notify("stop_burnFxInfilCleanupThread");
  self endon("death_or_disconnect");
  self endon("stop_burnFxInfilCleanupThread");
  self waittill("beginC130");
  thread clearburning(1);
}

function function_fc27c713595c6a00(var_ee8fa35daedf8c6b, burningpart) {
  if(isDefined(var_ee8fa35daedf8c6b)) {
    if(var_ee8fa35daedf8c6b == "nuke_active" || var_ee8fa35daedf8c6b == "wp_active" || var_ee8fa35daedf8c6b == "active") {
      var_ee8fa35daedf8c6b = "flareUp";
    } else {
      switch (var_ee8fa35daedf8c6b) {
        case #"hash_aff60910f2d22661":
          var_ee8fa35daedf8c6b = "al_to_ar_";
          break;
        case #"hash_e375a3f665d58036":
          var_ee8fa35daedf8c6b = "al_to_ll_";
          break;
        case #"hash_32f426f68ef33047":
        case #"hash_56dae623a0537cab":
        case #"hash_94143bf6c209d5b9":
          var_ee8fa35daedf8c6b = "to_ar_lr";
          break;
        case #"hash_79ca5b8a91fe4b3f":
        case #"hash_8b427f4805eb13fc":
        case #"hash_b81e7b23d386c21a":
          var_ee8fa35daedf8c6b = "to_ll_lr";
          break;
        case #"hash_384a0d26e7095bf9":
        case #"hash_4fa5087b17ea1b62":
        case #"hash_78a25902c839c2bc":
        case #"hash_a6405a3db3fbeda8":
        case #"hash_d00a40c1f19a1a07":
        case #"hash_d56c02428470d154":
          var_ee8fa35daedf8c6b = "flareUp";
          break;
      }
    }

    self.var_5ac96327bbcda1c8[burningpart] = var_ee8fa35daedf8c6b;
    return;
  }

  self.var_5ac96327bbcda1c8 = undefined;
}

function stopburnfx() {
  if(isDefined(self.burnfxplaying)) {
    function_11bc0d93953a155a();
    damage::dequeuecorpsetablefunc("burning");
    function_fc27c713595c6a00();
    self.burnfxplaying = undefined;
  }

  self notify("stop_burnFxInfilCleanupThread");
}

function function_11bc0d93953a155a() {
  if(self isscriptable()) {
    if(isDefined(self.burnfxstates)) {
      foreach(part, state in self.burnfxstates) {
        if(self getscriptablehaspart(part) && self getscriptableparthasstate(part, "neutral")) {
          self setscriptablepartstate(part, "neutral");
        }
      }
    }
  }
}

function function_d9fcebdb704a67fa() {
  if(isDefined(self.burnsfxenabled) && self.burnsfxenabled == 1) {
    if(isDefined(self.burnsfx)) {
      self.burnsfx stoploopsound("iw9_weap_molotov_fire_enemy_burn");
    }

    self.burnsfxenabled = 0;
  }

  if(isDefined(self.burnsfx)) {
    self.burnsfx ent_manager::deregisterspawn();
    self.burnsfx delete();
  }
}

function burnfxcorpstablefunc(corpsetable) {
  burningstate = "flareUp";

  if(isDefined(self) && isDefined(self.var_5ac96327bbcda1c8)) {
    foreach(part, state in self.var_5ac96327bbcda1c8) {
      if(isDefined(state)) {
        corpsetable setscriptablepartstate(part, state, 0);
      }
    }
  }
}

function semtex_used(grenade) {
  self endon("disconnect");
  grenade endon("death");
  grenade.bundle = equipment::function_2113b6f7cb462692(grenade.weapon_name);
  grenade waittill("missile_stuck", stuckto);

  if(isPlayer(stuckto) || isagent(stuckto)) {
    thread grenadestuckto(grenade, stuckto);

    if(isagent(stuckto)) {
      function_216c67ab6749137a(stuckto, undefined, "semtex_stuck");
    }

    if(isagent(stuckto) && !istrue(stuckto.var_274d3a7704e351ef)) {
      if(!isDefined(stuckto.var_f8ecc64162438d76)) {
        stuckto.var_f8ecc64162438d76 = [];
      } else {
        stuckto.var_f8ecc64162438d76 = utility::array_removedead(stuckto.var_f8ecc64162438d76);
      }

      stuckto.var_f8ecc64162438d76 = utility::array_add(stuckto.var_f8ecc64162438d76, grenade);
      assertex(stuckto.health > 0, "<dev string:x577>");
      ai::function_60daa23100a2b874(grenade, stuckto);
    }
  }
}

function semtex_stuckplayer(grenade, stuckto) {
  self endon("disconnect");
  grenade endon("end_explode");
  stuckto endon("death_or_disconnect");
  grenade thread script::notifyafterframeend("death", "end_explode");
  grenade waittill("explode", position);
  stuckdamage = stuckto.maxhealth;

  if(isDefined(grenade.bundle)) {
    stuckdamage = utility::default_to(grenade.bundle.var_dc6074bf92aed826, stuckto.maxhealth);
    stuckdamage *= utility::default_to(grenade.bundle.var_43f9a1342da4e1a0, 1);
  }

  thread function_c50caf1f56ecf73(stuckto, position, stuckdamage, grenade);
}

function function_c50caf1f56ecf73(stuckto, position, stuckdamage, var_68647a50e85e8152) {
  var_31bbffe8512c7c8a = distancesquared(position, stuckto.origin);
  var_1c6cdb959bb1bf2a = 5000;

  if(var_31bbffe8512c7c8a > var_1c6cdb959bb1bf2a) {
    return;
  }

  stuckto damage_utility::forcestuckdamage();

  if(!isDefined(var_68647a50e85e8152)) {
    var_68647a50e85e8152 = self;
  }

  stuckto dodamage(stuckdamage, position, self, var_68647a50e85e8152, "MOD_EXPLOSIVE", makeweapon("semtex_mp"));
  stuckto damage_utility::forcestuckdamageclear();
}

function function_7a91162092cc11ec(lootid) {
  variantref = loot::function_793e8a72cedb8ef3(lootid);
  baseweaponref = weapon::getweaponrootname(variantref);
  return loot::getlootidfromref(baseweaponref);
}

function function_15abe90be101ffc8(weaponassetname, attachment, variantlootid) {
  blueprints = function_4527f44d851c9afd(weaponassetname, attachment);

  foreach(variantindex, attachmentdata in blueprints) {
    attachmentlootid = attachmentdata.lootid;

    if(isDefined(attachmentlootid) && variantlootid == attachmentlootid) {
      return variantindex;
    }
  }

  return 0;
}

function function_1c6803f36c2ea0a6(weaponassetname, attachment, variantid) {
  blueprints = function_4527f44d851c9afd(weaponassetname, attachment);

  foreach(variantindex, attachmentdata in blueprints) {
    if(variantindex == variantid) {
      return attachmentdata.lootid;
    }
  }

  return undefined;
}

function function_82a0e6138ba06718(objweapon) {
  self.var_888410f22da94ad0 = undefined;

  if(objweapon hasattachment("trigger_heavy_p14")) {
    thread function_f0ab1405beddd91f();
  }
}

function function_f0ab1405beddd91f() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("weapon_taken");
  self endon("weapon_change");

  while(true) {
    if(self getcurrentweaponclipammo() == 1) {
      self.var_888410f22da94ad0 = 1;
    } else {
      self.var_888410f22da94ad0 = undefined;
    }

    self waittill("reload");
  }
}

function function_e0780928b2591268(objweapon, missileent) {
  level endon("game_ended");
  viewangles = self getplayerangles();
  vieweye = self getEye();
  playerforward = anglesToForward(viewangles);
  traceendposlong = vieweye + playerforward * 6000;
  var_217857c69d3e9a04 = 400;
  var_504eac462f9531a4 = getdvarint(@ "hash_8a17c968aa5c8fd1", -1);

  if(var_504eac462f9531a4 > 0) {
    traceendposlong = vieweye + playerforward * var_504eac462f9531a4;
  }

  var_7e8fdab2d6343efc = getdvarint(@ "hash_1e45eef33a3b63", -1);

  if(var_7e8fdab2d6343efc > 0) {
    var_217857c69d3e9a04 = var_7e8fdab2d6343efc;
  }

  var_1a1b6c4c33f1b3b8 = trace::create_contents(1, 0, 0, 0, 0, 1);
  toweroffset = (0, 0, 10);
  var_b83b0fc6a542638 = 0;

  if(scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    var_b83b0fc6a542638 = getdvarint(@ "hash_31c5e6d57a1104e1", 0);
  }

  var_c8863cdecb0560f4 = [];
  var_38b853e7e5c069f8 = [];
  var_e228b6eb479306d = trace::sphere_trace_get_all_results(vieweye, traceendposlong, 60, self, var_1a1b6c4c33f1b3b8, 0, 1);

  foreach(result in var_e228b6eb479306d) {
    if(isDefined(result["entity"])) {
      ent = result["entity"];

      if(sighttracepassed(vieweye, result["position"], 0, ent, undefined, 1)) {
        if(isPlayer(ent) && (ent _hasperk("specialty_emp_immunity") || ent _hasperk("specialty_empimmune")) && isenemyteam(self.team, ent.team) && level.teambased) {
          continue;
        }

        var_c8863cdecb0560f4 = function_6d6af8144a5131f1(var_c8863cdecb0560f4, ent);
      }
    }
  }

  if(getdvarint(@ "hash_e11b62d8bc4f25da", 1) == 1) {
    var_b1ca25a639f7dd44 = getentitiesinradius(vieweye, var_217857c69d3e9a04, undefined, undefined, trace::create_default_contents(0));

    foreach(ent in var_b1ca25a639f7dd44) {
      if(self worldpointinreticle_circle(ent.origin, 65, 120) == 1) {
        var_c8863cdecb0560f4 = array_add(var_c8863cdecb0560f4, ent);
      }
    }

    if(var_b83b0fc6a542638) {
      if(istrue(level.var_684d782689230a50)) {
        var_32680e06caf9feb2 = getentitylessscriptablearray(undefined, undefined, vieweye, var_217857c69d3e9a04, "dmz_uav_tower");

        foreach(scriptable in var_32680e06caf9feb2) {
          if(isDefined(scriptable.var_3545410459b16762)) {
            if(self worldpointinreticle_circle(scriptable.origin + toweroffset, 65, 120) == 1) {
              var_38b853e7e5c069f8 = function_6d6af8144a5131f1(var_38b853e7e5c069f8, scriptable);
            }
          }
        }
      }

      if(istrue(level.br_armory_kiosk.var_aaa31c1e28a5663c)) {
        var_3cf7da794ccd4e13 = getentitylessscriptablearray(undefined, undefined, vieweye, var_217857c69d3e9a04, "br_plunder_box");

        foreach(scriptable in var_3cf7da794ccd4e13) {
          if(isDefined(scriptable.var_3545410459b16762)) {
            if(self worldpointinreticle_circle(scriptable.origin + toweroffset, 65, 120) == 1) {
              var_38b853e7e5c069f8 = function_6d6af8144a5131f1(var_38b853e7e5c069f8, scriptable);
            }
          }
        }
      }
    }
  }

  if(isDefined(level.activekillstreaks)) {
    foreach(ent in level.activekillstreaks) {
      location = ent.origin;

      if(isDefined(ent.streakname)) {
        switch (ent.streakname) {
          case #"hash_19dd9a3a4147e09e":
            location += (0, 0, 40);
            break;
          case #"hash_ab5712e297cd430e":
            location += (0, 0, 45);
            break;
        }
      }

      if(sighttracepassed(vieweye, location, 0, ent, missileent, 1) && self worldpointinreticle_circle(location, 65, 50) == 1) {
        var_c8863cdecb0560f4 = array_add(var_c8863cdecb0560f4, ent);
      }
    }
  }

  foreach(ent in getactiveequipmentarray()) {
    if(sighttracepassed(vieweye, ent.origin, 0, missileent, undefined, 1) && self worldpointinreticle_circle(ent.origin, 65, 50) == 1) {
      var_c8863cdecb0560f4 = array_add(var_c8863cdecb0560f4, ent);
    }
  }

  foreach(ent in level.grenades) {
    if(!isDefined(ent) || !isDefined(ent.origin)) {
      continue;
    }

    if(sighttracepassed(vieweye, (ent.origin[0], ent.origin[1], ent.origin[2] + 5), 0, missileent, undefined, 1) && self worldpointinreticle_circle(ent.origin, 65, 50) == 1) {
      var_c8863cdecb0560f4 = array_add(var_c8863cdecb0560f4, ent);
    }
  }

  var_c8863cdecb0560f4 = array_remove_duplicates(var_c8863cdecb0560f4);
  var_1fa763edf5f1cc00 = trace::create_contents(0, 1, 1, 1);

  if(isDefined(level.brgametype) && isDefined(level.brgametype.cysts)) {
    foreach(cyst in level.brgametype.cysts) {
      if(!isDefined(cyst) || !isDefined(cyst.origin)) {
        continue;
      }

      if(distancesquared(self.origin, cyst.origin) <= 640000) {
        if(self worldpointinreticle_circle(cyst.origin, 65, 90) == 1) {
          var_8bd607a2b7bbf567 = ray_trace(vieweye, cyst.origin, missileent, var_1fa763edf5f1cc00, 0, 1, 1);

          if(isDefined(var_8bd607a2b7bbf567) && isDefined(var_8bd607a2b7bbf567["scriptable"]) && isDefined(var_8bd607a2b7bbf567["scriptable"].type) && var_8bd607a2b7bbf567["scriptable"].type == "ob_aethernest_cyst_scriptable") {
            var_38b853e7e5c069f8 = array_add(var_38b853e7e5c069f8, cyst);
          }
        }
      }
    }
  }

  if(var_b83b0fc6a542638) {
    if(istrue(level.var_684d782689230a50)) {
      foreach(tower in level.uavtowers) {
        if(!isDefined(tower) || !isDefined(tower.origin)) {
          continue;
        }

        if(distancesquared(self.origin, tower.origin + toweroffset) <= 3841600) {
          if(self worldpointinreticle_circle(tower.origin + toweroffset, 65, 90) == 1) {
            towertrace = ray_trace(vieweye, tower.origin + toweroffset, missileent, undefined, 0, 1, 1);

            if(isDefined(towertrace) && isDefined(towertrace["scriptable"]) && isDefined(towertrace["scriptable"].type) && towertrace["scriptable"].type == "dmz_uav_tower" && isDefined(towertrace["scriptable"].var_3545410459b16762)) {
              var_38b853e7e5c069f8 = function_6d6af8144a5131f1(var_38b853e7e5c069f8, towertrace["scriptable"]);
            }
          }
        }
      }
    }

    if(istrue(level.var_3976c9c03dc06d9b)) {
      foreach(var_bb19a0b11e79e6cb in level.var_fc4bb27a820f54dd.var_cd2de8814a52f22c) {
        if(!isDefined(var_bb19a0b11e79e6cb) || !istrue(var_bb19a0b11e79e6cb.b_occupied)) {
          continue;
        }

        if(distancesquared(self.origin, var_bb19a0b11e79e6cb.origin) <= 96884649) {
          if(self worldpointinreticle_circle(var_bb19a0b11e79e6cb.origin, 65, 90) == 1) {
            dronetrace = ray_trace(vieweye, var_bb19a0b11e79e6cb.origin, missileent, undefined, 0, 1, 1);

            if(isDefined(dronetrace) && isDefined(dronetrace["scriptable"]) && isDefined(dronetrace["scriptable"].type) && dronetrace["scriptable"].type == "scriptable_redeploy_drone" && isDefined(dronetrace["scriptable"].var_3545410459b16762)) {
              var_38b853e7e5c069f8 = function_6d6af8144a5131f1(var_38b853e7e5c069f8, dronetrace["scriptable"]);
            }
          }
        }
      }
    }

    if(istrue(level.br_armory_kiosk.var_aaa31c1e28a5663c)) {
      foreach(buystation in level.br_armory_kiosk.scriptables) {
        if(!isDefined(buystation)) {
          continue;
        }

        if(distancesquared(self.origin, buystation.origin) <= 3841600) {
          if(self worldpointinreticle_circle(buystation.origin, 65, 90) == 1) {
            var_524bf2aaff80ebde = ray_trace(vieweye, buystation.origin, missileent, undefined, 0, 1, 1);

            if(isDefined(var_524bf2aaff80ebde) && isDefined(var_524bf2aaff80ebde["scriptable"]) && isDefined(var_524bf2aaff80ebde["scriptable"].type) && var_524bf2aaff80ebde["scriptable"].type == "br_plunder_box" && isDefined(var_524bf2aaff80ebde["scriptable"].var_3545410459b16762)) {
              var_38b853e7e5c069f8 = function_6d6af8144a5131f1(var_38b853e7e5c069f8, var_524bf2aaff80ebde["scriptable"]);
            }
          }
        }
      }
    }
  }

  foreach(ent in var_c8863cdecb0560f4) {
    if(!isDefined(ent)) {
      continue;
    }

    if(ent scripts\common\vehicle::isvehicle()) {
      if(scripts\cp_mp\vehicles\vehicle::vehicle_isfriendlytoplayer(ent, self)) {
        continue;
      }

      if(getdvarint(@ "hash_be23c0cca5ddca69", 1) && !istrue(ent.israllypointvehicle)) {
        occupants = scripts\cp_mp\vehicles\vehicle_occupancy::function_efa75aa7f0a1289(ent, 0);

        if(isDefined(occupants) && occupants == 0) {
          continue;
        }
      }
    }

    if(isDefined(ent.team) && ent.team == self.team) {
      if(isPlayer(ent)) {
        ent notify("stop_tracker_grenade_thirdparty", self, self.currentprimaryweapon);
      }

      if(level.teambased) {
        continue;
      }
    }

    if(isDefined(ent.owner) && ent.owner.team == self.team && level.teambased) {
      continue;
    }

    if(isDefined(ent.owner) && ent.owner == self) {
      continue;
    }

    if(var_b83b0fc6a542638) {
      if(isDefined(ent.domflag) && isDefined(ent.domflag.trigger) && isDefined(ent.domflag.trigger.var_3545410459b16762)) {
        if(isDefined(ent.domflag.trigger.stronghold) && isDefined(ent.domflag.trigger.stronghold.capturedteam) && istrue(ent.domflag.trigger.stronghold.capturedteam == self.team)) {
          continue;
        }

        function_63476cca54e728ce(ent.domflag.trigger);
      }

      if(istrue(level.var_3976c9c03dc06d9b)) {
        if(isDefined(ent.type) && ent.type == "scriptable_redeploy_drone" && isDefined(ent.var_3545410459b16762)) {
          function_63476cca54e728ce(ent);
        }
      }

      if(istrue(level.deployablekiosks.var_8bf814f9559f53)) {
        if(isDefined(ent.type) && ent.type == "portable_buy_drone" && isDefined(ent.var_3545410459b16762)) {
          function_63476cca54e728ce(ent);
        }
      }

      if(istrue(level.deployablekiosks.var_aaa31c1e28a5663c)) {
        if(isDefined(ent.team) && isDefined(self.team) && ent.team == self.team) {
          continue;
        }

        if(isDefined(ent.type) && ent.type == "deployable_buystation" && isDefined(ent.var_3545410459b16762)) {
          function_63476cca54e728ce(ent);
        }
      }
    }

    if(isPlayer(ent)) {
      ent thread function_a0a176ec45783695(self, 5);
      continue;
    }

    if(isagent(ent) && isDefined(ent.team) && ent.team != self.team) {
      if(isDefined(ent.unittype)) {
        if(ent.unittype == "zombie") {
          ent val::set("drone_launcher", "pain", 0);
          var_ee67fb3e8bee9a6e = getdvarint(@ "hash_245a8ac774461e4a", 40);
          ent dodamage(var_ee67fb3e8bee9a6e, self.origin, self, self, "MOD_UNKNOWN", self.currentprimaryweapon);
          ent val::reset("drone_launcher", "pain");
          continue;
        } else if(ent.unittype == "soldier") {
          var_12c07b09a7777175 = getdvarint(@ "hash_7cdb49e8f87074af", 20);
          ent dodamage(var_12c07b09a7777175, self.origin, self, self, "MOD_UNKNOWN", self.currentprimaryweapon);
          continue;
        }
      }
    }

    if(isDefined(ent.sourcegrenade) && ent.sourcegrenade.equipmentref == "equip_butterfly_mine") {
      ent dodamage(9999, self.origin, self, self, "MOD_EXPLOSIVE", self.currentprimaryweapon);
      continue;
    }

    if(isDefined(ent.streakname)) {
      if(ent.streakname == "radar_drone_recon") {
        ent dodamage(9999, self.origin, self, self, "MOD_EXPLOSIVE", self.currentprimaryweapon);
      } else if(ent.streakname == "uav") {
        ent dodamage(250, self.origin, self, self, "MOD_EXPLOSIVE", self.currentprimaryweapon);
      } else if(ent.streakname == "missile_turret") {
        ent dodamage(130, self.origin, self, self, "MOD_EXPLOSIVE", self.currentprimaryweapon);

        if(!istrue(ent.ishaywire)) {
          function_1475aa09aebba72(ent);
          ent thread function_4e9544f537fa99d6(self);
        }
      } else if(ent.streakname == "assault_drone") {
        ent dodamage(1, self.origin, self, self, "MOD_EXPLOSIVE", self.currentprimaryweapon);
        data = damage_utility::packdamagedata(self, ent, 1, self.currentprimaryweapon, "MOD_EXPLOSIVE", self);
        ent thread[[ent.var_3545410459b16762]](data);
        ent thread function_258b974cf7d16877(self);
      } else if(ent.streakname == "lrad") {
        ent dodamage(250, self.origin, self, self, "MOD_EXPLOSIVE", self.currentprimaryweapon);
        function_1475aa09aebba72(ent);
        ent thread function_258b974cf7d16877(self);
      } else if(ent.streakname == "airdrop") {
        ent dodamage(10, self.origin, self, self, "MOD_EXPLOSIVE", self.currentprimaryweapon);
      } else if(ent.streakname == "switchblade_drone") {
        function_1475aa09aebba72(ent);
        ent thread function_258b974cf7d16877(self);
      } else if(ent.streakname == "scrambler_drone_guard") {
        ent dodamage(300, self.origin, self, self, "MOD_EXPLOSIVE", self.currentprimaryweapon);
      } else if(ent.streakname == "cluster_spike") {
        ent dodamage(100, self.origin, self, self, "MOD_EXPLOSIVE", self.currentprimaryweapon);
      } else if(ent.streakname == "cruise_predator") {
        ent dodamage(1, self.origin, self, self, "MOD_EXPLOSIVE", self.currentprimaryweapon);

        if(getdvarint(@ "hash_82fc9d1ee58b396", 1) == 1) {
          function_1475aa09aebba72(ent);
          ent thread function_258b974cf7d16877(self);
        }
      } else if(ent.streakname == "bunker_buster") {
        ent dodamage(1, self.origin, self, self, "MOD_EXPLOSIVE", self.currentprimaryweapon);

        if(getdvarint(@ "hash_82fc9d1ee58b396", 1) == 1) {
          function_1475aa09aebba72(ent);
          ent thread function_258b974cf7d16877(self);
        }
      } else if(ent.streakname == "pac_sentry") {
        ent dodamage(30, self.origin, self, self, "MOD_EXPLOSIVE", self.currentprimaryweapon);
        data = scripts\cp_mp\utility\damage_utility::packdamagedata(self, ent, 1, self.currentprimaryweapon, "MOD_EXPLOSIVE", self);

        if(!istrue(ent.var_195cf5a953ae9265)) {
          ent thread scripts\mp\killstreaks\remotetank::function_876be54dd49f69a9(data);
        }
      } else if(ent.streakname == "airdrop_escort") {
        ent dodamage(5, (0, 0, 0), self, self, "MOD_EXPLOSIVE", self.currentprimaryweapon);
        function_1475aa09aebba72(ent);
        data = damage_utility::packdamagedata(self, ent, 1, self.currentprimaryweapon, "MOD_EXPLOSIVE", self);
        function_1475aa09aebba72(ent);
        ent thread scripts\cp_mp\killstreaks\airdrop_escort::function_dbfa95f808879295(data, 5);
      } else if(ent.streakname == "hover_jet") {
        ent dodamage(5, (0, 0, 0), self, self, "MOD_EXPLOSIVE", self.currentprimaryweapon);
        data = damage_utility::packdamagedata(self, ent, 1, self.currentprimaryweapon, "MOD_EXPLOSIVE", self);
        ent thread scripts\cp_mp\killstreaks\hover_jet::function_8b040f320bd1e206(data);
      } else if(ent.streakname == "chopper_gunner") {
        ent dodamage(10, (0, 0, 0), self, self, "MOD_EXPLOSIVE", self.currentprimaryweapon);
        data = damage_utility::packdamagedata(self, ent, 1, self.currentprimaryweapon, "MOD_EXPLOSIVE", self);
        ent thread scripts\cp_mp\killstreaks\chopper_gunner::function_d33b650337c6008b(data);
      } else if(ent.streakname == "gunship") {
        ent dodamage(10, self.origin, self, self, "MOD_EXPLOSIVE", self.currentprimaryweapon);
        data = damage_utility::packdamagedata(self, ent, 1, self.currentprimaryweapon, "MOD_EXPLOSIVE", self);
        ent scripts\cp_mp\killstreaks\gunship::function_377ab89187436937(data);
      } else if(ent.streakname == "remote_turret") {
        ent dodamage(140, self.origin, self, self, "MOD_EXPLOSIVE", self.currentprimaryweapon);
        function_1475aa09aebba72(ent);
        ent thread function_4e9544f537fa99d6(self);
      } else if(ent.streakname == "drone_swarm") {
        ent dodamage(50, self.origin, self, self, "MOD_EXPLOSIVE", self.currentprimaryweapon);
      } else if(ent.streakname == "loitering_munition") {
        ent dodamage(10, self.origin, self, self, "MOD_EXPLOSIVE", self.currentprimaryweapon);
        data = damage_utility::packdamagedata(self, ent, 1, self.currentprimaryweapon, "MOD_EXPLOSIVE", self);
        ent utility::function_f3bb4f4911a1beb2("loitering_munition", "loiteringMunition_droneGunEmpApplied", data);
      }

      continue;
    }

    if(isDefined(ent.equipmentref) && utility::array_contains(getactiveequipmentarray(), ent)) {
      equipmentname = ent.equipmentref;

      if(issubstr(ent.equipmentref, "_jup")) {
        equipmentname = removesubstr(equipmentname, "_jup");
      }

      switch (ent.equipmentref) {
        case #"hash_4320d77f90725183":
          ent dodamage(1, self.origin, self, self, "MOD_EXPLOSIVE", self.currentprimaryweapon);
          break;
        case #"hash_2354208d9af64220":
          ent dodamage(1, self.origin, self, self, "MOD_EXPLOSIVE", self.currentprimaryweapon);
          break;
        case #"hash_3995658e01f4fac1":
          ent dodamage(1, self.origin, self, self, "MOD_EXPLOSIVE", self.currentprimaryweapon);
          break;
        case #"hash_c848458cca24d656":
          ent dodamage(9999, self.origin, self, self, "MOD_EXPLOSIVE", self.currentprimaryweapon);
          break;
        case #"hash_cbcb2b145327e750":
          ent dodamage(9999, self.origin, self, self, "MOD_EXPLOSIVE", self.currentprimaryweapon);
          break;
        case #"hash_29972969a98220a1":
        case #"hash_ecd28780631ff043":
          ent dodamage(9999, self.origin, self, self, "MOD_EXPLOSIVE", self.currentprimaryweapon);
          break;
        case #"hash_91076f076ee682f4":
          ent dodamage(9999, self.origin, self, self, "MOD_EXPLOSIVE", self.currentprimaryweapon);
          break;
        case #"hash_1602aabae23dc4b7":
          ent dodamage(9999, self.origin, self, self, "MOD_EXPLOSIVE", self.currentprimaryweapon);
          break;
        case #"hash_1eeb976ed8edf3e2":
          ent dodamage(9999, self.origin, self, self, "MOD_EXPLOSIVE", self.currentprimaryweapon);
          break;
        case #"hash_f4e4d96da65cbe0c":
          ent dodamage(9999, self.origin, self, self, "MOD_EXPLOSIVE", self.currentprimaryweapon);
          break;
        case #"hash_7c09786dbc292c05":
          ent dodamage(9999, self.origin, self, self, "MOD_EXPLOSIVE", self.currentprimaryweapon);
          break;
        case #"hash_b64c903871503d5d":
          ent dodamage(9999, self.origin, self, self, "MOD_EXPLOSIVE", self.currentprimaryweapon);
          break;
        case #"hash_731f922359382673":
          ent dodamage(9999, self.origin, self, self, "MOD_EXPLOSIVE", self.currentprimaryweapon);
          break;
        case #"hash_c613333b4f1bbb78":
          ent dodamage(9999, self.origin, self, self, "MOD_EXPLOSIVE", self.currentprimaryweapon);
          break;
        case #"hash_33dc79aea3c12e98":
          ent dodamage(9999, self.origin, self, self, "MOD_EXPLOSIVE", self.currentprimaryweapon);
          break;
        case #"hash_1a5a56a6fdfa6d6b":
          ent dodamage(9999, self.origin, self, self, "MOD_EXPLOSIVE", self.currentprimaryweapon);
          break;
        case #"hash_4a85ee2b82965fe2":
          ent dodamage(9999, self.origin, self, self, "MOD_EXPLOSIVE", self.currentprimaryweapon);
          break;
        default:
          break;
      }

      continue;
    }

    if(isDefined(ent.classname)) {
      if(ent.classname == "grenade" && isDefined(ent.equipmentref)) {
        if(ent.equipmentref == "sonar_pulse_mp") {
          ent dodamage(9999, self.origin, self, self, "MOD_EXPLOSIVE", self.currentprimaryweapon);
        } else if(ent.equipmentref == "equip_breacher_drone") {
          ent thread breacher_drone::function_42393d355d1090ff(0);
        } else if(ent.equipmentref == "equip_snapshot_grenade") {
          ent dodamage(9999, self.origin, self, self, "MOD_EXPLOSIVE", self.currentprimaryweapon);
        } else if(ent.equipmentref == "equip_decoy") {
          ent thread decoy_grenade::decoy_destroy();
        } else if(ent.equipmentref == "equip_shockstick") {
          ent dodamage(9999, self.origin, self, self, "MOD_EXPLOSIVE", self.currentprimaryweapon);
        } else if(ent.equipmentref == "equip_tracker_grenade") {
          ent dodamage(9999, self.origin, self, self, "MOD_EXPLOSIVE", self.currentprimaryweapon);
        } else if(ent.equipmentref == "equip_bunkerbuster") {
          ent thread scripts\mp\equipment\bunkerbuster::function_a5a20b852c325190();
        }
      } else if(ent.classname == "misc_turret") {
        if(isDefined(ent.cameratype) && ent.cameratype == "tacCam") {
          ent dodamage(9999, self.origin, self, self, "MOD_EXPLOSIVE", self.currentprimaryweapon);
        }
      } else if(ent.classname == "script_vehicle") {
        ent thread function_4e9544f537fa99d6(self);
      } else if(ent.classname == "script_model" && isDefined(ent.weapon_name) && ent.weapon_name == "deployed_decoy_mp") {
        ent dodamage(50, self.origin, self, self, undefined, self.currentprimaryweapon);
      } else if(ent.classname == "script_model" && isDefined(ent.animname) && ent.animname == "super_smoke_airdrop") {
        ent dodamage(50, self.origin, self, self, undefined, self.currentprimaryweapon);
      } else if(ent.classname == "scriptable_bomb_01") {
        ent dodamage(50, self.origin, self, self, undefined, self.currentprimaryweapon);
      } else if(ent.classname == "scriptable_bomb_c4_large_double_01") {
        ent dodamage(50, self.origin, self, self, undefined, self.currentprimaryweapon);
      }

      continue;
    }

    if(isDefined(ent.animname) && ent.animname == "super_smoke_airdrop") {
      data = damage_utility::packdamagedata(self, ent, 1, self.currentprimaryweapon, "MOD_EXPLOSIVE", self);
      ent thread[[ent.empstartcallback]](data);
    }
  }

  foreach(scriptable in var_38b853e7e5c069f8) {
    if(issubstr(scriptable.classname, "scriptable")) {
      if(scriptable.type == "ob_aethernest_cyst_scriptable") {
        scriptable function_b85de89251e1fe76(200, self, self);
        continue;
      }

      if(scriptable.type == "jup_ob_zombie_control_spore") {
        scriptable function_b85de89251e1fe76(200, self, self);
        continue;
      }

      if(var_b83b0fc6a542638) {
        if(scriptable.type == "dmz_uav_tower" && istrue(level.var_684d782689230a50)) {
          if(isDefined(scriptable.activeteam) && istrue(scriptable.activeteam == self.team)) {
            continue;
          }

          function_63476cca54e728ce(scriptable.towerstruct.uav_station);
          continue;
        }

        if(istrue(level.var_3976c9c03dc06d9b) && scriptable.type == "scriptable_redeploy_drone") {
          function_63476cca54e728ce(scriptable);
          continue;
        }

        if(scriptable.type == "br_plunder_box" && istrue(level.br_armory_kiosk.var_aaa31c1e28a5663c)) {
          function_63476cca54e728ce(scriptable);
        }
      }
    }
  }
}

function function_63476cca54e728ce(ent) {
  data = spawnStruct();
  data.time = 5;
  data.attacker = self;
  data.reason = "STORMENDER";
  ent thread[[ent.var_3545410459b16762]](data);
}

function function_aa3939ed0f60d04e(objweapon, missileent) {
  level endon("game_ended");
  self endon("death");

  if(!isalive(self)) {
    return;
  }

  viewangles = self getplayerangles();
  vieweye = self getEye();
  playerforward = anglesToForward(viewangles);
  traceendposob = vieweye + playerforward * 3500;
  var_6405edb8ef20fe35 = trace::create_contents(1, 0, 0, 0, 0, 1);
  waittillframeend();
  var_9b80af519ecdb255 = [];
  var_c8863cdecb0560f4 = [];
  var_38b853e7e5c069f8 = [];
  var_f2577c0ea89a8e3 = trace::sphere_trace_get_all_results(vieweye, traceendposob, 60, self, var_6405edb8ef20fe35, 0, 1);

  foreach(result in var_f2577c0ea89a8e3) {
    if(isDefined(result["entity"])) {
      var_9b80af519ecdb255 = array_add(var_9b80af519ecdb255, result["entity"]);
      continue;
    }

    if(isDefined(result["scriptable"])) {
      if(sighttracepassed(vieweye, result["position"], 0, undefined, undefined, 1)) {
        var_38b853e7e5c069f8 = array_add(var_38b853e7e5c069f8, result["scriptable"]);
      }
    }
  }

  var_275d78a9e8d113aa = 0;
  sortbydistance(var_9b80af519ecdb255, self.origin);

  foreach(entdetected in var_9b80af519ecdb255) {
    if(isDefined(entdetected.team) && entdetected.team == self.team) {
      continue;
    }

    if(isDefined(entdetected.owner) && isDefined(entdetected.owner.team) && entdetected.owner.team == self.team) {
      continue;
    }

    if(isDefined(level.var_250dc4a23947d41) && arraycontains(level.var_250dc4a23947d41, entdetected)) {
      continue;
    }

    if(var_275d78a9e8d113aa < 4) {
      if(isDefined(entdetected)) {
        hitlocation = entdetected getcentroid();
        hitlocation = (hitlocation[0], hitlocation[1], hitlocation[2] + entdetected getboundshalfsize()[2]);
      }

      if(sighttracepassed(vieweye, hitlocation, 0, entdetected, undefined, 1)) {
        var_c8863cdecb0560f4 = array_add(var_c8863cdecb0560f4, entdetected);
        var_275d78a9e8d113aa++;
      }
    }
  }

  var_1fa763edf5f1cc00 = trace::create_contents(0, 1, 1, 1);

  if(isDefined(level.ob.cysts)) {
    foreach(cyst in level.ob.cysts) {
      if(!isDefined(cyst) || !isDefined(cyst.origin)) {
        continue;
      }

      if(isDefined(cyst.s_cyst)) {
        vup = anglestoup(cyst.s_cyst.angles);
        var_6cd94f42dce2a663 = cyst.origin + vup * 10;
      } else {
        var_6cd94f42dce2a663 = cyst.origin;
      }

      if(distancesquared(self.origin, var_6cd94f42dce2a663) <= 12250000) {
        if(self worldpointinreticle_circle(var_6cd94f42dce2a663, 65, 90) == 1) {
          var_8bd607a2b7bbf567 = ray_trace(vieweye, var_6cd94f42dce2a663, missileent, var_1fa763edf5f1cc00, 0, 1, 1);

          if(isDefined(var_8bd607a2b7bbf567) && isDefined(var_8bd607a2b7bbf567["scriptable"]) && isDefined(var_8bd607a2b7bbf567["scriptable"].type) && var_8bd607a2b7bbf567["scriptable"].type == "ob_aethernest_cyst_scriptable") {
            var_38b853e7e5c069f8 = array_add(var_38b853e7e5c069f8, cyst);
          }
        }
      }
    }
  }

  if(isDefined(level.ob.spores)) {
    foreach(spore in level.ob.spores) {
      if(isDefined(spore.shielded_state) && spore.shielded_state == "inactive" && isDefined(spore.shield)) {
        shield = spore.shield;
        var_a7901d75f7306461 = (shield.origin[0], shield.origin[1], shield.origin[2] + 30);

        if(distancesquared(self.origin, var_a7901d75f7306461) <= 12250000) {
          if(self worldpointinreticle_circle(var_a7901d75f7306461, 65, 100) == 1) {
            if(sighttracepassed(vieweye, var_a7901d75f7306461, 0, shield, missileent, 1)) {
              var_c8863cdecb0560f4 = array_add(var_c8863cdecb0560f4, shield);
            }
          }
        }
      }
    }
  }

  if(isDefined(level.activekillstreaks)) {
    foreach(ent in level.activekillstreaks) {
      if(isDefined(ent.team) && ent.team == self.team) {
        continue;
      }

      if(isDefined(ent.owner) && isDefined(ent.owner.team) && ent.owner.team == self.team) {
        continue;
      }

      if(distancesquared(self.origin, ent.origin) <= 12250000) {
        if(sighttracepassed(vieweye, ent.origin, 0, ent, missileent, 1) && self worldpointinreticle_circle(ent.origin, 65, 50) == 1) {
          var_c8863cdecb0560f4 = array_add(var_c8863cdecb0560f4, ent);
        }
      }
    }
  }

  foreach(ent in getactiveequipmentarray()) {
    if(isDefined(ent.team) && ent.team == self.team) {
      continue;
    }

    if(isDefined(ent.owner) && isDefined(ent.owner.team) && ent.owner.team == self.team) {
      continue;
    }

    entdistsq = distancesquared(self.origin, ent.origin);

    if(entdistsq > 12250000) {
      continue;
    }

    if(entdistsq > 160000 && !sighttracepassed(vieweye, ent.origin, 0, ent, missileent, 1)) {
      continue;
    }

    if(self worldpointinreticle_circle(ent.origin, 65, 50) == 1) {
      var_c8863cdecb0560f4 = array_add(var_c8863cdecb0560f4, ent);
    }
  }

  foreach(ent in level.grenades) {
    if(!isDefined(ent)) {
      continue;
    }

    if(isDefined(ent.team) && ent.team == self.team) {
      continue;
    }

    if(isDefined(ent.owner) && isDefined(ent.owner.team) && ent.owner.team == self.team) {
      continue;
    }

    var_88e33e4830ac7d47 = (ent.origin[0], ent.origin[1], ent.origin[2] + 15);
    entdistsq = distancesquared(self.origin, var_88e33e4830ac7d47);

    if(entdistsq > 12250000) {
      continue;
    }

    if(entdistsq > 160000 && !sighttracepassed(vieweye, var_88e33e4830ac7d47, 0, ent, missileent, 1)) {
      continue;
    }

    if(self worldpointinreticle_circle(var_88e33e4830ac7d47, 65, 50) == 1) {
      var_c8863cdecb0560f4 = array_add(var_c8863cdecb0560f4, ent);
    }
  }

  if(isDefined(level.supportdrones)) {
    foreach(drone in level.supportdrones) {
      if(distancesquared(self.origin, drone.origin) <= 12250000) {
        if(sighttracepassed(vieweye, drone.origin, 0, drone, missileent, 1)) {
          if(self worldpointinreticle_circle(drone.origin, 65, 90) == 1) {
            var_c8863cdecb0560f4 = array_add(var_c8863cdecb0560f4, drone);
          }
        }
      }
    }
  }

  if(isDefined(level.aisentryturrets) && isDefined(level.aisentryturrets.spawnedturrets)) {
    foreach(sentry in level.aisentryturrets.spawnedturrets) {
      var_bf6447599b22469f = (sentry.origin[0], sentry.origin[1], sentry.origin[2] + 30);

      if(distancesquared(self.origin, var_bf6447599b22469f) <= 12250000) {
        if(sighttracepassed(vieweye, var_bf6447599b22469f, 0, sentry, missileent, 1)) {
          if(self worldpointinreticle_circle(var_bf6447599b22469f, 65, 120) == 1) {
            var_c8863cdecb0560f4 = array_add(var_c8863cdecb0560f4, sentry);
          }
        }
      }
    }
  }

  if(isDefined(level.ob.var_7dd4780d4e4bff4d)) {
    foreach(warlord_activity in level.ob.var_7dd4780d4e4bff4d) {
      if(isDefined(warlord_activity.sentries)) {
        foreach(sentry in warlord_activity.sentries) {
          if(isalive(sentry)) {
            var_bf6447599b22469f = (sentry.origin[0], sentry.origin[1], sentry.origin[2] + 60);

            if(distancesquared(self.origin, var_bf6447599b22469f) <= 12250000) {
              if(sighttracepassed(vieweye, var_bf6447599b22469f, 0, sentry, missileent, 1)) {
                if(self worldpointinreticle_circle(var_bf6447599b22469f, 65, 120) == 1) {
                  var_c8863cdecb0560f4 = array_add(var_c8863cdecb0560f4, sentry);
                }
              }
            }
          }
        }
      }
    }
  }

  if(isDefined(level.ob.harvesterorbs)) {
    foreach(var_8460ea35acc6e0ee in level.ob.harvesterorbs) {
      if(isDefined(var_8460ea35acc6e0ee.move)) {
        harvesterorb = var_8460ea35acc6e0ee.move;
        orborigin = harvesterorb.origin;

        if(distancesquared(self.origin, orborigin) <= 12250000) {
          if(sighttracepassed(vieweye, orborigin, 0, harvesterorb, missileent, 1)) {
            if(self worldpointinreticle_circle(orborigin, 65, 120) == 1) {
              var_c8863cdecb0560f4 = array_add(var_c8863cdecb0560f4, harvesterorb);
            }
          }
        }
      }
    }
  }

  var_c8863cdecb0560f4 = array_remove_duplicates(var_c8863cdecb0560f4);
  var_c8863cdecb0560f4 = sortbydistance(var_c8863cdecb0560f4, self.origin);
  var_6b89c719fde173c1 = self.currentprimaryweapon;
  damageorigin = self.origin;

  foreach(ent in var_c8863cdecb0560f4) {
    if(isDefined(ent.team) && ent.team == self.team) {
      continue;
    }

    if(isDefined(ent.owner) && isDefined(ent.owner.team) && ent.owner.team == self.team) {
      continue;
    }

    if(isagent(ent) && isDefined(ent.team) && ent.team != self.team) {
      if(isDefined(ent.unittype)) {
        if(ent.unittype == "zombie") {
          var_ee67fb3e8bee9a6e = getdvarint(@ "hash_245a8ac774461e4a", 40);
          ent thread function_bdeef7bfa895108c(var_ee67fb3e8bee9a6e, self, damageorigin, var_6b89c719fde173c1, 1);
          continue;
        } else if(ent.unittype == "soldier") {
          var_12c07b09a7777175 = getdvarint(@ "hash_7cdb49e8f87074af", 20);
          ent thread function_bdeef7bfa895108c(var_12c07b09a7777175, self, damageorigin, var_6b89c719fde173c1, 0);
          continue;
        }
      }
    } else if(isDefined(ent.classname)) {
      if(ent.classname == "script_vehicle") {
        if(isDefined(ent.helperdronetype) && ent.helperdronetype == "scrambler_drone_guard") {
          ent dodamage(250, damageorigin, self, self, "MOD_EXPLOSIVE", var_6b89c719fde173c1);
          continue;
        } else if(isDefined(ent.knight_ai)) {
          ent dodamage(25, damageorigin, self, self, "MOD_EXPLOSIVE", var_6b89c719fde173c1);
          ent thread function_4e9544f537fa99d6(self);
          continue;
        } else if(isDefined(ent.subclass) && issubstr(ent.subclass, "helicopter")) {
          ent dodamage(275, damageorigin, self, self, "MOD_EXPLOSIVE", var_6b89c719fde173c1);
          continue;
        } else if(isDefined(ent.targetname) && ent.targetname == "remote_tank") {
          ent dodamage(275, damageorigin, self, self, "MOD_EXPLOSIVE", var_6b89c719fde173c1);
          ent thread function_4e9544f537fa99d6(self);
          continue;
        } else if(isDefined(ent.var_aa6fe6af4cbbdd47)) {
          ent thread function_4e9544f537fa99d6(self);
        }
      } else if(ent.classname == "grenade") {
        ent dodamage(200, damageorigin, self, self, "MOD_EXPLOSIVE", var_6b89c719fde173c1);
      } else if(ent.classname == "misc_turret") {
        ent dodamage(200, damageorigin, self, self, "MOD_EXPLOSIVE", var_6b89c719fde173c1);
        ent thread function_e1e1af51fbad6907();
      }
    }

    ent dodamage(200, self.origin, self, self, "MOD_EXPLOSIVE", var_6b89c719fde173c1);
  }

  foreach(scriptable in var_38b853e7e5c069f8) {
    if(scriptable.classname == "scriptable") {
      if(scriptable.type == "ob_aethernest_cyst_scriptable") {
        scriptable function_b85de89251e1fe76(300, self, self);
      }
    }
  }
}

function function_bdeef7bfa895108c(damage, attacker, origin, weapon, var_8df4d6ecebcb0faf) {
  self endon("death");
  scripts\engine\throttle::function_f632348cbb773537(level.var_30b163d5fb8dc7d9, self);

  if(isDefined(attacker)) {
    if(var_8df4d6ecebcb0faf) {
      val::set("drone_launcher", "pain", 0);
    }

    self dodamage(damage, origin, attacker, attacker, "MOD_UNKNOWN", weapon);

    if(var_8df4d6ecebcb0faf) {
      val::reset("drone_launcher", "pain");
    }
  }
}

function function_a0a176ec45783695(attacker, time) {
  self endon("death_or_disconnect");
  level endon("game_ended");

  if(isPlayer(self) && (_hasperk("specialty_emp_immunity") || _hasperk("specialty_empimmune")) && isenemyteam(attacker.team, self.team)) {
    return;
  }

  self dodamage(1, self.origin, attacker, attacker, "MOD_EXPLOSIVE", attacker.currentprimaryweapon, undefined, undefined);

  if(scripts\cp_mp\emp_debuff::can_be_empd() == 1 && !istrue(self.var_85dc59c6a906819f)) {
    attacker thread scripts\mp\killstreaks\killstreaks::givescoreforempedplayer();
    attacker thread scripts\cp_mp\challenges::function_f05d761dc1bfa1b5();

    if(issharedfuncdefined("emp", "watch_checkForLauncherWeapons")) {
      self thread[[getsharedfunc("emp", "watch_checkForLauncherWeapons")]]();
    }

    self notify("emp_started");
    self notify("emp_applied");
    self.var_85dc59c6a906819f = 1;
    thread scripts\cp_mp\emp_debuff::function_9d31a370d60f86da(self, 2);

    if(isDefined(self.var_5d67315cdcf62026)) {
      self thread[[self.var_5d67315cdcf62026]]();
    }
  } else {
    return;
  }

  wait time;
  self.var_85dc59c6a906819f = undefined;
  self notify("dronegun_emp_cleared");

  if(!isDefined(self.var_5c079aa1be2b9bb)) {
    self notify("emp_cleared");
    self notify("stopLauncherCheck");

    if(isDefined(self.var_2ba749157b05bad7)) {
      self[[self.var_2ba749157b05bad7]]();
    }
  }
}

function function_258b974cf7d16877(attackingplayer) {
  level endon("game_ended");
  self notify("object_hit_by_dronegun");
  self endon("object_hit_by_dronegun");
  data = damage_utility::packdamagedata(attackingplayer, self, 1, attackingplayer.currentprimaryweapon, "MOD_EXPLOSIVE", attackingplayer);

  if(isDefined(self.var_5d67315cdcf62026)) {
    self thread[[self.var_5d67315cdcf62026]](data);
  }

  wait 5;

  if(isDefined(self.var_2ba749157b05bad7)) {
    self thread[[self.var_2ba749157b05bad7]](data);
  }
}

function function_4e9544f537fa99d6(attackingplayer) {
  level endon("game_ended");
  self notify("object_hit_by_dronegun");
  self endon("object_hit_by_dronegun");
  data = damage_utility::packdamagedata(attackingplayer, self, 1, attackingplayer.currentprimaryweapon, "MOD_EXPLOSIVE", attackingplayer);

  if(isDefined(self.var_aa6fe6af4cbbdd47)) {
    self thread[[self.var_aa6fe6af4cbbdd47]](data);
  }

  wait 5;

  if(isDefined(self.var_2ca1a8cc9f467817)) {
    self thread[[self.var_2ca1a8cc9f467817]](data);
  }
}

function function_1475aa09aebba72(killstreakent) {
  if(!isDefined(self.var_48acfe82a1d42d61)) {
    self.var_48acfe82a1d42d61 = [];
  }

  self.var_48acfe82a1d42d61 = array_removeundefined(self.var_48acfe82a1d42d61);

  if(!array_contains(self.var_48acfe82a1d42d61, killstreakent)) {
    self.var_48acfe82a1d42d61 = array_add(self.var_48acfe82a1d42d61, killstreakent);
    thread killstreaks::givescoreforempedkillstreak();
    thread function_2b68ad55a6fdd0d4(killstreakent, 3);
  }
}

function function_2b68ad55a6fdd0d4(killstreakent, timer) {
  level endon("game_ended");
  wait timer;

  if(isDefined(self.var_48acfe82a1d42d61) && array_contains(self.var_48acfe82a1d42d61, killstreakent)) {
    self.var_48acfe82a1d42d61 = array_remove(self.var_48acfe82a1d42d61, killstreakent);
  }
}

function function_e1e1af51fbad6907() {
  self endon("death");
  self setmode("sentry_offline");
  playFXOnTag(getfx("sentry_gun_stun_fx"), self, "tag_aim_pivot");
  self laseroff();
  wait 2;
  stopFXOnTag(level._effect["sentry_gun_stun_fx"], self, "tag_aim_pivot");
  self setmode("sentry");
  self laseron();
}

function recommendedstatusbyseason(objweapon, inflictor) {
  var_55a3d589b1919af0 = [];

  if(isDefined(objweapon)) {
    var_18cfb23a952605a8 = scripts\cp_mp\weapon::getweaponrootname(objweapon);
    weaponbundle = scripts\cp_mp\weapon::function_8477d8595e0364a7(var_18cfb23a952605a8, [#"hash_c598198697548df4"]);

    if(isDefined(weaponbundle)) {
      if(isDefined(weaponbundle.var_26755ea5f1d38138)) {
        var_8bf210125d6a466e = 0;

        foreach(index, recentry in weaponbundle.var_26755ea5f1d38138) {
          var_2e232a8fc762e00 = index + var_8bf210125d6a466e;

          if(isDefined(weaponbundle.var_26755ea5f1d38138[index].priority)) {
            if(int(weaponbundle.var_26755ea5f1d38138[index].season) == var_2e232a8fc762e00) {
              var_55a3d589b1919af0[var_55a3d589b1919af0.size] = weaponbundle.var_26755ea5f1d38138[index].priority;
            } else {
              var_94187ed0b2312b3c = var_2e232a8fc762e00;

              while(var_94187ed0b2312b3c < int(weaponbundle.var_26755ea5f1d38138[index].season)) {
                var_55a3d589b1919af0[var_55a3d589b1919af0.size] = 0;
                var_94187ed0b2312b3c++;
                var_8bf210125d6a466e++;
              }

              var_55a3d589b1919af0[var_55a3d589b1919af0.size] = weaponbundle.var_26755ea5f1d38138[index].priority;
            }

            continue;
          }

          var_55a3d589b1919af0[var_55a3d589b1919af0.size] = 0;
        }

        while(var_55a3d589b1919af0.size < 7) {
          var_55a3d589b1919af0[var_55a3d589b1919af0.size] = 0;
        }

        return var_55a3d589b1919af0;
      } else {
        return undefined;
      }
    } else {
      return undefined;
    }

    return;
  }

  return undefined;
}

function function_2d2bee2ee8b4efee(missile) {
  level endon("game_ended");

  if(!isDefined(missile.weapon_object)) {
    return;
  }

  if(!isDefined(missile.weapon_object.override)) {
    return;
  }

  var_580837ba9de8f3d4 = missile.weapon_object.override;

  switch (var_580837ba9de8f3d4) {
    case #"hash_dae501c7958e0d14":
      spawnpos = self getEye();
      launchvelocity = missile getmissilevelocity();
      grenadeweaponname = "jup_semtex_mike32_mp";

      if(isDefined(missile.weapon_object.weaponblueprint) && isDefined(missile.weapon_object.weaponblueprint.lootid) && missile.weapon_object.weaponblueprint.lootid == 68641) {
        grenadeweaponname = "jup_semtex_mike32_v5008_mp";
      }

      grenade = scripts\mp\utility\weapon::_launchgrenade(grenadeweaponname, spawnpos, launchvelocity, undefined, 1, grenade);
      grenade hide();
      scripts\mp\weapons::grenadeinitialize(grenade, makeweapon(grenadeweaponname));
      thread semtex_used(grenade);
      missile notify("death");
      missile hide();
      waitframe();
      waitframe();
      missile delete();
      grenade show();
      break;
    case #"hash_fad9e06cbc21bdd4":
      thread scripts\mp\equipment\bunkerbuster::function_d5fe78860931c577(missile, self.currentprimaryweapon);
      break;
    default:
      break;
  }
}

function function_6989a64fc49d022() {
  level endon("game_ended");
  self endon("disconnect");

  while(true) {
    self waittill("weapon_change", weapon);

    if(isDefined(self.var_30ac085d2040dbe7) && weapon == self.var_30ac085d2040dbe7) {
      continue;
    }

    if(weapon hasattachment("jup_grip_vert_tk_amp")) {
      if(!isDefined(self.var_30ac085d2040dbe7)) {
        self.var_30ac085d2040dbe7 = scripts\cp_mp\utility\weapon_utility::function_eeaa22f0cd1ff845("jup_amp_knifestab_mp");
      }

      if(!self hasweapon(self.var_30ac085d2040dbe7)) {
        self giveweapon(self.var_30ac085d2040dbe7);
        self assignweaponmeleeslot(self.var_30ac085d2040dbe7);
      }

      continue;
    }

    if(isDefined(self.var_30ac085d2040dbe7) && self hasweapon(self.var_30ac085d2040dbe7)) {
      self takeweapon(self.var_30ac085d2040dbe7);
    }
  }
}

function function_130230f6bb9e9666() {
  self endon("death_or_disconnect");
  level endon("game_ended");
  self endon("weapon_change");
  var_fd65486089c85d6d = getdvarint(@ "hash_4d9ba4fc0ac8b480", 500);
  var_e816087e55998734 = 0;

  while(true) {
    if(!isDefined(self.currentprimaryweapon) || self.currentprimaryweapon.basename != "jup_jp31_dm_compound_mp") {
      waitframe();
      continue;
    }

    while(self reloadbuttonPressed()) {
      if(var_e816087e55998734 == 0) {
        var_e816087e55998734 = gettime();
      }

      var_22561ffcb8eb5f8f = gettime() - var_e816087e55998734;

      if(var_22561ffcb8eb5f8f > var_fd65486089c85d6d) {
        var_22561ffcb8eb5f8f = 0;
        var_e816087e55998734 = 0;
        function_4afcb847b264f855();
      }

      waitframe();
    }

    var_e816087e55998734 = 0;
    waitframe();
  }
}

function function_4afcb847b264f855() {
  currentweapon = self.currentprimaryweapon;
  currentammo = currentweapon.modifier;
  newammo = undefined;

  switch (currentammo) {
    case #"hash_14a0eff941d2ec83":
      newammo = "jup_ammo_arrow_gas";
      break;
    case #"hash_bb2800f912ce65eb":
      newammo = "jup_ammo_arrow_snapshot";
      break;
    case #"hash_fc78a991420fd12e":
      newammo = "jup_ammo_arrow_he";
      break;
    case #"hash_54394a972b4ae6e1":
      newammo = "jup_ammo_arrow_rip";
      break;
    case #"hash_dd886f93e6f7e11":
      newammo = "jup_ammo_arrow_db";
      break;
    case #"hash_542d33972b41c850":
      newammo = "jup_ammo_arrow_std";
      break;
    default:
      newammo = "jup_ammo_arrow_std";
      break;
  }

  variantid = getweaponvariantindex(currentweapon);
  stickers = [currentweapon.stickerslot0, currentweapon.stickerslot1, currentweapon.stickerslot2, currentweapon.stickerslot3, default_to(currentweapon.var_b39ac546cc8621f8, "none")];
  attachments = currentweapon.attachments;
  attachmentids = currentweapon.attachmentvarindices;
  attachments = array_remove(attachments, currentammo);
  attachments = array_add(attachments, newammo);
  camo = getweaponcamoname(currentweapon);
  w_new = scripts\cp_mp\weapon::buildweapon(currentweapon.basename, attachments, camo, undefined, variantid, attachmentids, undefined, stickers);
  w_new = w_new withattachment(newammo);
  self takeweapon(self.currentprimaryweapon);
  self giveweapon(w_new, variantid);
  _switchtoweaponimmediate(w_new);
}

function function_450edf11cb278f66() {
  self endon("death_or_disconnect");
  level endon("game_ended");
  self endon("end_spear_inspect_monitor");
  childthread function_946eed4c32b18d98();
  self function_35501b42058d4de9();

  while(true) {
    if(isDefined(self.laststance)) {
      if(self.laststance == "prone" || self isdiving() || inprematch()) {
        wait 0.5;
        self function_35501b42058d4de9();
      } else {
        self function_bb04491d50d9e43e();
      }
    }

    wait 0.1;
  }
}

function function_946eed4c32b18d98() {
  while(true) {
    self waittill("weapon_change");
    currentweapon = self getcurrentweapon();

    if(isDefined(currentweapon) && currentweapon.basename == "jup_jp23_me_spear_mp") {
      continue;
    }

    self function_bb04491d50d9e43e();
    self notify("end_spear_inspect_monitor");
  }
}