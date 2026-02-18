/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm\perk\zm_perk_juggernaut.gsc
***********************************************/

#using script_3751b21462a54a7d;
#using script_5f261a5d57de5f7c;
#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\player\player_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\visionset_mgr_shared;
#using scripts\zm_common\util;
#using scripts\zm_common\zm_perks;
#using scripts\zm_common\zm_stats;
#using scripts\zm_common\zm_utility;
#namespace zm_perk_juggernaut;

function private autoexec __init__system__() {
  system::register(#"zm_perk_juggernaut", &preinit, undefined, undefined, #"hash_2d064899850813e2");
}

function private preinit() {
  function_485b89e9();
  level.var_8cc294a7 = &function_7486dbf4;
  level.var_bb0b2298 = &function_297a5142;
}

function function_297a5142() {
  if(!isPlayer(self)) {
    return 1;
  }

  if(self namespace_e86ffa8::function_71680faf(4)) {
    return 0.75;
  }

  return 1;
}

function function_7486dbf4(var_2cacdde7) {
  var_2cacdde7 += var_2cacdde7 * 0.25;
  return var_2cacdde7;
}

function function_366a682a(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime) {
  if(self namespace_e86ffa8::function_71680faf(5)) {
    var_b66f2623 = self.health - shitloc;

    if(psoffsettime === "MOD_FALLING" && self namespace_e86ffa8::function_3623f9d1(2)) {
      return shitloc;
    }

    if(var_b66f2623 <= 0 && self.armor > 0) {
      self playsoundtoplayer(#"hash_7bc0e76bd7c09fd0", self);
      self.armor = 0;
      shitloc -= 1 - var_b66f2623;
    }
  }

  return shitloc;
}

function function_485b89e9() {
  zm_perks::register_perk_basic_info(#"hash_47d7a8105237c88", #"perk_juggernog", 2500, #"hash_27b60f868a13cc91", getweapon("zombie_perk_bottle_jugg"), undefined, #"zmperksjuggernaut");
  zm_perks::register_perk_precache_func(#"hash_47d7a8105237c88", &function_166eeafc);
  zm_perks::register_perk_clientfields(#"hash_47d7a8105237c88", &function_370cba1f, &function_a710e34a);
  zm_perks::register_perk_machine(#"hash_47d7a8105237c88", &function_1ff28887, &init_juggernaut);
  zm_perks::register_perk_threads(#"hash_47d7a8105237c88", &function_535de102, &function_8a2f8354);
  zm_perks::register_perk_host_migration_params(#"hash_47d7a8105237c88", "vending_jugg", "jugger_light");
  zm_perks::register_perk_damage_override_func(&function_366a682a);
}

function init_juggernaut() {}

function function_166eeafc() {
  if(isDefined(level.var_7aa19444)) {
    [[level.var_7aa19444]]();
    return;
  }

  level._effect[# "jugger_light"] = "zombie/fx_perk_juggernaut_ndu";
  level.machine_assets[# "hash_47d7a8105237c88"] = spawnStruct();
  level.machine_assets[# "hash_47d7a8105237c88"].weapon = getweapon("zombie_perk_bottle_jugg");
  level.machine_assets[# "hash_47d7a8105237c88"].off_model = "p9_sur_machine_juggernog_off";
  level.machine_assets[# "hash_47d7a8105237c88"].on_model = "p9_sur_machine_juggernog";
}

function function_370cba1f() {}

function function_a710e34a(state) {}

function function_1ff28887(use_trigger, perk_machine, bump_trigger, collision) {
  perk_machine.script_sound = "mus_perks_jugganog_jingle";
  perk_machine.script_string = "jugg_perk";
  perk_machine.script_label = "mus_perks_jugganog_sting";
  perk_machine.var_7619f1b6 = 1;
  perk_machine.target = "vending_jugg";
  bump_trigger.script_string = "jugg_perk";
  bump_trigger.targetname = "vending_jugg";

  if(isDefined(collision)) {
    collision.script_string = "jugg_perk";
  }
}

function function_535de102() {
  if(isPlayer(self) && is_true(getgametypesetting(#"hash_1e8998fd7f271bb7"))) {
    if(self.health < self.var_66cb03ad) {
      self.health = self.var_66cb03ad;
    }
  }
}

function function_8a2f8354(b_pause, str_perk, str_result, n_slot) {}