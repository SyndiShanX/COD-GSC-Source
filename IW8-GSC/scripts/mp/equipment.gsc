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
  var0 = level.equipment;
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
  var0.callbacks["equip_helmet"]["onGive"] = &scripts\mp\perks\headgear::runheadgear;
  var0.callbacks["equip_helmet"]["onTake"] = &scripts\mp\perks\headgear::removeheadgear;
  var0.callbacks["equip_adrenaline"]["onFired"] = &scripts\mp\equipment\adrenaline::onequipmentfired;
  var0.callbacks["equip_adrenaline"]["onTake"] = &scripts\mp\equipment\adrenaline::onequipmenttaken;
  var0.callbacks["equip_c4"]["onGive"] = &scripts\mp\equipment\c4::c4_set;
  var0.callbacks["equip_trophy"]["onGive"] = &scripts\mp\equipment\trophy_system::trophy_set;
  var0.callbacks["equip_trophy"]["onTake"] = &scripts\mp\equipment\trophy_system::trophy_unset;
  var0.callbacks["equip_decon_station"]["onTake"] = &_debug_rooftop_heli_start::jugg_go_to_node_callback;
  var0.callbacks["equip_decon_station"]["onGive"] = &_debug_rooftop_heli_start::jugg_getminigunweapon;
  var0.callbacks["equip_throwing_knife"]["onGive"] = &scripts\cp_mp\equipment\throwing_knife::throwing_knife_ongive;
  var0.callbacks["equip_throwing_knife"]["onTake"] = &scripts\cp_mp\equipment\throwing_knife::throwing_knife_ontake;
  var0.callbacks["equip_throwing_knife_fire"]["onGive"] = &scripts\cp_mp\equipment\throwing_knife::throwing_knife_ongive;
  var0.callbacks["equip_throwing_knife_fire"]["onTake"] = &scripts\cp_mp\equipment\throwing_knife::throwing_knife_ontake;
  var0.callbacks["equip_throwing_knife_electric"]["onGive"] = &scripts\cp_mp\equipment\throwing_knife::throwing_knife_ongive;
  var0.callbacks["equip_throwing_knife_electric"]["onTake"] = &scripts\cp_mp\equipment\throwing_knife::throwing_knife_ontake;
  var0.callbacks["equip_throwing_knife_drill"]["onGive"] = &scripts\cp_mp\equipment\throwing_knife::throwing_knife_ongive;
  var0.callbacks["equip_throwing_knife_drill"]["onTake"] = &scripts\cp_mp\equipment\throwing_knife::throwing_knife_ontake;
  var0.callbacks["equip_molotov"]["onGive"] = &scripts\mp\equipment\molotov::molotov_on_give;
  var0.callbacks["equip_molotov"]["onTake"] = &scripts\mp\equipment\molotov::molotov_on_take;
  var0.callbacks["equip_tac_cover"]["onGive"] = &scripts\mp\equipment\tactical_cover::tac_cover_on_give;
  var0.callbacks["equip_tac_cover"]["onTake"] = &scripts\mp\equipment\tactical_cover::tac_cover_on_take;
  var0.callbacks["equip_tac_cover"]["onFired"] = &scripts\mp\equipment\tactical_cover::tac_cover_on_fired;
  var0.callbacks["equip_tac_insert"]["onGive"] = &scripts\mp\equipment\tac_insert::tacinsert_set;
  var0.callbacks["equip_tac_insert"]["onTake"] = &scripts\mp\equipment\tac_insert::tacinsert_unset;
  var0.callbacks["equip_binoculars"]["onGive"] = &_debug_rooftop_activesat::closeobjectiveiconid;
  var0.callbacks["equip_binoculars"]["onTake"] = &_debug_rooftop_activesat::codeloc;
  var0.callbacks["equip_gas_grenade"]["onPlayerDamaged"] = &scripts\mp\equipment\gas_grenade::gas_onplayerdamaged;
  var0.callbacks["equip_flash"]["onPlayerDamaged"] = &scripts\mp\equipment\flash_grenade::onplayerdamaged;
  var0.callbacks["equip_concussion"]["onPlayerDamaged"] = &scripts\mp\equipment\concussion_grenade::onplayerdamaged;
  var0.callbacks["equip_thermite"]["onPlayerDamaged"] = &scripts\mp\equipment\thermite::thermite_onplayerdamaged;
  var0.callbacks["equip_molotov"]["onPlayerDamaged"] = &scripts\mp\equipment\molotov::molotov_on_player_damaged;
  var0.callbacks["equip_numbers_grenade"]["onPlayerDamaged"] = &scripts\mp\equipment\numbers_grenade::on_player_damaged;
  var0.callbacks["equip_at_mine"]["onOwnerChanged"] = &scripts\mp\equipment\at_mine::at_mine_onownerchanged;
  var0.callbacks["equip_claymore"]["onOwnerChanged"] = &scripts\mp\equipment\claymore::claymore_onownerchanged;
  var0.callbacks["equip_c4"]["onOwnerChanged"] = &scripts\mp\equipment\c4::c4_onownerchanged;
  var0.callbacks["equip_jammer"]["onOwnerChanged"] = &_donewithcorpse::vehicle_compass_updateallvisibilityforplayer;
  var0.callbacks["equip_at_mine"]["onDestroyedByTrophy"] = &scripts\mp\equipment\at_mine::at_mine_delete;
  var0.callbacks["equip_claymore"]["onDestroyedByTrophy"] = &scripts\mp\equipment\claymore::claymore_delete;
  var0.callbacks["equip_trophy"]["onDestroyedByTrophy"] = &scripts\mp\equipment\trophy_system::trophy_delete;
  var0.callbacks["equip_c4"]["onDestroyedByTrophy"] = &scripts\mp\equipment\c4::c4_delete;
  var0.callbacks["equip_snapshot_grenade"]["onDestroyedByTrophy"] = &scripts\mp\equipment\snapshot_grenade::snapshot_grenade_delete;
  thread watchlethaldelay();
  scripts\mp\utility\disconnect_event_aggregator::registerondisconnecteventcallback(&onownerdisconnect);
}

