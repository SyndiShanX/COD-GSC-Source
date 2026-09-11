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
  var0 = [];
  GscBinSkip0(0x2e, "nothing", getdvarfloat("scr_arms_deal_lt_ammo_nothing", 1));
}

function ref_119f7(var0, var1, var2, var3) {
  if(!isDefined(var3)) {
    var3 = 0;
  }

  wait var3;
  var4 = level.ai_event.ref_119fc[var0];
  var2.dropstruct = scripts\mp\gametypes\br_pickups::test_ai_anim();
  var2.dropstruct.ml_p3_to_safehouse_transition = scripts\engine\utility::ter_op(var1 == 1, 6 + randomintrange(1, 10), 6);
  var2.dropstruct.silencer_pick_up_monitor = 0;

  for(var5 = 0; var5 < var1; var5++) {
    var6 = randomfloat(1);

    foreach(var13, var8 in var4) {
      var9 = var8[2];
      var10 = var8[3];

      if(var6 >= var9 && var6 <= var10) {
        var11 = undefined;

        switch (var13) {
          case "nothing":
            return;
          case "brloot_ammo_killer_based":
            if(isDefined(var2)) {
              var12 = weaponclass(var2.eattacker getcurrentweapon());

              switch (var12) {
                case "rifle":
                  var11 = "brloot_ammo_762";
                  break;
                case "mg":
                  var11 = "brloot_ammo_762";
                  break;
                case "pistol":
                  var11 = "brloot_ammo_919";
                  break;
                case "smg":
                  var11 = "brloot_ammo_919";
                  break;
                case "sniper":
                  var11 = "brloot_ammo_50cal";
                  break;
                case "rocketlauncher":
                  var11 = "brloot_ammo_rocket";
                  break;
                case "spread":
                  var11 = "brloot_ammo_12g";
                  break;
              }
            }

            break;
          default:
            var11 = var13;
            break;
        }

        var2.dropstruct.ml_p3_to_safehouse_transition += 2;
        thread ref_119f8(var11, var2);
        wait 0.002;
      }
    }
  }
}

function ref_119f8(var0, var1) {
  if(!isDefined(var0)) {
    return;
  }

  var2 = (0, 0, 0);
  var1.legendary = 0;

  if(issubstr(var0, "lege")) {
    var3 = randomintrange(15, 40);
    var1.dropstruct.ml_p3_to_safehouse_transition = var3;
    var1.legendary = 1;
  }

  switch (var0) {
    case "brloot_access_card_gold_vault_lockbox_3":
      var3 = 0;
      var1.dropstruct.ml_p3_to_safehouse_transition = var3;
      var1.legendary = 1;
      break;
  }

  var4 = scripts\mp\gametypes\br_lootcache::ref_11a41(var0, var1.dropstruct, var1.origin + (0, 0, var1.dropstruct.silencer_pick_up_monitor), var1.angles, 0, var1.legendary, 0);
  var1.dropstruct.silencer_pick_up_monitor += 3;
}

function ref_119e8(var0, var1) {
  var2 = [];
  var3 = 0;

  foreach(var5 in var0) {
    var3 += var5;
  }

  var7 = 0;
  var8 = getarraykeys(var0);
  var9 = undefined;

  foreach(var14, var5 in var0) {
    var2 = [];
    var11 = var5 / var3;

    if(var7 == 0) {
      var12 = 0;
      var13 = var11;
    } else {
      var12 = var9[3];
      var13 = var12 + var11;
    }

    var2 = [var5, var11, var12, var13];
    var9 = var2[var14];
    var7++;
  }

  level.ai_event.ref_119fc[var1] = var2;
}

function ref_12d28(var0, var1, var2, var3) {
  if(!isDefined(var0)) {
    return;
  }

  var4 = var0 scripts\mp\gametypes\br_soa_tower_ai_event::objective_set_hot();

  if(!var4) {
    return;
  }

  if(!isDefined(self.ref_12d29) || self.ref_12d29 != var0) {
    self.ref_12d2a = self.ref_12d29;
    self.ref_12d29 = var0;
  }

  if(!isalive(self) && isDefined(var1) && isDefined(var2)) {
    var5 = 0;
    var5 = scripts\mp\utility\damage::isheadshot(var1, var2, var0);
    self.ref_12d25 = var5 && !self.enemy_left_monitor;
  }

  if(!isalive(self)) {
    if(!isDefined(var0.boardroomopen)) {
      var0.boardroomopen = 1;
    } else {
      var0.boardroomopen += 1;
    }
  }

  if(self.enemy_left_monitor && isalive(self)) {
    if(!isDefined(var0.body0)) {
      var0.body0 = var3;
      return;
    }

    var0.body0 += var3;
    return;
  }
}

