/*************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\mp_zombie_descent_ee_side.gsc
*************************************************/

func_00D5() {
  thread classic_init();
  thread tower_deflect_init();
  thread grenade_hole_init();
  thread ravens();
  thread dark_passenger_init();
  thread sewers_init();
}

_______________________classic_______________________() {}

classic_debug_init() {}

classic_init() {
  level.currentclassicdifficultylevel = 1;
  level.maxclassicdifficultylevel = 3;
  level.classicfails = 0;
  var_00 = common_scripts\utility::func_46B7("classic_corpse_object", "targetname");
  foreach(var_02 in var_00) {
    var_02 thread classic_setup_corpse();
  }

  thread classic_run_on_puzzle_start();
  thread classic_wait_for_jolts();
  thread classic_debug_init();
}

classic_run_on_puzzle_start(param_00, param_01) {
  if(!isDefined(param_00)) {
    param_00 = 0;
  }

  if(!param_00) {
    param_01 = level common_scripts\utility::func_A715("team_classic_start", "team_vintage_start");
  }

  if(param_01 == "team_classic_start") {
    var_02 = common_scripts\utility::func_46B7("classic_teamone_eyeglow", "targetname");
    foreach(var_04 in var_02) {
      var_04 thread classic_eye_flicker("blueGlow");
    }
  } else if(param_01 == "team_vintage_start") {
    var_02 = common_scripts\utility::func_46B7("classic_teamtwo_eyeglow", "targetname");
    foreach(var_04 in var_02) {
      var_04 thread classic_eye_flicker("redGlow");
    }
  }

  wait(3);
  var_08 = common_scripts\utility::func_46B7("classic_corpse_object_minion", "targetname");
  foreach(var_0A in var_08) {
    if(!isDefined(var_0A.eyeglow)) {
      var_0A.eyeglow = [];
    }

    var_0B = undefined;
    var_0C = undefined;
    if(var_0A.var_8260 == "team_classic") {
      var_0B = "team_classic_start";
      var_0C = "blueGlow";
    } else if(var_0A.var_8260 == "team_vintage") {
      var_0B = "team_vintage_start";
      var_0C = "redGlow";
    }

    if(isDefined(var_0B)) {
      var_0A.allyteam = var_0B;
      var_0A.eyes = common_scripts\utility::func_46B7(var_0A.var_1A2, "targetname");
      for(var_0D = 0; var_0D < var_0A.eyes.size; var_0D++) {
        if(!isDefined(var_0A.eyeglow[var_0D])) {
          var_0E = spawnfx(common_scripts\utility::func_44F5(var_0C), var_0A.eyes[var_0D].var_116);
          var_0A.eyeglow[var_0D] = var_0E;
          triggerfx(var_0E);
        }
      }
    }
  }

  thread classic_minion_eye_counter(param_01);
}

classic_minion_eye_counter(param_00) {
  for(;;) {
    var_01 = level common_scripts\utility::func_A715("classic_level_complete", "classic_fail_notify");
    thread classic_minion_glow_remove(var_01, param_00);
  }
}

classic_minion_glow_remove(param_00, param_01) {
  var_02 = common_scripts\utility::func_46B7("classic_corpse_object_minion", "targetname");
  if(param_00 == "classic_level_complete") {
    foreach(var_04 in var_02) {
      if(var_04.allyteam != param_01 && isDefined(var_04.eyeglow) && var_04.eyeglow.size > 0) {
        foreach(var_06 in var_04.eyeglow) {
          var_04.eyeglow = common_scripts\utility::func_F93(var_04.eyeglow, var_06);
          var_06 delete();
        }

        break;
      }
    }

    return;
  }

  if(param_00 == "classic_fail_notify") {
    foreach(var_04 in var_02) {
      if(var_04.allyteam == param_01 && isDefined(var_04.eyeglow) && var_04.eyeglow.size > 0) {
        foreach(var_06 in var_04.eyeglow) {
          var_04.eyeglow = common_scripts\utility::func_F93(var_04.eyeglow, var_06);
          var_06 delete();
        }

        break;
      }
    }
  }
}

classic_reset(param_00) {
  level.currentclassicdifficultylevel = 1;
  level.classicfails = 0;
  thread classic_run_on_puzzle_start(1, param_00);
}

classic_setup_corpse() {
  var_00 = common_scripts\utility::func_44BE(self.var_1A2, "targetname");
  foreach(var_02 in var_00) {
    if(!isDefined(self.eyefxorg)) {
      self.eyefxorg = [];
    }

    switch (var_02.var_165) {
      case "eye_glow_struct":
        self.eyefxorg[self.eyefxorg.size] = var_02;
        break;

      case "classic_head":
        self.color = var_02;
        self.color.upposition = self.color.var_116;
        self.color.downposition = self.color.var_116 - (0, 0, 16);
        self.color setCanDamage(1);
        self.color.var_BC = 1000000;
        break;

      case "classic_body":
        self.var_18A8 = var_02;
        self.var_18A8.upposition = self.var_18A8.var_116;
        self.var_18A8.downposition = self.var_18A8.var_116 - (0, 0, 16);
        break;
    }
  }
}

classic_wait_for_jolts() {
  var_00 = getent("classic_jolt_drop_trigger_teamone", "targetname");
  var_01 = getent("classic_jolt_drop_trigger_teamtwo", "targetname");
  var_02 = undefined;
  var_03 = undefined;
  for(;;) {
    level waittill("spawned_money_share");
    foreach(var_05 in level.var_8AD2) {
      var_06 = 0;
      if(var_00 method_858B(var_05.var_116)) {
        var_06 = 1;
        if(lib_0547::func_5565(var_02, "teamVintage")) {
          continue;
        }

        var_02 = "teamClassic";
        var_03 = var_00;
        level notify("team_classic_start");
      }

      if(var_01 method_858B(var_05.var_116)) {
        var_06 = 1;
        if(lib_0547::func_5565(var_02, "teamClassic")) {
          continue;
        }

        var_02 = "teamVintage";
        var_03 = var_01;
        level notify("team_vintage_start");
      }

      if(!isDefined(var_02)) {
        continue;
      }

      if(!var_06) {
        continue;
      }

      var_07 = var_05.var_117;
      var_08 = var_07 getentitynumber();
      var_05 maps\mp\zombies\_zombies_money::func_8ADD(var_08, 0);
      var_05.var_6FD4 = 0;
      var_05.var_6FCB = 0;
      thread classic_jolt_drop_fx(var_03.var_116 - (0, 0, 32));
      wait(3);
      classic_game_logic(var_02, var_07);
      if(level.currentclassicdifficultylevel > level.maxclassicdifficultylevel) {
        thread classic_complete(var_02);
        return;
      }

      break;
    }
  }
}

classic_eye_flicker(param_00) {
  var_01 = spawnfx(common_scripts\utility::func_44F5(param_00), self.var_116);
  triggerfx(var_01);
  for(var_02 = 0; var_02 < 60; var_02++) {
    var_01 method_805C();
    wait(0.01);
    var_01 method_805B();
    wait(0.01);
  }
}