function getcallback(var0, var1) {
  if(!isDefined(level.equipment.callbacks[var0])) {
    return undefined;
  }

  return level.equipment.callbacks[var0][var1];
}

function loadtable() {
  level.equipment.table = [];

  for(var0 = 1;; var0++) {
    var1 = tablelookupbyrow("mp/equipment.csv", var0, 1);

    if(!isDefined(var1) || var1 == "") {
      break;
    }

    var2 = tolower(var1);
    var3 = spawnStruct();
    var3.ref = var2;
    var4 = tablelookupbyrow("mp/equipment.csv", var0, 6);

    if(var4 != "none") {
      var5 = tablelookupbyrow("mp/equipment.csv", var0, 19);
      var6 = undefined;

      if(var5 != "") {
        var7 = getcompleteweaponname(var4);

        if(!nullweapon(var7)) {
          var6 = [var5];
        }
      }

      var3.objweapon = getcompleteweaponname(var4, var6);
    }

    var3.id = var0;
    var3.image = tablelookupbyrow("mp/equipment.csv", var0, 4);
    var3.defaultslot = scripts\engine\utility::ter_op(tablelookupbyrow("mp/equipment.csv", var0, 7) == "2", "secondary", "primary");
    var3.scavengerammo = int(tablelookupbyrow("mp/equipment.csv", var0, 10));
    var3.ispassive = tolower(tablelookupbyrow("mp/equipment.csv", var0, 11)) == "true";
    var3.usecellspawns = tablelookupbyrow("mp/equipment.csv", var0, 8) != "-1";
    var8 = tablelookupbyrow("mp/equipment.csv", var0, 12);

    if(var8 == "none") {} else if(var8 == "") {
      if(var4 != "none") {
        var3.damageweaponnames = [var4];
      }
    } else {
      var9 = [];

      if(var4 != "none") {
        GscBinSkip0(0x2e, var9.size, var4);
      }

      var10 = strtok(var8, " ");

      foreach(var12 in var10) {
        var9 = var12;
      }

      var3.damageweaponnames = var9;
    }

    level.equipment.table[var2] = var3;
  }
}

function getequipmenttableinfo(var0) {
  return level.equipment.table[var0];
}

