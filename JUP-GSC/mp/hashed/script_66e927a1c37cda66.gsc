/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_66e927a1c37cda66.gsc
*************************************************/

#using script_422801cfe4074e05;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\engine\utility;
#namespace namespace_30101e0cca498f6;

function init() {
  assert(flag("<dev string:x1c>"));
  callback::add("on_agent_spawned", &on_ai_spawn);
  callback::add("on_ai_killed", &on_ai_killed);
}

function private on_ai_spawn(params) {
  ent = params.agent;

  if(!isDefined(ent)) {
    return;
  }

  state = 0;
  data = ent.agent_type;
  analytics::function_a569c60476357392("agent_spawn", ent, state, data);
}

function private on_ai_killed(params) {
  ent = self;

  if(!isDefined(ent)) {
    return;
  }

  attacker = params.eattacker;

  if(!isDefined(attacker) || !(isagent(attacker) || isPlayer(attacker)) || !isDefined(attacker.classname) || attacker.classname == "worldspawn" || attacker.classname == "script_vehicle" || attacker.classname == "script_model" || attacker.classname == "misc_turret" || attacker.classname == "misc_samsite" || attacker.classname == "trigger_hurt" || attacker.classname == "trigger_multiple" || attacker.classname == "script_origin") {
    var_9c46fc77656f0e4b = "world";
  } else {
    attacker_weapon = attacker getcurrentweapon();
    var_9c46fc77656f0e4b = attacker_weapon.basename;
  }

  state = 0;
  analytics::function_a569c60476357392("agent_down", ent, state, var_9c46fc77656f0e4b);
}