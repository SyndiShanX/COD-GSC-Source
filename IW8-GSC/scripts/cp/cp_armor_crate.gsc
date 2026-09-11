/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_armor_crate.gsc
***********************************************/

function armor_crate_init() {
  var_0 = spawnStruct();
  var_0.id = "armor";
  var_0.weaponinfo = "iw8_armor_marker_cp";
  var_0.modelbase = "offhand_wm_supportbox_armor";
  var_0.hintstring = &"COOP_CRAFTING/ARMOR_TAKE";
  var_0.streakname = "armor";
  var_0.splashname = "used_support_box";
  var_0.shadername = "compass_objpoint_deploy_friendly";
  var_0.headicon = "cp_crate_icon_armor";
  var_0.headiconoffset = 20;
  var_0.lifespan = 90;
  var_0.usexp = 50;
  var_0.onusesfx = "ammo_crate_use";
  var_0.deployedsfx = "ammo_crate_use";
  var_0.deathvfx = loadfx("vfx/iw8/prop/scriptables/vfx_offhand_wm_supportbox_armor_timeout.vfx");
  var_0.onusecallback = &armorbox_onusedeployable;
  var_0.canusecallback = &armorbox_canusedeployable;
  var_0.deployfunc = &armorbox_onusedeployable;
  var_0.ref_120aa = "ping_response_thanks";
  var_0.usetime = 1000;
  var_0.maxhealth = 100;
  var_0.maxuses = 4;
  var_0.canreusebox = 0;
  var_0.allowmeleedamage = 1;
  var_0.damagefeedback = "";
  var_0.grenadeusefunc = &supportbox_grenadelaunchfunc;
  var_0.ondeploycallback = &scripts\cp\cp_deployablebox::supportbox_ondeploy;
  var_0.deployanimduration = scripts\cp\cp_deployablebox::supportbox_getdeployanimduration();
  level.boxsettings["armor"] = var_0;
  level.deployable_box["armor"] = [];
}

function weaponswitchendedsupportbox(var_0, var_1) {
  if(istrue(var_1)) {
    thread supportbox_watchplayerweapon(var_0);
    return;
  }
}

function tryusesupportbox(var_0, var_1) {
  return true;
}

function armorbox_canusedeployable(var_0) {
  return true;
}

function supportbox_grenadelaunchfunc(var_0) {
  var_1 = self gettagorigin("tag_accessory_left");
  var_2 = 400;
  var_3 = anglesToForward(self.angles);
  var_4 = anglestoup(self.angles);
  var_4 *= 0.6;
  var_5 = vectorNormalize(var_3 + var_4);
  var_6 = var_5 * var_2;
  var_7 = magicbullet("iw8_ammocrate_marker_zm", var_1, var_1 + var_6, self);
  self notify("grenade_fire", var_7);
}

function armorbox_onusedeployable(var_0) {
  self endon("disconnect");

  if(scripts\cp\cp_armor::player_have_full_armor(self)) {
    scripts\cp\utility::hint_prompt("max_armor", 1, 3);
    return false;
  }

  scripts\cp\cp_armor::givearmor(self, 100, 1);
  self playlocalsound("weap_ammo_pickup");
  return true;
}

function supportbox_watchplayerweapon(var_0) {
  self endon("disconnect");
  self endon("deployable_deployed");
  self notifyonplayercommand("cancel_deploy", "+actionslot 3");
  self notifyonplayercommand("cancel_deploy", "+actionslot 4");
  self notifyonplayercommand("cancel_deploy", "+actionslot 5");
  self notifyonplayercommand("cancel_deploy", "+actionslot 6");
  var_1 = scripts\engine\utility::ref_143ae("grenade_fire", "cancel_deploy", "weapon_switch_started");

  if(!isDefined(var_1)) {
    return;
  }

  jumpiffalse(var_1 == "cancel_deploy") LOC_0000007d;
  self switchtoweapon(self.lastdroppableweaponobj);

  for(;;) {
    var_2 = self getcurrentweapon();

    if(var_2 != var_0.objweapon) {
      self notify("killstreak_finished_with_weapon_" + var_0.weaponname);
      break;
    }

    waitframe();
  }
}

