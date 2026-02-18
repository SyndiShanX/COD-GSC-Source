/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\audio_shared.gsc
***********************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\music_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace audio;

function private autoexec __init__system__() {
  system::register(#"audio", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  util::registerclientsys("duckCmd");
  callback::on_connect(&on_player_connect);
  callback::on_spawned(&sndresetsoundsettings);
  callback::on_player_killed(&on_player_killed);
  callback::on_vehicle_spawned(&vehiclespawncontext);
  level thread register_clientfields();
}

function register_clientfields() {
  clientfield::register("world", "sndMatchSnapshot", 1, 2, "int");
  clientfield::register("scriptmover", "sndRattle", 1, 1, "counter");
  clientfield::register("allplayers", "sndRattle", 1, 1, "counter");
  clientfield::register("toplayer", "sndMelee", 1, 1, "int");
  clientfield::register("vehicle", "sndSwitchVehicleContext", 1, 3, "int");
  clientfield::register("toplayer", "sndCCHacking", 1, 2, "int");
  clientfield::register("toplayer", "sndTacRig", 1, 1, "int");
  clientfield::register("toplayer", "sndLevelStartSnapOff", 1, 1, "int");
  clientfield::register("world", "sndIGCsnapshot", 1, 4, "int");
  clientfield::register("world", "sndChyronLoop", 1, 1, "int");
  clientfield::register("world", "sndZMBFadeIn", 1, 1, "int");
  clientfield::register("world", "sndDeactivateSquadSpawnMusic", 1, 1, "int");
  clientfield::register("toplayer", "sndVehicleDamageAlarm", 1, 1, "counter");
  clientfield::register("toplayer", "sndCriticalHealth", 1, 1, "int");
  clientfield::register("toplayer", "sndLastStand", 1, 1, "int");
}

function function_dcd27601(state, player) {
  if(isDefined(player)) {
    util::setclientsysstate("duckCmd", state, player);
    return;
  }

  util::setclientsysstate("duckCmd", state);
}

function sndchyronwatcher() {
  level waittill(#"chyron_menu_open");

  if(isDefined(level.var_3bc9e7f0) == 0) {
    level clientfield::set("sndChyronLoop", 1);
  }

  level waittill(#"chyron_menu_closed");

  if(isDefined(level.var_3bc9e7f0) == 0) {
    level clientfield::set("sndChyronLoop", 0);
  }
}

function sndresetsoundsettings() {
  self clientfield::set_to_player("sndMelee", 0);
  self util::clientnotify("sndDEDe");

  if(!self flag::exists("playing_stinger_fired_at_me")) {
    self flag::init("playing_stinger_fired_at_me", 0);
    return;
  }

  self flag::clear("playing_stinger_fired_at_me");
}

function on_player_connect() {
  self callback::function_d8abfc3d(#"missile_lock", &on_missile_lock);
  self callback::function_d8abfc3d(#"hash_1a32e0fdeb70a76b", &function_c25f7d1);
}

function on_player_killed(params) {
  if(sessionmodeiscampaigngame()) {
    if(self util::function_a1d6293()) {
      return;
    }

    music::setmusicstate("death");
    self playSound("uin_player_death");
  }
}

function vehiclespawncontext() {
  if(sessionmodeismultiplayergame() || sessionmodeiswarzonegame()) {
    self clientfield::set("sndSwitchVehicleContext", 1);
  }
}

function sndupdatevehiclecontext(added) {
  if(!isDefined(self.sndoccupants)) {
    self.sndoccupants = 0;
  }

  if(added) {
    self.sndoccupants++;
  } else {
    self.sndoccupants--;

    if(self.sndoccupants < 0) {
      self.sndoccupants = 0;
    }
  }

  self clientfield::set("sndSwitchVehicleContext", self.sndoccupants + 1);
}

function playtargetmissilesound(alias, looping) {
  self notify(#"stop_target_missile_sound");
  self endon(#"stop_target_missile_sound", #"disconnect", #"death");

  if(isDefined(alias)) {
    time = soundgetplaybacktime(alias) * 0.001;

    if(time > 0) {
      do {
        self playlocalsound(alias);
        wait time;
      }
      while(looping);
    }
  }
}

function on_missile_lock(params) {
  assert(isPlayer(self));

  if(!flag::get("playing_stinger_fired_at_me")) {
    self thread playtargetmissilesound(params.weapon.lockontargetlockedsound, params.weapon.lockontargetlockedsoundloops);
    self waittill(#"stinger_fired_at_me", #"missile_unlocked", #"death");
    self notify(#"stop_target_missile_sound");
  }
}

function function_c25f7d1(params) {
  assert(isPlayer(self));
  self endon(#"death", #"disconnect");
  self flag::set("playing_stinger_fired_at_me");
  self thread playtargetmissilesound(params.weapon.lockontargetfiredonsound, params.weapon.lockontargetfiredonsoundloops);
  params.projectile waittill(#"projectile_impact_explode", #"death");
  self notify(#"stop_target_missile_sound");
  self flag::clear("playing_stinger_fired_at_me");
}

function unlockfrontendmusic(unlockname, allplayers) {}

function function_30d4f8c4(attacker, smeansofdeath, weapon) {
  str_alias = # "hash_4296e7b3cbb7f3de";
  var_90937e56 = function_bd53fa92(attacker, smeansofdeath, weapon);

  if(isDefined(var_90937e56)) {
    if(var_90937e56 === # "explosive") {
      str_alias = # "hash_c43c0f6a63f7e0";
    }

    if(var_90937e56 === # "gas") {
      str_alias = # "hash_291958f59b6be82";
    }

    if(var_90937e56 === # "execution") {
      str_alias = # "hash_58d3709b34454b17";
    }

    if(var_90937e56 === # "bullet") {
      str_alias = # "hash_100370f52a9e0c99";
    }
  }

  if(weapon.name === # "hatchet") {
    str_alias = # "hash_55bb02aa30e19da8";
  }

  self playsoundtoplayer(str_alias, self);
}

function function_bd53fa92(attacker, mod, weapon) {
  if(isDefined(mod)) {
    if(mod === "MOD_EXECUTION") {
      return # "execution";
    }

    if(mod === "MOD_EXPLOSIVE" || mod === "MOD_GRENADE" || mod === "MOD_GRENADE_SPLASH") {
      return # "explosive";
    }

    if(mod === "MOD_GAS") {
      return # "gas";
    }

    if(mod === "MOD_BULLET" || mod === "MOD_RIFLE_BULLET" || mod === "MOD_PISTOL_BULLET" || mod === "MOD_HEAD_SHOT") {
      return # "bullet";
    }

    if(mod === "MOD_SUICIDE") {
      return;
    }
  }

  if(isDefined(weapon)) {
    if(weapon.name === "tear_gas") {
      return # "gas";
    }
  }

  return undefined;
}

function function_641cec60(weapon) {
  if(!isDefined(weapon)) {
    return;
  }

  var_80de6af = 0;

  if(weapon.name == # "knife_loadout") {
    var_80de6af = 1;
  }

  return var_80de6af;
}