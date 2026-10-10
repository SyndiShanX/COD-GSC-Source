/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_681c3db54537afa6.gsc
*************************************************/

#using scripts\common\elevators;
#using scripts\common\utility;
#using scripts\cp_mp\emp_debuff;
#using scripts\cp_mp\ent_manager;
#using scripts\cp_mp\equipment\haywire;
#using scripts\cp_mp\utility\callback_group;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\cp_mp\utility\train_utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\vehicles\vehicle_occupancy;
#using scripts\cp_mp\weapon;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\damage;
#using scripts\mp\equipment\sound_veil;
#using scripts\mp\hostmigration;
#using scripts\mp\hud_util;
#using scripts\mp\sentientpoolmanager;
#using scripts\mp\utility\entity;
#using scripts\mp\utility\game;
#using scripts\mp\utility\killstreak;
#using scripts\mp\utility\outline;
#using scripts\mp\utility\perk;
#using scripts\mp\utility\player;
#using scripts\mp\utility\points;
#using scripts\mp\utility\print;
#using scripts\mp\utility\teams;
#using scripts\mp\utility\weapon;
#using scripts\mp\weapons;
#namespace namespace_59b4686a745dd963;

function function_7b988e1bb56ca747(grenade) {
  grenade endon("death");

  print::printgameaction("<dev string:x1c>", self);

  if(!isDefined(level.var_4405e76242d7cb8e)) {
    level.var_4405e76242d7cb8e = 0;
  }

  grenade ent_manager::registerspawn(1, &sound_veil::function_558d562eb33ea61d);
  grenade setscriptablepartstate("visibility", "show", 0);
  grenade waittill("missile_stuck", stuckto);

  if(isDefined(stuckto) && stuckto vehicle::isvehicle()) {
    grenade.vehicle_stuck = 1;
  }

  if(isDefined(level.var_ca4e08767cbdae12)) {
    canplant = grenade[[level.var_ca4e08767cbdae12]]();

    if(!canplant) {
      grenade delete();
      return;
    }
  }

  grenade setscriptablepartstate("plant", "active", 0);
  grenade setotherent(self);
  grenade setnodeploy(1);
  grenade setnonstick(1);
  grenade.usedcount = 0;
  grenade.deployingplayer = self;
  grenade.activetargets = [];
  trigger = spawn("trigger_rotatable_radius", grenade.origin, 0, 80, 300);
  trigger.angles = grenade.angles;
  grenade.trigger = trigger;
  trigger enablelinkTo();
  trigger linkTo(grenade);
  onequipmentplanted(grenade, "equip_sound_veil", &sound_veil::function_558d562eb33ea61d, 1);
  grenade sentientpoolmanager::registersentient("Tactical_Static", self);
  maxhealth = 100;
  grenade thread damage::monitordamage(maxhealth, "hitequip", &sound_veil::function_f313405d166290be, &sound_veil::function_50b1d2352a6a686a, 0);
  grenade emp_debuff::set_apply_emp_callback(&sound_veil::function_b434ea15774ed770);
  grenade haywire::function_172d848d58051fdf(&sound_veil::function_391ebdde9e0eec71);
  grenade sound_veil::function_49197cd063a740ea(&sound_veil::function_558d562eb33ea61d);

  if(isDefined(level.elevators)) {
    foreach(elevators in level.elevators) {
      elevators thread elevators::isentitytouchingdoortrigger(grenade);
    }
  }

  grenade sound_veil::function_74844a68121c9b36();
}