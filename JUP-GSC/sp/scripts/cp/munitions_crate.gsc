/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\cp\munitions_crate.gsc
***********************************************/

#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp\armor;
#using scripts\cp\cp_ammo_crate;
#using scripts\cp\cp_deployablebox;
#using scripts\cp\cp_grenade_crate;
#using scripts\cp\damagefeedback;
#using scripts\cp\pickups;
#using scripts\cp\utility;
#using scripts\engine\utility;
#namespace munitions_crate;

function function_6444dd7186b01cfc() {
  boxconfig = spawnStruct();
  boxconfig.id = "munitions_crate";
  boxconfig.weaponinfo = "iw8_armor_marker_cp";
  boxconfig.modelbase = "offhand_wm_supportbox_armor";
  boxconfig.hintstring = &"COOP_CRAFTING/AMMO_CRATE_TAKE";
  boxconfig.streakname = "munitions_crate";
  boxconfig.splashname = "used_support_box";
  boxconfig.shadername = "compass_objpoint_deploy_friendly";
  boxconfig.headicon = "hud_icon_equipment_support_box";
  boxconfig.headiconoffset = 20;
  boxconfig.lifespan = 90;
  boxconfig.usexp = 50;
  boxconfig.onusesfx = "ammo_crate_use";
  boxconfig.deployedsfx = "ammo_crate_use";
  boxconfig.deathvfx = loadfx("vfx/iw9/fieldupgrades/ammobox/vfx_ammobox_timeout.vfx");
  boxconfig.onusecallback = &function_b6c303e97d2afe72;
  boxconfig.canusecallback = &function_ff0eaf5506ddb339;
  boxconfig.deployfunc = &function_570566f845ec4461;
  boxconfig.onusethanksbc = #"ping_social_thanks";
  boxconfig.usetime = 1000;
  boxconfig.maxhealth = 100;
  boxconfig.maxuses = 4;
  boxconfig.canreusebox = 0;
  boxconfig.allowmeleedamage = 1;
  boxconfig.damagefeedback = "";
  boxconfig.grenadeusefunc = &supportbox_grenadelaunchfunc;
  boxconfig.ondeploycallback = &supportbox_ondeploy;
  boxconfig.deployanimduration = supportbox_getdeployanimduration();
  level.boxsettings["munitions_crate"] = boxconfig;
  level.deployable_box["munitions_crate"] = [];
}

function weaponswitchendedsupportbox(streakinfo, switchresult) {
  if(istrue(switchresult)) {
    thread supportbox_watchplayerweapon(streakinfo);
  }
}

function tryusesupportbox(streakinfo, grenade) {
  return true;
}

function function_ff0eaf5506ddb339(boxent) {
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

function function_b6c303e97d2afe72(boxent) {
  self endon("disconnect");
  var_a5aec2c7f44be2bf = function_3a119e0cfe090cba(self);
  success2 = function_1749db81c9375723(self);

  if(var_a5aec2c7f44be2bf || success2) {
    return true;
  }

  thread scripts\cp\utility::hint_prompt("max_ammo_grenades", 1, 3);
  return false;
}

function function_cb8f3b5096d94129() {
  self endon("disconnect");
  val::set("munitionsbox", "reload", 0);
  val::set("munitionsbox", "weapon_switch", 0);
  wait 1;
  val::set("munitionsbox", "reload", 1);
  val::set("munitionsbox", "weapon_switch", 1);
}

function function_3a119e0cfe090cba(player) {
  player endon("disconnect");
  success = player scripts\cp\cp_ammo_crate::supportbox_onusedeployable(0);

  if(success) {
    player thread function_8db4cafb79e5124a();
    return true;
  }

  return false;
}

function function_1749db81c9375723(player) {
  player endon("disconnect");
  success = player scripts\cp\cp_grenade_crate::healthbox_onusedeployable(0);

  if(success) {
    player thread function_8db4cafb79e5124a();
    return true;
  }

  return false;
}

function function_8db4cafb79e5124a() {
  self notify("ammo_cache_success");
  self endon("ammo_cache_success");
  thread scripts\cp\pickups::player_play_pickup_anim();
  self playlocalsound("weap_ammo_pickup");
  thread scripts\cp\damagefeedback::hudicontype("ammobox");
}

function function_570566f845ec4461(boxent) {
  self endon("disconnect");
  self playlocalsound("weap_ammo_pickup");
  return true;
}

function function_98abc38c4430f306() {
  scripts\cp\armor::function_1258f8d2084a2ce7();
}

function function_25da11ee5fd804ee() {}

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

function cangive_ammo() {
  currentweapon = getvalidtakeweapon();
  current_ammo = self getweaponammoclip(currentweapon);
  max_clip = weaponclipsize(currentweapon);
  max_stock = weaponmaxammo(currentweapon);
  player_stock = self getweaponammostock(currentweapon);

  if(player_stock < max_stock || current_ammo < max_clip) {
    return 1;
  }

  return 0;
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