/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\bgbs\_zm_bgb_sword_flay.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\flag_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm_bgb;
#using scripts\zm\_zm_powerups;
#using scripts\zm\_zm_stats;
#using scripts\zm\_zm_utility;
#namespace zm_bgb_sword_flay;

function autoexec __init__sytem__() {
  system::register("zm_bgb_sword_flay", & __init__, undefined, "bgb");
}

function __init__() {
  if(!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
    return;
  }
  bgb::register("zm_bgb_sword_flay", "time", 150, & enable, & disable, undefined);
  bgb::register_actor_damage_override("zm_bgb_sword_flay", & actor_damage_override);
  bgb::register_vehicle_damage_override("zm_bgb_sword_flay", & vehicle_damage_override);
}

function enable() {}

function disable() {}

function actor_damage_override(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype) {
  if(meansofdeath === "MOD_MELEE") {
    damage = damage * 5;
    if((self.health - damage) <= 0 && isdefined(attacker) && isplayer(attacker)) {
      attacker zm_stats::increment_challenge_stat("GUM_GOBBLER_SWORD_FLAY");
    }
  }
  return damage;
}

function vehicle_damage_override(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal) {
  if(smeansofdeath === "MOD_MELEE") {
    idamage = idamage * 5;
  }
  return idamage;
}