function supportbox_handledamage() {
  var_0 = level.boxsettings[self.boxtype];
}

function supportbox_handledeathdamage(var_0) {
  var_1 = var_0.attacker;
  var_2 = var_0.objweapon;
  var_3 = var_0.meansofdeath;
  var_4 = var_0.damage;
  var_5 = level.boxsettings[self.boxtype];
  var_1 notify("destroyed_equipment");
}

function supportbox_modifydamage(var_0) {
  var_1 = var_0.attacker;
  var_2 = var_0.objweapon;
  var_3 = var_0.meansofdeath;
  var_4 = var_0.damage;
  var_5 = var_0.idflags;
  var_6 = var_4;
  var_7 = level.boxsettings[self.boxtype];
  return var_6;
}

function supportbox_waittill_removeorweaponchange(var_0, var_1) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  var_2 = spawnStruct();
  thread supportbox_waittill_notify(var_0, var_2);
  thread supportbox_waittill_notify(var_1, var_2);
  var_2 waittill("returned", var_3, var_4);
  var_2 notify("die");
  var_5 = spawnStruct();
  var_5.msg = var_3;
  var_5.param = var_4;
  return var_5;
}

function supportbox_waittill_notify(var_0, var_1) {
  self endon("death");
  self endon("disconnect");
  var_1 endon("die");
  self waittill(var_0, var_2);
  var_1 notify("returned", var_0, var_2);
}

function cangive_ammo() {
  var_0 = scripts\cp\utility::getvalidtakeweapon();
  var_1 = self getweaponammoclip(var_0);
  var_2 = weaponclipsize(var_0);
  var_3 = weaponmaxammo(var_0);
  var_4 = self getweaponammostock(var_0);

  if(var_4 < var_3 || var_1 < var_2) {
    return 1;
  }

  return 0;
}

function give_ammo_to_player_through_crate() {
  var_0 = self getweaponslistprimaries();

  foreach(var_2 in var_0) {
    if(!scripts\cp\utility::is_valid_player()) {
      continue;
    }

    if(weapontype(var_2) == "riotshield") {
      continue;
    }

    if(scripts\cp\cp_weapon::is_incompatible_weapon(var_2)) {
      continue;
    }

    var_3 = weaponclipsize(var_2);
    self givemaxammo(var_2);
  }

  self playlocalsound("weap_ammo_pickup");
}

function adjust_clip_ammo_from_stock(var_0, var_1, var_2, var_3, var_4) {
  if(!istrue(var_4)) {
    var_5 = weaponmaxammo(var_1);
    var_6 = var_0 getweaponammostock(var_1);
    var_7 = var_5 - var_6;
    var_8 = scripts\engine\utility::ter_op(var_7 >= var_3, var_6 + var_3, var_5);
    var_0 setweaponammostock(var_1, var_8);
  }

  var_9 = var_0 getweaponammoclip(var_1, var_2);
  var_10 = var_3 - var_9;
  var_11 = min(var_9 + var_10, var_3);
  var_0 setweaponammoclip(var_1, int(var_11), var_2);
}

function test_ammo_crate(var_0) {
  thread watch_dpad();
  var_0 notify("new_power", "crafted_autosentry");
  scripts\cp\utility::set_crafted_inventory_item("crafted_autosentry", &give_crafted_ammo_crate, var_0);
}

function give_crafted_ammo_crate(var_0, var_1) {
  thread watch_dpad();
  var_1 notify("new_power", "crafted_autosentry");
  scripts\cp\utility::set_crafted_inventory_item("crafted_autosentry", &give_crafted_ammo_crate, var_1);
}

function watch_dpad() {
  self endon("disconnect");
  self endon("death");
  self endon("remove_sentry");
  self notify("craft_dpad_watcher");
  self endon("craft_dpad_watcher");
  self notifyonplayercommand("pullout_sentry", "+actionslot 4");

  for(;;) {
    self waittill("pullout_sentry");

    if(istrue(self.iscarrying)) {
      continue;
    }

    if(istrue(self.linked_to_coaster)) {
      continue;
    }

    if(isDefined(self.allow_carry) && self.allow_carry == 0) {
      continue;
    }

    if(scripts\cp\utility::is_valid_player()) {
      break;
    }
  }
}