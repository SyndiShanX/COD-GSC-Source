/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\cp\cp_grenade_crate.gsc
***********************************************/

#using scripts\common\utility;
#using scripts\cp\cp_deployablebox;
#using scripts\cp\equipment;
#using scripts\cp\utility;
#using scripts\cp_mp\equipment;
#using scripts\engine\utility;
#namespace cp_grenade_crate;

function grenade_crate_init() {
  boxconfig = spawnStruct();
  boxconfig.id = "grenade_crate";
  boxconfig.weaponinfo = "iw8_health_marker_cp";
  boxconfig.modelbase = "offhand_wm_supportbox_explosives";
  boxconfig.hintstring = &"COOP_CRAFTING/GRENADE_TAKE";
  boxconfig.streakname = "grenade_crate";
  boxconfig.splashname = "used_support_box";
  boxconfig.shadername = "compass_objpoint_deploy_friendly";
  boxconfig.headicon = "cp_crate_icon_lethalrefill";
  boxconfig.headiconoffset = 20;
  boxconfig.lifespan = 90;
  boxconfig.usexp = 50;
  boxconfig.onusesfx = "ammo_crate_use";
  boxconfig.deployedsfx = "ammo_crate_use";
  boxconfig.deathvfx = loadfx("vfx/iw8/prop/scriptables/vfx_offhand_wm_supportbox_explosives_timeout.vfx");
  boxconfig.onusecallback = &healthbox_onusedeployable;
  boxconfig.canusecallback = &healthbox_canusedeployable;
  boxconfig.deployfunc = &healthbox_onusedeployable;
  boxconfig.onusethanksbc = #"ping_social_thanks";
  boxconfig.usetime = 1000;
  boxconfig.maxhealth = 100;
  boxconfig.maxuses = 4;
  boxconfig.canreusebox = 0;
  boxconfig.allowmeleedamage = 1;
  boxconfig.damagefeedback = "";
  boxconfig.grenadeusefunc = &healthbox_grenadelaunchfunc;
  boxconfig.ondeploycallback = &supportbox_ondeploy;
  boxconfig.deployanimduration = supportbox_getdeployanimduration();
  level.boxsettings["grenade_crate"] = boxconfig;
  level.deployable_box["grenade_crate"] = [];
}

function weaponswitchendedsupportbox(streakinfo, switchresult) {
  if(istrue(switchresult)) {
    thread supportbox_watchplayerweapon(streakinfo);
  }
}

function tryusesupportbox(streakinfo, grenade) {
  return true;
}

function healthbox_canusedeployable(boxent) {
  return true;
}

function healthbox_grenadelaunchfunc(boxent) {
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

function healthbox_onusedeployable(showhint) {
  self endon("disconnect");
  grenade_full = 1;
  projectile_full = 1;
  primary_weapons = self getweaponslistprimaries();

  foreach(weapon in primary_weapons) {
    if(weapontype(weapon) == "projectile") {
      if(weapon.basename == "iw8_la_mike32_mp") {
        if(self.gl_proj_override == "thermite") {
          continue;
        }
      }

      if(!max_projectile_check(weapon)) {
        projectile_full = 0;
        self setweaponammoclip(weapon, weaponclipsize(weapon));
        self givemaxammo(weapon);
      }
    }

    if(weapon.inventorytype == "altmode" && isDefined(weapon.underbarrel) && weapon.underbarrel == "ubshtgn") {
      if(!max_projectile_check(weapon)) {
        projectile_full = 0;
        self setweaponammoclip(weapon, weaponclipsize(weapon));
        self setweaponammostock(weapon, 0);
      }
    }
  }

  if(scripts\cp\equipment::function_a6c819e1c09a2472()) {
    if(!isDefined(showhint) || showhint == 1) {
      thread scripts\cp\utility::hint_prompt("max_grenades", 1, 3);
    }

    return false;
  }

  thread refill_grenades(self);
  return true;
}

function max_projectile_check(weapon) {
  current_clip = self getweaponammoclip(weapon);
  current_stock = self getweaponammostock(weapon);
  max_clip = weaponclipsize(weapon);
  max_stock = weaponmaxammo(weapon);

  if(current_stock < max_stock || current_clip < max_clip) {
    return false;
  }

  return true;
}

function refill_grenades(player) {
  player notify("stop_restock_recharge");
  primaries = player scripts\cp_mp\equipment::getcurrentequipment("primary");
  secondaries = player scripts\cp_mp\equipment::getcurrentequipment("secondary");

  if(isDefined(primaries)) {
    player thread scripts\cp_mp\equipment::setequipmentammo(primaries, 4);
  }

  if(isDefined(secondaries)) {
    player thread scripts\cp_mp\equipment::setequipmentammo(secondaries, 4);
  }

  player playlocalsound("weap_ammo_pickup");
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