/*********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_soa_tower_rewards.gsc
*********************************************************/

function init() {
  thread ref_119f0();
}

function ref_119f0() {
  level.ai_event.ref_119fc = [];
  level.ai_event.ref_12d26 = [];
  level._effect["vfx_golden_loot_explosion_flare"] = loadfx("vfx/iw8_br/gameplay/vfx_golden_loot_explosion_flare");
  level._effect["vfx_br_legendary_loot_glow"] = loadfx("vfx/iw8_br/gameplay/vfx_br_launch_code_glow");
  ref_119f2();
}

function ref_119f2() {
  var_0 = [];
  GscBinSkip0(0x2e, "nothing", getdvarfloat("scr_arms_deal_lt_ammo_nothing", 1));
}

function ref_119f7(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3)) {
    var_3 = 0;
  }

  wait var_3;
  var_4 = level.ai_event.ref_119fc[var_0];
  var_2.dropstruct = scripts\mp\gametypes\br_pickups::test_ai_anim();
  var_2.dropstruct.ml_p3_to_safehouse_transition = scripts\engine\utility::ter_op(var_1 == 1, 6 + randomintrange(1, 10), 6);
  var_2.dropstruct.silencer_pick_up_monitor = 0;

  for(var_5 = 0; var_5 < var_1; var_5++) {
    var_6 = randomfloat(1);

    foreach(var_13, var_8 in var_4) {
      var_9 = var_8[2];
      var_10 = var_8[3];

      if(var_6 >= var_9 && var_6 <= var_10) {
        var_11 = undefined;

        switch (var_13) {
          case "nothing":
            return;
          case "brloot_ammo_killer_based":
            if(isDefined(var_2)) {
              var_12 = weaponclass(var_2.eattacker getcurrentweapon());

              switch (var_12) {
                case "rifle":
                  var_11 = "brloot_ammo_762";
                  break;
                case "mg":
                  var_11 = "brloot_ammo_762";
                  break;
                case "pistol":
                  var_11 = "brloot_ammo_919";
                  break;
                case "smg":
                  var_11 = "brloot_ammo_919";
                  break;
                case "sniper":
                  var_11 = "brloot_ammo_50cal";
                  break;
                case "rocketlauncher":
                  var_11 = "brloot_ammo_rocket";
                  break;
                case "spread":
                  var_11 = "brloot_ammo_12g";
                  break;
              }
            }

            break;
          default:
            var_11 = var_13;
            break;
        }

        var_2.dropstruct.ml_p3_to_safehouse_transition += 2;
        thread ref_119f8(var_11, var_2);
        wait 0.002;
      }
    }
  }
}

function ref_119f8(var_0, var_1) {
  if(!isDefined(var_0)) {
    return;
  }

  var_2 = (0, 0, 0);
  var_1.legendary = 0;

  if(issubstr(var_0, "lege")) {
    var_3 = randomintrange(15, 40);
    var_1.dropstruct.ml_p3_to_safehouse_transition = var_3;
    var_1.legendary = 1;
  }

  switch (var_0) {
    case "brloot_access_card_gold_vault_lockbox_3":
      var_3 = 0;
      var_1.dropstruct.ml_p3_to_safehouse_transition = var_3;
      var_1.legendary = 1;
      break;
  }

  var_4 = scripts\mp\gametypes\br_lootcache::ref_11a41(var_0, var_1.dropstruct, var_1.origin + (0, 0, var_1.dropstruct.silencer_pick_up_monitor), var_1.angles, 0, var_1.legendary, 0);
  var_1.dropstruct.silencer_pick_up_monitor += 3;
}

