/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_4d0e7ced9714e7d4.gsc
***********************************************/

#using script_35ae72be7b4fec10;
#using scripts\abilities\ability_player;
#using scripts\abilities\ability_util;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\colors_shared;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\lui_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\player\player_loadout;
#using scripts\core_common\player\player_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\spawning_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\cp_common\bb;
#using scripts\cp_common\dialog_tree;
#using scripts\cp_common\dialogue;
#using scripts\cp_common\ending;
#using scripts\cp_common\gametypes\save;
#using scripts\cp_common\objectives;
#using scripts\cp_common\objectives_ui;
#using scripts\cp_common\util;
#using scripts\weapons\weapon_utils;
#namespace namespace_ac5221d7;

function function_292592aa(var_50cc0d4f) {
  self flag::wait_till(#"loadout_given");
  self takeallweapons();
  var_9e22157a = getweapon(#"ar_standard_t9", array("stalker"));
  var_d9338b9c = getweapon(#"pistol_semiauto_t9", array("extbarrel", "fastreload"));
  self giveweapon(var_9e22157a);
  self givemaxammo(var_9e22157a);
  self giveweapon(var_d9338b9c);
  self givemaxammo(var_d9338b9c);
  self shoulddoinitialweaponraise(var_9e22157a, 0);
  self switchtoweaponimmediate(var_9e22157a);
}

function function_a22db743(var_50cc0d4f) {
  self flag::wait_till(#"loadout_given");
  self takeallweapons();
  var_9e22157a = getweapon(#"ar_damage_t9", array("scope4x", "stalker", "fastreload", "speedgrip"));
  var_d9338b9c = getweapon(#"sniper_standard_t9", array());
  self giveweapon(var_9e22157a);
  self givemaxammo(var_9e22157a);
  self giveweapon(var_d9338b9c);
  self givemaxammo(var_d9338b9c);
  self switchtoweaponimmediate(var_9e22157a);
}

function private function_5aed5305() {
  grenade = getweapon(#"frag_grenade");

  if(!self hasweapon(grenade)) {
    self giveweapon(grenade);
    self setweaponammoclip(grenade, grenade.maxammo + 2);
    self setweaponammostock(grenade, grenade.maxammo + 2);
  }
}

function function_6f94ced5(a_ents, str_shot) {
  if(isDefined(level.var_deda09e)) {
    switch (level.var_deda09e) {
      case # "lazar":
        if(isDefined(str_shot[# "park"]) && isalive(str_shot[# "park"])) {
          str_shot[# "park"] delete();
        }

        if(isDefined(str_shot[# "lazarshotty"])) {
          str_shot[# "lazarshotty"].targetname = "lazarshotty";
        }

        break;
      case # "park":
        if(isDefined(str_shot[# "lazar"]) && isalive(str_shot[# "lazar"])) {
          str_shot[# "lazar"] delete();
        }

        if(isDefined(str_shot[# "lazarshotty"])) {
          str_shot[# "lazarshotty"] delete();
        }

        break;
    }

    return;
  }

  if(isDefined(str_shot[# "lazar"]) && isalive(str_shot[# "lazar"])) {
    str_shot[# "lazar"] delete();
  }

  if(isDefined(str_shot[# "park"]) && isalive(str_shot[# "park"])) {
    str_shot[# "park"] delete();
  }

  if(isDefined(str_shot[# "lazarshotty"])) {
    str_shot[# "lazarshotty"] delete();
  }
}

function function_ed760ecb(var_a7f24c3d, var_b895b611 = 1, var_d3440450 = level.var_28c22d88[0]) {
  ai = getent(var_a7f24c3d, "targetname", 1);

  if(!isalive(ai)) {
    var_e582d78a = getent(var_a7f24c3d, "targetname");
    ai = spawner::simple_spawn_single(var_e582d78a);
  }

  if(!isDefined(level.allies)) {
    level.allies = [];
  } else if(!isarray(level.allies)) {
    level.allies = array(level.allies);
  }

  if(!isinarray(level.allies, ai)) {
    level.allies[level.allies.size] = ai;
  }

  if(is_true(var_b895b611)) {
    ai function_55623c92(var_d3440450, var_a7f24c3d);
  }

  ai val::set(#"duga", "ignoreme", 1);
  ai setgoal(ai.origin);
  ai.enableterrainik = 1;
  level.(var_a7f24c3d) = ai;
  return ai;
}

function function_55623c92(var_d3440450 = level.var_28c22d88[0], str_name = self.targetname) {
  var_142cfe56 = var_d3440450 + "_" + str_name;
  s_org = struct::get(var_142cfe56, "targetname");

  if(isDefined(s_org)) {
    self forceteleport(s_org.origin, s_org.angles);
    return;
  }

  iprintln("<dev string:x38>" + str_name + "<dev string:x3f>" + level.var_c2ccaeac + "<dev string:x68>");
}

function function_7b37895() {
  if(isDefined(level.var_deda09e)) {
    return level.var_deda09e;
  }
}

function function_cfc94b81(guys, count, flag) {
  ai::waittill_dead_or_dying(guys, count);
  level flag::set(flag);
}

function function_d6fedf97(guys, killcount, sflag, timeout) {
  ai::waittill_dead_or_dying(guys, killcount, timeout);
  level flag::set(sflag);
}

function function_603d935(var_c5827a95, n_goalradius = 200, var_dd47e22 = 0.1, var_27ff9e4 = 0.4) {
  self endon(#"death");

  if(isDefined(self.script_noteworthy) && self.script_noteworthy === "run_to_delete") {
    a_nodes = getnodearraysorted("delete_runner_node", "targetname", self.origin, 2048);

    if(a_nodes.size) {
      self thread ai::force_goal(a_nodes[0], 0);
      self thread ai::bloody_death(randomintrange(2, 5));
      return;
    } else {
      iprintlnbold("<dev string:xa0>");
    }
  }

  e_vol = getent(var_c5827a95, "targetname");
  wait randomfloatrange(var_dd47e22, var_27ff9e4);
  self notify(#"stop_going_to_node");
  self val::set(#"hash_4629ea2949a36bbb", "goalradius", n_goalradius);
  self thread ai::set_goal_ent(e_vol);
  self.ignoresuppression = 1;
  self.grenadeawareness = 0;
  self ai::set_behavior_attribute("sprint", 1);
  self waittill(#"goal");
  self.ignoresuppression = 0;
  self.grenadeawareness = 1;
  self ai::set_behavior_attribute("sprint", 0);
  self val::reset_all(#"hash_4629ea2949a36bbb");
}

function function_f42f6f14() {
  if(self isattached("c_t9_cp_rus_hero_perseus_head2")) {
    self detach("c_t9_cp_rus_hero_perseus_head2");
  }

  if(!self isattached("c_t9_cp_rus_hero_perseus_head2_gasmask")) {
    self attach("c_t9_cp_rus_hero_perseus_head2_gasmask");
  }
}

function function_ae1eba32() {
  namespace_61e6d095::create(#"hash_26ccd69d3e6f3b56", #"hash_28d1565bae3236e");
  namespace_61e6d095::set_color(#"hash_26ccd69d3e6f3b56", 0, 0, 0);
  namespace_61e6d095::function_39710437(#"hash_26ccd69d3e6f3b56", "fullscreen");
  namespace_61e6d095::function_46df0bc7(#"hash_26ccd69d3e6f3b56", 999);
  e_player = getplayers()[0];
  e_player val::set(#"hash_75e1db7c3af8ae06", "freezecontrols", 1);
  e_player val::set(#"hash_383e66ab943657f9", "disable_weapons", 1);
  e_player val::set(#"hash_fa9cf212730562d", "show_hud", 0);

  if(isDefined(level.var_9706ce90) && is_true(level.var_9706ce90)) {
    wait 5;
  }

  e_player unlink();
  e_player setorigin((14960, 9808, 355));
  e_player util::delay(0.1, undefined, &setplayerangles, (0, 90, 0));

  if(function_c9cc889()) {
    level function_7c927add(#"hash_1b59729f98292f0b");
  } else {
    level function_7c927add(#"hash_2b307838febf78c8");
  }

  wait 1;
  level function_7c927add(#"hash_1e0b9df35ce3e723");
  wait 1;
  level ending::function_103cd64c();
}

function function_7c927add(var_ec670c03) {
  if(level.var_3cf0e895[# "hash_23478d403d62c627"] >= 1) {
    return;
  }

  if(isDefined(level.var_b00240a2) && is_true(level.var_b00240a2)) {
    return;
  }

  if(isDefined(var_ec670c03)) {
    level lui::play_movie(var_ec670c03, "fullscreen", 1, 0, 0);
  }
}

function function_c9cc889() {
  return is_true(getplayers()[0].var_fcd1efa7);
}