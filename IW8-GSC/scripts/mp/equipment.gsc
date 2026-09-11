/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\equipment.gsc
***********************************************/

function init() {
  level.equipment = spawnStruct();
  inititems();
  loadtable();
  timeoflastexecute();
  scripts\mp\utility\spawn_event_aggregator::registeronplayerspawncallback(&equiponplayerspawned);
}

function inititems() {
  level.equipment.callbacks = [];
  var_0 = level.equipment;
  scripts\mp\equipment_interact::equipmentinteract_init();

  if(!istrue(game["isLaunchChunk"])) {
    scripts\mp\perks\headgear::init();
    scripts\mp\equipment\tactical_cover::tac_cover_init();
    scripts\mp\equipment\trophy_system::trophy_init();
    scripts\mp\equipment\decoy_grenade::decoy_init();
    _donewithcorpse::vehicle_compass_setteamfriendlyto();
    scripts\mp\equipment\slinger::slinger_init();
    scripts\mp\equipment\at_mine::at_mine_init();
    scripts\mp\equipment\tac_insert::tacinsert_init();
  }

  scripts\mp\equipment\claymore::claymore_init();
  scripts\mp\equipment\molotov::molotov_init();
  _debug_rooftop_raid_exfil::emp_init();
  scripts\mp\equipment\weapon_drop::weapondrop_init();
  scripts\cp_mp\equipment\throwing_knife::throwing_knife_init();
  scripts\mp\equipment\numbers_grenade::init();
  var_0.callbacks["equip_helmet"]["onGive"] = &scripts\mp\perks\headgear::runheadgear;
  var_0.callbacks["equip_helmet"]["onTake"] = &scripts\mp\perks\headgear::removeheadgear;
  var_0.callbacks["equip_adrenaline"]["onFired"] = &scripts\mp\equipment\adrenaline::onequipmentfired;
  var_0.callbacks["equip_adrenaline"]["onTake"] = &scripts\mp\equipment\adrenaline::onequipmenttaken;
  var_0.callbacks["equip_c4"]["onGive"] = &scripts\mp\equipment\c4::c4_set;
  var_0.callbacks["equip_trophy"]["onGive"] = &scripts\mp\equipment\trophy_system::trophy_set;
  var_0.callbacks["equip_trophy"]["onTake"] = &scripts\mp\equipment\trophy_system::trophy_unset;
  var_0.callbacks["equip_decon_station"]["onTake"] = &_debug_rooftop_heli_start::jugg_go_to_node_callback;
  var_0.callbacks["equip_decon_station"]["onGive"] = &_debug_rooftop_heli_start::jugg_getminigunweapon;
  var_0.callbacks["equip_throwing_knife"]["onGive"] = &scripts\cp_mp\equipment\throwing_knife::throwing_knife_ongive;
  var_0.callbacks["equip_throwing_knife"]["onTake"] = &scripts\cp_mp\equipment\throwing_knife::throwing_knife_ontake;
  var_0.callbacks["equip_throwing_knife_fire"]["onGive"] = &scripts\cp_mp\equipment\throwing_knife::throwing_knife_ongive;
  var_0.callbacks["equip_throwing_knife_fire"]["onTake"] = &scripts\cp_mp\equipment\throwing_knife::throwing_knife_ontake;
  var_0.callbacks["equip_throwing_knife_electric"]["onGive"] = &scripts\cp_mp\equipment\throwing_knife::throwing_knife_ongive;
  var_0.callbacks["equip_throwing_knife_electric"]["onTake"] = &scripts\cp_mp\equipment\throwing_knife::throwing_knife_ontake;
  var_0.callbacks["equip_throwing_knife_drill"]["onGive"] = &scripts\cp_mp\equipment\throwing_knife::throwing_knife_ongive;
  var_0.callbacks["equip_throwing_knife_drill"]["onTake"] = &scripts\cp_mp\equipment\throwing_knife::throwing_knife_ontake;
  var_0.callbacks["equip_molotov"]["onGive"] = &scripts\mp\equipment\molotov::molotov_on_give;
  var_0.callbacks["equip_molotov"]["onTake"] = &scripts\mp\equipment\molotov::molotov_on_take;
  var_0.callbacks["equip_tac_cover"]["onGive"] = &scripts\mp\equipment\tactical_cover::tac_cover_on_give;
  var_0.callbacks["equip_tac_cover"]["onTake"] = &scripts\mp\equipment\tactical_cover::tac_cover_on_take;
  var_0.callbacks["equip_tac_cover"]["onFired"] = &scripts\mp\equipment\tactical_cover::tac_cover_on_fired;
  var_0.callbacks["equip_tac_insert"]["onGive"] = &scripts\mp\equipment\tac_insert::tacinsert_set;
  var_0.callbacks["equip_tac_insert"]["onTake"] = &scripts\mp\equipment\tac_insert::tacinsert_unset;
  var_0.callbacks["equip_binoculars"]["onGive"] = &_debug_rooftop_activesat::closeobjectiveiconid;
  var_0.callbacks["equip_binoculars"]["onTake"] = &_debug_rooftop_activesat::codeloc;
  var_0.callbacks["equip_gas_grenade"]["onPlayerDamaged"] = &scripts\mp\equipment\gas_grenade::gas_onplayerdamaged;
  var_0.callbacks["equip_flash"]["onPlayerDamaged"] = &scripts\mp\equipment\flash_grenade::onplayerdamaged;
  var_0.callbacks["equip_concussion"]["onPlayerDamaged"] = &scripts\mp\equipment\concussion_grenade::onplayerdamaged;
  var_0.callbacks["equip_thermite"]["onPlayerDamaged"] = &scripts\mp\equipment\thermite::thermite_onplayerdamaged;
  var_0.callbacks["equip_molotov"]["onPlayerDamaged"] = &scripts\mp\equipment\molotov::molotov_on_player_damaged;
  var_0.callbacks["equip_numbers_grenade"]["onPlayerDamaged"] = &scripts\mp\equipment\numbers_grenade::on_player_damaged;
  var_0.callbacks["equip_at_mine"]["onOwnerChanged"] = &scripts\mp\equipment\at_mine::at_mine_onownerchanged;
  var_0.callbacks["equip_claymore"]["onOwnerChanged"] = &scripts\mp\equipment\claymore::claymore_onownerchanged;
  var_0.callbacks["equip_c4"]["onOwnerChanged"] = &scripts\mp\equipment\c4::c4_onownerchanged;
  var_0.callbacks["equip_jammer"]["onOwnerChanged"] = &_donewithcorpse::vehicle_compass_updateallvisibilityforplayer;
  var_0.callbacks["equip_at_mine"]["onDestroyedByTrophy"] = &scripts\mp\equipment\at_mine::at_mine_delete;
  var_0.callbacks["equip_claymore"]["onDestroyedByTrophy"] = &scripts\mp\equipment\claymore::claymore_delete;
  var_0.callbacks["equip_trophy"]["onDestroyedByTrophy"] = &scripts\mp\equipment\trophy_system::trophy_delete;
  var_0.callbacks["equip_c4"]["onDestroyedByTrophy"] = &scripts\mp\equipment\c4::c4_delete;
  var_0.callbacks["equip_snapshot_grenade"]["onDestroyedByTrophy"] = &scripts\mp\equipment\snapshot_grenade::snapshot_grenade_delete;
  thread watchlethaldelay();
  scripts\mp\utility\disconnect_event_aggregator::registerondisconnecteventcallback(&onownerdisconnect);
}

