/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\zm_mansion_achievements.gsc
***********************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\flagsys_shared;
#include scripts\zm_common\zm_utility;

#namespace mansion_achievements;

init() {
  level thread function_51e43f4f();
  level thread function_f4b6212();
  level thread function_c91cfd5a();
  level thread function_a46f4413();
  callback::on_connect(&on_player_connect);
  callback::on_player_damage(&on_player_damage);
  callback::on_ai_killed(&on_ai_killed);
}

on_player_connect() {
  self thread function_51328dc2();
  self thread function_783dcd31();
  self thread function_87a4fba4();
  self thread bend19_animate_ta();
  self thread function_dd592c16();
  self thread function_18c92a4f();
}

on_player_damage(params) {
  if(isDefined(params.einflictor) && isDefined(params.einflictor.subarchetype)) {
    var_e72cb811 = params.einflictor.subarchetype;
  }

  if(isDefined(params.einflictor) && isDefined(params.einflictor.str_current_anim)) {
    str_current_anim = params.einflictor.str_current_anim;
  }

  if(var_e72cb811 === #"crimson_nosferatu" && str_current_anim === #"hash_30a3ae992c453f0c") {
    self notify(#"hash_6938bc311a1a893e");
  }
}

on_ai_killed(params) {
  e_attacker = params.eattacker;

  if(isplayer(e_attacker)) {
    if(self.archetype == #"nosferatu") {
      str_zone = self zm_utility::get_current_zone();

      if(isDefined(params.weapon) && isDefined(params.weapon.name)) {
        str_weapon = params.weapon.name;
      }

      if(str_zone === "zone_dining_room" && str_weapon === #"stake_knife") {
        e_attacker notify(#"hash_4505abb76e48700a");
      }

      return;
    }

    if(self.archetype == #"werewolf") {
      str_zone = self zm_utility::get_current_zone();

      if(isDefined(params.weapon) && isDefined(params.weapon.name)) {
        str_weapon = params.weapon.name;
      }

      a_revolvers = array(#"pistol_topbreak_t8", #"pistol_topbreak_t8_upgraded", #"pistol_revolver_t8", #"pistol_revolver_t8_gold", #"pistol_revolver_t8_upgraded", #"ww_random_ray_gun1", #"ww_random_ray_gun2", #"ww_random_ray_gun2_charged", #"ww_random_ray_gun3", #"ww_random_ray_gun3_charged");

      if(str_zone === "zone_library" && isDefined(str_weapon) && isinarray(a_revolvers, str_weapon)) {
        e_attacker notify(#"hash_1ac06d8c0149a66c");
      }
    }
  }
}

function_51e43f4f() {
  level endon(#"end_game");
  level flagsys::wait_till(#"hash_25d8c88ff3f91ee5");

  iprintlnbold("<dev string:x38>");

    zm_utility::giveachievement_wrapper("ZM_MANSION_ARTIFACT", 1);
}

function_783dcd31() {
  level endon(#"end_game");
  self endon(#"disconnect");
  self waittill(#"hash_4505abb76e48700a");

  iprintlnbold("<dev string:x57>" + self getentnum());

    self zm_utility::giveachievement_wrapper("ZM_MANSION_STAKE", 0);
}

function_87a4fba4() {
  level endon(#"end_game");
  self endon(#"disconnect");
  self waittill(#"hash_1ac06d8c0149a66c");

  iprintlnbold("<dev string:x7b>" + self getentnum());

    self zm_utility::giveachievement_wrapper("ZM_MANSION_BOARD", 0);
}

function_51328dc2() {
  level endon(#"end_game");
  self endon(#"disconnect");
  self waittill(#"hash_6938bc311a1a893e");

  iprintlnbold("<dev string:xa1>" + self getentnum());

    self zm_utility::giveachievement_wrapper("ZM_MANSION_BITE", 0);
}

function_f4b6212() {
  level endon(#"end_game", #"hash_691d769f8aa3dcbd");
  level waittill(#"hash_3464fd1132f34721");

  iprintlnbold("<dev string:xc5>");

    zm_utility::giveachievement_wrapper("ZM_MANSION_QUICK", 1);
}

function_c91cfd5a() {
  level endon(#"end_game");

  for(var_532a9491 = 0; var_532a9491 < 3; var_532a9491++) {
    level waittill(#"hash_144b3192f03325f3");
  }

  iprintlnbold("<dev string:xe3>");

    zm_utility::giveachievement_wrapper("ZM_MANSION_ALCHEMICAL", 1);
}

function_a46f4413() {
  level endon(#"end_game");
  level.var_f5ad5bac = 0;
  level thread function_8dc740fa("zblueprint_mansion_silver_molten");
  level thread function_8dc740fa("zblueprint_mansion_ww_lvl2");
  level thread function_8dc740fa("zblueprint_chaos_lvl3");
  level thread function_8dc740fa("zblueprint_shield_dual_wield");
  level thread function_8dc740fa("zblueprint_mansion_silver_bullet");
  level thread function_8dc740fa("zblueprint_mansion_a_skeet_fink");

  while(true) {
    level waittill(#"crafting_table_completed");

    if(level.var_f5ad5bac >= 6) {

      iprintlnbold("<dev string:x102>");

        zm_utility::giveachievement_wrapper("ZM_MANSION_CRAFTING", 1);
      break;
    }
  }
}

function_8dc740fa(str_blueprint) {
  while(true) {
    waitresult = level waittill(#"blueprint_completed");

    if(waitresult.blueprint.name === str_blueprint) {
      level.var_f5ad5bac++;
      level notify(#"crafting_table_completed");
      break;
    }
  }
}

bend19_animate_ta() {
  level endon(#"end_game");
  self endon(#"disconnect");
  self waittill(#"hash_510f9114e7a6300c");

  iprintlnbold("<dev string:x123>" + self getentnum());

    self zm_utility::giveachievement_wrapper("ZM_MANSION_SHOCKING", 0);
}

function_dd592c16() {
  level endon(#"end_game");
  self endon(#"disconnect");
  self waittill(#"hash_305ca852d958a7e1");

  iprintlnbold("<dev string:x152>" + self getentnum());

    self zm_utility::giveachievement_wrapper("ZM_MANSION_CLOCK", 0);
}

function_18c92a4f() {
  level endon(#"end_game");
  self endon(#"disconnect");
  self waittill(#"hash_148a0d55a59ee6a3");

  iprintlnbold("<dev string:x16f>" + self getentnum());

    self zm_utility::giveachievement_wrapper("ZM_MANSION_SHRINKING", 0);
}