classic_game_logic(param_00, param_01) {
  var_02 = 0;
  var_03 = 0;
  var_04 = 0;
  switch (level.currentclassicdifficultylevel) {
    case 1:
      var_02 = 4;
      var_04 = 1.25;
      var_03 = 6;
      break;

    case 2:
      var_02 = 3;
      var_04 = 0.75;
      var_03 = 8;
      break;

    case 3:
      var_02 = 2;
      var_04 = 0.25;
      var_03 = 10;
      break;

    default:
      break;
  }

  classic_reset_head_positions();
  wait(2);
  var_05 = 0;
  for(;;) {
    var_06 = common_scripts\utility::func_46B7("classic_corpse_object", "targetname");
    var_07 = undefined;
    for(;;) {
      wait 0.05;
      var_07 = common_scripts\utility::func_7A33(var_06);
      if(common_scripts\utility::func_562E(var_07.var_4B57)) {
        continue;
      } else {
        break;
      }
    }

    var_08 = var_07 classic_head_popup(param_00, param_01, var_02);
    if(var_08) {
      var_05++;
      thread classic_victory_celebration();
    } else {
      classic_failure_celebration(param_00);
      break;
    }

    if(var_05 >= var_03) {
      classic_difficulty_complete_celebration();
      break;
    }

    wait(var_04);
  }
}

classic_head_popup(param_00, param_01, param_02) {
  self.color moveto(self.color.upposition, 0.25);
  self.var_18A8 moveto(self.var_18A8.upposition, 0.25);
  var_03 = randomint(100);
  if(var_03 <= 90) {
    var_04 = "enemy";
  } else {
    var_04 = "ally";
  }

  if(!isDefined(self.eyeglowarray)) {
    self.eyeglowarray = [];
  }

  foreach(var_06 in self.eyefxorg) {
    if(param_00 == "teamClassic") {
      if(var_04 == "ally") {
        self.eyeglowarray[self.eyeglowarray.size] = spawnfx(common_scripts\utility::func_44F5("blueGlow"), var_06.var_116);
      } else if(var_04 == "enemy") {
        self.eyeglowarray[self.eyeglowarray.size] = spawnfx(common_scripts\utility::func_44F5("redGlow"), var_06.var_116);
      }

      continue;
    }

    if(param_00 == "teamVintage") {
      if(var_04 == "ally") {
        self.eyeglowarray[self.eyeglowarray.size] = spawnfx(common_scripts\utility::func_44F5("redGlow"), var_06.var_116);
        continue;
      }

      if(var_04 == "enemy") {
        self.eyeglowarray[self.eyeglowarray.size] = spawnfx(common_scripts\utility::func_44F5("blueGlow"), var_06.var_116);
      }
    }
  }

  foreach(var_09 in self.eyeglowarray) {
    triggerfx(var_09);
  }

  self.color thread classic_head_popup_waittill_timeout(param_02);
  self.color thread classic_head_popup_waittill_damage(var_04, param_01);
  var_0B = self.color common_scripts\utility::func_A715("classic_head_popup_timeout", "classic_head_popup_damage");
  thread classic_head_remove_eye_glow();
  self.var_4B57 = 1;
  self.color.var_BC = 1000000;
  if(var_0B == "classic_head_popup_damage") {
    if(var_04 == "enemy") {
      return 1;
    }

    if(var_04 == "ally") {
      return 0;
    }

    return;
  }

  if(var_0B == "classic_head_popup_timeout") {
    if(var_04 == "enemy") {
      return 0;
    }

    if(var_04 == "ally") {
      return 1;
    }

    return;
  }
}

classic_head_popup_waittill_damage(param_00, param_01) {
  for(;;) {
    self waittill("damage", var_02, var_03);
    if(var_03 != param_01) {
      continue;
    }

    if(param_00 == "enemy") {
      self notify("classic_head_popup_damage");
      break;
    } else if(param_00 == "ally") {
      break;
    }
  }
}

classic_head_popup_waittill_timeout(param_00) {
  wait(param_00);
  self notify("classic_head_popup_timeout");
}

classic_reset_head_positions() {
  var_00 = common_scripts\utility::func_46B7("classic_corpse_object", "targetname");
  foreach(var_02 in var_00) {
    var_02.color moveto(var_02.color.downposition, 0.5, 0.25, 0.25);
    var_02.var_18A8 moveto(var_02.var_18A8.downposition, 0.5, 0.25, 0.25);
    var_02 thread classic_head_remove_eye_glow();
    var_02.var_4B57 = 0;
  }

  wait(0.5);
}

classic_head_remove_eye_glow() {
  if(isDefined(self.eyeglowarray)) {
    foreach(var_01 in self.eyeglowarray) {
      if(isDefined(var_01)) {
        self.eyeglowarray = common_scripts\utility::func_F93(self.eyeglowarray, var_01);
        var_01 delete();
      }
    }
  }
}

classic_failure_celebration(param_00) {
  level notify("classic_fail_notify");
  level.classicfails++;
  if(level.classicfails >= 3) {
    thread classic_reset(param_00);
  }

  classic_reset_head_positions();
}

classic_victory_celebration() {
  level notify("classic_victory_notify");
}

classic_difficulty_complete_celebration() {
  level notify("classic_level_complete");
  level.currentclassicdifficultylevel++;
  classic_reset_head_positions();
}

classic_complete(param_00) {
  if(param_00 == "teamClassic") {
    var_01 = common_scripts\utility::func_46B7("vintage_leader_fire_fx_spawn", "targetname");
    foreach(var_03 in var_01) {
      var_04 = spawnfx(common_scripts\utility::func_44F5("onFireLoop"), var_03.var_116);
      triggerfx(var_04);
    }

    maps\mp\zombies\_zombies_magicbox::func_9C8("ppsh41_classic_zm", "extended_mag", "none", "none");
    var_06 = common_scripts\utility::func_46B5("classic_spawn_struct", "targetname");
    thread classic_jolt_drop_fx(var_06.var_116);
    var_07 = lib_0586::create_streamed_world_weapon_model("ppsh41_classic_zm+extended_mag", var_06.var_116);
    var_07.var_1D = var_06.var_1D;
    var_07 lib_0547::func_AC41(&"ZOMBIES_CLASSIC", undefined, var_06.var_116);
    var_07 classic_weapon_pickup("ppsh41_classic_zm+extended_mag");
    return;
  }

  if(param_00 == "teamVintage") {
    var_01 = common_scripts\utility::func_46B7("classic_leader_fire_fx_spawn", "targetname");
    foreach(var_03 in var_01) {
      var_04 = spawnfx(common_scripts\utility::func_44F5("onFireLoop"), var_03.var_116);
      triggerfx(var_04);
    }

    maps\mp\zombies\_zombies_magicbox::func_9C8("mg42_vintage_zm", "extended_mag_mg42_zm", "none", "none");
    var_06 = common_scripts\utility::func_46B5("vintage_spawn_struct", "targetname");
    thread classic_jolt_drop_fx(var_06.var_116);
    var_07 = lib_0586::create_streamed_world_weapon_model("mg42_vintage_zm+extended_mag_mg42_zm", var_06.var_116);
    var_07.var_1D = var_06.var_1D;
    var_07 lib_0547::func_AC41(&"ZOMBIE_WEAPONDLC4_VINTAGE_MG42", undefined, var_06.var_116);
    var_07 classic_weapon_pickup("mg42_vintage_zm+extended_mag_mg42_zm");
  }
}

classic_weapon_pickup(param_00) {
  self waittill("player_used", var_01);
  maps\mp\zombies\_zombies_magicbox::func_A7D6(var_01, maps\mp\zombies\_zombies_magicbox::func_454B(var_01, param_00));
  lib_0547::func_AC40();
  self delete();
}

classic_jolt_drop_fx(param_00) {
  var_01 = spawnfx(common_scripts\utility::func_44F5("moneyCloud"), param_00);
  triggerfx(var_01);
  wait(3);
  var_01 delete();
}

_______________________tower_deflect_______________________() {}