function getcallback(var_0, var_1) {
  if(!isDefined(level.equipment.callbacks[var_0])) {
    return undefined;
  }

  return level.equipment.callbacks[var_0][var_1];
}

function loadtable() {
  level.equipment.table = [];

  for(var_0 = 1;; var_0++) {
    var_1 = tablelookupbyrow("mp/equipment.csv", var_0, 1);

    if(!isDefined(var_1) || var_1 == "") {
      break;
    }

    var_2 = tolower(var_1);
    var_3 = spawnStruct();
    var_3.ref = var_2;
    var_4 = tablelookupbyrow("mp/equipment.csv", var_0, 6);

    if(var_4 != "none") {
      var_5 = tablelookupbyrow("mp/equipment.csv", var_0, 19);
      var_6 = undefined;

      if(var_5 != "") {
        var_7 = getcompleteweaponname(var_4);

        if(!nullweapon(var_7)) {
          var_6 = [var_5];
        }
      }

      var_3.objweapon = getcompleteweaponname(var_4, var_6);
    }

    var_3.id = var_0;
    var_3.image = tablelookupbyrow("mp/equipment.csv", var_0, 4);
    var_3.defaultslot = scripts\engine\utility::ter_op(tablelookupbyrow("mp/equipment.csv", var_0, 7) == "2", "secondary", "primary");
    var_3.scavengerammo = int(tablelookupbyrow("mp/equipment.csv", var_0, 10));
    var_3.ispassive = tolower(tablelookupbyrow("mp/equipment.csv", var_0, 11)) == "true";
    var_3.usecellspawns = tablelookupbyrow("mp/equipment.csv", var_0, 8) != "-1";
    var_8 = tablelookupbyrow("mp/equipment.csv", var_0, 12);

    if(var_8 == "none") {} else if(var_8 == "") {
      if(var_4 != "none") {
        var_3.damageweaponnames = [var_4];
      }
    } else {
      var_9 = [];

      if(var_4 != "none") {
        GscBinSkip0(0x2e, var_9.size, var_4);
      }

      var_10 = strtok(var_8, " ");

      foreach(var_12 in var_10) {
        var_9 = var_12;
      }

      var_3.damageweaponnames = var_9;
    }

    level.equipment.table[var_2] = var_3;
  }
}

