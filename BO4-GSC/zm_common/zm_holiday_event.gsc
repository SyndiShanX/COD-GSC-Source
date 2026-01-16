/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\zm_holiday_event.gsc
***********************************************/

#include scripts\core_common\array_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\flag_shared;
#include scripts\core_common\spawner_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\zm\weapons\zm_weap_homunculus;
#include scripts\zm_common\zm_loadout;
#include scripts\zm_common\zm_maptable;
#include scripts\zm_common\zm_spawner;
#include scripts\zm_common\zm_transformation;
#include scripts\zm_common\zm_utility;
#include scripts\zm_common\zm_weapons;

#namespace zm_holiday_event;

autoexec __init__system__() {
  system::register(#"zm_holiday_event", &__init__, &__main__, #"zm_loadout");
}

__init__() {
  if(getdvarint(#"zm_holiday_event", 0)) {
    clientfield::register("actor", "" + #"hash_59e8c30d5e28dad3", 14000, 1, "int");
    clientfield::register("scriptmover", "" + #"hash_d260ef4191c5b3d", 14000, 1, "int");
    zm_loadout::register_lethal_grenade_for_level(#"homunculus_leprechaun");
  }
}

__main__() {
  if(getdvarint(#"zm_holiday_event", 0) && zm_utility::is_classic() && !(isDefined(level.var_aa2d5655) && level.var_aa2d5655) && zm_maptable::get_story() == 2) {
    level.w_homunculus_leprechaun = getweapon(#"homunculus_leprechaun");

    if(!isDefined(level.var_fe96a4c4)) {
      level.var_fe96a4c4 = [];
    } else if(!isarray(level.var_fe96a4c4)) {
      level.var_fe96a4c4 = array(level.var_fe96a4c4);
    }

    if(!isinarray(level.var_fe96a4c4, level.w_homunculus_leprechaun)) {
      level.var_fe96a4c4[level.var_fe96a4c4.size] = level.w_homunculus_leprechaun;
    }

    zm_weapons::register_zombie_weapon_callback(level.w_homunculus_leprechaun, &zm_weap_homunculus::function_91b8863c);
    level thread function_e95f47c2();

    level thread devgui();

  }
}

function_e95f47c2() {
  while(true) {
    s_result = level waittill(#"start_of_round");

    if(s_result.n_round_number == 17) {
      level thread function_da29ac13();
      return;
    }
  }
}

function_da29ac13() {
  array::run_all(level.zombie_spawners, &spawner::add_spawn_function, &function_e12bc077);
  zm_spawner::register_zombie_death_event_callback(&function_cfe06357);
  level waittill(#"shamrock_finished");
  array::run_all(level.zombie_spawners, &spawner::remove_spawn_function, &function_e12bc077);
  zm_spawner::deregister_zombie_death_event_callback(&function_cfe06357);
}

function_e12bc077() {
  if(isDefined(level.var_17bf15ba) || isDefined(level.var_c94d8a40) && level.var_c94d8a40 || self.archetype !== #"zombie") {
    return;
  }

  if(randomint(100) < 100) {
    level.var_17bf15ba = self;
    zm_transform::function_5db4f2f5(self, 1);

    while(isalive(self) && !self clientfield::get("zombie_eye_glow")) {
      wait 1;
    }

    if(isalive(self)) {
      self clientfield::set("" + #"hash_59e8c30d5e28dad3", 1);
      return;
    }

    level.var_17bf15ba = undefined;
  }
}

function_cfe06357(attacker) {
  if(!isDefined(level.var_17bf15ba) || self != level.var_17bf15ba) {
    return;
  }

  level.var_17bf15ba clientfield::set("" + #"hash_59e8c30d5e28dad3", 0);

  if(isplayer(attacker) && !(isDefined(attacker.var_ccd959e1) && attacker.var_ccd959e1)) {
    if(!isDefined(level.var_1cd9760e)) {
      level.var_1cd9760e = attacker;
    }

    if(attacker == level.var_1cd9760e) {
      self function_a33a15c();
    } else {
      level function_1443aaa();
    }
  }

  level.var_17bf15ba = undefined;
}

function_a33a15c() {
  if(!isDefined(level.var_d64e4374)) {
    level.var_d64e4374 = 0;
  }

  level.var_d64e4374++;

  if(isDefined(level.var_fa38e985) && level.var_fa38e985) {
    iprintlnbold("<dev string:x38>" + level.var_d64e4374 + "<dev string:x51>" + 7);
  }

    if(level.var_d64e4374 >= 7) {
      self thread function_ded808d5();
      level thread function_4634a866();
      level.var_1cd9760e function_efe5c28();
      level function_1443aaa(1);
      return;
    }

  level thread function_23287dd();
}

function_23287dd() {
  if(!isDefined(level.var_23d44713)) {
    level.var_23d44713 = util::spawn_model("tag_origin", level.var_17bf15ba.origin + (0, 0, 60));
    level.var_23d44713 clientfield::set("" + #"hash_d260ef4191c5b3d", 1);
    level.var_c94d8a40 = 1;
  }

  a_ai_zombies = getaiteamarray(level.zombie_team);
  a_ai_zombies = array::randomize(a_ai_zombies);

  foreach(ai_zombie in a_ai_zombies) {
    if(ai_zombie.archetype === #"zombie" && ai_zombie !== level.var_17bf15ba) {
      n_move_time = 1.5;
      zm_transform::function_5db4f2f5(ai_zombie, 1);

      while(isalive(ai_zombie)) {
        if(100 > distancesquared(ai_zombie.origin + (0, 0, 60), level.var_23d44713.origin)) {
          break;
        }

        level.var_23d44713 moveto(ai_zombie.origin + (0, 0, 60), n_move_time);
        wait 0.1;

        if(n_move_time > 0.1) {
          n_move_time -= 0.1;
        }
      }

      if(isalive(ai_zombie)) {
        level.var_23d44713.origin = ai_zombie.origin + (0, 0, 60);

        while(isalive(ai_zombie) && !ai_zombie clientfield::get("zombie_eye_glow")) {
          wait 1;
        }

        if(isalive(ai_zombie)) {
          level.var_23d44713 playSound(#"zmb_sq_souls_impact");
          ai_zombie clientfield::set("" + #"hash_59e8c30d5e28dad3", 1);
          level.var_17bf15ba = ai_zombie;
        } else {
          level thread function_23287dd();
          return;
        }
      } else {
        level thread function_23287dd();
        return;
      }

      level.var_c94d8a40 = undefined;

      if(isDefined(level.var_23d44713)) {
        level.var_23d44713 delete();
      }

      return;
    }
  }

  level function_1443aaa();
}

function_1443aaa(b_success = 0) {

  if(isDefined(level.var_fa38e985) && level.var_fa38e985 && !b_success) {
    if(!isDefined(level.var_d64e4374)) {
      level.var_d64e4374 = 0;
    }

    iprintlnbold("<dev string:x55>" + level.var_d64e4374 + "<dev string:x51>" + 7 + "<dev string:x74>");
  }

    level.var_17bf15ba = undefined;
  level.var_1cd9760e = undefined;
  level.var_d64e4374 = undefined;
  level.var_c94d8a40 = undefined;

  if(isDefined(level.var_23d44713)) {
    level.var_23d44713 delete();
  }
}

function_ded808d5() {
  mdl_soul = util::spawn_model("tag_origin", self.origin + (0, 0, 60));
  mdl_soul clientfield::set("" + #"hash_d260ef4191c5b3d", 1);
  n_move_dist = 10;

  for(i = 0; i < 6; i++) {
    mdl_soul movez(n_move_dist, 0.1);
    mdl_soul waittill(#"movedone");
    n_move_dist *= -1;
  }

  mdl_soul movez(9999, 4);
  mdl_soul waittill(#"movedone");
  mdl_soul delete();
}

function_4634a866() {
  if(isDefined(level.var_47cc5401) && level.var_47cc5401) {
    return;
  }

  level.var_47cc5401 = 1;
  level flag::wait_till("magicbox_initialized");
  level._effect[#"hash_2ff87d61167ea531"] = #"hash_4bd4c9b0fb97f425";
  level._effect[#"hash_21167096dfea3409"] = #"hash_4bd4c9b0fb97f425";

  foreach(s_chest in level.chests) {
    if(isDefined(s_chest.pandora_light)) {
      s_chest.pandora_light delete();
      s_chest thread[[level.pandora_show_func]]();
    }

    wait 0.1;
  }
}

function_efe5c28() {
  self.var_c21099c0 = 1;
  self.var_16fc6934 = level.w_homunculus_leprechaun;
  self.var_61c96978 = &function_55f8e11e;
  self.var_ccd959e1 = 1;

  foreach(e_player in getplayers()) {
    if(!(isDefined(e_player.var_ccd959e1) && e_player.var_ccd959e1)) {
      return;
    }
  }

  level notify(#"shamrock_finished");
}

function_55f8e11e(e_box) {
  self endon(#"death");
  e_box waittill(#"randomization_done");
  a_str_lines = array(#"hash_2f00ed381261784b", #"hash_2f00ec3812617698", #"hash_2f00ef3812617bb1");
  playsoundatposition(array::random(a_str_lines), e_box.origin);
  self.var_c21099c0 = 0;
  self.var_16fc6934 = undefined;
  self.var_61c96978 = undefined;
}

private devgui() {
  adddebugcommand("<dev string:x7d>");
  adddebugcommand("<dev string:xf2>");
  adddebugcommand("<dev string:x161>");
  adddebugcommand("<dev string:x1e0>");

  while(true) {
    waitframe(1);
    str_command = getdvarstring(#"hash_83ca4038b5f2453", "<dev string:x24d>");

    switch (str_command) {
      case #"green_eyes":
        level thread function_705afbf2();
        break;
      case #"transfer_soul":
        level thread function_cf9e485();
        break;
      case #"hash_9411b0f797691e1":
        level thread function_74441f15();
        break;
      case #"toggle_debug":
        if(!isDefined(level.var_fa38e985)) {
          level.var_fa38e985 = 1;
        } else {
          level.var_fa38e985 = undefined;
        }

        break;
      default:
        break;
    }

    setdvar(#"hash_83ca4038b5f2453", "<dev string:x24d>");
  }
}

function_705afbf2() {
  a_ai_zombies = getaiteamarray(level.zombie_team);
  e_host = getplayers()[0];

  if(!isalive(e_host)) {
    return;
  }

  a_ai_zombies = arraysortclosest(a_ai_zombies, e_host.origin);

  foreach(ai_zombie in a_ai_zombies) {
    if(ai_zombie.archetype === #"zombie") {
      ai_zombie clientfield::set("<dev string:x24d>" + #"hash_59e8c30d5e28dad3", 1);
      level.var_17bf15ba = ai_zombie;
      return;
    }
  }
}

function_cf9e485() {
  if(!isDefined(level.var_17bf15ba)) {
    return;
  }

  function_23287dd();
}

function_74441f15() {
  level thread function_4634a866();

  foreach(player in util::get_players()) {
    player thread function_efe5c28();
  }
}