tower_deflect_init() {
  if(!isDefined(level.var_744A) || level.var_744A.size < 1) {
    wait(1);
  }

  foreach(var_01 in level.var_744A) {
    var_01 thread tower_deflect_wait_for_missile();
  }
}

tower_deflect_wait_for_missile() {
  var_00 = self;
  var_01 = getEntArray("tower_deflection_trigger", "targetname");
  for(;;) {
    var_00 waittill("missile_fire", var_02, var_03);
    foreach(var_05 in var_01) {
      var_05 thread tower_deflect_track_incoming_missile(var_00, var_02, var_03);
    }

    wait 0.05;
  }
}

tower_deflect_track_incoming_missile(param_00, param_01, param_02) {
  param_00 endon("projectile_impact");
  param_01 endon("missile_hit_tower");
  for(;;) {
    if(isDefined(param_01) && self method_858B(param_01.var_116)) {
      param_00 thread tower_deflect_fire_missile(param_01, param_02);
      param_01 delete();
      param_01 notify("missile_hit_tower");
    }

    wait 0.05;
  }
}

tower_deflect_fire_missile(param_00, param_01) {
  self endon("projectile_impact");
  var_02 = self.var_116;
  var_03 = magicbullet(param_01, param_00.var_116, var_02);
  var_04 = 0;
  var_05 = lib_0547::func_AAF9(param_01, 0, 0);
  switch (var_05) {
    case "fliegerfaust_zm":
    case "panzerschreck_zm":
    case "bazooka_zm":
      var_04 = 1;
      break;
  }

  if(var_04) {
    var_06 = undefined;
    for(;;) {
      if(isDefined(var_06)) {
        var_03 = var_06;
      }

      wait(1.25);
      if(isDefined(var_03)) {
        var_06 = magicbullet(param_01, var_03.var_116, var_02);
        var_03 delete();
      }
    }
  }
}

_______________________grenade_hole_______________________() {}

grenade_hole_init() {
  if(!isDefined(level.var_744A) || level.var_744A.size < 1) {
    wait(1);
  }

  level.grenadeholecooldown = 0;
  foreach(var_01 in level.var_744A) {
    var_01 thread grenade_hole_wait_for_grenade();
  }
}

grenade_hole_wait_for_grenade() {
  var_00 = self;
  var_01 = getEntArray("grenade_hole_trigger", "targetname");
  for(;;) {
    var_00 waittill("grenade_fire", var_02, var_03);
    if(var_03 != "frag_grenade_zm") {
      continue;
    }

    foreach(var_05 in var_01) {
      var_05 thread grenade_hole_track_incoming_grenade(var_00, var_02, var_03);
    }

    wait 0.05;
  }
}

grenade_hole_track_incoming_grenade(param_00, param_01, param_02) {
  param_00 endon("projectile_impact");
  param_01 endon("grenade_hit_hole");
  for(;;) {
    if(isDefined(param_01) && self method_858B(param_01.var_116) && !level.grenadeholecooldown) {
      level.grenadeholecooldown = 1;
      param_01 delete();
      wait(2);
      thread grenade_hole_fire_grenades(param_02);
      wait(10);
      level.grenadeholecooldown = 0;
      param_01 notify("grenade_hit_hole");
    }

    wait 0.05;
  }
}

grenade_hole_fire_grenades(param_00) {
  var_01 = common_scripts\utility::func_46B7(self.var_1A2, "targetname");
  foreach(var_03 in var_01) {
    magicgrenademanual(param_00, var_03.var_116, var_03.var_116 - (0, 0, 128), randomfloatrange(2.5, 4));
  }
}

_______________________outlaw_ravens_______________________() {}

ravens() {
  level.raven_manager = spawnStruct();
  level.raven_manager.raven_spawns = common_scripts\utility::func_46B7("struct_raven", "targetname");
  level.raven_manager.gold_ravens = getEntArray("gold_ravens", "targetname");
  var_00 = getent("starter_raven", "targetname");
  var_01 = common_scripts\utility::func_46B5("starter_raven_dir", "targetname");
  var_02 = getent("trig_starter_raven", "targetname");
  level.raven_manager.remaining = 4;
  level.raven_manager.selected_spawns = [];
  level.raven_manager.var_6E97 = [];
  raven_spawn_setup(level.raven_manager.raven_spawns);
  gold_raven_setup(level.raven_manager.gold_ravens);
  level.raven_manager thread gold_ravens_think();
  thread maps\mp\zombies\weapons\_zombie_raven_gun::func_D5();
  for(var_03 = 0; !common_scripts\utility::func_562E(var_03); var_03 = maps\mp\_utility::func_3B8E(var_04, var_00, 80)) {
    var_02 waittill("trigger", var_04);
  }

  var_00 lib_0378::func_8D74("aud_raven_fly_away");
  playFX(common_scripts\utility::func_44F5("zmb_dec_crows_fly"), var_01.var_116, anglesToForward(var_01.var_1D));
  playFX(common_scripts\utility::func_44F5("zmb_desc_raven_feathers_pop"), var_00.var_116, var_01.var_1D);
  var_00 delete();
  var_02 delete();
  level.raven_manager raven_manager();
}

raven_spawn_setup(param_00) {
  foreach(var_02 in param_00) {
    var_03 = common_scripts\utility::func_44BE(var_02.var_1A2, "targetname");
    foreach(var_05 in var_03) {
      switch (var_05.var_165) {
        case "clip":
          var_02.raven_clip = var_05;
          var_02.raven_clip notsolid();
          break;
      }
    }
  }
}

gold_raven_setup(param_00) {
  foreach(var_02 in param_00) {
    var_02 method_805C();
  }
}

gold_ravens_think() {
  var_00 = 0;
  var_01 = 0;
  while(!common_scripts\utility::func_562E(var_00)) {
    level.raven_manager waittill("raven_shot");
    level.raven_manager.gold_ravens[var_01] method_805B();
    var_01++;
    if(var_01 >= 4) {
      break;
    }
  }

  common_scripts\utility::func_3C8F("flag_outlaw_raven_puzzle_complete");
  maps\mp\zombies\_zombies_magicbox::func_9C8("raven_gun_zm", "none", "none", "none");
  spawn_raven_guns();
}

spawn_raven_guns() {
  var_00 = common_scripts\utility::func_46B5("raven_gun_spawn", "targetname");
  var_01 = lib_0586::create_streamed_world_weapon_model("raven_gun_zm", var_00.var_116);
  var_01.var_1D = var_00.var_1D;
  var_02 = spawnfx(common_scripts\utility::func_44F5("zmb_desc_raven_feathers_pop"), var_00.var_116);
  triggerfx(var_02);
  var_03 = getent(var_00.var_1A2, "targetname");
  var_01 thread raven_gun_pickup(var_03);
}

raven_gun_pickup(param_00) {
  var_01 = 0;
  for(;;) {
    param_00 waittill("trigger", var_02);
    if(common_scripts\utility::func_562E(var_02.hastakenravengun)) {
      continue;
    }

    var_02.hastakenravengun = 1;
    var_01++;
    self hidefromclient(var_02);
    var_03 = spawnfxforclient(common_scripts\utility::func_44F5("zmb_desc_raven_feathers_pop"), self.var_116, var_02);
    triggerfx(var_03);
    var_03 common_scripts\utility::func_2CBE(1, ::delete);
    maps\mp\zombies\_zombies_magicbox::func_A7D6(var_02, maps\mp\zombies\_zombies_magicbox::func_454B(var_02, "raven_gun_zm"));
    wait 0.05;
  }
}

set_hidden_but_sent_to_player(param_00) {
  set_shown_only_to_player(param_00);
  self method_8511();
}

