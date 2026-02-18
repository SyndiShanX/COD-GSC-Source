/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: cp_common\gametypes\loadout.gsc
***********************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\healthoverlay;
#using scripts\core_common\player\player_loadout;
#using scripts\core_common\player\player_shared;
#using scripts\core_common\system_shared;
#using scripts\cp_common\gametypes\save;
#namespace loadout;

function private autoexec __init__system__() {
  system::register(#"loadout", &preinit, undefined, undefined, #"load");
}

function private preinit() {
  callback::on_start_gametype(&function_6fddd9e2);
  callback::on_connect(&on_connect);
  callback::on_disconnect(&function_5890c14e);
}

function on_connect() {
  self.pers[# "loadout"] = spawnStruct();
  self function_c67222df();
}

function private function_6fddd9e2() {
  profilestart();
  init();
  profilestop();
}

function private init() {
  level.maxkillstreaks = 4;
  level.maxspecialties = 6;
  level.maxallocation = getgametypesetting(#"maxallocation");
  level.loadoutkillstreaksenabled = getgametypesetting(#"loadoutkillstreaksenabled");
}

function function_5890c14e() {
  self savegame::set_player_data("playerClass", undefined);
  self savegame::set_player_data("altPlayerID", undefined);
  self savegame::set_player_data("saved_weapon", undefined);
  self savegame::set_player_data("saved_weapon_attachments", undefined);
  self savegame::set_player_data("saved_weapondata", undefined);
  self savegame::set_player_data("lives", undefined);
  self savegame::set_player_data("saved_rig1", undefined);
  self savegame::set_player_data("saved_rig1_upgraded", undefined);
  self savegame::set_player_data("saved_rig2", undefined);
  self savegame::set_player_data("saved_rig2_upgraded", undefined);
}

function function_bac6b417(equipment_name) {
  if(isDefined(level.weapontacticalinsertion) && equipment_name == level.weapontacticalinsertion.name && level.disabletacinsert) {
    return false;
  }

  return true;
}

function private function_5536bd9e() {
  has_specialty_armor = self hasperk(#"specialty_armor");
  healthtoassign = self.spawnhealth;

  if(isDefined(level.maxspawnhealthboostprct)) {
    self.bonusspawnhealth = int(level.maxspawnhealthboostprct * self.spawnhealth);
    healthtoassign += self.bonusspawnhealth;
  }

  self player::function_9080887a(healthtoassign);
  self.maxhealth = healthtoassign;
  new_health = self.var_66cb03ad < 0 ? healthtoassign : self.var_66cb03ad;
  self.health = new_health;
  self.maxarmor = has_specialty_armor ? self.spawnarmor : 0;
  self.armor = has_specialty_armor ? self.spawnarmor : 0;
  self.var_ed2f8b3a = self.spawnhealth;
  self healthoverlay::restart_player_health_regen();
}

function giveloadout(team, weaponclass, var_d4a479a1) {
  pixbeginevent(#"");
  defaultweapon = getweapon("ar_accurate_t9");
  self takeallweapons();
  self giveweapon(defaultweapon);
  self switchtoweaponimmediate(defaultweapon);
  self setspawnweapon(defaultweapon);
  self setperk("specialty_sprint");
  self setperk("specialty_slide");
  self setperk("specialty_sprintreload");
  self.lastnonkillstreakweapon = defaultweapon;
  self.specialty = [];
  self.killstreak = [];
  self notify(#"give_map");
  self.class_num = 0;
  function_5536bd9e();
  self.var_699ca781 = 0;
  self.var_b204c655 = 0;
  self.grenadetypeprimary = level.weaponnone;
  self.grenadetypeprimarycount = 0;
  self.grenadetypesecondary = level.weaponnone;
  self.grenadetypesecondarycount = 0;

  if(isDefined(self.movementspeedmodifier)) {
    self setmovespeedscale(self.movementspeedmodifier * self getmovespeedscale());
  }

  self flag::set(#"loadout_given");
  callback::callback(#"on_loadout");
  pixendevent();
}

function setclass(newclass) {
  self.curclass = newclass;
}

function event_handler[player_loadoutchanged] loadout_changed(eventstruct) {
  self callback::callback(#"hash_39bf72fd97e248a0", eventstruct);
}

function isexplosivedamage(meansofdeath) {
  switch (meansofdeath) {
    case # "mod_explosive":
    case # "mod_grenade":
    case # "mod_grenade_splash":
    case # "mod_projectile_splash":
      return true;
  }

  return false;
}

function function_88c673cf(player) {
  return player hasperk(#"specialty_stunprotection") || player hasperk(#"specialty_flashprotection") || player hasperk(#"specialty_proximityprotection");
}

function isfiredamage(weapon, meansofdeath) {
  if(weapon.doesfiredamage && (meansofdeath == "MOD_BURNED" || meansofdeath == "MOD_GRENADE" || meansofdeath == "MOD_GRENADE_SPLASH")) {
    return true;
  }

  return false;
}

function grenadestuck(inflictor) {
  return isDefined(inflictor) && isDefined(inflictor.stucktoplayer) && inflictor.stucktoplayer == self;
}