function ref_119e8(var_0, var_1) {
  var_2 = [];
  var_3 = 0;

  foreach(var_5 in var_0) {
    var_3 += var_5;
  }

  var_7 = 0;
  var_8 = getarraykeys(var_0);
  var_9 = undefined;

  foreach(var_14, var_5 in var_0) {
    var_2 = [];
    var_11 = var_5 / var_3;

    if(var_7 == 0) {
      var_12 = 0;
      var_13 = var_11;
    } else {
      var_12 = var_9[3];
      var_13 = var_12 + var_11;
    }

    var_2 = [var_5, var_11, var_12, var_13];
    var_9 = var_2[var_14];
    var_7++;
  }

  level.ai_event.ref_119fc[var_1] = var_2;
}

function ref_12d28(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_0)) {
    return;
  }

  var_4 = var_0 scripts\mp\gametypes\br_soa_tower_ai_event::objective_set_hot();

  if(!var_4) {
    return;
  }

  if(!isDefined(self.ref_12d29) || self.ref_12d29 != var_0) {
    self.ref_12d2a = self.ref_12d29;
    self.ref_12d29 = var_0;
  }

  if(!isalive(self) && isDefined(var_1) && isDefined(var_2)) {
    var_5 = 0;
    var_5 = scripts\mp\utility\damage::isheadshot(var_1, var_2, var_0);
    self.ref_12d25 = var_5 && !self.enemy_left_monitor;
  }

  if(!isalive(self)) {
    if(!isDefined(var_0.boardroomopen)) {
      var_0.boardroomopen = 1;
    } else {
      var_0.boardroomopen += 1;
    }
  }

  if(self.enemy_left_monitor && isalive(self)) {
    if(!isDefined(var_0.body0)) {
      var_0.body0 = var_3;
      return;
    }

    var_0.body0 += var_3;
    return;
  }
}

function ref_12d22(var_0) {
  var_1 = undefined;
  var_2 = undefined;

  switch (var_0) {
    case "takedown":
      if(isDefined(self.ref_12d29)) {
        if(!self.enemy_left_monitor) {
          var_1 = scripts\engine\utility::ter_op(self.ref_12d25, "br_soa_tower_reward_kill_agent_headshot", "br_soa_tower_reward_kill_agent");
          var_3 = self.is_correct_wire_color.smeansofdeath == "MOD_GRENADE" || self.is_correct_wire_color.smeansofdeath == "MOD_GRENADE_SPLASH";
          var_1 = scripts\engine\utility::ter_op(var_3, "br_soa_tower_reward_kill_agent_explosive", var_1);
          var_2 = scripts\mp\rank::getscoreinfovalue(var_1);

          if(self.ref_12d29 scripts\mp\gametypes\br_soa_tower_ai_event::objective_origin()) {
            var_2 = 1;
          }

          self.ref_12d29 thread scripts\mp\rank::giverankxp(var_1, var_2);
          self.ref_12d29 thread scripts\mp\rank::scoreeventpopup(var_1);

          if(getdvarint("MLNNMOPQOP", 0) == 6) {
            self.ref_12d29 scripts\cp\vehicles\vehicle_compass_cp::ref_12c3f("t9_ch_global_eliminate_enemies_arms_deal_for_s3_5_event_wz", 1);
          }
        } else {
          var_1 = "br_soa_tower_reward_kill_brute";
          var_2 = scripts\mp\rank::getscoreinfovalue(var_1);

          foreach(var_5 in level.ai_event.ref_12662) {
            var_5 thread scripts\mp\rank::giverankxp(var_1, var_2);
            var_5 thread scripts\mp\rank::scoreeventpopup(var_1);

            if(getdvarint("MLNNMOPQOP", 0) == 6) {
              var_5 scripts\cp\vehicles\vehicle_compass_cp::ref_12c3f("t9_ch_global_eliminate_enemies_arms_deal_for_s3_5_event_wz", 1);
            }
          }
        }
      }

      break;
    case "assist":
      if(isDefined(self.ref_12d2a) && !self.enemy_left_monitor) {
        var_1 = "br_soa_tower_reward_kill_agent_assist";
        var_2 = scripts\mp\rank::getscoreinfovalue(var_1);

        if(self.ref_12d2a scripts\mp\gametypes\br_soa_tower_ai_event::objective_origin()) {
          var_2 = 1;
        }

        self.ref_12d2a thread scripts\mp\rank::giverankxp(var_1, var_2);
        self.ref_12d2a thread scripts\mp\rank::scoreeventpopup(var_1);

        if(getdvarint("MLNNMOPQOP", 0) == 6) {
          self.ref_12d2a scripts\cp\vehicles\vehicle_compass_cp::ref_12c3f("t9_ch_global_eliminate_enemies_arms_deal_for_s3_5_event_wz", 1);
        }
      }

      break;
    case "killing_blow":
      if(isDefined(self.ref_12d29) && self.enemy_left_monitor) {
        var_1 = "br_soa_tower_reward_kill_brute_killing_blow";
        var_2 = scripts\mp\rank::getscoreinfovalue(var_1);

        if(self.ref_12d29 scripts\mp\gametypes\br_soa_tower_ai_event::objective_origin()) {
          var_2 = 1;
        }

        self.ref_12d29 thread scripts\mp\rank::giverankxp(var_1, var_2);
        self.ref_12d29 thread scripts\mp\rank::scoreeventpopup(var_1);
      }

      break;
  }
}