set_shown_only_to_player(param_00) {
  if(isDefined(param_00)) {
    self method_805C();
    self showtoclient(param_00);
    return;
  }

  self method_805B();
}

raven_manager() {
  for(var_00 = 0; var_00 < level.raven_manager.remaining; var_00++) {
    level.raven_manager.selected_spawns["spawn_" + var_00] = get_raven_spawn();
    level.raven_manager.selected_spawns["spawn_" + var_00] thread try_spawn_raven();
  }

  while(level.raven_manager.remaining > 0) {
    level.raven_manager.remaining--;
    level.raven_manager waittill("raven_shot");
  }

  foreach(var_02 in level.raven_manager.var_6E97) {
    var_02 notify("outlaw_0_complete");
  }
}

get_raven_spawn() {
  for(var_00 = undefined; !isDefined(var_00); var_00 = var_01) {
    var_01 = common_scripts\utility::func_7A33(level.raven_manager.raven_spawns);
    if(isDefined(var_01.isoccupied) && var_01.isoccupied == 1) {
      wait 0.05;
      continue;
    }
  }

  var_00.isoccupied = 1;
  return var_00;
}

try_spawn_raven() {
  var_00 = self;
  var_01 = 1;
  while(common_scripts\utility::func_562E(var_01)) {
    var_01 = 0;
    foreach(var_03 in level.var_744A) {
      var_04 = maps\mp\_utility::func_3B8E(var_03, var_00.raven_clip, 100);
      if(common_scripts\utility::func_562E(var_04)) {
        var_05 = bullettracepassed(var_03 getEye(), var_00.var_116, 0, var_03);
        if(lib_0547::func_5565(var_05, 1)) {
          var_01 = 1;
        }
      }
    }

    wait(1);
  }

  var_00 thread spawn_raven();
}

spawn_raven() {
  var_00 = self;
  var_01 = common_scripts\utility::func_8FFC();
  var_01.var_116 = var_00.var_116;
  if(isDefined(var_00.var_1D)) {
    var_01.var_1D = var_00.var_1D;
  } else {
    var_01.var_1D = (0, 0, 0);
  }

  var_01 method_805B();
  var_01.raven_fx = spawnlinkedfx(common_scripts\utility::func_44F5("zmb_dec_crows_peck"), var_01, "Tag_Origin");
  triggerfx(var_01.raven_fx);
  var_01 lib_0378::func_8D74("aud_spawn_raven");
  var_00.raven_clip solid();
  var_00.raven_clip setCanDamage(1);
  var_02 = 1;
  var_03 = undefined;
  var_04 = undefined;
  while(common_scripts\utility::func_562E(var_02)) {
    var_00.raven_clip waittill("damage", var_05, var_04, var_06, var_07, var_08, var_09, var_0A, var_0B, var_0C, var_03);
    if(isPlayer(var_04)) {
      var_02 = 0;
    }
  }

  var_01 lib_0378::func_8D74("aud_raven_fly_away");
  var_01.raven_fx delete();
  var_01 method_805C();
  playFX(common_scripts\utility::func_44F5("zmb_dec_crows_fly"), var_01.var_116, anglesToForward(var_01.var_1D));
  playFX(common_scripts\utility::func_44F5("zmb_desc_raven_feathers_pop"), var_01.var_116, anglesToForward(var_01.var_1D));
  var_01 delete();
  var_00.raven_clip notsolid();
  var_00.raven_clip setCanDamage(0);
  var_00.isoccupied = undefined;
  if(valid_raven_weapon(var_03)) {
    level.raven_manager notify("raven_shot");
    level.raven_manager.var_6E97[level.raven_manager.var_6E97.size] = var_04;
    thread spawn_punisher(var_04);
    return;
  }

  wait(15);
  var_00 = get_raven_spawn();
  var_00 thread try_spawn_raven();
}

valid_raven_weapon(param_00) {
  if(!isDefined(param_00)) {
    return 0;
  }

  if(issubstr(param_00, "m1911") || issubstr(param_00, "reich") || issubstr(param_00, "m712") || issubstr(param_00, "p38") || issubstr(param_00, "enfieldno2") || issubstr(param_00, "luger")) {
    return 1;
  }

  return 0;
}

spawn_punisher(param_00) {
  wait(1.4);
  var_01 = lib_054D::func_90BA("zombie_dlc4", undefined, "raven punisher", 1, 1, 1);
  wait(0.5);
  var_01.var_5A36 = maps\mp\zombies\zombie_corpse_eater::get_max_zombies_to_eat();
  wait(0.5);
  var_01 punisher_track_player(param_00);
}

punisher_track_player(param_00) {
  var_01 = self;
  var_01 endon("death");
  if(!isDefined(param_00) || !isalive(param_00) || lib_0547::func_577E(param_00)) {
    return;
  }

  var_01.var_1928 = param_00;
  while(isDefined(param_00) && isalive(param_00) && !lib_0547::func_577E(param_00)) {
    wait 0.05;
  }

  var_01.var_1928 = undefined;
}

_______________________dark_passenger_______________________() {}

dark_passenger_init() {
  level.dark_passenger = spawnStruct();
  level.dark_passenger.final_destination = common_scripts\utility::func_46B5("struct_dark_passenger_end", "targetname");
  level.dark_passenger.complete = 0;
  level.dark_passenger.attempt_waves = [];
}

dark_passenger_test(param_00) {
  var_01 = undefined;
  var_02 = undefined;
  foreach(var_04 in param_00) {
    if(!isDefined(var_04)) {
      continue;
    }

    if(lib_0547::func_5565(level.ravenweaponmanager["spike_emp"].var_117, var_04)) {
      var_01 = var_04;
    }

    if(isDefined(var_04.ismooncontrolled) && var_04.ismooncontrolled == 1) {
      var_02 = var_04;
    }
  }

  if(isDefined(var_02) && isDefined(var_01)) {
    thread dark_passenger_run(var_01, var_02);
  }
}

dark_passenger_zombie_setup() {
  var_00 = self;
  level.dark_passenger.dark_host = var_00;
  var_00.isdarkhost = 1;
  var_00.ispassiveexempt = 1;
  var_00.var_55AB = 1;
  var_00.var_562B = 1;
  var_00.var_C29 = 0;
  var_00.var_297D = ::host_hc_zombie_custom_movemode;
  var_00.stall_mc_death = 1;
  var_00 dark_host_control_fx();
  var_00 maps\mp\agents\_agent_common::func_83FD(var_00.var_FB * 10);
  return var_00;
}

dark_passenger_track_org_for_detach() {
  var_00 = self;
  var_00 endon("dark_host_end_tracking");
  var_00.detachposarray = [];
  while(isDefined(var_00)) {
    var_00.detachposarray = common_scripts\utility::func_F86(var_00.detachposarray, var_00.var_116, 0);
    wait(0.5);
  }
}

dark_host_control_fx() {
  self endon("death");
  if(isDefined(self.darkhostfx)) {
    self.darkhostfx delete();
  }

  self notify("dark_host_fx_update");
  self.darkhostfx = spawnlinkedfx(common_scripts\utility::func_44F5("zmb_red_zmb_blind"), self, "j_head", 1);
  triggerfx(self.darkhostfx);
  self.darkhostfx thread lib_0547::func_2D19(self);
}

host_hc_zombie_custom_movemode() {
  self.var_64C2 = 0.8 * lib_054D::func_4440();
  return "sprint";
}

