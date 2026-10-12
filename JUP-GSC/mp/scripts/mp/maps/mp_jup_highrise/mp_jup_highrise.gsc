/***************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_jup_highrise\mp_jup_highrise.gsc
***************************************************************/

#using scripts\common\utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\utility;
#using scripts\mp\agents\agent_utility;
#using scripts\mp\animation_suite;
#using scripts\mp\compass;
#using scripts\mp\load;
#using scripts\mp\maps\mp_jup_highrise\gen\mp_jup_highrise_art;
#using scripts\mp\maps\mp_jup_highrise\mp_jup_highrise_fx;
#using scripts\mp\maps\mp_jup_highrise\mp_jup_highrise_lighting;
#using scripts\mp\spawnlogic;
#namespace mp_jup_highrise;

function main() {
  scripts\mp\maps\mp_jup_highrise\gen\mp_jup_highrise_art::main();
  scripts\mp\maps\mp_jup_highrise\mp_jup_highrise_fx::main();
  scripts\mp\maps\mp_jup_highrise\mp_jup_highrise_lighting::main();
  scripts\mp\load::main();
  level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
  level.kill_border_triggers = getEntArray("kill_border_trigger", "targetname");
  scripts\mp\compass::setupminimap("compass_map_mp_jup_highrise");
  setDvar(@ "hash_7686fcb92ccc5edb", 8);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  thread scripts\mp\animation_suite::animationsuite();
  function_86eda34bb6bbe9fb();
  thread function_4f48f01701f9e22b();
}

function function_86eda34bb6bbe9fb() {
  level.var_8aa11cb20211ed31["scriptable_me_machinery_oil_tank_a_derail_01"] = "indestructible";
  level.var_8aa11cb20211ed31["scriptable_uk_gas_tank_thin_cylinder"] = "hide";
  level.var_8aa11cb20211ed31["scriptable_decor_barrels_gameplay_red"] = "hide";
  level.var_8aa11cb20211ed31["scriptable_un_propane_gas_tank_tall_med"] = "hide";
  level.var_8aa11cb20211ed31["scriptable_fac_metal_extinguisher_02"] = "hide";
  level.var_8aa11cb20211ed31["scriptable_fac_metal_extinguisher_02_static"] = "hide";
}

function function_4f48f01701f9e22b() {
  if(scripts\cp_mp\utility\game_utility::getgametype() != "arena") {
    return;
  }

  function_a1f774c728610421();
  function_359d426bc2dca387();
}

function function_a1f774c728610421() {
  if(scripts\cp_mp\utility\game_utility::getgametype() == "arena" && !getdvarint(@ "hash_2167cbfc86b6839", 0)) {
    outofbounds = getEntArray("OutOfBoundsGunfight", "targetname");

    if(outofbounds.size > 0) {
      level.outofboundstriggers = array_combine(outofbounds, level.outofboundstriggers);
    }
  }
}

function function_359d426bc2dca387() {
  var_1cf8be03fb3c42de = scripts\mp\spawnlogic::getspawnpointarray("mp_arena_spawn_allies_start");
  var_68c73806e24ff493 = scripts\mp\spawnlogic::getspawnpointarray("mp_arena_spawn_axis_start");
  spawnpointents = scripts\engine\utility::array_combine(var_1cf8be03fb3c42de, var_68c73806e24ff493);

  foreach(spawn_point in spawnpointents) {
    spawn_origin = getoriginidentifierstring(spawn_point);

    if(!getdvarint(@ "hash_2167cbfc86b6839")) {
      if(isDefined(spawn_point.target) && spawn_point.target != "gunfight_only_spawn") {
        spawn_point.script_noteworthy = "";
        level.modifiedspawnpoints[spawn_origin][spawn_point.classname]["remove"] = 1;
      }

      continue;
    }

    if(isDefined(spawn_point.target) && spawn_point.target == "gunfight_only_spawn") {
      spawn_point.script_noteworthy = "";
      level.modifiedspawnpoints[spawn_origin][spawn_point.classname]["remove"] = 1;
    }
  }
}