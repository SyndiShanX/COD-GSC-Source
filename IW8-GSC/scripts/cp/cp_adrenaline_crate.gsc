/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_adrenaline_crate.gsc
***********************************************/

function adrenaline_crate_init() {
  var_0 = spawnStruct();
  var_0.id = "adrenaline";
  var_0.weaponinfo = "iw8_adrenaline_marker_cp";
  var_0.modelbase = "offhand_wm_supportbox";
  var_0.hintstring = &"COOP_CRAFTING/ADRENALINE_TAKE";
  var_0.streakname = "adrenaline";
  var_0.splashname = "used_support_box";
  var_0.shadername = "compass_objpoint_deploy_friendly";
  var_0.headicon = "cp_crate_icon_instarevive";
  var_0.headiconoffset = 20;
  var_0.lifespan = 90;
  var_0.usexp = 50;
  var_0.onusesfx = "ammo_crate_use";
  var_0.deployedsfx = "ammo_crate_use";
  var_0.deathvfx = loadfx("vfx/iw7/core/mp/killstreaks/vfx_dp_pickup_dust.vfx");
  var_0.onusecallback = &adrenalinebox_onusedeployable;
  var_0.canusecallback = &adrenalinebox_canusedeployable;
  var_0.deployfunc = &adrenalinebox_onusedeployable;
  var_0.usetime = 1000;
  var_0.maxhealth = 100;
  var_0.maxuses = 4;
  var_0.canreusebox = 0;
  var_0.allowmeleedamage = 1;
  var_0.damagefeedback = "";
  var_0.grenadeusefunc = &supportbox_grenadelaunchfunc;
  var_0.ondeploycallback = &scripts\cp\cp_deployablebox::supportbox_ondeploy;
  var_0.deployanimduration = scripts\cp\cp_deployablebox::supportbox_getdeployanimduration();
  level.boxsettings["adrenaline"] = var_0;
  level.deployable_box["adrenaline"] = [];
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

function adrenalinebox_canusedeployable(var_0) {
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

function adrenalinebox_onusedeployable(var_0) {
  self endon("disconnect");
  thread give_auto_revive();
  self setclientomnvar("ui_self_revive", 1);
}

function give_adrenaline_for_time(var_0) {
  var_1 = self.perk_data["regen_time_scalar"];
  self.perk_data["regen_time_scalar"] = 5;
  scripts\cp\utility::giveperk("specialty_quickdraw");
  scripts\cp\utility::giveperk("specialty_quickswap");
  scripts\cp\utility::giveperk("specialty_lightweight");
  scripts\cp\utility::giveperk("specialty_fastreload");
  scripts\cp\utility::giveperk("specialty_stalker");
  scripts\cp\utility::giveperk("specialty_fastoffhand");
  scripts\cp\utility::giveperk("specialty_fastsprintrecovery");
  scripts\cp\cp_visionsets::add_visionset_to_stack(self, "alien_feral", 2);
  self lerpfovbypreset("80_instant");
  wait var_0;
  self.perk_data["regen_time_scalar"] = var_1;
  scripts\cp\utility::_unsetperk("specialty_quickswap");
  scripts\cp\utility::_unsetperk("specialty_quickdraw");
  scripts\cp\utility::_unsetperk("specialty_lightweight");
  scripts\cp\utility::_unsetperk("specialty_fastreload");
  scripts\cp\utility::_unsetperk("specialty_stalker");
  scripts\cp\utility::_unsetperk("specialty_fastoffhand");
  scripts\cp\utility::_unsetperk("specialty_fastsprintrecovery");
  self lerpfovbypreset("default_2seconds");
  scripts\cp\cp_visionsets::remove_visionset_specific_from_stack(self, "alien_feral", 2);
}

function give_auto_revive() {
  self endon("disconnect");
  self.has_auto_revive = 1;
  self waittill("last_stand");
  wait 0.1;

  if(scripts\cp\cp_laststand::player_in_laststand(self)) {
    scripts\cp\cp_laststand::instant_revive(self);

    if(isDefined(self.dogtag)) {
      self.dogtag delete();
    }
  }

  self.has_auto_revive = 0;
}

function supportbox_watchplayerweapon(var_0) {
  self endon("disconnect");
  self endon("deployable_deployed");
  self notifyonplayercommand("cancel_deploy", "+actionslot 3");
  self notifyonplayercommand("cancel_deploy", "+actionslot 4");
  self notifyonplayercommand("cancel_deploy", "+actionslot 5");
  self notifyonplayercommand("cancel_deploy", "+actionslot 6");
  var_1 = scripts\engine\utility::ref_143AE("grenade_fire", "cancel_deploy", "weapon_switch_started");

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