dark_passenger_player_setup(param_00) {
  var_01 = self;
  level.dark_passenger.dark_passenger = var_01;
  var_01 method_8322();
  var_01 method_812A(0);
  var_01 method_8114(0);
  var_01 method_8113(0);
  var_01 setclientomnvar("ui_hide_hud", 1);
  var_01.isdarkpassenger = 1;
  var_01 method_8003();
  param_00 hidefromclient(var_01);
  var_01 lib_0547::func_8A6D(1);
  var_01 maps\mp\zombies\_zombies_blood_tubes::enable_blood_vision();
  var_01.safeposbeforepassenger = var_01.var_116;
  var_01 thread dark_passenger_track_org_for_detach();
  var_01 dark_passenger_player_attach_to_host(param_00);
  var_01 thread dark_passenger_fury_think();
  var_01 thread dark_passenger_detach();
}

dark_passenger_player_attach_to_host(param_00) {
  var_01 = self;
  var_01.passenger_org = common_scripts\utility::func_8FFC();
  var_01.passenger_org method_805B();
  var_02 = param_00 geteyeangles();
  var_03 = param_00 gettagorigin("tag_origin");
  var_01.darkhost = param_00;
  var_01.passenger_org.var_1D = var_02;
  var_04 = get_passenger_offset(param_00.var_A4B);
  var_05 = param_00.var_116 + anglesToForward(param_00.var_1D) * var_04[1];
  var_01.passenger_org.var_116 = var_05;
  var_01 setorigin(var_01.passenger_org.var_116 + var_04[0], 1);
  var_01 setangles(var_01.passenger_org.var_1D);
  var_01.passenger_org method_8449(param_00, "TAG_ORIGIN");
  var_01 playerlinktoblend(var_01.passenger_org, "TAG_ORIGIN", 0.05);
}

get_passenger_offset(param_00) {
  var_01 = (0, 0, 0);
  var_02 = 12;
  switch (param_00) {
    case "zombie_generic":
      var_01 = (0, 0, 5);
      var_02 = -18;
      break;

    case "zombie_heavy":
      var_01 = (0, 0, 16);
      var_02 = -18;
      break;

    case "zombie_berserker":
      var_01 = (0, 0, 5);
      var_02 = -16;
      break;

    case "zombie_exploder":
      var_01 = (0, 0, 12);
      var_02 = -22;
      break;

    default:
      break;
  }

  return [var_01, var_02];
}

dark_passenger_detach(param_00) {
  var_01 = self;
  var_01 dark_passenger_detach_wait();
  var_01 method_8323();
  var_01 method_812A(1);
  var_01 method_8114(1);
  var_01 method_8113(1);
  var_01 method_8004();
  var_01 setclientomnvar("ui_hide_hud", 0);
  var_01 maps\mp\zombies\_zombies_blood_tubes::disable_blood_vision();
  var_01 lib_0547::func_8A6D(0);
  var_01.isdarkpassenger = undefined;
  level.dark_passenger.dark_passenger = undefined;
  var_02 = (var_01.passenger_org.var_1D[0], var_01.passenger_org.var_1D[1], 0);
  var_01 setangles(var_02);
  var_03 = var_01.passenger_org gettagorigin("TAG_ORIGIN");
  playFX(common_scripts\utility::func_44F5("zmb_blood_blast"), var_03);
  var_01 notify("dark_host_end_tracking");
  var_04 = undefined;
  var_05 = var_01.detachposarray;
  var_01.detachposarray = undefined;
  var_05 = common_scripts\utility::func_F86(var_05, var_01.var_116, 0);
  foreach(var_07 in var_05) {
    var_08 = var_01 dark_passenger_detach_safe_test(var_07);
    if(common_scripts\utility::func_562E(var_08[0])) {
      var_04 = var_08[1];
      break;
    }
  }

  if(!isDefined(var_04)) {
    var_04 = var_01.safeposbeforepassenger;
  }

  var_01 unlink();
  var_01 setorigin(var_04);
  var_01.safeposbeforepassenger = undefined;
  if(lib_0547::func_5565(level.dark_passenger.complete, 0)) {
    var_01 lib_056A::func_95D2();
    var_01 dodamage(var_01.var_BC + 1, var_01.var_116);
  }

  var_01.passenger_org delete();
}

dark_passenger_detach_safe_test(param_00) {
  var_01 = 64;
  var_02 = 32;
  var_03 = 0;
  var_04 = 4;
  var_05 = [0];
  if(isDefined(param_00)) {
    for(var_06 = 0; var_06 < 2; var_06++) {
      if(!isDefined(var_03)) {
        var_03 = 0;
      }

      var_03 = var_03 + var_06 * var_04;
      var_07 = param_00 + (0, 0, var_03) + (0, 0, 2);
      var_08 = capsuletracepassed(var_07, var_02, var_01, self.darkhost, 0, 0, 1);
      if(common_scripts\utility::func_562E(var_08)) {
        var_05 = [1, var_07];
        break;
      }
    }
  }

  return var_05;
}

dark_passenger_detach_wait() {
  var_00 = self;
  var_00.darkhost endon("death");
  var_00 waittill("dark_detach");
}

dark_passenger_fury_think() {
  var_00 = self;
  var_00 endon("disconnect");
  var_00 endon("death");
  var_00 childthread dark_passenger_cast_fury();
  while(isDefined(var_00.isdarkpassenger) && common_scripts\utility::func_562E(var_00.isdarkpassenger)) {
    if(var_00 adsButtonPressed() || var_00 attackButtonPressed()) {
      var_00 notify("dark_fury_pressed");
    }

    wait 0.05;
  }
}

dark_passenger_cast_fury() {
  var_00 = self;
  for(;;) {
    var_00 waittill("dark_fury_pressed");
    var_00 dark_fury();
    wait(10);
  }
}

dark_fury(param_00) {
  var_01 = self;
  var_02 = "moonorb_control_burst";
  if(isDefined(param_00)) {
    var_02 = param_00;
  }

  var_03 = lib_0547::func_408F();
  var_04 = function_01AC(var_03, var_01.var_116, 300, 1);
  playFX(common_scripts\utility::func_44F5(var_02), var_01 getEye());
  foreach(var_06 in var_04) {
    if(lib_0547::func_5565(var_01.darkhost, var_06)) {} else {
      var_06 dodamage(var_06.var_FB / 2, var_01.var_116, var_01, var_01, "MOD_ENERGY");
      if(isDefined(var_06.var_A4B)) {}
    }
  }
}

dark_passenger_attempted_this_round() {
  var_00 = level.var_A980;
  foreach(var_02 in level.dark_passenger.attempt_waves) {
    if(lib_0547::func_5565(var_00, var_02)) {
      return 1;
    }
  }

  return 0;
}

dark_passenger_run(param_00, param_01) {
  if(dark_passenger_attempted_this_round() || common_scripts\utility::func_562E(param_00.darkpassengercomplete)) {
    return;
  }

  level.dark_passenger.attempt_waves[level.dark_passenger.attempt_waves.size] = level.var_A980;
  param_01 dark_passenger_zombie_setup();
  param_00 dark_passenger_player_setup(param_01);
  lib_0547::register_allykilledfunc(::dark_passenger_host_dead);
  param_01.var_1928 = level.dark_passenger.final_destination;
  param_01 lib_053C::func_4F7F("dark_passenger");
  param_01 walk_the_dark_path();
  lib_0547::deregister_allykilledfunc(::dark_passenger_host_dead);
}

dark_passenger_host_dead(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08) {
  if(lib_0547::func_5565(self.isdarkhost, 1)) {
    if(isDefined(self.beingfedon)) {
      level.dark_passenger.complete = 1;
      level.dark_passenger notify("dark_traveled");
    }

    self.isdarkhost = undefined;
    level.dark_passenger.dark_host = undefined;
  }
}

