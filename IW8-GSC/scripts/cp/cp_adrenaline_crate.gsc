/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_adrenaline_crate.gsc
***********************************************/

function adrenaline_crate_init() {
  var0 = spawnStruct();
  var0.id = "adrenaline";
  var0.weaponinfo = "iw8_adrenaline_marker_cp";
  var0.modelbase = "offhand_wm_supportbox";
  var0.hintstring = &"COOP_CRAFTING/ADRENALINE_TAKE";
  var0.streakname = "adrenaline";
  var0.splashname = "used_support_box";
  var0.shadername = "compass_objpoint_deploy_friendly";
  var0.headicon = "cp_crate_icon_instarevive";
  var0.headiconoffset = 20;
  var0.lifespan = 90;
  var0.usexp = 50;
  var0.onusesfx = "ammo_crate_use";
  var0.deployedsfx = "ammo_crate_use";
  var0.deathvfx = loadfx("vfx/iw7/core/mp/killstreaks/vfx_dp_pickup_dust.vfx");
  var0.onusecallback = &adrenalinebox_onusedeployable;
  var0.canusecallback = &adrenalinebox_canusedeployable;
  var0.deployfunc = &adrenalinebox_onusedeployable;
  var0.usetime = 1000;
  var0.maxhealth = 100;
  var0.maxuses = 4;
  var0.canreusebox = 0;
  var0.allowmeleedamage = 1;
  var0.damagefeedback = "";
  var0.grenadeusefunc = &supportbox_grenadelaunchfunc;
  var0.ondeploycallback = &scripts\cp\cp_deployablebox::supportbox_ondeploy;
  var0.deployanimduration = scripts\cp\cp_deployablebox::supportbox_getdeployanimduration();
  level.boxsettings["adrenaline"] = var0;
  level.deployable_box["adrenaline"] = [];
}

function weaponswitchendedsupportbox(var0, var1) {
  if(istrue(var1)) {
    thread supportbox_watchplayerweapon(var0);
    return;
  }
}

function tryusesupportbox(var0, var1) {
  return true;
}

function adrenalinebox_canusedeployable(var0) {
  return true;
}

function supportbox_grenadelaunchfunc(var0) {
  var1 = self gettagorigin("tag_accessory_left");
  var2 = 400;
  var3 = anglesToForward(self.angles);
  var4 = anglestoup(self.angles);
  var4 *= 0.6;
  var5 = vectorNormalize(var3 + var4);
  var6 = var5 * var2;
  var7 = magicbullet("iw8_ammocrate_marker_zm", var1, var1 + var6, self);
  self notify("grenade_fire", var7);
}

function adrenalinebox_onusedeployable(var0) {
  self endon("disconnect");
  thread give_auto_revive();
  self setclientomnvar("ui_self_revive", 1);
}

function give_adrenaline_for_time(var0) {
  var1 = self.perk_data["regen_time_scalar"];
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
  wait var0;
  self.perk_data["regen_time_scalar"] = var1;
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

function supportbox_watchplayerweapon(var0) {
  self endon("disconnect");
  self endon("deployable_deployed");
  self notifyonplayercommand("cancel_deploy", "+actionslot 3");
  self notifyonplayercommand("cancel_deploy", "+actionslot 4");
  self notifyonplayercommand("cancel_deploy", "+actionslot 5");
  self notifyonplayercommand("cancel_deploy", "+actionslot 6");
  var1 = scripts\engine\utility::ref_143ae("grenade_fire", "cancel_deploy", "weapon_switch_started");

  if(!isDefined(var1)) {
    return;
  }

  jumpiffalse(var1 == "cancel_deploy") LOC_0000007d;
  self switchtoweapon(self.lastdroppableweaponobj);

  for(;;) {
    var2 = self getcurrentweapon();

    if(var2 != var0.objweapon) {
      self notify("killstreak_finished_with_weapon_" + var0.weaponname);
      break;
    }

    waitframe();
  }
}

function supportbox_handledamage() {
  var0 = level.boxsettings[self.boxtype];
}

function supportbox_handledeathdamage(var0) {
  var1 = var0.attacker;
  var2 = var0.objweapon;
  var3 = var0.meansofdeath;
  var4 = var0.damage;
  var5 = level.boxsettings[self.boxtype];
  var1 notify("destroyed_equipment");
}

function supportbox_modifydamage(var0) {
  var1 = var0.attacker;
  var2 = var0.objweapon;
  var3 = var0.meansofdeath;
  var4 = var0.damage;
  var5 = var0.idflags;
  var6 = var4;
  var7 = level.boxsettings[self.boxtype];
  return var6;
}

function supportbox_waittill_removeorweaponchange(var0, var1) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  var2 = spawnStruct();
  thread supportbox_waittill_notify(var0, var2);
  thread supportbox_waittill_notify(var1, var2);
  var2 waittill("returned", var3, var4);
  var2 notify("die");
  var5 = spawnStruct();
  var5.msg = var3;
  var5.param = var4;
  return var5;
}

function supportbox_waittill_notify(var0, var1) {
  self endon("death");
  self endon("disconnect");
  var1 endon("die");
  self waittill(var0, var2);
  var1 notify("returned", var0, var2);
}

function give_crafted_ammo_crate(var0, var1) {
  thread watch_dpad();
  var1 notify("new_power", "crafted_autosentry");
  scripts\cp\utility::set_crafted_inventory_item("crafted_autosentry", &give_crafted_ammo_crate, var1);
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