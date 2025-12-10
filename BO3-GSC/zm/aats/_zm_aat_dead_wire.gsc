/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\aats\_zm_aat_dead_wire.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\aat_shared;
#using scripts\shared\ai\systems\gib;
#using scripts\shared\ai\zombie_utility;
#using scripts\shared\array_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\math_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm_lightning_chain;
#using scripts\zm\_zm_utility;
#namespace zm_aat_dead_wire;

function autoexec __init__sytem__() {
  system::register("zm_aat_dead_wire", &__init__, undefined, "aat");
}

function __init__() {
  if(!(isDefined(level.aat_in_use) && level.aat_in_use)) {
    return;
  }
  aat::register("zm_aat_dead_wire", 0.2, 0, 5, 2, 1, &result, "t7_hud_zm_aat_deadwire", "wpn_aat_dead_wire_plr");
  clientfield::register("actor", "zm_aat_dead_wire" + "_zap", 1, 1, "int");
  clientfield::register("vehicle", "zm_aat_dead_wire" + "_zap_vehicle", 1, 1, "int");
  level.zm_aat_dead_wire_lightning_chain_params = lightning_chain::create_lightning_chain_params(8, 9, 120);
  level.zm_aat_dead_wire_lightning_chain_params.head_gib_chance = 100;
  level.zm_aat_dead_wire_lightning_chain_params.network_death_choke = 4;
  level.zm_aat_dead_wire_lightning_chain_params.challenge_stat_name = "ZOMBIE_HUNTER_DEAD_WIRE";
}

function result(death, attacker, mod, weapon) {
  if(!isDefined(level.zombie_vars["tesla_head_gib_chance"])) {
    zombie_utility::set_zombie_var("tesla_head_gib_chance", 50);
  }
  attacker.tesla_enemies = undefined;
  attacker.tesla_enemies_hit = 1;
  attacker.tesla_powerup_dropped = 0;
  attacker.tesla_arc_count = 0;
  level.zm_aat_dead_wire_lightning_chain_params.weapon = weapon;
  self lightning_chain::arc_damage(self, attacker, 1, level.zm_aat_dead_wire_lightning_chain_params);
}