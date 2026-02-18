/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: mp_common\weapon_cache.gsc
***********************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\player\player_loadout;
#using scripts\core_common\scene_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\territory;
#using scripts\core_common\territory_util;
#using scripts\core_common\util_shared;
#namespace weapon_cache;

function private autoexec __init__system__() {
  system::register(#"weapon_cache", &preinit, undefined, &finalize, undefined);
}

function private preinit() {
  if(!is_true(getgametypesetting(#"hash_6143c4e1e18f08fd"))) {
    return;
  }

  clientfield::register("scriptmover", "register_weapon_cache", 1, 1, "int");
  clientfield::register("toplayer", "weapon_cache_ammo_cooldown", 1, 1, "int");
  clientfield::register("toplayer", "weapon_cache_cac_cooldown", 1, 1, "int");
  callback::on_connect(&onplayerconnect);
  level.var_b24258 = &function_b24258;
  level.var_f830a9db = &function_f830a9db;
  level.var_50c35573 = [];
}

function onplayerconnect() {
  level.var_50c35573[self getentitynumber()] = 1;
}

function finalize() {
  if(!is_true(getgametypesetting(#"hash_6143c4e1e18f08fd"))) {
    return;
  }

  var_b5f67dff = territory::function_5c7345a3("weapon_cache");

  foreach(var_73b9e48e in var_b5f67dff) {
    var_73b9e48e.var_331b8fa4 = 0;
    var_73b9e48e function_4c6228cd();
  }
}

function function_4c6228cd() {
  usetrigger = spawn("trigger_radius_use", self.origin, 0, 96, 32);
  usetrigger setcursorhint("HINT_INTERACTIVE_PROMPT");
  usetrigger function_dae4ab9b(0);
  useobject = gameobjects::create_use_object(#"any", usetrigger, [], undefined, #"weapon_cache", 1, 1, 1, self.angles);
  useobject gameobjects::set_visible(#"group_all");
  useobject gameobjects::allow_use(#"group_all");
  useobject gameobjects::set_use_time(0);
  useobject gameobjects::set_onuse_event(&function_692bd0bc);
  useobject.canuseobject = &function_43017839;
  useobject.dontlinkplayertotrigger = 1;
  useobject.keepweapon = 1;
  useobject clientfield::set("register_weapon_cache", 1);
  useobject disconnectpaths();
  self.entity = util::spawn_model(#"p9_usa_large_ammo_crate_01", self.origin, self.angles);
  self.mdl_gameobject = useobject;
  useobject.var_73b9e48e = self;
}

function function_692bd0bc(player) {
  primaryweapons = player getweaponslistprimaries();
  givemaxammo = player hasperk(#"specialty_extraammo") || player function_db654c9(player.class_num, #"hash_4a12859000892dda");

  foreach(weapon in primaryweapons) {
    player setweaponammoclip(weapon, player getclipsize(weapon));

    if(givemaxammo) {
      player givemaxammo(weapon);
      continue;
    }

    player givestartammo(weapon);
  }

  primaryoffhand = player function_826ed2dd();
  player setweaponammoclip(primaryoffhand, player getclipsize(primaryoffhand));
  loadout = player loadout::get_loadout_slot("secondarygrenade");
  secondaryoffhand = loadout.weapon;

  if(isDefined(secondaryoffhand) && player hasweapon(secondaryoffhand)) {
    player setweaponammoclip(secondaryoffhand, player getclipsize(secondaryoffhand));
  }

  player.var_864fb19 = gettime();
  player notify(#"resupply");
  player playsoundtoplayer(#"hash_da34d63dbce7ba7", player);
  player thread function_2909dca6(self.var_73b9e48e);
  player thread function_f9502d83();
}

function function_f9502d83() {
  self endon(#"disconnect");
  var_b5f67dff = territory::function_5c7345a3("weapon_cache");
  self clientfield::set_to_player("weapon_cache_ammo_cooldown", 1);
  level.var_50c35573[self getentitynumber()] = 0;

  foreach(var_73b9e48e in var_b5f67dff) {
    var_73b9e48e gameobjects::function_7a00d78c(self);
  }

  self waittilltimeout(60, #"death");
  self clientfield::set_to_player("weapon_cache_ammo_cooldown", 0);
  level.var_50c35573[self getentitynumber()] = 1;

  foreach(var_73b9e48e in var_b5f67dff) {
    var_73b9e48e gameobjects::function_664b40(self);
  }
}

function private function_43017839(player) {
  if(level.var_50c35573[player getentitynumber()] != 1) {
    return false;
  }

  return true;
}

function private function_b24258(eventstruct) {
  self luinotifyevent(#"hash_c893e57629c7648");
}

function function_f830a9db() {
  self endon(#"disconnect");
  self clientfield::set_to_player("weapon_cache_cac_cooldown", 1);
  self notify(#"hash_2bc8de932f7212e7");
  self waittilltimeout(120, #"death");
  self clientfield::set_to_player("weapon_cache_cac_cooldown", 0);
}

function private function_6f438290() {
  var_b5f67dff = territory::function_5c7345a3("weapon_cache");
  var_8794b467 = arraysortclosest(var_b5f67dff, self.origin);
  return var_8794b467[0];
}

function private function_74547745() {
  var_73b9e48e = self function_6f438290();

  if(!isDefined(var_73b9e48e)) {
    return;
  }

  var_73b9e48e function_4ac19c4f();
  self waittill(#"death", #"hash_2bc8de932f7212e7");
  var_73b9e48e function_70db7bab();
}

function private function_2909dca6(var_73b9e48e) {
  var_73b9e48e function_4ac19c4f();
  wait 1;
  var_73b9e48e function_70db7bab();
}

function private function_4ac19c4f() {
  if(!self.var_331b8fa4 && isDefined(self.entity)) {
    self.entity thread scene::play("p9_usa_large_ammo_crate_01_bundle", "open", self.entity);
  }

  self.var_331b8fa4++;
}

function private function_70db7bab() {
  if(self.var_331b8fa4 && isDefined(self.entity)) {
    self.var_331b8fa4--;

    if(!self.var_331b8fa4) {
      self.entity thread scene::play("p9_usa_large_ammo_crate_01_bundle", "close", self.entity);
    }
  }
}