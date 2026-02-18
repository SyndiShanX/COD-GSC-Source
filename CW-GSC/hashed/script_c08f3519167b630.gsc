/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_c08f3519167b630.gsc
***********************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\flag_shared;
#using scripts\zm_common\callbacks;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_zonemgr;
#namespace namespace_c3c0ef6f;

function init() {
  callback::on_spawned(&function_95b24959);
  callback::on_ai_killed(&function_df8c20ce);
  level.var_d8104f84 = 100;
  level.var_2a5adcff = 14;
  level.var_4b8d723f = getent("zone_kill_achievement", "script_noteworthy");
  callback::add_callback(#"crafted_item", &function_a6f7e3da);
}

function function_a6f7e3da() {
  if(self.var_1a69e47f.size >= 14) {
    zm_utility::give_achievement(#"zm_silver_craft");
  }
}

function function_df8c20ce(s_params) {
  e_player = s_params.eattacker;
  weapon = s_params.weapon;
  ai_type = self.aitype;

  if(isPlayer(e_player)) {
    if(!isDefined(e_player.var_f96ce53f)) {
      e_player.var_f96ce53f = 0;
    }

    if(isDefined(weapon) && weapon.inventorytype != # "offhand" && !is_true(e_player.var_df6978da)) {
      if(!is_true(e_player.var_f96ce53f)) {
        if(ai_type === "spawner_zm_steiner_split_radiation_bomb" || ai_type === "spawner_zm_steiner_split_radiation_blast") {
          switch (ai_type) {
            case # "spawner_zm_steiner_split_radiation_bomb":
              e_player.var_287dbab8 = "spawner_zm_steiner_split_radiation_blast";
              break;
            case # "spawner_zm_steiner_split_radiation_blast":
              e_player.var_287dbab8 = "spawner_zm_steiner_split_radiation_bomb";
              break;
          }

          e_player.var_f96ce53f = 1;
          e_player thread function_735fa731();
        }
      } else if(e_player.var_287dbab8 === ai_type) {
        e_player.var_df6978da = 1;
        e_player zm_utility::give_achievement(#"zm_silver_mega");
      }
    }

    if(!isDefined(e_player.kill_count)) {
      e_player.kill_count = 0;
    }

    if(!is_true(e_player.var_12445983)) {
      if(e_player.kill_count < level.var_d8104f84 && e_player istouching(level.var_4b8d723f)) {
        e_player.kill_count++;
      }

      if(e_player.kill_count >= level.var_d8104f84) {
        e_player.var_12445983 = 1;
        e_player zm_utility::give_achievement(#"zm_silver_wing");
      }
    }
  }
}

function function_95b24959() {
  self.var_df6978da = 0;
  self.var_12445983 = 0;
  self.var_d7073519 = 0;

  if(!isDefined(self.var_6616d107)) {
    self.var_6616d107 = 0;
  }

  self thread function_e361ce1b();
  self thread function_ceba8321();
  self thread function_9a4f865b();
  self thread function_f5b265ac();
}

function function_e361ce1b() {
  self endon(#"disconnect");
  level endon(#"end_game");
  level flag::wait_till("pap_quest_completed");
  self zm_utility::give_achievement(#"zm_silver_pap");
}

function function_9a4f865b() {
  self endon(#"disconnect");
  level endon(#"end_game");
  level waittill(#"main_quest_completed");
  self zm_utility::give_achievement(#"zm_silver_pa");
}

function function_ceba8321() {
  self endon(#"disconnect");
  level endon(#"end_game");
  level flag::wait_till("ww_quest_completed");

  self iprintlnbold("<dev string:x38>");

  self zm_utility::give_achievement(#"zm_silver_ww");
}

function function_735fa731() {
  self notify("67ede2be5a74b6a3");
  self endon("67ede2be5a74b6a3");
  self endon(#"end_game", #"disconnect", #"death");
  waitframe(10);
  self.var_f96ce53f = 0;
}

function function_f5b265ac() {
  self endon(#"disconnect");
  level endon(#"end_game");
  var_c9d4ff68 = level.round_number;
  var_84d02e05 = var_c9d4ff68 + 15;
  wait 5;

  while(true) {
    var_a26574af = zm_zonemgr::get_player_zone();

    if(isDefined(var_a26574af)) {
      if(var_a26574af == "zone_proto_start" || var_a26574af == "zone_proto_start2") {
        if(level.round_number >= var_84d02e05) {
          self zm_utility::give_achievement(#"zm_silver_start");
          break;
        }
      } else {
        break;
      }
    }

    wait 1;
  }
}