function giveequipment(var0, var1) {
  if(!isDefined(self.equipment)) {
    self.equipment = [];
  }

  if(var0 == "none") {
    return;
  }

  var2 = getequipmenttableinfo(var0);

  if(!isDefined(var2)) {
    scripts\mp\utility\script::laststand_dogtags("Attempting to give unknown equipment - " + var0 + " - in slot - " + var1);
    return;
  }

  if(var1 == "super") {
    var3 = level.br_pickups.br_superreference[level.br_pickups.br_equipnametoscriptable[var0]];
    var2.id = scripts\mp\supers::getsuperid(var3);
  }

  takeequipment(var1);

  if(isDefined(var2.objweapon)) {
    self giveweapon(var2.objweapon);

    if(is_equipment_slot_allowed(var1) && !var2.ispassive) {
      if(var1 == "primary") {
        self assignweaponoffhandprimary(var2.objweapon);
      } else if(var1 == "secondary") {
        self assignweaponoffhandsecondary(var2.objweapon);
      } else if(var1 == "super") {
        self assignweaponoffhandspecial(var2.objweapon);
      }
    }
  }

  sethudslot(var1, var2.id);
  self.equipment[var1] = var0;
  var4 = getcallback(var0, "onGive");

  if(isDefined(var4)) {
    self thread[[var4]](var0, var1);
  }

  updateuiammocount(var1);
  var5 = var0 == "equip_throwing_knife" || var0 == "equip_throwing_knife_fire" || var0 == "equip_throwing_knife_electric" || var0 == "equip_throwing_knife_drill";

  if(scripts\mp\utility\game::getgametype() == "arena" && var5) {
    return;
  }

  thread watchlethaldelayplayer(var0, var1);
}

function takeequipment(var0) {
  var1 = getcurrentequipment(var0);

  if(!isDefined(var1)) {
    return;
  }

  var2 = getequipmenttableinfo(var1);

  if(isDefined(var2.objweapon)) {
    if(self hasweapon(var2.objweapon)) {
      scripts\cp_mp\utility\inventory_utility::_takeweapon(var2.objweapon);

      if(var0 == "primary") {
        self clearoffhandprimary();
      } else if(var0 == "secondary") {
        self clearoffhandsecondary();
      }
    }
  }

  sethudslot(var0, 0);
  self.equipment[var0] = undefined;
  var3 = getcallback(var1, "onTake");

  if(isDefined(var3)) {
    self thread[[var3]](var1, var0);
  }

  updateuiammocount(var0);
  self notify("equipment_taken_" + var1);
}

function equiponplayerdamaged(var0) {
  var1 = var0.objweapon.basename;

  foreach(var3 in level.equipment.table) {
    var4 = getcallback(var10, "onPlayerDamaged");

    if(isDefined(var4) && isDefined(var3.damageweaponnames)) {
      foreach(var6 in var3.damageweaponnames) {
        if(var6 == var1) {
          var7 = gettime();
          var8 = [[var4]](var0);
          return var8;
        }
      }

      var8 = undefined;
    }
  }

  var4 = undefined;
}

function ondestroyedbytrophy() {
  if(isDefined(self.equipmentref)) {
    var0 = getcallback(self.equipmentref, "onDestroyedByTrophy");

    if(isDefined(var0)) {
      self thread[[var0]]();
      return true;
    } else if(scripts\mp\weapons::isplantedequipment(self)) {
      thread scripts\mp\weapons::deleteexplosive();
      return true;
    }
  }

  return false;
}

function disableslotinternal(var0) {
  if(var0 == "primary") {
    self clearoffhandprimary();
    return;
  }

  if(var0 == "secondary") {
    self clearoffhandsecondary();
    return;
  }

  if(var0 == "super") {
    self clearoffhandspecial();
    return;
  }
}

function enableslotinternal(var0) {
  var1 = getcurrentequipment(var0);

  if(!isDefined(var1)) {
    return;
  }

  var2 = getequipmenttableinfo(var1);

  if(isDefined(var2.objweapon) && !var2.ispassive && self hasweapon(var2.objweapon)) {
    if(var0 == "primary") {
      self assignweaponoffhandprimary(var2.objweapon);
      return;
    }

    if(var0 == "secondary") {
      self assignweaponoffhandsecondary(var2.objweapon);
      return;
    }

    if(var0 == "super") {
      self assignweaponoffhandspecial(var2.objweapon);
      return;
    }

    return;
  }
}