function getequipmenttableinfo(var_0) {
  return level.equipment.table[var_0];
}

function giveequipment(var_0, var_1) {
  if(!isDefined(self.equipment)) {
    self.equipment = [];
  }

  if(var_0 == "none") {
    return;
  }

  var_2 = getequipmenttableinfo(var_0);

  if(!isDefined(var_2)) {
    scripts\mp\utility\script::laststand_dogtags("Attempting to give unknown equipment - " + var_0 + " - in slot - " + var_1);
    return;
  }

  if(var_1 == "super") {
    var_3 = level.br_pickups.br_superreference[level.br_pickups.br_equipnametoscriptable[var_0]];
    var_2.id = scripts\mp\supers::getsuperid(var_3);
  }

  takeequipment(var_1);

  if(isDefined(var_2.objweapon)) {
    self giveweapon(var_2.objweapon);

    if(is_equipment_slot_allowed(var_1) && !var_2.ispassive) {
      if(var_1 == "primary") {
        self assignweaponoffhandprimary(var_2.objweapon);
      } else if(var_1 == "secondary") {
        self assignweaponoffhandsecondary(var_2.objweapon);
      } else if(var_1 == "super") {
        self assignweaponoffhandspecial(var_2.objweapon);
      }
    }
  }

  sethudslot(var_1, var_2.id);
  self.equipment[var_1] = var_0;
  var_4 = getcallback(var_0, "onGive");

  if(isDefined(var_4)) {
    self thread[[var_4]](var_0, var_1);
  }

  updateuiammocount(var_1);
  var_5 = var_0 == "equip_throwing_knife" || var_0 == "equip_throwing_knife_fire" || var_0 == "equip_throwing_knife_electric" || var_0 == "equip_throwing_knife_drill";

  if(scripts\mp\utility\game::getgametype() == "arena" && var_5) {
    return;
  }

  thread watchlethaldelayplayer(var_0, var_1);
}

function takeequipment(var_0) {
  var_1 = getcurrentequipment(var_0);

  if(!isDefined(var_1)) {
    return;
  }

  var_2 = getequipmenttableinfo(var_1);

  if(isDefined(var_2.objweapon)) {
    if(self hasweapon(var_2.objweapon)) {
      scripts\cp_mp\utility\inventory_utility::_takeweapon(var_2.objweapon);

      if(var_0 == "primary") {
        self clearoffhandprimary();
      } else if(var_0 == "secondary") {
        self clearoffhandsecondary();
      }
    }
  }

  sethudslot(var_0, 0);
  self.equipment[var_0] = undefined;
  var_3 = getcallback(var_1, "onTake");

  if(isDefined(var_3)) {
    self thread[[var_3]](var_1, var_0);
  }

  updateuiammocount(var_0);
  self notify("equipment_taken_" + var_1);
}

