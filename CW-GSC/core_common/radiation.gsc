/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\radiation.gsc
***********************************************/

#using script_26187575f84f8d07;
#using script_c8d806d2487b617;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\perks;
#using scripts\core_common\radiation_ui;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace radiation;

function private autoexec __init__system__() {
  system::register(#"radiation", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  if(!namespace_956bd4dd::function_ab99e60c()) {
    return;
  }

  level thread function_1e3ac913();
  callback::on_spawned(&_on_player_spawned);
  callback::on_player_killed(&function_9dece272);
  clientfield::register("toplayer", "ftdb_inZone", 1, 1, "int");
}

function private function_3c3e40b6() {
  if(!isDefined(level.radiation)) {
    assertmsg("<dev string:x38>");
    return;
  }

  if(level.radiation.levels.size <= 0) {
    assertmsg("<dev string:x6f>");
    return;
  }

  self.radiation = {};
  self.radiation.var_abd7d46a = level.radiation.levels[0].maxhealth;
  self.radiation.var_32adf91d = 0;
  self.radiation.sickness = [];
  self.radiation.var_393e0e31 = 0;
  self.radiation.var_f1c51b06 = 0;
  self.radiation.var_1389a65a = 0;
}

function private _on_player_spawned() {
  if(!namespace_956bd4dd::function_ab99e60c()) {
    return;
  }

  assert(isPlayer(self));
  self function_3c3e40b6();
}

function private function_9dece272(params) {
  if(!namespace_956bd4dd::function_ab99e60c()) {
    return;
  }

  assert(isPlayer(self));
  self clientfield::set_to_player("ftdb_inZone", 0);
}

function function_c9c6dda1(player) {
  if(!isPlayer(player)) {
    assert(0);
    return;
  }

  return player.radiation.var_32adf91d;
}