function allow_equipment(var0, var1) {
  allow_equipment_slot("primary", var0, var1);
  allow_equipment_slot("secondary", var0, var1);
}

function allow_equipment_slot(var0, var1, var2) {
  var3 = scripts\common\input_allow::allow_input_internal("equipment_" + var0, var1, var2);

  if(!isDefined(var3)) {
    return;
  }

  if(var1) {
    enableslotinternal(var0);
    return;
  }

  disableslotinternal(var0);
}

function is_equipment_slot_allowed(var0) {
  return scripts\common\input_allow::is_input_allowed_internal("equipment_" + var0);
}

function sethudslot(var0, var1) {
  if(var0 != "super") {
    self setclientomnvar("ui_equipment_id_" + var0, var1);
    return;
  }

  self setclientomnvar("ui_perk_package_super1", var1);
}

function getcurrentequipment(var0) {
  if(!isDefined(self.equipment)) {
    return undefined;
  }

  return self.equipment[var0];
}

function clearallequipment() {
  if(!isDefined(self.equipment)) {
    return;
  }

  foreach(var1 in self.equipment) {
    takeequipment(var2);
  }
}

function getequipmentmaxammo(var0) {
  var1 = getequipmenttableinfo(var0);

  if(!isDefined(var1)) {
    return undefined;
  }

  if(!isDefined(var1.objweapon)) {
    return 0;
  }

  jumpiffalse(level.gametype != "br") LOC_000000aa;
  var2 = scripts\mp\utility\perk::_hasperk("specialty_extraoffhandammo");
  var3 = weaponmaxammo(var1.objweapon, var2);

  switch (var0) {
    case "equip_hb_sensor":
    case "equip_binoculars":
    case "equip_tac_cover":
      break;
    default:
      var3--;
      break;
  }

  var4 = findequipmentslot(var0);

  if(isDefined(var4) && scripts\mp\utility\perk::_hasperk("specialty_extra_deadly") && var4 == "primary") {
    var3++;
  }

  goto LOC_00000112;
}

function getequipmentstartammo(var0) {
  var1 = getequipmenttableinfo(var0);

  if(!isDefined(var1)) {
    return undefined;
  }

  if(!isDefined(var1.objweapon)) {
    return 0;
  }

  var2 = scripts\mp\utility\perk::_hasperk("specialty_extraoffhandammo");
  return weaponstartammo(var1.objweapon, var2);
}

function getequipmentammo(var0) {
  var1 = getequipmenttableinfo(var0);

  if(!isDefined(var1)) {
    return undefined;
  }

  if(!isDefined(var1.objweapon)) {
    return 0;
  }

  return self getammocount(var1.objweapon);
}

function setequipmentammo(var0, var1) {
  var2 = getequipmenttableinfo(var0);

  if(!isDefined(var2.objweapon)) {
    return;
  }

  self setweaponammoclip(var2.objweapon, var1);
  updateuiammocount(findequipmentslot(var0));
}

function incrementequipmentammo(var0, var1) {
  if(!isDefined(var1)) {
    var1 = 1;
  }

  var2 = getequipmentammo(var0);
  var3 = int(min(var2 + var1, getequipmentmaxammo(var0)));
  setequipmentammo(var0, var3);
}

function decrementequipmentammo(var0, var1) {
  if(!isDefined(var1)) {
    var1 = 1;
  }

  var2 = getequipmentammo(var0);
  var1 = int(min(var1, var2));

  if(var1 > 0) {
    var3 = int(min(var2 - var1, getequipmentmaxammo(var0)));
    setequipmentammo(var0, var3);
    return;
  }
}

function incrementequipmentslotammo(var0, var1) {
  var2 = getcurrentequipment(var0);

  if(!isDefined(var2)) {
    return undefined;
  }

  if(!isDefined(var1)) {
    var1 = 1;
  }

  var3 = getequipmentammo(var2);
  var4 = int(min(var3 + var1, getequipmentmaxammo(var2)));
  setequipmentammo(var2, var4);
}

function decrementequipmentslotammo(var0, var1) {
  var2 = getcurrentequipment(var0);

  if(!isDefined(var2)) {
    return undefined;
  }

  if(!isDefined(var1)) {
    var1 = 1;
  }

  var3 = getequipmentammo(var2);
  var4 = int(min(var3 - var1, getequipmentmaxammo(var2)));
  setequipmentammo(var2, var4);
}

