/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_adrenaline_crate.gsc
***********************************************/



#using scripts\common\utility;
#using scripts\cp\cp_deployablebox;
#using scripts\cp\cp_visionsets;
#using scripts\cp\laststand;
#using scripts\cp\utility;
#using scripts\engine\utility;
#namespace cp_adrenaline_crate;

function adrenaline_crate_init() {
  boxconfig = spawnStruct();
  boxconfig.id = "adrenaline";
  boxconfig.modelbase = "offhand_wm_supportbox";
  boxconfig.hintstring = &"COOP_CRAFTING/ADRENALINE_TAKE";
  boxconfig.streakname = "adrenaline";
  boxconfig.splashname = "used_support_box";
  boxconfig.shadername = "compass_objpoint_deploy_friendly";
  boxconfig.headiconoffset = 20;
  boxconfig.lifespan = 90;
  boxconfig.usexp = 50;
  boxconfig.onusesfx = "ammo_crate_use";
  boxconfig.deployedsfx = "ammo_crate_use";
  boxconfig.deathvfx = loadfx("vfx/iw7/core/mp/killstreaks/vfx_dp_pickup_dust.vfx");
  boxconfig.onusecallback = &adrenalinebox_onusedeployable;
  boxconfig.canusecallback = &adrenalinebox_canusedeployable;
  boxconfig.deployfunc = &adrenalinebox_onusedeployable;
  boxconfig.usetime = 1000;
  boxconfig.maxhealth = 100;
  boxconfig.maxuses = 4;
  boxconfig.canreusebox = 0;
  boxconfig.allowmeleedamage = 1;
  boxconfig.damagefeedback = "";
  boxconfig.grenadeusefunc = &supportbox_grenadelaunchfunc;
  boxconfig.ondeploycallback = &supportbox_ondeploy;
  boxconfig.deployanimduration = supportbox_getdeployanimduration();
  level.boxsettings["adrenaline"] = boxconfig;
  level.deployable_box["adrenaline"] = [];
}

function weaponswitchendedsupportbox(streakinfo, switchresult) {
  if(istrue(switchresult)) {
    thread supportbox_watchplayerweapon(streakinfo);
  }
}

function tryusesupportbox(streakinfo, grenade) {
  return true;
}

function adrenalinebox_canusedeployable(boxent) {
  return true;
}

function supportbox_grenadelaunchfunc(boxent) {
  start = self gettagorigin("tag_accessory_left");
  speed = 400;
  f = anglesToForward(self.angles);
  u = anglestoup(self.angles);
  u *= 0.6;
  dir = vectorNormalize(f + u);
  velocity = dir * speed;
  throwngrenade = magicbullet("iw8_ammocrate_marker_zm", start, start + velocity, self);
  self notify("grenade_fire", throwngrenade);
}

function adrenalinebox_onusedeployable(boxent) {
  self endon("disconnect");
  thread give_auto_revive();
  self setclientomnvar("ui_self_revive", 1);
}

function give_adrenaline_for_time(timer) {
  var_2099048a1823ba6b = self.perk_data["regen_time_scalar"];
  self.perk_data["regen_time_scalar"] = 5;
  giveperk("specialty_quickdraw");
  giveperk("specialty_quickswap");
  giveperk("specialty_lightweight");
  giveperk("specialty_fastreload");
  giveperk("specialty_stalker");
  giveperk("specialty_fastoffhand");
  giveperk("specialty_fastsprintrecovery");
  scripts\cp\cp_visionsets::add_visionset_to_stack(self, "alien_feral", 2);
  self lerpfovbypreset("80_instant");
  wait timer;
  self.perk_data["regen_time_scalar"] = var_2099048a1823ba6b;
  _unsetperk("specialty_quickswap");
  _unsetperk("specialty_quickdraw");
  _unsetperk("specialty_lightweight");
  _unsetperk("specialty_fastreload");
  _unsetperk("specialty_stalker");
  _unsetperk("specialty_fastoffhand");
  _unsetperk("specialty_fastsprintrecovery");
  self lerpfovbypreset("default_2seconds");
  scripts\cp\cp_visionsets::remove_visionset_specific_from_stack(self, "alien_feral", 2);
}

function give_auto_revive() {
  self endon("disconnect");
  self.has_auto_revive = 1;
  self waittill("last_stand");
  wait 0.1;

  if(scripts\cp\laststand::player_in_laststand(self)) {
    scripts\cp\laststand::instant_revive(self);

    if(isDefined(self.dogtag)) {
      self.dogtag delete();
    }
  }

  self.has_auto_revive = 0;
}

function supportbox_watchplayerweapon(streakinfo) {
  self endon("disconnect");
  self endon("deployable_deployed");
  self notifyonplayercommand("cancel_deploy", "+actionslot 3");
  self notifyonplayercommand("cancel_deploy", "+actionslot 4");
  self notifyonplayercommand("cancel_deploy", "+actionslot 5");
  self notifyonplayercommand("cancel_deploy", "+actionslot 6");
  result = waittill_any_return_3("grenade_fire", "cancel_deploy", "weapon_switch_started");

  if(!isDefined(result)) {
    return;
  }

  if(result == "cancel_deploy") {
    self switchtoweapon(self.lastdroppableweaponobj);
  }

  while(true) {
    currentweapon = self getcurrentweapon();

    if(currentweapon != streakinfo.objweapon) {
      self notify("killstreak_finished_with_weapon_" + streakinfo.weaponname);
      break;
    }

    waitframe();
  }
}

function supportbox_handledamage() {
  boxconfig = level.boxsettings[self.boxtype];
}

function supportbox_handledeathdamage(data) {
  attacker = data.attacker;
  objweapon = data.objweapon;
  type = data.meansofdeath;
  damage = data.damage;
  boxconfig = level.boxsettings[self.boxtype];
  attacker notify("destroyed_equipment");
}

function supportbox_modifydamage(data) {
  attacker = data.attacker;
  objweapon = data.objweapon;
  type = data.meansofdeath;
  damage = data.damage;
  idflags = data.idflags;
  modifieddamage = damage;
  boxconfig = level.boxsettings[self.boxtype];
  return modifieddamage;
}

function supportbox_waittill_removeorweaponchange(removenotify, var_e12eb6c8616be7dc) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  ent = spawnStruct();
  thread supportbox_waittill_notify(removenotify, ent);
  thread supportbox_waittill_notify(var_e12eb6c8616be7dc, ent);
  ent waittill("returned", msg, param);
  ent notify("die");
  info = spawnStruct();
  info.msg = msg;
  info.param = param;
  return info;
}

function supportbox_waittill_notify(msg, ent) {
  self endon("death");
  self endon("disconnect");
  ent endon("die");
  self waittill(msg, param);
  ent notify("returned", msg, param);
}

function give_crafted_ammo_crate(interaction_struct, player) {
  player thread watch_dpad();
  player notify("new_power", "crafted_autosentry");
  set_crafted_inventory_item("crafted_autosentry", &give_crafted_ammo_crate, player);
}

function watch_dpad() {
  self endon("disconnect");
  self endon("death");
  self endon("remove_sentry");
  self notify("craft_dpad_watcher");
  self endon("craft_dpad_watcher");
  self notifyonplayercommand("pullout_sentry", "+actionslot 4");

  while(true) {
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

    if(is_valid_player()) {
      break;
    }
  }
}