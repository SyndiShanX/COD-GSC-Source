/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm\perk\zm_perk_deadshot.gsc
***********************************************/

#using script_2c5daa95f8fec03c;
#using script_3751b21462a54a7d;
#using script_5f261a5d57de5f7c;
#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\visionset_mgr_shared;
#using scripts\zm_common\ai\zm_ai_utility;
#using scripts\zm_common\scoreevents;
#using scripts\zm_common\util;
#using scripts\zm_common\zm_perks;
#using scripts\zm_common\zm_stats;
#using scripts\zm_common\zm_utility;
#namespace zm_perk_deadshot;

function private autoexec __init__system__() {
  system::register(#"zm_perk_deadshot", &preinit, undefined, undefined, #"hash_2d064899850813e2");
}

function private preinit() {
  enable_deadshot_perk_for_level();
  zm_perks::register_actor_damage_override(#"talent_deadshot", &function_4d088c19);
}

function enable_deadshot_perk_for_level() {
  zm_perks::register_perk_basic_info(#"talent_deadshot", #"perk_dead_shot", 2000, #"zombie/perk_deadshot", getweapon("zombie_perk_bottle_deadshot"), undefined, #"zmperksdeadshot");
  zm_perks::register_perk_precache_func(#"talent_deadshot", &deadshot_precache);
  zm_perks::register_perk_clientfields(#"talent_deadshot", &deadshot_register_clientfield, &deadshot_set_clientfield);
  zm_perks::register_perk_machine(#"talent_deadshot", &deadshot_perk_machine_setup);
  zm_perks::register_perk_threads(#"talent_deadshot", &give_deadshot_perk, &take_deadshot_perk);
  zm_perks::register_perk_host_migration_params(#"talent_deadshot", "vending_deadshot", "deadshot_light");
}

function deadshot_precache() {
  if(isDefined(level.var_bc5f9f6a)) {
    [[level.var_bc5f9f6a]]();
    return;
  }

  level._effect[#"deadshot_light"] = "zombie/fx_perk_deadshot_ndu";
  level.machine_assets[#"talent_deadshot"] = spawnStruct();
  level.machine_assets[#"talent_deadshot"].weapon = getweapon("zombie_perk_bottle_deadshot");
  level.machine_assets[#"talent_deadshot"].off_model = "p9_sur_vending_ads_off";
  level.machine_assets[#"talent_deadshot"].on_model = "p9_sur_vending_ads";
}

function deadshot_register_clientfield() {
  clientfield::register("toplayer", "deadshot_perk", 1, 1, "int");
}

function deadshot_set_clientfield(state) {}

function deadshot_perk_machine_setup(use_trigger, perk_machine, bump_trigger, collision) {
  perk_machine.script_sound = "mus_perks_deadshot_jingle";
  perk_machine.script_string = "deadshot_perk";
  perk_machine.script_label = "mus_perks_deadshot_sting";
  perk_machine.target = "vending_deadshot";
  bump_trigger.script_string = "deadshot_vending";
  bump_trigger.targetname = "vending_deadshot";

  if(isDefined(collision)) {
    collision.script_string = "deadshot_vending";
  }
}

function give_deadshot_perk() {
  self clientfield::set_to_player("deadshot_perk", 1);
}

function take_deadshot_perk(b_pause, str_perk, str_result, n_slot) {
  self clientfield::set_to_player("deadshot_perk", 0);
}

function function_4d088c19(inflictor, attacker, damage, flags, meansofdeath, weapon, var_fd90b0bb, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype) {
  if(isPlayer(vpoint)) {
    if(shitloc === "MOD_MELEE") {
      return vdir;
    }

    var_84ed9a13 = self zm_ai_utility::function_de3dda83(surfacetype, boneindex, psoffsettime);

    if(vpoint namespace_e86ffa8::function_7bf30775(1)) {
      if(self.health >= self.maxhealth) {
        if(isDefined(var_84ed9a13) && namespace_81245006::function_f29756fe(var_84ed9a13) == 1 && var_84ed9a13.type !== # "armor") {
          vdir += vdir * 1;
        }
      }
    }

    if(vpoint namespace_e86ffa8::function_7bf30775(4)) {
      if(isDefined(var_84ed9a13) && namespace_81245006::function_f29756fe(var_84ed9a13) == 1 && var_84ed9a13.type !== # "armor") {
        vdir += vdir * 0.1;
      }
    }

    if(vpoint namespace_791d0451::function_56cedda7(#"hash_1f95b08e4a49d87e")) {
      if(!isDefined(vpoint.var_39f18bc3)) {
        vpoint.var_39f18bc3 = 0;
      }

      if(self === vpoint.var_9c098a96) {
        vpoint.var_39f18bc3++;

        if(vpoint.var_39f18bc3 < vpoint.var_39f18bc3) {
          vpoint.var_39f18bc3 = vpoint.var_39f18bc3;
        } else if(vpoint.var_39f18bc3 > 10) {
          vpoint.var_39f18bc3 = 10;
        }

        vdir += vdir * 0.02 * vpoint.var_39f18bc3;
      } else {
        vpoint.var_39f18bc3 = 0;
      }

      vpoint.var_9c098a96 = self;
    }
  }

  return vdir;
}