function equiponplayerdamaged(var_0) {
  var_1 = var_0.objweapon.basename;

  foreach(var_3 in level.equipment.table) {
    var_4 = getcallback(var_10, "onPlayerDamaged");

    if(isDefined(var_4) && isDefined(var_3.damageweaponnames)) {
      foreach(var_6 in var_3.damageweaponnames) {
        if(var_6 == var_1) {
          var_7 = gettime();
          var_8 = [[var_4]](var_0);
          return var_8;
        }
      }

      var_8 = undefined;
    }
  }

  var_4 = undefined;
}

function ondestroyedbytrophy() {
  if(isDefined(self.equipmentref)) {
    var_0 = getcallback(self.equipmentref, "onDestroyedByTrophy");

    if(isDefined(var_0)) {
      self thread[[var_0]]();
      return true;
    } else if(scripts\mp\weapons::isplantedequipment(self)) {
      thread scripts\mp\weapons::deleteexplosive();
      return true;
    }
  }

  return false;
}

function disableslotinternal(var_0) {
  if(var_0 == "primary") {
    self clearoffhandprimary();
    return;
  }

  if(var_0 == "secondary") {
    self clearoffhandsecondary();
    return;
  }

  if(var_0 == "super") {
    self clearoffhandspecial();
    return;
  }
}

function enableslotinternal(var_0) {
  var_1 = getcurrentequipment(var_0);

  if(!isDefined(var_1)) {
    return;
  }

  var_2 = getequipmenttableinfo(var_1);

  if(isDefined(var_2.objweapon) && !var_2.ispassive && self hasweapon(var_2.objweapon)) {
    if(var_0 == "primary") {
      self assignweaponoffhandprimary(var_2.objweapon);
      return;
    }

    if(var_0 == "secondary") {
      self assignweaponoffhandsecondary(var_2.objweapon);
      return;
    }

    if(var_0 == "super") {
      self assignweaponoffhandspecial(var_2.objweapon);
      return;
    }

    return;
  }
}

function allow_equipment(var_0, var_1) {
  allow_equipment_slot("primary", var_0, var_1);
  allow_equipment_slot("secondary", var_0, var_1);
}

function allow_equipment_slot(var_0, var_1, var_2) {
  var_3 = scripts\common\input_allow::allow_input_internal("equipment_" + var_0, var_1, var_2);

  if(!isDefined(var_3)) {
    return;
  }

  if(var_1) {
    enableslotinternal(var_0);
    return;
  }

  disableslotinternal(var_0);
}

function is_equipment_slot_allowed(var_0) {
  return scripts\common\input_allow::is_input_allowed_internal("equipment_" + var_0);
}

function sethudslot(var_0, var_1) {
  if(var_0 != "super") {
    self setclientomnvar("ui_equipment_id_" + var_0, var_1);
    return;
  }

  self setclientomnvar("ui_perk_package_super1", var_1);
}

function getcurrentequipment(var_0) {
  if(!isDefined(self.equipment)) {
    return undefined;
  }

  return self.equipment[var_0];
}

function clearallequipment() {
  if(!isDefined(self.equipment)) {
    return;
  }

  foreach(var_1 in self.equipment) {
    takeequipment(var_2);
  }
}

function getequipmentmaxammo(var_0) {
  var_1 = getequipmenttableinfo(var_0);

  if(!isDefined(var_1)) {
    return undefined;
  }

  if(!isDefined(var_1.objweapon)) {
    return 0;
  }

  jumpiffalse(level.gametype != "br") LOC_000000aa;
  var_2 = scripts\mp\utility\perk::_hasperk("specialty_extraoffhandammo");
  var_3 = weaponmaxammo(var_1.objweapon, var_2);

  switch (var_0) {
    case "equip_hb_sensor":
    case "equip_binoculars":
    case "equip_tac_cover":
      break;
    default:
      var_3--;
      break;
  }

  var_4 = findequipmentslot(var_0);

  if(isDefined(var_4) && scripts\mp\utility\perk::_hasperk("specialty_extra_deadly") && var_4 == "primary") {
    var_3++;
  }

  goto LOC_00000112;
}

function getequipmentstartammo(var_0) {
  var_1 = getequipmenttableinfo(var_0);

  if(!isDefined(var_1)) {
    return undefined;
  }

  if(!isDefined(var_1.objweapon)) {
    return 0;
  }

  var_2 = scripts\mp\utility\perk::_hasperk("specialty_extraoffhandammo");
  return weaponstartammo(var_1.objweapon, var_2);
}