function getequipmentslotammo(var0) {
  var1 = getcurrentequipment(var0);

  if(!isDefined(var1)) {
    return undefined;
  }

  return getequipmentammo(var1);
}

function setequipmentslotammo(var0, var1) {
  var2 = getcurrentequipment(var0);

  if(!isDefined(var2)) {
    return undefined;
  }

  return setequipmentammo(var2, var1);
}

function mapequipmentweaponforref(var0) {
  switch (var0.basename) {
    case "claymore_radial_mp":
      return getcompleteweaponname("claymore_mp");
    case "at_mine_ap_mp":
      return getcompleteweaponname("at_mine_mp");
    case "thermite_av_mp":
    case "thermite_ap_mp":
      return getcompleteweaponname("thermite_mp");
  }

  return var0;
}

function getequipmentreffromweapon(var0) {
  var0 = mapequipmentweaponforref(var0);

  foreach(var2 in level.equipment.table) {
    if(isDefined(var2.objweapon) && var0 == var2.objweapon) {
      return var2.ref;
    }
  }

  return undefined;
}

function getweaponfromequipmentref(var0) {
  foreach(var2 in level.equipment.table) {
    if(isDefined(var2.ref) && var0 == var2.ref) {
      return var2.objweapon;
    }
  }

  return undefined;
}

function hasequipment(var0) {
  if(!isDefined(self.equipment)) {
    return false;
  }

  foreach(var2 in self.equipment) {
    if(var2 == var0) {
      return true;
    }
  }

  return false;
}

function findequipmentslot(var0) {
  if(!isDefined(self.equipment)) {
    return undefined;
  }

  foreach(var2 in self.equipment) {
    if(var2 == var0) {
      return var3;
    }
  }
}

function isequipmentlethal(var0) {
  return isequipmentprimary(var0);
}

function isequipmentprimary(var0) {
  if(isDefined(level.equipment.table[var0])) {
    return (level.equipment.table[var0].defaultslot == "primary");
  }

  return 0;
}

function isequipmenttactical(var0) {
  return isequipmentsecondary(var0);
}

function isequipmentsecondary(var0) {
  if(isDefined(level.equipment.table[var0])) {
    return (level.equipment.table[var0].defaultslot == "secondary");
  }

  return 0;
}

function unset_force_aitype_suicidebomber(var0) {
  if(isDefined(level.equipment.table[var0])) {
    return istrue(level.equipment.table[var0].usecellspawns);
  }

  return 0;
}