function ref_12d22(var0) {
  var1 = undefined;
  var2 = undefined;

  switch (var0) {
    case "takedown":
      if(isDefined(self.ref_12d29)) {
        if(!self.enemy_left_monitor) {
          var1 = scripts\engine\utility::ter_op(self.ref_12d25, "br_soa_tower_reward_kill_agent_headshot", "br_soa_tower_reward_kill_agent");
          var3 = self.is_correct_wire_color.smeansofdeath == "MOD_GRENADE" || self.is_correct_wire_color.smeansofdeath == "MOD_GRENADE_SPLASH";
          var1 = scripts\engine\utility::ter_op(var3, "br_soa_tower_reward_kill_agent_explosive", var1);
          var2 = scripts\mp\rank::getscoreinfovalue(var1);

          if(self.ref_12d29 scripts\mp\gametypes\br_soa_tower_ai_event::objective_origin()) {
            var2 = 1;
          }

          self.ref_12d29 thread scripts\mp\rank::giverankxp(var1, var2);
          self.ref_12d29 thread scripts\mp\rank::scoreeventpopup(var1);

          if(getdvarint("MLNNMOPQOP", 0) == 6) {
            self.ref_12d29 scripts\cp\vehicles\vehicle_compass_cp::ref_12c3f("t9_ch_global_eliminate_enemies_arms_deal_for_s3_5_event_wz", 1);
          }
        } else {
          var1 = "br_soa_tower_reward_kill_brute";
          var2 = scripts\mp\rank::getscoreinfovalue(var1);

          foreach(var5 in level.ai_event.ref_12662) {
            var5 thread scripts\mp\rank::giverankxp(var1, var2);
            var5 thread scripts\mp\rank::scoreeventpopup(var1);

            if(getdvarint("MLNNMOPQOP", 0) == 6) {
              var5 scripts\cp\vehicles\vehicle_compass_cp::ref_12c3f("t9_ch_global_eliminate_enemies_arms_deal_for_s3_5_event_wz", 1);
            }
          }
        }
      }

      break;
    case "assist":
      if(isDefined(self.ref_12d2a) && !self.enemy_left_monitor) {
        var1 = "br_soa_tower_reward_kill_agent_assist";
        var2 = scripts\mp\rank::getscoreinfovalue(var1);

        if(self.ref_12d2a scripts\mp\gametypes\br_soa_tower_ai_event::objective_origin()) {
          var2 = 1;
        }

        self.ref_12d2a thread scripts\mp\rank::giverankxp(var1, var2);
        self.ref_12d2a thread scripts\mp\rank::scoreeventpopup(var1);

        if(getdvarint("MLNNMOPQOP", 0) == 6) {
          self.ref_12d2a scripts\cp\vehicles\vehicle_compass_cp::ref_12c3f("t9_ch_global_eliminate_enemies_arms_deal_for_s3_5_event_wz", 1);
        }
      }

      break;
    case "killing_blow":
      if(isDefined(self.ref_12d29) && self.enemy_left_monitor) {
        var1 = "br_soa_tower_reward_kill_brute_killing_blow";
        var2 = scripts\mp\rank::getscoreinfovalue(var1);

        if(self.ref_12d29 scripts\mp\gametypes\br_soa_tower_ai_event::objective_origin()) {
          var2 = 1;
        }

        self.ref_12d29 thread scripts\mp\rank::giverankxp(var1, var2);
        self.ref_12d29 thread scripts\mp\rank::scoreeventpopup(var1);
      }

      break;
  }
}

function ref_12d21(var0) {
  switch (var0) {
    case "most_agent_kills":
      var1 = scripts\engine\utility::array_sort_with_func(level.ai_event.ref_12662, &ref_12d1f);

      foreach(var3 in var1) {
        if(!isDefined(var3.boardroomopen) || var3.boardroomopen == 0) {
          var1 = scripts\engine\utility::array_remove(var1, var3);
        }
      }

      var5 = var1[0];

      if(!isDefined(var5)) {
        return;
      }

      if(!var5 scripts\mp\gametypes\br_soa_tower_ai_event::objective_set_hot()) {
        return;
      }

      var6 = "br_soa_tower_reward_kill_agent_most_killed";
      var7 = scripts\mp\rank::getscoreinfovalue(var6);
      var5 thread scripts\mp\rank::giverankxp(var6, var7);
      var5 thread scripts\mp\rank::scoreeventpopup(var6);
      scripts\mp\gametypes\br_soa_tower_ai_event::objective_locations_logic(var5, "br_soa_tower_reward_splash_agent_most_killed", var5.boardroomopen);
      break;
    case "most_brute_damage":
      var8 = scripts\engine\utility::array_sort_with_func(level.ai_event.ref_12662, &ref_12d20);

      foreach(var3 in var8) {
        if(!isDefined(var3.body0) || var3.body0 == 0) {
          var8 = scripts\engine\utility::array_remove(var8, var3);
        }
      }

      var5 = var8[0];

      if(!isDefined(var5)) {
        return;
      }

      if(!var5 scripts\mp\gametypes\br_soa_tower_ai_event::objective_set_hot()) {
        return;
      }

      var6 = "br_soa_tower_reward_kill_brute_most_damage";
      var7 = scripts\mp\rank::getscoreinfovalue(var6);
      var5 thread scripts\mp\rank::giverankxp(var6, var7);
      var5 thread scripts\mp\rank::scoreeventpopup(var6);
      scripts\mp\gametypes\br_soa_tower_ai_event::objective_locations_logic(var5, "br_soa_tower_reward_splash_brute_most_damage", var5.body0);
      break;
  }
}

function ref_12d1f(var0, var1) {
  var2 = var0.boardroomopen;
  var3 = var1.boardroomopen;

  if(!isDefined(var2) || !isDefined(var3)) {
    return true;
  }

  return var2 > var3;
}

function ref_12d20(var0, var1) {
  var2 = var0.body0;
  var3 = var1.body0;

  if(!isDefined(var2) || !isDefined(var3)) {
    return true;
  }

  return var2 > var3;
}