function getequipmentammo(var_0) {
  var_1 = getequipmenttableinfo(var_0);

  if(!isDefined(var_1)) {
    return undefined;
  }

  if(!isDefined(var_1.objweapon)) {
    return 0;
  }

  return self getammocount(var_1.objweapon);
}

function setequipmentammo(var_0, var_1) {
  var_2 = getequipmenttableinfo(var_0);

  if(!isDefined(var_2.objweapon)) {
    return;
  }

  self setweaponammoclip(var_2.objweapon, var_1);
  updateuiammocount(findequipmentslot(var_0));
}

function incrementequipmentammo(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  var_2 = getequipmentammo(var_0);
  var_3 = int(min(var_2 + var_1, getequipmentmaxammo(var_0)));
  setequipmentammo(var_0, var_3);
}

function decrementequipmentammo(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  var_2 = getequipmentammo(var_0);
  var_1 = int(min(var_1, var_2));

  if(var_1 > 0) {
    var_3 = int(min(var_2 - var_1, getequipmentmaxammo(var_0)));
    setequipmentammo(var_0, var_3);
    return;
  }
}

function incrementequipmentslotammo(var_0, var_1) {
  var_2 = getcurrentequipment(var_0);

  if(!isDefined(var_2)) {
    return undefined;
  }

  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  var_3 = getequipmentammo(var_2);
  var_4 = int(min(var_3 + var_1, getequipmentmaxammo(var_2)));
  setequipmentammo(var_2, var_4);
}

function decrementequipmentslotammo(var_0, var_1) {
  var_2 = getcurrentequipment(var_0);

  if(!isDefined(var_2)) {
    return undefined;
  }

  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  var_3 = getequipmentammo(var_2);
  var_4 = int(min(var_3 - var_1, getequipmentmaxammo(var_2)));
  setequipmentammo(var_2, var_4);
}

function getequipmentslotammo(var_0) {
  var_1 = getcurrentequipment(var_0);

  if(!isDefined(var_1)) {
    return undefined;
  }

  return getequipmentammo(var_1);
}

function setequipmentslotammo(var_0, var_1) {
  var_2 = getcurrentequipment(var_0);

  if(!isDefined(var_2)) {
    return undefined;
  }

  return setequipmentammo(var_2, var_1);
}

function mapequipmentweaponforref(var_0) {
  switch (var_0.basename) {
    case "claymore_radial_mp":
      return getcompleteweaponname("claymore_mp");
    case "at_mine_ap_mp":
      return getcompleteweaponname("at_mine_mp");
    case "thermite_av_mp":
    case "thermite_ap_mp":
      return getcompleteweaponname("thermite_mp");
  }

  return var_0;
}

function getequipmentreffromweapon(var_0) {
  var_0 = mapequipmentweaponforref(var_0);

  foreach(var_2 in level.equipment.table) {
    if(isDefined(var_2.objweapon) && var_0 == var_2.objweapon) {
      return var_2.ref;
    }
  }

  return undefined;
}

function getweaponfromequipmentref(var_0) {
  foreach(var_2 in level.equipment.table) {
    if(isDefined(var_2.ref) && var_0 == var_2.ref) {
      return var_2.objweapon;
    }
  }

  return undefined;
}

function hasequipment(var_0) {
  if(!isDefined(self.equipment)) {
    return false;
  }

  foreach(var_2 in self.equipment) {
    if(var_2 == var_0) {
      return true;
    }
  }

  return false;
}

function findequipmentslot(var_0) {
  if(!isDefined(self.equipment)) {
    return undefined;
  }

  foreach(var_2 in self.equipment) {
    if(var_2 == var_0) {
      return var_3;
    }
  }
}

function isequipmentlethal(var_0) {
  return isequipmentprimary(var_0);
}

function isequipmentprimary(var_0) {
  if(isDefined(level.equipment.table[var_0])) {
    return (level.equipment.table[var_0].defaultslot == "primary");
  }

  return 0;
}

function isequipmenttactical(var_0) {
  return isequipmentsecondary(var_0);
}