function private function_1e3ac913() {
  level endon(#"game_ended");
  updatepass = 0;

  while(true) {
    foreach(index, player in getplayers()) {
      if(index % 10 == updatepass) {
        if(!isDefined(player.radiation)) {
          continue;
        }

        var_56bea7c = 0;

        if(player.sessionstate != "playing" || !isalive(player)) {
          player.radiation.var_abd7d46a = level.radiation.levels[0].maxhealth;
          var_56bea7c = player.radiation.var_32adf91d != 0;
          player.radiation.var_32adf91d = 0;
          player.radiation.var_f1c51b06 = 0;

          if(var_56bea7c) {
            player thread function_6ade1bbf(0);
            player function_3c1f8280();
          }

          continue;
        }

        var_4a68766 = player namespace_b77e8eb1::function_8e4e3bb2();

        if(var_4a68766) {
          player clientfield::set_to_player("ftdb_inZone", 1);
        } else {
          player clientfield::set_to_player("ftdb_inZone", 0);
        }

        var_cad9861a = 0;

        if(var_4a68766) {
          if(gettime() >= player.radiation.var_f1c51b06 + level.var_a6cec0dc) {
            var_2f42039 = 1;

            if(isDefined(level.var_2632202d)) {
              var_2f42039 = player[[level.var_2632202d]]();
            }

            var_cad9861a = level.var_ee660ce0 * (1 + var_2f42039);

            if(isDefined(level.var_c3a003ad)) {
              var_cad9861a = player[[level.var_c3a003ad]](var_cad9861a);
            }

            player.radiation.var_abd7d46a -= var_cad9861a;

            while(player.radiation.var_abd7d46a < 0 && player.radiation.var_32adf91d < level.var_c43aac04) {
              player.radiation.var_32adf91d++;
              player.radiation.var_abd7d46a += level.radiation.levels[player.radiation.var_32adf91d].maxhealth;
              var_56bea7c = 1;
            }

            if(player.radiation.var_abd7d46a < 0) {
              player.radiation.var_abd7d46a = 0;
            }

            if(var_56bea7c) {
              var_76f7b10e = 0;

              if(player.radiation.var_32adf91d == 1) {
                player luinotifyevent(#"hash_7adc508fd96535c9", 0);
                var_76f7b10e = 3.5;
              }

              if(isDefined(level.var_df8a7ea7)) {
                player[[level.var_df8a7ea7]]();
              }

              player thread function_6ade1bbf(var_76f7b10e);
            }

            player function_3c1f8280();
            player.radiation.var_f1c51b06 = gettime();
          }
        }

        if(var_cad9861a <= 0) {
          if(player.radiation.var_32adf91d == 0 && player.radiation.var_abd7d46a >= level.radiation.levels[0].maxhealth) {
            if(is_true(player.var_cfc4949c)) {
              player.var_cfc4949c = undefined;
              player thread function_6ade1bbf(0);
            }

            player function_3c1f8280();
            continue;
          }

          if(gettime() >= player.radiation.var_f1c51b06 + level.var_bb0c0222) {
            var_4a34487 = 0;

            if(isDefined(level.var_11f2d0c5)) {
              var_4a34487 = player[[level.var_11f2d0c5]]();
            }

            healamount = level.var_f569833a * (1 - var_4a34487);
            player.radiation.var_abd7d46a += healamount;

            while(player.radiation.var_32adf91d > 0 && player.radiation.var_abd7d46a > level.radiation.levels[player.radiation.var_32adf91d].maxhealth) {
              player.radiation.var_abd7d46a -= level.radiation.levels[player.radiation.var_32adf91d].maxhealth;
              player.radiation.var_32adf91d--;
              var_56bea7c = 1;
            }

            if(player.radiation.var_abd7d46a > level.radiation.levels[player.radiation.var_32adf91d].maxhealth) {
              player.radiation.var_abd7d46a = level.radiation.levels[player.radiation.var_32adf91d].maxhealth;
            }

            player function_3c1f8280();

            if(var_56bea7c) {
              player thread function_6ade1bbf(0);
            }

            player.radiation.var_f1c51b06 = gettime();
          }
        }

        player function_9b065f90();
      }
    }

    updatepass = (updatepass + 1) % 10;
    waitframe(1);
  }
}

function function_9b065f90() {
  if(self.radiation.var_32adf91d == level.var_4fdf11d8) {
    if(gettime() >= self.radiation.var_1389a65a + level.var_77a24482) {
      self dodamage(level.var_f87355e5, self.origin, undefined, undefined, "none", "MOD_DEATH_CIRCLE", 0, level.weaponnone);
      self.radiation.var_1389a65a = gettime();
    }
  }
}

function function_6ade1bbf(timedelay) {
  self endon(#"death", #"disconnect");
  level endon(#"game_ended");
  wait timedelay;

  if(!isDefined(self.radiation.var_32adf91d)) {
    return;
  }

  if(self.radiation.var_32adf91d == level.var_4fdf11d8) {
    radiation_ui::function_59621e3c(self, #"dot");
  }

  if(self.radiation.var_32adf91d >= 2) {
    self.heal.var_c8777194 = 1;
    self.n_regen_delay = 9;
    radiation_ui::function_59621e3c(self, #"hash_53d8a06b13ec49d9");
  } else {
    self.n_regen_delay = 1;
  }

  if(self.radiation.var_32adf91d >= 1) {
    self cleartalents();
    self perks::perk_reset_all();
    self addtalent(#"specialty_sprint");
    self addtalent(#"specialty_sprintreload");
    self addtalent(#"specialty_forwardspawninteract");
    self addtalent(#"specialty_slide");
    self addtalent(#"specialty_sprintheal");
    self perks::perk_setperk(#"specialty_sprint");
    self perks::perk_setperk(#"specialty_sprintreload");
    self perks::perk_setperk(#"specialty_forwardspawninteract");
    self perks::perk_setperk(#"specialty_slide");
    self perks::perk_setperk(#"specialty_sprintheal");
    radiation_ui::function_59621e3c(self, #"disable_perks");
    return;
  }

  if(isDefined(level.var_eada15e7)) {
    self[[level.var_eada15e7]]();
  }
}

function function_3c1f8280() {
  radiation_ui::function_137e7814(self, self.radiation.var_32adf91d);
  var_60ece81c = level.radiation.levels[self.radiation.var_32adf91d].maxhealth;
  percenthealth = self.radiation.var_abd7d46a / var_60ece81c;
  radiation_ui::function_835a6746(self, percenthealth);
  radiation_ui::function_36a2c924(self, 1 - percenthealth);
}

function private function_770871f5(player) {
  foreach(sickness, var_46bdb64c in player.radiation.sickness) {
    function_f68871f2(player, sickness);
  }
}

function private function_f68871f2(player, sickness) {
  if(!isPlayer(player)) {
    assert(0);
    return;
  }

  if(!ishash(sickness)) {
    assert(0);
    return;
  }

  var_46bdb64c = level.radiation.sickness[sickness];

  if(isDefined(var_46bdb64c.var_dad6905e)) {
    player[[var_46bdb64c.var_dad6905e]]();
  }

  player.radiation.sickness[sickness] = undefined;
  arrayremovevalue(player.radiation.sickness, undefined, 1);
  radiation_ui::function_5cf1c0a(player, sickness);
}