walk_the_dark_path() {
  var_00 = self;
  var_00 endon("death");
  var_00 thread dark_passenger_spawn_eater();
  var_00 thread dark_passenger_host_eaten();
  while(isDefined(var_00.var_1928) && distance(var_00.var_116, var_00.var_1928.var_116) > 128) {
    wait(1);
  }

  var_00 suicide();
}

dark_passenger_host_eaten() {
  var_00 = self;
  var_00 endon("death");
  level waittill("corpse_eater_start_feed", var_01, var_02);
  if(!lib_0547::func_5565(var_02, var_00)) {
    return;
  }

  var_01 endon("death");
  var_00.beingfedon = var_01;
  var_03 = level.dark_passenger.dark_passenger.passenger_org;
  var_03 unlink();
  var_03 rotateto(vectortoangles(var_01.var_116 - var_03.var_116), 0.4);
  var_01 thread dark_passenger_end_condition();
}

dark_passenger_end_condition() {
  var_00 = self;
  level.dark_passenger waittill("dark_traveled");
  level.dark_passenger.dark_passenger dark_passenger_reward();
  level.dark_passenger.dark_passenger dark_fury("zmb_gk_geistblast_impact");
  var_00 suicide();
}

dark_passenger_spawn_eater() {
  wait(6);
  spawn_dark_eater(level.dark_passenger.dark_host);
}

spawn_dark_eater(param_00) {
  wait(1.4);
  var_01 = lib_054D::func_90BA("zombie_dlc4", undefined, "raven punisher", 1, 1, 1);
  wait(0.5);
  var_01 dark_eater_track(param_00);
}

dark_eater_track(param_00) {
  var_01 = self;
  var_01 endon("death");
}

dark_passenger_reward() {
  var_00 = self;
  var_00 notify("dark_passenger_survived");
  var_00.darkpassengercomplete = 1;
  var_00 maps\mp\gametypes\zombies::func_4798(10000);
  var_01 = ["quickrevive", "doubletap", "fastreload", "punchperk", "runperk", "electriccherry"];
  if(level.var_6F5C["quickrevive"].var_6078 > -1) {
    if(!isDefined(var_00.numperkbuys)) {
      var_00.numperkbuys = [];
    }

    if(!isDefined(var_00.numperkbuys["quickrevive"])) {
      var_00.numperkbuys["quickrevive"] = 0;
    }

    if(isDefined(var_00.numselfrevivedowns) && var_00.numselfrevivedowns >= level.var_6F5C["quickrevive"].var_6078 && level.var_744A.size == 1) {
      var_01 = common_scripts\utility::func_F93(var_01, "quickrevive");
    }
  }

  var_02 = common_scripts\utility::func_7A33(var_01);
  var_03 = 0;
  while(var_00 lib_056A::func_4B7E(var_02)) {
    var_01 = common_scripts\utility::func_F93(var_01, var_02);
    if(var_01.size <= 0) {
      lib_0555::func_83DD("blitz_owned", var_00);
      var_03 = 1;
      break;
    }

    var_02 = common_scripts\utility::func_7A33(var_01);
  }

  if(!isDefined(var_02)) {
    return;
  }

  var_00[[level.var_6F5C[var_02].var_868B]]();
  self notify("perkmachine_activated");
  var_00 notify("perkmachine_activated", level.var_6F5C[var_02]);
  level notify("perkmachine_activated", level.var_6F5C[var_02]);
  level notify("perkmachine_player", level.var_6F5C[var_02], self.var_116, var_00);
  var_00 lib_0547::func_7ACD();
}

_______________________sewers_______________________() {}

sewers_init() {
  if(!common_scripts\utility::func_3C83("flag_bonus_plates_filled")) {
    common_scripts\utility::func_3C87("flag_bonus_plates_filled");
  }

  lib_0551::func_3D50();
  level.var_3D4F = ["zmb_player_attached_light_wide"];
  level.sewer_spikes_collected = 0;
  level.sewer_spikes_placed = 0;
  level.spike_spawns = [];
  thread maps\mp\_utility::func_6F74(::sewers_player_flashlight_think);
  var_00 = getEntArray("blitz_all_spikes_plinth", "targetname");
  foreach(var_02 in var_00) {
    var_02.placed = 0;
    var_02 method_805C();
  }

  var_04 = getent("blitz_all_place_spike_trig", "targetname");
  var_04 thread sewers_spike_plinth_use_think(var_00);
  var_05 = common_scripts\utility::func_46B7("blitz_all_spikes_spawn", "targetname");
  var_06 = [];
  while(var_06.size < var_00.size) {
    var_07 = common_scripts\utility::func_7A33(var_05);
    var_06 = common_scripts\utility::func_F6F(var_06, var_07);
    var_05 = common_scripts\utility::func_F93(var_05, var_07);
  }

  level.spike_spawns = var_06;
  foreach(var_02 in level.spike_spawns) {
    var_02.use_trig = getent(var_02.var_1A2, "targetname");
    var_02.use_trig usetriggerrequirelookat(1);
    var_02.spike_model = spawn("script_model", var_02.var_116);
    var_02.spike_model setModel("rem_railspike_01");
    var_02.spike_model.var_1D = var_02.var_1D;
    var_02 thread sewers_spike_use_think();
  }

  foreach(var_02 in var_05) {
    var_0B = getent(var_02.var_1A2, "targetname");
    if(isDefined(var_0B)) {
      var_0B delete();
    }
  }

  level thread sewers_handle_shelf_fill();
  sewers_wait_for_all_plates_full();
  sewers_disable_plinth();
  common_scripts\utility::func_3C8F("flag_bonus_plates_filled");
  level sewers_handle_plinth_trap_door();
}

sewers_player_setup() {
  var_00 = self;
  var_00.istrial = "sewers";
}

sewers_player_flashlight_think() {
  self endon("disconnect");
  for(;;) {
    if(sewers_player_in_zone()) {
      if(!isDefined(self.var_3D4C)) {
        lib_0551::func_3D52(1);
      } else if(common_scripts\utility::func_562E(self.flashlightflicker)) {
        lib_0551::func_3D52(0);
        wait 0.05;
        lib_0551::func_3D52(1);
        wait 0.05;
        lib_0551::func_3D52(0);
        wait 0.05;
        wait 0.05;
        lib_0551::func_3D52(1);
        wait 0.05;
        lib_0551::func_3D52(0);
        wait 0.05;
        wait 0.05;
        lib_0551::func_3D52(1);
      }
    } else if(isDefined(self.var_3D4C)) {
      lib_0551::func_3D52(0);
    }

    wait(1);
  }
}

sewers_player_in_zone() {
  if(!isDefined(self)) {
    return 0;
  }

  if(!isPlayer(self)) {
    return 0;
  }

  return lib_055A::func_7413(self, "zone_sewers");
}

sewers_wait_for_all_plates_full() {
  level endon("flag_bonus_plates_filled");
  var_00 = common_scripts\utility::func_46B7("blood_plate_struct", "targetname");
  var_01 = [];
  foreach(var_03 in var_00) {
    if(isDefined(var_03.var_8260)) {
      if(var_03.var_8260 == "plate_frontdoor" || var_03.var_8260 == "plate_bonus_room" || var_03.var_8260 == "plate_shelf") {
        var_01 = common_scripts\utility::func_F6F(var_01, var_03);
      }
    }
  }

  for(;;) {
    common_scripts\utility::func_A70D(10, var_01[0], "blood_plate_full", var_01[1], "blood_plate_full", var_01[2], "blood_plate_full");
    var_05 = 1;
    foreach(var_07 in var_01) {
      if(!common_scripts\utility::func_562E(var_07.isbloodfull)) {
        var_05 = 0;
        break;
      }
    }

    if(var_05) {
      break;
    }
  }
}