function updateuiammocount(var0) {
  if(!isDefined(self.equipment)) {
    return;
  }

  var1 = 0;
  var2 = getcurrentequipment(var0);

  if(isDefined(var2)) {
    var1 = getequipmentslotammo(var0);
  }

  if(var0 == "primary") {
    self setclientomnvar("ui_power_num_charges", var1);
    self trajectoryupdateoriginandangles("primary", var1);
    return;
  }

  if(var0 == "secondary") {
    self setclientomnvar("ui_power_secondary_num_charges", var1);
    self trajectoryupdateoriginandangles("secondary", var1);
    return;
  }

  if(var0 == "health") {
    self setclientomnvar("ui_equipment_id_health_numCharges", var1);

    if(scripts\mp\utility\game::unset_relic_grounded()) {
      scripts\mp\gametypes\br_public::updatebrextradata("armorPlateCount", var1);
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

function executeoffhandfired(var0) {
  foreach(var2 in self.equipment) {
    var3 = getequipmenttableinfo(var2);

    if(isDefined(var3.objweapon) && var0 == var3.objweapon) {
      if(scripts\mp\utility\game::getgametype() == "br") {
        scripts\mp\gametypes\br_analytics::branalytics_equipmentuse(self, var0);
      }

      var4 = getequipmentreffromweapon(var0);
      scripts\mp\damage::hide_name_fx_from_players(var4);
      var5 = getcallback(var2, "onFired");

      if(isDefined(var5)) {
        self thread[[var5]](var2, var6, var0);
      }

      updateuiammocount(var6);
      break;
    }
  }
}

function watchoffhandfired() {
  level endon("game_ended");
  self endon("death_or_disconnect");

  for(;;) {
    self waittill("offhand_fired", var0);
    executeoffhandfired(var0);
  }
}

function givescavengerammo() {
  foreach(var1 in self.equipment) {
    var2 = getequipmenttableinfo(var1);

    if(var2.scavengerammo > 0) {
      incrementequipmentammo(var1, var2.scavengerammo);
    }
  }
}

function getdefaultslot(var0) {
  var1 = getequipmenttableinfo(var0);

  if(!isDefined(var1)) {
    return undefined;
  }

  return var1.defaultslot;
}

function watchlethaldelay() {
  level endon("lethal_delay_end");
  level endon("round_end");
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("prematch_done");
  var0 = initstandardloadout();

  if(var0) {
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
    var1 = undefined;

    if(var0) {
      var1 = gettime();
    } else {
      var1 = scripts\mp\utility\game::gettimepassed();
    }

    if(var1 >= level.lethaldelayendtime) {
      break;
    }

    waitframe();
  }

  level notify("lethal_delay_end");
}

function watchlethaldelayplayer(var0, var1) {
  self endon("death_or_disconnect");
  level endon("round_end");
  level endon("game_ended");

  if(lethaldelaypassed()) {
    return;
  }

  self notify("watchLethalDelayPlayer_" + var1);
  self endon("watchLethalDelayPlayer_" + var1);
  self endon("equipment_taken_" + var0);

  if(!isDefined(self.weapon_xp_iw8_sh_charlie725) || !istrue(self.weapon_xp_iw8_sh_charlie725[var1])) {
    if(!isDefined(self.weapon_xp_iw8_sh_charlie725)) {
      self.weapon_xp_iw8_sh_charlie725 = [];
    }

    self.weapon_xp_iw8_sh_charlie725[var1] = 1;
    allow_equipment_slot(var1, 0);
  }

  watchlethaldelayfeedbackplayer(self, var1);

  if(isDefined(self.weapon_xp_iw8_sh_charlie725) && istrue(self.weapon_xp_iw8_sh_charlie725[var1])) {
    self.weapon_xp_iw8_sh_charlie725[var1] = undefined;

    if(self.weapon_xp_iw8_sh_charlie725.size == 0) {
      self.weapon_xp_iw8_sh_charlie725 = undefined;
    }

    allow_equipment_slot(var1, 1);
    return;
  }
}

function watchlethaldelayfeedbackplayer(var0, var1) {
  level endon("lethal_delay_end");

  if(!istrue(scripts\mp\flags::gameflag("prematch_done"))) {
    level waittill("lethal_delay_start");
  }

  var2 = "+frag";

  if(var1 != "primary") {
    var2 = "+smoke";
  }

  if(!isai(var0)) {
    var0 notifyonplayercommand("lethal_attempt_" + var1, var2);
  }

  var3 = initstandardloadout();

  for(;;) {
    self waittill("lethal_attempt_" + var1);
    var4 = undefined;

    if(var3) {
      var4 = gettime();
    } else {
      var4 = scripts\mp\utility\game::gettimepassed();
    }

    var5 = (level.lethaldelayendtime - var4) / 1000;
    var5 = int(max(0, ceil(var5)));
    var0 scripts\mp\hud_message::showerrormessage("MP/LETHALS_UNAVAILABLE_FOR_N", var5);
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
    var0 = undefined;

    if(initstandardloadout()) {
      var0 = gettime();
    } else {
      var0 = scripts\mp\utility\game::gettimepassed();
    }

    return (var0 > level.lethaldelayendtime);
  }

  return false;
}

function initstandardloadout() {
  var0 = scripts\mp\utility\game::getgametype();

  if(var0 == "hq" || var0 == "grnd" || var0 == "koth") {
    return true;
  }

  return false;
}

function onownerdisconnect(var0) {
  var1 = var0 scripts\mp\weapons::getallequip();

  foreach(var3 in var1) {
    var3 notify("owner_disconnect");
  }
}

function hackequipment(var0) {
  self.ishacked = 1;
  var0 scripts\mp\gamelogic::sethasdonecombat(var0, 1);
  var0 scripts\cp\vehicles\vehicle_compass_cp::ref_1203d(self.equipmentref);
  changeowner(var0);

  if(level.teambased) {
    self filteroutplayermarks(var0.team);
  } else {
    self filteroutplayermarks(var0);
  }

  var0 scripts\mp\killstreaks\killstreaks::givescoreforhack();
}

function changeowner(var0) {
  var1 = self.owner;
  self setentityowner(var0);
  self.owner = var0;
  self.team = var0.team;
  self setotherent(var0);
  var1 scripts\mp\weapons::removeequip(self);
  self.owner scripts\mp\weapons::updateplantedarray(self);
  var2 = getcallback(self.equipmentref, "onOwnerChanged");
  self notify("ownerChanged");

  if(isDefined(var2)) {
    self[[var2]](var1);
    return;
  }
}

function scriptablescleanupbatchsize(var0, var1, var2) {
  foreach(var4 in var0) {
    if(istrue(var4.gulag)) {
      continue;
    }

    var4.ref_12fb1 = getcurrentequipment(var4, var1);
    var4.ref_12fb0 = getequipmentslotammo(var1);
    takeequipment(var4, var1);
    giveequipment(var4, var2, var1);
  }
}

function ref_13a30(var0, var1, var2, var3) {
  foreach(var5 in var0) {
    if(istrue(var5.gulag)) {
      continue;
    }

    var6 = getcurrentequipment(var5, var1);

    if(!istrue(var3) && isDefined(var6) && var2 != var6) {
      continue;
    }

    takeequipment(var5, var1);
    var7 = var5.ref_12fb1;
    var8 = var5.ref_12fb0;

    if(isDefined(var7)) {
      giveequipment(var5, var7, var1);
      var5.ref_12fb1 = undefined;

      if(isDefined(var8)) {
        setequipmentammo(var5, var7, var8);
        var5.ref_12fb0 = undefined;
      }
    }
  }
}

function debughackequipment() {
  for(;;) {
    if(getdvarint("scr_debugHackEquipment") != 0) {
      var0 = level.players[0];
      var1 = undefined;

      for(var2 = 1; var2 < level.players.size; var2++) {
        if(var0 scripts\mp\utility\player::isenemy(level.players[var2])) {
          var1 = level.players[var2];
          break;
        }
      }

      if(!isDefined(var1)) {
        iprintlnbold("Need a player on the other team to scr_debugHackEquipment");
        continue;
      }

      var3 = var0 scripts\mp\weapons::getallequip();
      var4 = undefined;

      if(var3.size > 0) {
        var4 = var3[0];
      }

      if(!isDefined(var4)) {
        iprintlnbold("First player must have at least one piece of equipment to scr_debugHackEquipment");
        continue;
      }

      hackequipment(var4, var1);
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

      var0 = level.players[1];
      var0 scripts\mp\utility\weapon::_launchgrenade("emp_grenade_mp", (0, 0, 0), (0, 0, 0), 0.05, 0);
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

      var0 = level.players[0];
      var1 = level.players[1];
      var2 = spawnStruct();
      var2.streakname = "emp_drone";
      var2.owner = var1;
      var2.id = scripts\cp_mp\utility\killstreak_utility::getuniquekillstreakid(var1);
      var2.lifeid = 0;
      var3 = var0.origin;
      var4 = var1 scripts\cp_mp\killstreaks\emp_drone_targeted::empdrone_createdrone(var2, var3);
    }

    waitframe();
  }
}

function debugdestroyempdrones() {
  for(;;) {
    if(getdvarint("scr_testEMPDroneDestroy") != 0) {
      foreach(var1 in level.activekillstreaks) {
        if(isDefined(var1.streakinfo) && var1.streakinfo.streakname == "emp_drone") {
          var1 scripts\cp_mp\killstreaks\emp_drone::empdrone_destroy();
        }
      }
    }

    waitframe();
  }
}

function timeoflastexecute() {
  level.weapon_xp_iw8_pi_papa320 = [];
  var0 = 0;

  foreach(var2 in level.equipment.table) {
    if(!var2.usecellspawns) {
      continue;
    }

    if(var2.id <= 0) {
      continue;
    }

    if(var2.defaultslot == "secondary") {
      continue;
    }

    level.weapon_xp_iw8_pi_papa320[var2.ref] = 1 << var0;
    var0++;
  }
}