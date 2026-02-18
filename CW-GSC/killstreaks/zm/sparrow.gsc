/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: killstreaks\zm\sparrow.gsc
***********************************************/

#using script_24c32478acf44108;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\status_effects\status_effect_util;
#using scripts\core_common\system_shared;
#using scripts\killstreaks\killstreaks_shared;
#using scripts\weapons\weapons;
#using scripts\zm_common\aats\ammomods\ammomod_napalmburst;
#using scripts\zm_common\zm_player;
#namespace zm_sparrow;

function private autoexec __init__system__() {
  system::register(#"zm_sparrow", &__init__, undefined, undefined, #"killstreaks");
}

function __init__() {
  callback::on_actor_damage(&onactordamage);
  zm_player::register_player_friendly_fire_callback(&function_61f584a7);
}

function private onactordamage(params) {
  weapon = params.weapon;

  if(!isDefined(weapon)) {
    return;
  }

  if(!function_119a2a90(weapon)) {
    return;
  }

  if(params.smeansofdeath == "MOD_DOT") {
    return;
  }

  statuseffect = getstatuseffect("dot_sig_bow_flame");
  self status_effect::status_effect_apply(statuseffect, weapon, params.eattacker, 0, undefined, undefined, params.vpoint);
  self ammomod_napalmburst::function_74816787();
  duration = float(statuseffect.seduration) / 1000;
  self thread function_77b06e9c(duration);
}

function function_77b06e9c(duration) {
  self endon(#"death");
  wait duration;
  self ammomod_napalmburst::function_68364c40();
}

function private function_119a2a90(weapon) {
  return weapon.statname === "sig_bow_flame";
}

function private function_61f584a7(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex) {
  if(shitloc !== self) {
    return psoffsettime;
  }

  if(!isDefined(boneindex) || !function_119a2a90(boneindex)) {
    return psoffsettime;
  }

  return int(psoffsettime / 3);
}