run_shelf_visit() {
  var_00 = self;
  level.shelf_timeout = 60;
  var_01 = level.blood_plates["shelf"];
  var_00.inasneakyplace = 1;
  if(isDefined(var_01)) {
    if(common_scripts\utility::func_562E(var_01.isbloodfull)) {
      level.shelf_timeout = 30;
    } else {
      thread sewers_shelf_handle_zombies();
    }
  }

  level.shelf_event_happening = 1;
  thread sewers_shelf_timer();
  var_02 = common_scripts\utility::func_A70E(level, "shelf_timeout", level, "players_exitted_shelf", var_00, "death", var_00, "disconnect", var_00, "begin_last_stand");
  var_03 = var_02[0];
  var_04 = var_02[1];
  if(lib_0547::func_5565(var_03, "shelf_timeout") || lib_0547::func_5565(var_03, "begin_last_stand")) {
    sewers_shelf_boot_players_from_shelf();
  }

  var_00.inasneakyplace = 0;
  return 1;
}

sewers_shelf_boot_players_from_shelf() {
  var_00 = common_scripts\utility::func_46B7("shelf_timeout_points", "targetname");
  while(sewers_any_player_in_shelf()) {
    for(var_01 = 0; var_01 < level.var_744A.size; var_01++) {
      if(!isDefined(level.zmb_temp_moon_orb_ent)) {
        level.zmb_temp_moon_orb_ent = level.var_744A[var_01] common_scripts\utility::func_8FFC();
        level.zmb_temp_moon_orb_ent method_805B();
      } else {
        level.zmb_temp_moon_orb_ent.var_116 = level.var_744A[var_01].var_116;
      }

      if(common_scripts\utility::func_562E(level.var_744A[var_01].isinshelfevent)) {
        level.var_744A[var_01] maps\mp\zombies\weapons\_zombie_dlc4_melee::do_moon_orb_teleportation(var_00[var_01].var_116, level.zmb_temp_moon_orb_ent);
      }
    }
  }

  if(isDefined(level.zmb_temp_moon_orb_ent)) {
    level.zmb_temp_moon_orb_ent delete();
  }
}

sewers_shelf_force_orb_teleport_return() {
  self.inasneakyplace = 0;
  level.shelf_event_happening = 0;
}

sewers_handle_shelf_fill() {
  level thread sewers_shelf_mark_shelf_event_goers();
  for(;;) {
    level waittill("player_entered_shelf", var_00);
    if(!common_scripts\utility::func_562E(level.shelf_event_happening)) {
      var_00 thread maps\mp\mp_zombie_descent_ee_main::run_weapon_ritual("zom_shelf_trial_destination");
    }
  }
}

sewers_shelf_handle_zombies() {
  level endon("shelf_timeout");
  level endon("players_exitted_shelf");
  var_00 = common_scripts\utility::func_46B5("bridge_shelf_spawner", "targetname");
  sewers_shelf_register_killed_func();
  if(!isDefined(level.shelf_zombies)) {
    level.shelf_zombies = [];
  }

  wait(0.5);
  for(var_01 = level.shelf_zombies.size; var_01 < 8; var_01++) {
    wait(randomfloatrange(1, 2));
    if(var_01 == 5) {
      var_02 = "zombie_heavy";
    } else {
      var_02 = common_scripts\utility::func_7A33(["zombie_generic", "zombie_berserker"]);
    }

    var_03 = sewers_shelf_spawn_zombie([var_00], var_02);
  }
}

sewers_shelf_register_killed_func() {
  var_00 = ::sewers_clear_shelf_zombie_on_death;
  if(!isDefined(level.shelf_zombies)) {
    foreach(var_02 in level.var_376B) {
      if(var_02 == var_00) {
        return;
      }
    }
  }

  lib_0547::func_7BA9(::sewers_clear_shelf_zombie_on_death);
}

sewers_shelf_spawn_zombie(param_00, param_01) {
  var_02 = lib_054D::func_90BA(param_01, common_scripts\utility::func_7A33(param_00), "shelf zombies", 0, 1, 1);
  if(!isDefined(var_02)) {
    return undefined;
  }

  var_02.isshelfzombie = 1;
  var_02.isintrial = "zom_shelf_trial_destination";
  var_02.var_6734 = 1;
  level.shelf_zombies[level.shelf_zombies.size] = var_02;
  var_02 thread sewers_shelf_zombie_track_zone();
  return var_02;
}

sewers_shelf_zombie_track_zone() {
  self endon("death");
  var_00 = getent("bridge_shelf", "targetname");
  while(self istouching(var_00) || !common_scripts\utility::func_562E(self.var_4BA0)) {
    wait 0.05;
  }

  self.isshelfzombie = 0;
  level.shelf_zombies = common_scripts\utility::func_F93(level.shelf_zombies, self);
}

sewers_clear_shelf_zombie_on_death(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08) {
  if(lib_0547::func_5565(self.isshelfzombie, 1)) {
    level.shelf_zombies = common_scripts\utility::func_F93(level.shelf_zombies, self);
  }

  if(!isDefined(level.shelf_zombies) || level.shelf_zombies.size < 0) {
    lib_0547::func_2D8C(::sewers_clear_sewer_zombie_on_death);
  }
}

sewers_shelf_mark_shelf_event_goers() {
  lib_0547::func_A78B();
  for(;;) {
    var_00 = undefined;
    foreach(var_02 in level.var_744A) {
      if(var_02 sewers_is_player_in_shelf() && !lib_0547::func_577E(var_02)) {
        var_00 = var_02;
        var_02.isinshelfevent = 1;
        continue;
      }

      var_02.isinshelfevent = 0;
    }

    if(isDefined(var_00)) {
      if(!common_scripts\utility::func_562E(level.shelf_event_happening)) {
        level notify("player_entered_shelf", var_00);
      }
    } else if(common_scripts\utility::func_562E(level.shelf_event_happening)) {
      level notify("players_exitted_shelf");
    }

    wait 0.05;
  }
}

sewers_is_player_in_shelf() {
  var_00 = getent("bridge_shelf", "targetname");
  if(self istouching(var_00)) {
    return 1;
  }

  return 0;
}

sewers_any_player_in_shelf() {
  var_00 = 0;
  foreach(var_02 in level.var_744A) {
    if(lib_0547::func_57E1(var_02)) {
      continue;
    }

    if(var_02.var_178 == "spectator") {
      continue;
    }

    if(var_02 sewers_is_player_in_shelf()) {
      return 1;
    }
  }

  return 0;
}

sewers_shelf_timer() {
  while(level.shelf_timeout > 0) {
    wait(1);
    level.shelf_timeout--;
  }

  level notify("shelf_timeout");
}

run_sewers_visit() {
  var_00 = self;
  var_00 thread sewers_trial();
  level waittill("player_exitting_sewers");
  return 0;
}