function isequipmentsecondary(var_0) {
  if(isDefined(level.equipment.table[var_0])) {
    return (level.equipment.table[var_0].defaultslot == "secondary");
  }

  return 0;
}

function unset_force_aitype_suicidebomber(var_0) {
  if(isDefined(level.equipment.table[var_0])) {
    return istrue(level.equipment.table[var_0].usecellspawns);
  }

  return 0;
}

function updateuiammocount(var_0) {
  if(!isDefined(self.equipment)) {
    return;
  }

  var_1 = 0;
  var_2 = getcurrentequipment(var_0);

  if(isDefined(var_2)) {
    var_1 = getequipmentslotammo(var_0);
  }

  if(var_0 == "primary") {
    self setclientomnvar("ui_power_num_charges", var_1);
    self trajectoryupdateoriginandangles("primary", var_1);
    return;
  }

  if(var_0 == "secondary") {
    self setclientomnvar("ui_power_secondary_num_charges", var_1);
    self trajectoryupdateoriginandangles("secondary", var_1);
    return;
  }

  if(var_0 == "health") {
    self setclientomnvar("ui_equipment_id_health_numCharges", var_1);

    if(scripts\mp\utility\game::unset_relic_grounded()) {
      scripts\mp\gametypes\br_public::updatebrextradata("armorPlateCount", var_1);
      return;
    }

    return;
  }
}

function equiponplayerspawned() {
  thread watchoffhandfired();
}

function resetequipment() {
  self.equipment = [];
}

function executeoffhandfired(var_0) {
  foreach(var_2 in self.equipment) {
    var_3 = getequipmenttableinfo(var_2);

    if(isDefined(var_3.objweapon) && var_0 == var_3.objweapon) {
      if(scripts\mp\utility\game::getgametype() == "br") {
        scripts\mp\gametypes\br_analytics::branalytics_equipmentuse(self, var_0);
      }

      var_4 = getequipmentreffromweapon(var_0);
      scripts\mp\damage::hide_name_fx_from_players(var_4);
      var_5 = getcallback(var_2, "onFired");

      if(isDefined(var_5)) {
        self thread[[var_5]](var_2, var_6, var_0);
      }

      updateuiammocount(var_6);
      break;
    }
  }
}

function watchoffhandfired() {
  level endon("game_ended");
  self endon("death_or_disconnect");

  for(;;) {
    self waittill("offhand_fired", var_0);
    executeoffhandfired(var_0);
  }
}

function givescavengerammo() {
  foreach(var_1 in self.equipment) {
    var_2 = getequipmenttableinfo(var_1);

    if(var_2.scavengerammo > 0) {
      incrementequipmentammo(var_1, var_2.scavengerammo);
    }
  }
}

function getdefaultslot(var_0) {
  var_1 = getequipmenttableinfo(var_0);

  if(!isDefined(var_1)) {
    return undefined;
  }

  return var_1.defaultslot;
}

function watchlethaldelay() {
  level endon("lethal_delay_end");
  level endon("round_end");
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("prematch_done");
  var_0 = initstandardloadout();

  if(var_0) {
    level.lethaldelaystarttime = gettime();
  } else {
    level.lethaldelaystarttime = scripts\mp\utility\game::gettimepassed();
  }

  if(level.lethaldelay == 0) {
    level.lethaldelayendtime = level.lethaldelaystarttime;
    level notify("lethal_delay_end");
  }

  level.lethaldelayendtime = level.lethaldelaystarttime + level.lethaldelay * 1000;
  level notify("lethal_delay_start");

  for(;;) {
    var_1 = undefined;

    if(var_0) {
      var_1 = gettime();
    } else {
      var_1 = scripts\mp\utility\game::gettimepassed();
    }

    if(var_1 >= level.lethaldelayendtime) {
      break;
    }

    waitframe();
  }

  level notify("lethal_delay_end");
}

