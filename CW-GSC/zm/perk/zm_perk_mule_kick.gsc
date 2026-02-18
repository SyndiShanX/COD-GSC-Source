/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm\perk\zm_perk_mule_kick.gsc
***********************************************/

#using script_4ccfb58a9443a60b;
#using script_5f261a5d57de5f7c;
#using script_7a5293d92c61c788;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\gestures;
#using scripts\core_common\item_inventory;
#using scripts\core_common\item_world_util;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\lui_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\spawning_squad;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\zm_common\gametypes\zm_gametype;
#using scripts\zm_common\zm_equipment;
#using scripts\zm_common\zm_laststand;
#using scripts\zm_common\zm_loadout;
#using scripts\zm_common\zm_perks;
#using scripts\zm_common\zm_player;
#using scripts\zm_common\zm_score;
#using scripts\zm_common\zm_stats;
#using scripts\zm_common\zm_unitrigger;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_vo;
#using scripts\zm_common\zm_weapons;
#namespace zm_perk_mule_kick;

function private autoexec __init__system__() {
  system::register(#"zm_perk_mule_kick", &preinit, undefined, undefined, #"hash_2d064899850813e2");
}

function private preinit() {
  if(!is_true(getgametypesetting(#"hash_616a22c5c1ebe5b8"))) {
    return;
  }

  function_27473e44();
  level.var_bec232ae = &function_9ae34cb7;
}

function function_27473e44() {
  zm_perks::register_perk_basic_info(#"talent_mulekick", #"perk_tombstone", 2000, #"hash_4a88c89fbf0061f6", getweapon("zombie_perk_bottle_mulekick"), undefined, #"zmperksmulekick");
  zm_perks::register_perk_precache_func(#"talent_mulekick", &precache);
  zm_perks::register_perk_clientfields(#"talent_mulekick", &register_clientfield, &set_clientfield);
  zm_perks::register_perk_machine(#"talent_mulekick", &perk_machine_setup);
  zm_perks::register_perk_threads(#"talent_mulekick", &perk_give, &function_6df7ba74);
  zm_perks::register_perk_host_migration_params(#"talent_mulekick", "vending_mulekick", "mulekick_light");
}

function precache() {
  level._effect[# "mulekick_light"] = "zombie/fx9_perk_mulekick";
  level.machine_assets[# "talent_mulekick"] = spawnStruct();
  level.machine_assets[# "talent_mulekick"].weapon = getweapon("zombie_perk_bottle_mulekick");
  level.machine_assets[# "talent_mulekick"].off_model = "p9_fxanim_zm_gp_mule_kick_mod";
  level.machine_assets[# "talent_mulekick"].on_model = "p9_fxanim_zm_gp_mule_kick_mod";
  level.machine_assets[# "talent_mulekick"].power_on_callback = &function_c60d9d72;
}

function register_clientfield() {
  if(zm_utility::is_classic()) {
    clientfield::register("scriptmover", "mule_kick_machine_rob", 13000, 1, "int");
    clientfield::register("scriptmover", "mule_kick_machine_rob_buy", 13000, 1, "counter");
  }
}

function set_clientfield(state) {}

function function_5fd3f2ba(player) {
  self endon(#"death");
  self clientfield::increment("mule_kick_machine_rob_buy");
  self thread function_aee99628(player);
  self scene::play("p9_fxanim_zm_gp_mule_kick_bundle", "shot 1", self);
}

function function_aee99628(player) {
  self endon(#"death");

  if(!isPlayer(player)) {
    return;
  }

  for(shots = 0; shots < 15; shots++) {
    a_potential_targets = getentitiesinradius(self.origin, 256, 15);
    right = anglestoright(self.angles);
    right = vectornormalize(right);
    left = right * -1;

    foreach(zombie in a_potential_targets) {
      if(isalive(zombie) && zombie.team === level.zombie_team) {
        var_6e084471 = vectornormalize(zombie.origin - self.origin);
        rightdot = vectordot(right, var_6e084471);
        leftdot = vectordot(left, var_6e084471);

        if(rightdot <= 0.866025 && rightdot > 0 || leftdot <= 0.866025 && leftdot > 0) {
          damage = zm_equipment::function_379f6b5d(150, undefined, zombie.zm_ai_category, zombie.maxhealth);
          zombie dodamage(damage, zombie.origin, player, player, "torso_upper", "MOD_RIFLE_BULLET");

          if(damage >= zombie.health) {
            level scoreevents::doscoreeventcallback("scoreEventZM", {
              #attacker: player, #scoreevent: # "hash_748d4479ffd0521e", #enemy: zombie
            });
          }
        }
      }

      waitframe(1);
    }

    self waittill(#"mule_kick_fire");
  }
}

function function_c60d9d72() {
  self.use_func = &function_5fd3f2ba;
  self clientfield::set("mule_kick_machine_rob", 1);
}

function perk_machine_setup(use_trigger, perk_machine, bump_trigger, collision) {
  perk_machine.script_sound = "mus_perks_mulekick_jingle";
  perk_machine.script_string = "mule_kick_perk";
  perk_machine.script_label = "mus_perks_mulekick_sting";
  perk_machine.target = "vending_mulekick";
  bump_trigger.script_string = "mule_kick_vending";
  bump_trigger.targetname = "vending_mulekick";

  if(isDefined(collision)) {
    collision.script_string = "mule_kick_perk";
  }
}

function perk_give() {
  var_2c2030 = namespace_e86ffa8::function_30a8ed81(5);

  if(namespace_e86ffa8::function_30a8ed81(3)) {
    self thread function_9335851();
  }

  self thread function_6a6169b2(var_2c2030);
}

function function_6a6169b2(var_2c2030) {
  self endon(#"death");

  while(is_true(self.var_6696e200) || self function_104d7b4d() || self laststand::player_is_in_laststand() || self isswitchingweapons()) {
    waitframe(1);
  }

  var_a6e16638 = gettime();

  while(isDefined(self.laststandpistol) || is_true(self.var_b895a3ff)) {
    if(float(gettime() - var_a6e16638) / 1000 > 2) {
      break;
    }

    waitframe(1);
  }

  if(self namespace_e86ffa8::function_30a8ed81(0)) {
    self item_inventory::function_61b8a91f(1, var_2c2030);
  }
}

function function_6df7ba74(b_pause, str_perk, str_result, n_slot) {
  self endon(#"death");
  self notify(#"hash_73b1e35c66a4e898");
  var_a6e16638 = gettime();

  while(isDefined(self.laststandpistol) || is_true(self.var_b895a3ff)) {
    if(float(gettime() - var_a6e16638) / 1000 > 2) {
      break;
    }

    waitframe(1);
  }

  self item_inventory::function_61b8a91f(0, 1);
}

function function_9335851() {
  self endon(#"disconnect", #"hash_73b1e35c66a4e898");

  while(true) {
    wait 1;
    a_weapons = self getweaponslistprimaries();

    foreach(weapon in a_weapons) {
      w_current = self getcurrentweapon();

      if(w_current == weapon) {
        continue;
      }

      n_clip = self getweaponammoclip(weapon);
      n_clip_size = weapon.clipsize;
      n_stock_size = self getweaponammostock(weapon);

      if(isDefined(n_clip) && isDefined(n_clip_size) && n_clip < n_clip_size) {
        var_8e477029 = int(ceil(n_clip_size * 0.05));

        if(weapon.iscliponly) {
          continue;
        }

        if(n_stock_size >= var_8e477029) {
          self setweaponammoclip(weapon, n_clip + var_8e477029);
          self setweaponammostock(weapon, n_stock_size - var_8e477029);

          if(n_clip + var_8e477029 >= n_clip_size) {
            self playsoundtoplayer(#"hash_1306cd3cf0ce7b64", self);
          }

          continue;
        }

        if(n_stock_size > 0) {
          self setweaponammoclip(weapon, n_clip + 1);
          self setweaponammostock(weapon, n_stock_size - 1);
          self playsoundtoplayer(#"hash_1306cd3cf0ce7b64", self);
        }
      }
    }
  }
}

function function_9ae34cb7() {
  if(namespace_e86ffa8::function_30a8ed81(4)) {
    if(math::cointoss(25)) {
      return true;
    }
  }

  return false;
}