sewers_trial() {
  var_00 = self;
  level.sewer_timeout = 180;
  thread sewers_handle_zombies();
  level.sewer_event_happening = 1;
  thread sewers_timer(var_00);
  common_scripts\utility::func_A70C(level, "sewer_timeout", var_00, "sewers_exit", var_00, "death", var_00, "disconnect");
  if(isDefined(var_00)) {
    level notify("player_exitting_sewers", var_00);
  } else {
    level notify("player_exitting_sewers");
  }

  level.sewer_event_happening = 0;
  foreach(var_02 in level.sewer_zombies) {
    var_02 suicide();
  }

  level.sewer_zombies = [];
  if(isDefined(level.moon_orb_manager) && isDefined(level.moon_orb_manager["moonscepter_orb_active"])) {
    level.moon_orb_manager["moonscepter_orb_active"] notify("moonorb_trial_end_stagnate");
  }
}

sewers_handle_plinth_trap_door() {
  var_00 = getent("mdl_sewers_exit_manhole", "targetname");
  var_01 = getent("mdl_sewers_exit_manhole_clip", "targetname");
  for(;;) {
    level waittill("all_perkmachine_activated", var_02);
    var_02 notify("sewers_exit");
    var_02 notify("blood_is_power");
  }
}

sewers_spike_use_think() {
  common_scripts\utility::func_A70C(self.use_trig, "trigger", level, "all_sewer_spikes_placed");
  self.spike_model delete();
  self.use_trig delete();
  level.sewer_spikes_collected++;
}

sewers_spike_plinth_use_think(param_00) {
  for(;;) {
    var_01 = common_scripts\utility::func_A70E(self, "trigger", level, "all_sewer_spikes_placed");
    var_02 = var_01[0];
    var_03 = var_01[1];
    if(lib_0547::func_5565(var_02, "all_sewer_spikes_placed")) {
      foreach(var_05 in param_00) {
        if(common_scripts\utility::func_562E(var_05.placed)) {
          continue;
        }

        var_05 thread sewers_spike_plinth_place();
      }
    } else {
      if(level.sewer_spikes_placed == level.sewer_spikes_collected) {
        continue;
      }

      foreach(var_05 in param_00) {
        if(common_scripts\utility::func_562E(var_05.placed)) {
          continue;
        }

        if(level.sewer_spikes_placed < level.sewer_spikes_collected) {
          var_05 sewers_spike_plinth_place();
        }
      }
    }

    if(level.sewer_spikes_placed >= level.spike_spawns.size) {
      break;
    }
  }

  sewers_enable_plinth();
  self delete();
}

sewers_spike_plinth_place() {
  self method_805B();
  var_00 = common_scripts\utility::func_46B5(self.var_1A2, "targetname");
  self moveto(var_00.var_116, 0.5, 0.2, 0.2);
  level.sewer_spikes_placed++;
  self.placed = 1;
}

sewers_enable_plinth() {
  var_00 = getEntArray("all_perk_buy", "targetname");
  foreach(var_02 in var_00) {
    if(common_scripts\utility::func_562E(var_02.var_2307)) {
      var_02 common_scripts\utility::func_9DA3();
    }
  }
}

sewers_disable_plinth() {
  var_00 = getEntArray("all_perk_buy", "targetname");
  foreach(var_02 in var_00) {
    if(common_scripts\utility::func_562E(var_02.var_2307)) {
      var_02 common_scripts\utility::func_9D9F();
    }
  }
}

sewers_timer(param_00) {
  param_00 endon("death");
  param_00 endon("disconnect");
  param_00 endon("sewers_exit");
  while(level.sewer_timeout > 0) {
    wait(1);
    level.sewer_timeout--;
    if(level.sewer_timeout <= 60) {
      if(isDefined(param_00)) {
        param_00 thread sewers_flicker_flashlight();
      }
    }
  }

  level notify("sewer_timeout");
}

playersewersflashlightthink() {
  self endon("disconnect");
  for(;;) {
    if(lib_0547::func_5565(self.isinsewertrial, 1)) {
      if(playerinsewers()) {
        if(!isDefined(self.var_3D4C)) {
          lib_0551::func_3D52(1);
        } else if(common_scripts\utility::func_562E(self.flashlightflicker)) {
          lib_0551::func_3D52(0);
          wait 0.05;
          lib_0551::func_3D52(1);
          wait 0.05;
          lib_0551::func_3D52(0);
          wait 0.05;
          wait 0.05;
          lib_0551::func_3D52(1);
          wait 0.05;
          lib_0551::func_3D52(0);
          wait 0.05;
          wait 0.05;
          lib_0551::func_3D52(1);
        }
      }
    } else if(isDefined(self.var_3D4C)) {
      lib_0551::func_3D52(0);
    }

    wait(1);
  }
}

playerinsewers() {
  if(!isDefined(self)) {
    return 0;
  }

  if(!isPlayer(self)) {
    return 0;
  }

  return lib_055A::func_7413(self, "zone_sewers");
}

sewers_flicker_flashlight() {
  self.flashlightflicker = 1;
  wait(1);
  self.flashlightflicker = 0;
}

sewers_handle_zombies() {
  level endon("player_exitting_sewers");
  level endon("sewer_timeout");
  sewers_register_killed_func();
  if(!isDefined(level.sewer_zombies)) {
    level.sewer_zombies = [];
  }

  wait(0.5);
  var_00 = common_scripts\utility::func_46B7("zone_sewers_spawners", "targetname");
  for(;;) {
    wait(randomfloatrange(0.05, 0.25));
    if(!common_scripts\utility::func_562E(level.sewer_event_happening)) {
      break;
    }

    if(level.sewer_zombies.size < 4) {
      var_01 = sewers_spawn_zombie(var_00);
    }
  }
}

sewers_register_killed_func() {
  var_00 = ::sewers_clear_sewer_zombie_on_death;
  if(!isDefined(level.sewer_zombies)) {
    foreach(var_02 in level.var_376B) {
      if(var_02 == var_00) {
        return;
      }
    }
  }

  lib_0547::func_7BA9(::sewers_clear_sewer_zombie_on_death);
}

sewers_spawn_zombie(param_00) {
  var_01 = lib_054D::func_90BA("zombie_generic", common_scripts\utility::func_7A33(param_00), "sewer zombies", 0, 1, 1);
  if(!isDefined(var_01)) {
    return undefined;
  }

  var_01.issewerzombie = 1;
  var_01.var_6734 = 1;
  var_01.var_6816 = 1;
  var_01.var_C29 = 0;
  level.sewer_zombies[level.sewer_zombies.size] = var_01;
  var_01 thread sewers_zombie_track_zone();
  return var_01;
}

sewers_zombie_track_zone() {
  self endon("death");
  var_00 = getent("zone_sewers", "targetname");
  while(self istouching(var_00) || !common_scripts\utility::func_562E(self.var_4BA0)) {
    wait 0.05;
  }

  self.issewerzombie = 0;
  level.sewer_zombies = common_scripts\utility::func_F93(level.sewer_zombies, self);
}

sewers_clear_sewer_zombie_on_death(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08) {
  if(lib_0547::func_5565(self.issewerzombie, 1)) {
    level.sewer_zombies = common_scripts\utility::func_F93(level.sewer_zombies, self);
  }

  if(!isDefined(level.sewer_zombies) || level.sewer_zombies.size < 0) {
    lib_0547::func_2D8C(::sewers_clear_sewer_zombie_on_death);
  }
}

sewers_hitch_a_ride_back() {
  var_00 = self;
  var_00 endon("disconnect");
  var_00 notify("new_hitchhike");
  var_00 endon("new_hitchhike");
  var_01 = level.zmb_bonus_blood_tube_trig;
  var_00.hitchingaride = 1;
  var_00.inasneakyplace = 0;
  while(common_scripts\utility::func_562E(var_00.hitchingaride)) {
    var_01 notify("trigger", var_00);
    wait 0.05;
  }
}