function watchlethaldelayplayer(var_0, var_1) {
  self endon("death_or_disconnect");
  level endon("round_end");
  level endon("game_ended");

  if(lethaldelaypassed()) {
    return;
  }

  self notify("watchLethalDelayPlayer_" + var_1);
  self endon("watchLethalDelayPlayer_" + var_1);
  self endon("equipment_taken_" + var_0);

  if(!isDefined(self.weapon_xp_iw8_sh_charlie725) || !istrue(self.weapon_xp_iw8_sh_charlie725[var_1])) {
    if(!isDefined(self.weapon_xp_iw8_sh_charlie725)) {
      self.weapon_xp_iw8_sh_charlie725 = [];
    }

    self.weapon_xp_iw8_sh_charlie725[var_1] = 1;
    allow_equipment_slot(var_1, 0);
  }

  watchlethaldelayfeedbackplayer(self, var_1);

  if(isDefined(self.weapon_xp_iw8_sh_charlie725) && istrue(self.weapon_xp_iw8_sh_charlie725[var_1])) {
    self.weapon_xp_iw8_sh_charlie725[var_1] = undefined;

    if(self.weapon_xp_iw8_sh_charlie725.size == 0) {
      self.weapon_xp_iw8_sh_charlie725 = undefined;
    }

    allow_equipment_slot(var_1, 1);
    return;
  }
}

function watchlethaldelayfeedbackplayer(var_0, var_1) {
  level endon("lethal_delay_end");

  if(!istrue(scripts\mp\flags::gameflag("prematch_done"))) {
    level waittill("lethal_delay_start");
  }

  var_2 = "+frag";

  if(var_1 != "primary") {
    var_2 = "+smoke";
  }

  if(!isai(var_0)) {
    var_0 notifyonplayercommand("lethal_attempt_" + var_1, var_2);
  }

  var_3 = initstandardloadout();

  for(;;) {
    self waittill("lethal_attempt_" + var_1);
    var_4 = undefined;

    if(var_3) {
      var_4 = gettime();
    } else {
      var_4 = scripts\mp\utility\game::gettimepassed();
    }

    var_5 = (level.lethaldelayendtime - var_4) / 1000;
    var_5 = int(max(0, ceil(var_5)));
    var_0 scripts\mp\hud_message::showerrormessage("MP/LETHALS_UNAVAILABLE_FOR_N", var_5);
  }
}

function cancellethaldelay() {
  level.lethaldelay = 0;

  if(initstandardloadout()) {
    level.lethaldelaystarttime = gettime();
  } else {
    level.lethaldelaystarttime = scripts\mp\utility\game::gettimepassed();
  }

  level.lethaldelayendtime = level.lethaldelaystarttime;
  level notify("lethal_delay_end");
}

function lethaldelaypassed() {
  if(isDefined(level.lethaldelay) && level.lethaldelay == 0) {
    return true;
  }

  if(isDefined(level.lethaldelayendtime)) {
    var_0 = undefined;

    if(initstandardloadout()) {
      var_0 = gettime();
    } else {
      var_0 = scripts\mp\utility\game::gettimepassed();
    }

    return (var_0 > level.lethaldelayendtime);
  }

  return false;
}

function initstandardloadout() {
  var_0 = scripts\mp\utility\game::getgametype();

  if(var_0 == "hq" || var_0 == "grnd" || var_0 == "koth") {
    return true;
  }

  return false;
}

function onownerdisconnect(var_0) {
  var_1 = var_0 scripts\mp\weapons::getallequip();

  foreach(var_3 in var_1) {
    var_3 notify("owner_disconnect");
  }
}

function hackequipment(var_0) {
  self.ishacked = 1;
  var_0 scripts\mp\gamelogic::sethasdonecombat(var_0, 1);
  var_0 scripts\cp\vehicles\vehicle_compass_cp::ref_1203d(self.equipmentref);
  changeowner(var_0);

  if(level.teambased) {
    self filteroutplayermarks(var_0.team);
  } else {
    self filteroutplayermarks(var_0);
  }

  var_0 scripts\mp\killstreaks\killstreaks::givescoreforhack();
}

function changeowner(var_0) {
  var_1 = self.owner;
  self setentityowner(var_0);
  self.owner = var_0;
  self.team = var_0.team;
  self setotherent(var_0);
  var_1 scripts\mp\weapons::removeequip(self);
  self.owner scripts\mp\weapons::updateplantedarray(self);
  var_2 = getcallback(self.equipmentref, "onOwnerChanged");
  self notify("ownerChanged");

  if(isDefined(var_2)) {
    self[[var_2]](var_1);
    return;
  }
}

