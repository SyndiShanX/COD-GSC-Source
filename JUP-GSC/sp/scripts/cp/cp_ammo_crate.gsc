/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\cp\cp_ammo_crate.gsc
***********************************************/

#using scripts\common\utility;
#using scripts\cp\cp_deployablebox;
#using scripts\cp\pickups;
#using scripts\cp\utility;
#using scripts\engine\utility;
#namespace cp_ammo_crate;

function ammo_crate_init() {
  var_86280fefb94b6b28 = spawnStruct();
  var_86280fefb94b6b28.id = "ammo_crate";
  var_86280fefb94b6b28.weaponinfo = "iw8_ammo_marker_cp";
  var_86280fefb94b6b28.modelbase = "offhand_wm_supportbox_ammunition";
  var_86280fefb94b6b28.hintstring = &"COOP_CRAFTING/AMMO_CRATE_TAKE";
  var_86280fefb94b6b28.streakname = "ammo_crate";
  var_86280fefb94b6b28.splashname = "used_support_box";
  var_86280fefb94b6b28.shadername = "compass_objpoint_deploy_friendly";
  var_86280fefb94b6b28.headicon = "hud_icon_fieldupgrade_ammo_box";
  var_86280fefb94b6b28.headiconoffset = 20;
  var_86280fefb94b6b28.lifespan = 90;
  var_86280fefb94b6b28.usexp = 50;
  var_86280fefb94b6b28.onusesfx = "ammo_crate_use";
  var_86280fefb94b6b28.deployedsfx = "ammo_crate_use";
  var_86280fefb94b6b28.deathvfx = loadfx("vfx/iw8/prop/scriptables/vfx_offhand_wm_supportbox_ammunition_timeout.vfx");
  var_86280fefb94b6b28.onusecallback = &supportbox_onusedeployable;
  var_86280fefb94b6b28.canusecallback = &supportbox_canusedeployable;
  var_86280fefb94b6b28.deployfunc = &giveammo;
  var_86280fefb94b6b28.onusethanksbc = #"ping_social_thanks";
  var_86280fefb94b6b28.usetime = 1000;
  var_86280fefb94b6b28.maxhealth = 100;
  var_86280fefb94b6b28.maxuses = 4;
  var_86280fefb94b6b28.canreusebox = 0;
  var_86280fefb94b6b28.allowmeleedamage = 1;
  var_86280fefb94b6b28.damagefeedback = "";
  var_86280fefb94b6b28.grenadeusefunc = &supportbox_grenadelaunchfunc;
  var_86280fefb94b6b28.ondeploycallback = &supportbox_ondeploy;
  var_86280fefb94b6b28.deployanimduration = supportbox_getdeployanimduration();
  level.boxsettings["ammo_crate"] = var_86280fefb94b6b28;
  level.deployable_box["ammo_crate"] = [];
}

function weaponswitchendedsupportbox(streakinfo, switchresult) {
  if(istrue(switchresult)) {
    thread supportbox_watchplayerweapon(streakinfo);
  }
}

function tryusesupportbox(streakinfo, grenade) {
  return true;
}

function supportbox_canusedeployable(boxent) {
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

function supportbox_onusedeployable(showhint) {
  self endon("disconnect");

  if(cangive_ammo()) {
    [gaveammo, var_d6a57b95fc473441] = scripts\cp\pickups::giveammo(self);

    if(gaveammo) {
      self playlocalsound("weap_ammo_pickup");
    }

    return true;
  } else {
    if(!isDefined(showhint) || showhint == 1) {
      thread scripts\cp\utility::hint_prompt("max_ammo", 1, 3);
    }

    return false;
  }

  return true;
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
  var_86280fefb94b6b28 = level.boxsettings[self.boxtype];
}

function supportbox_handledeathdamage(data) {
  attacker = data.attacker;
  objweapon = data.objweapon;
  type = data.meansofdeath;
  damage = data.damage;
  var_86280fefb94b6b28 = level.boxsettings[self.boxtype];
  attacker notify("destroyed_equipment");
}

function supportbox_modifydamage(data) {
  attacker = data.attacker;
  objweapon = data.objweapon;
  type = data.meansofdeath;
  damage = data.damage;
  idflags = data.idflags;
  modifieddamage = damage;
  var_86280fefb94b6b28 = level.boxsettings[self.boxtype];
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

function cangive_ammo() {
  currentweapon = getvalidtakeweapon();
  var_e719a0688fe8f78a = istrue(currentweapon.hasalternate);
  var_f0e3b6926c055710 = istrue(currentweapon.isalternate);

  if(var_e719a0688fe8f78a || var_f0e3b6926c055710) {
    if(max_ammo_check(currentweapon)) {
      weapon = get_alt_weapon(currentweapon);

      if(isDefined(weapon)) {
        if(max_ammo_check(weapon)) {
          return false;
        }

        return true;
      }

      return false;
    }
  } else if(max_ammo_check(currentweapon)) {
    return false;
  }

  return true;
}

function get_alt_weapon(weapon) {
  basename = weapon.basename;
  primary_weapons = self getweaponslistprimaries();
  currentweapon = undefined;

  foreach(gun in primary_weapons) {
    if(gun.basename == basename && gun != weapon) {
      currentweapon = gun;
      break;
    }
  }

  if(isDefined(currentweapon)) {
    return currentweapon;
  }
}

function max_ammo_check(weapon) {
  if(weapontype(weapon) == "projectile") {
    return true;
  }

  if(weapon.basename == "iw9_me_fists_mp" || weapon.basename == "iw9_me_fists_mp_ls") {
    return true;
  }

  current_ammo = self getweaponammoclip(weapon);
  max_clip = weaponclipsize(weapon);
  max_stock = weaponmaxammo(weapon);

  if(istrue(weapon.isalternate)) {
    if(isDefined(weapon.underbarrel) && weapon.underbarrel == "ubshtgn") {
      max_stock = 0;
    }
  }

  player_stock = self getweaponammostock(weapon);

  if(player_stock < max_stock || current_ammo < max_clip) {
    return false;
  }

  return true;
}

function weapon_should_not_get_ammo(weapon) {
  weapon_name = weapon.basename;

  switch (weapon_name) {
    case #"hash_7b2c4b25882fbf2f":
    case #"hash_ca6072c8c1ca083f":
      return true;
    default:
      break;
  }

  return false;
}

function adjust_clip_ammo_from_stock(player, sweapon, hand, maxclipammo, var_6747b178b5fc3b95) {
  if(!istrue(var_6747b178b5fc3b95)) {
    maxstock = weaponmaxammo(sweapon);
    currentstock = player getweaponammostock(sweapon);
    stockdifference = maxstock - currentstock;
    var_db98701b04a114db = ter_op(stockdifference >= maxclipammo, currentstock + maxclipammo, maxstock);
    player setweaponammostock(sweapon, var_db98701b04a114db);
  }

  currammo = player getweaponammoclip(sweapon, hand);
  difference = maxclipammo - currammo;
  newammo = min(currammo + difference, maxclipammo);
  player setweaponammoclip(sweapon, int(newammo), hand);
}

function test_ammo_crate(player) {
  player thread watch_dpad();
  player notify("new_power", "crafted_autosentry");
  set_crafted_inventory_item("crafted_autosentry", &give_crafted_ammo_crate, player);
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