function ref_12d21(var_0) {
  switch (var_0) {
    case "most_agent_kills":
      var_1 = scripts\engine\utility::array_sort_with_func(level.ai_event.ref_12662, &ref_12d1f);

      foreach(var_3 in var_1) {
        if(!isDefined(var_3.boardroomopen) || var_3.boardroomopen == 0) {
          var_1 = scripts\engine\utility::array_remove(var_1, var_3);
        }
      }

      var_5 = var_1[0];

      if(!isDefined(var_5)) {
        return;
      }

      if(!var_5 scripts\mp\gametypes\br_soa_tower_ai_event::objective_set_hot()) {
        return;
      }

      var_6 = "br_soa_tower_reward_kill_agent_most_killed";
      var_7 = scripts\mp\rank::getscoreinfovalue(var_6);
      var_5 thread scripts\mp\rank::giverankxp(var_6, var_7);
      var_5 thread scripts\mp\rank::scoreeventpopup(var_6);
      scripts\mp\gametypes\br_soa_tower_ai_event::objective_locations_logic(var_5, "br_soa_tower_reward_splash_agent_most_killed", var_5.boardroomopen);
      break;
    case "most_brute_damage":
      var_8 = scripts\engine\utility::array_sort_with_func(level.ai_event.ref_12662, &ref_12d20);

      foreach(var_3 in var_8) {
        if(!isDefined(var_3.body0) || var_3.body0 == 0) {
          var_8 = scripts\engine\utility::array_remove(var_8, var_3);
        }
      }

      var_5 = var_8[0];

      if(!isDefined(var_5)) {
        return;
      }

      if(!var_5 scripts\mp\gametypes\br_soa_tower_ai_event::objective_set_hot()) {
        return;
      }

      var_6 = "br_soa_tower_reward_kill_brute_most_damage";
      var_7 = scripts\mp\rank::getscoreinfovalue(var_6);
      var_5 thread scripts\mp\rank::giverankxp(var_6, var_7);
      var_5 thread scripts\mp\rank::scoreeventpopup(var_6);
      scripts\mp\gametypes\br_soa_tower_ai_event::objective_locations_logic(var_5, "br_soa_tower_reward_splash_brute_most_damage", var_5.body0);
      break;
  }
}

function ref_12d1f(var_0, var_1) {
  var_2 = var_0.boardroomopen;
  var_3 = var_1.boardroomopen;

  if(!isDefined(var_2) || !isDefined(var_3)) {
    return true;
  }

  return var_2 > var_3;
}

function ref_12d20(var_0, var_1) {
  var_2 = var_0.body0;
  var_3 = var_1.body0;

  if(!isDefined(var_2) || !isDefined(var_3)) {
    return true;
  }

  return var_2 > var_3;
}