function scriptablescleanupbatchsize(var_0, var_1, var_2) {
  foreach(var_4 in var_0) {
    if(istrue(var_4.gulag)) {
      continue;
    }

    var_4.ref_12fb1 = getcurrentequipment(var_4, var_1);
    var_4.ref_12fb0 = getequipmentslotammo(var_1);
    takeequipment(var_4, var_1);
    giveequipment(var_4, var_2, var_1);
  }
}

function ref_13a30(var_0, var_1, var_2, var_3) {
  foreach(var_5 in var_0) {
    if(istrue(var_5.gulag)) {
      continue;
    }

    var_6 = getcurrentequipment(var_5, var_1);

    if(!istrue(var_3) && isDefined(var_6) && var_2 != var_6) {
      continue;
    }

    takeequipment(var_5, var_1);
    var_7 = var_5.ref_12fb1;
    var_8 = var_5.ref_12fb0;

    if(isDefined(var_7)) {
      giveequipment(var_5, var_7, var_1);
      var_5.ref_12fb1 = undefined;

      if(isDefined(var_8)) {
        setequipmentammo(var_5, var_7, var_8);
        var_5.ref_12fb0 = undefined;
      }
    }
  }
}

function debughackequipment() {
  for(;;) {
    if(getdvarint("scr_debugHackEquipment") != 0) {
      var_0 = level.players[0];
      var_1 = undefined;

      for(var_2 = 1; var_2 < level.players.size; var_2++) {
        if(var_0 scripts\mp\utility\player::isenemy(level.players[var_2])) {
          var_1 = level.players[var_2];
          break;
        }
      }

      if(!isDefined(var_1)) {
        iprintlnbold("Need a player on the other team to scr_debugHackEquipment");
        continue;
      }

      var_3 = var_0 scripts\mp\weapons::getallequip();
      var_4 = undefined;

      if(var_3.size > 0) {
        var_4 = var_3[0];
      }

      if(!isDefined(var_4)) {
        iprintlnbold("First player must have at least one piece of equipment to scr_debugHackEquipment");
        continue;
      }

      hackequipment(var_4, var_1);
    }

    waitframe();
  }
}

function debugemp() {
  for(;;) {
    if(getdvarint("scr_testEMPGrenade") != 0) {
      if(level.players.size < 2) {
        iprintlnbold("Need at least two players to scr_testEMPGrenade");
        continue;
      }

      var_0 = level.players[1];
      var_0 scripts\mp\utility\weapon::_launchgrenade("emp_grenade_mp", (0, 0, 0), (0, 0, 0), 0.05, 0);
    }

    waitframe();
  }
}

function debugempdrone() {
  for(;;) {
    if(getdvarint("scr_testEMPDrone") != 0) {
      if(level.players.size < 2) {
        iprintlnbold("Need at least two players to scr_testEMPDrone");
        continue;
      }

      var_0 = level.players[0];
      var_1 = level.players[1];
      var_2 = spawnStruct();
      var_2.streakname = "emp_drone";
      var_2.owner = var_1;
      var_2.id = scripts\cp_mp\utility\killstreak_utility::getuniquekillstreakid(var_1);
      var_2.lifeid = 0;
      var_3 = var_0.origin;
      var_4 = var_1 scripts\cp_mp\killstreaks\emp_drone_targeted::empdrone_createdrone(var_2, var_3);
    }

    waitframe();
  }
}

function debugdestroyempdrones() {
  for(;;) {
    if(getdvarint("scr_testEMPDroneDestroy") != 0) {
      foreach(var_1 in level.activekillstreaks) {
        if(isDefined(var_1.streakinfo) && var_1.streakinfo.streakname == "emp_drone") {
          var_1 scripts\cp_mp\killstreaks\emp_drone::empdrone_destroy();
        }
      }
    }

    waitframe();
  }
}

function timeoflastexecute() {
  level.weapon_xp_iw8_pi_papa320 = [];
  var_0 = 0;

  foreach(var_2 in level.equipment.table) {
    if(!var_2.usecellspawns) {
      continue;
    }

    if(var_2.id <= 0) {
      continue;
    }

    if(var_2.defaultslot == "secondary") {
      continue;
    }

    level.weapon_xp_iw8_pi_papa320[var_2.ref] = 1 << var_0;
    var_0++;
  }
}