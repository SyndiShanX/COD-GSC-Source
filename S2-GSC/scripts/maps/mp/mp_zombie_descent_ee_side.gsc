/*********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\mp_zombie_descent_ee_side.gsc
*********************************************************/

init() {
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
  var_0 = common_scripts\utility::_id_46B7("classic_corpse_object", "targetname");

  foreach(var_2 in var_0)
  var_2 thread classic_setup_corpse();

  thread classic_run_on_puzzle_start();
  thread classic_wait_for_jolts();
  thread classic_debug_init();
}

classic_run_on_puzzle_start(var_0, var_1) {
  if(!isDefined(var_0))
    var_0 = 0;

  if(!var_0)
    var_1 = level common_scripts\utility::_id_A715("team_classic_start", "team_vintage_start");

  if(var_1 == "team_classic_start") {
    var_2 = common_scripts\utility::_id_46B7("classic_teamone_eyeglow", "targetname");

    foreach(var_4 in var_2)
    var_4 thread classic_eye_flicker("blueGlow");
  } else if(var_1 == "team_vintage_start") {
    var_2 = common_scripts\utility::_id_46B7("classic_teamtwo_eyeglow", "targetname");

    foreach(var_4 in var_2)
    var_4 thread classic_eye_flicker("redGlow");
  }

  wait 3;
  var_8 = common_scripts\utility::_id_46B7("classic_corpse_object_minion", "targetname");

  foreach(var_10 in var_8) {
    if(!isDefined(var_10.eyeglow))
      var_10.eyeglow = [];

    var_11 = undefined;
    var_12 = undefined;

    if(var_10._id_8260 == "team_classic") {
      var_11 = "team_classic_start";
      var_12 = "blueGlow";
    } else if(var_10._id_8260 == "team_vintage") {
      var_11 = "team_vintage_start";
      var_12 = "redGlow";
    }

    if(isDefined(var_11)) {
      var_10.allyteam = var_11;
      var_10.eyes = common_scripts\utility::_id_46B7(var_10.target, "targetname");

      for(var_13 = 0; var_13 < var_10.eyes.size; var_13++) {
        if(!isDefined(var_10.eyeglow[var_13])) {
          var_14 = _func_14B(common_scripts\utility::_id_44F5(var_12), var_10.eyes[var_13].origin);
          var_10.eyeglow[var_13] = var_14;
          _func_14C(var_14);
        }
      }
    }
  }

  thread classic_minion_eye_counter(var_1);
}

classic_minion_eye_counter(var_0) {
  for(;;) {
    var_1 = level common_scripts\utility::_id_A715("classic_level_complete", "classic_fail_notify");
    thread classic_minion_glow_remove(var_1, var_0);
  }
}

classic_minion_glow_remove(var_0, var_1) {
  var_2 = common_scripts\utility::_id_46B7("classic_corpse_object_minion", "targetname");

  if(var_0 == "classic_level_complete") {
    foreach(var_4 in var_2) {
      if(var_4.allyteam != var_1 && isDefined(var_4.eyeglow) && var_4.eyeglow.size > 0) {
        foreach(var_6 in var_4.eyeglow) {
          var_4.eyeglow = common_scripts\utility::_id_0F93(var_4.eyeglow, var_6);
          var_6 delete();
        }

        break;
      }
    }
  } else if(var_0 == "classic_fail_notify") {
    foreach(var_4 in var_2) {
      if(var_4.allyteam == var_1 && isDefined(var_4.eyeglow) && var_4.eyeglow.size > 0) {
        foreach(var_6 in var_4.eyeglow) {
          var_4.eyeglow = common_scripts\utility::_id_0F93(var_4.eyeglow, var_6);
          var_6 delete();
        }

        break;
      }
    }
  }
}

classic_reset(var_0) {
  level.currentclassicdifficultylevel = 1;
  level.classicfails = 0;
  thread classic_run_on_puzzle_start(1, var_0);
}

classic_setup_corpse() {
  var_0 = common_scripts\utility::_id_44BE(self.target, "targetname");

  foreach(var_2 in var_0) {
    if(!isDefined(self.eyefxorg))
      self.eyefxorg = [];

    switch (var_2._id_0165) {
      case "eye_glow_struct":
        self.eyefxorg[self.eyefxorg.size] = var_2;
        break;
      case "classic_head":
        self._id_00B9 = var_2;
        self._id_00B9.upposition = self._id_00B9.origin;
        self._id_00B9.downposition = self._id_00B9.origin - (0, 0, 16);
        self._id_00B9 _meth_82C3(1);
        self._id_00B9.health = 1000000;
        break;
      case "classic_body":
        self._id_18A8 = var_2;
        self._id_18A8.upposition = self._id_18A8.origin;
        self._id_18A8.downposition = self._id_18A8.origin - (0, 0, 16);
        break;
    }
  }
}

classic_wait_for_jolts() {
  var_0 = _func_18E("classic_jolt_drop_trigger_teamone", "targetname");
  var_1 = _func_18E("classic_jolt_drop_trigger_teamtwo", "targetname");
  var_2 = undefined;
  var_3 = undefined;

  for(;;) {
    level waittill("spawned_money_share");

    foreach(var_5 in level._id_8AD2) {
      var_6 = 0;

      if(var_0 _meth_858B(var_5.origin)) {
        var_6 = 1;

        if(_id_0547::_id_5565(var_2, "teamVintage")) {
          continue;
        }
        var_2 = "teamClassic";
        var_3 = var_0;
        level notify("team_classic_start");
      }

      if(var_1 _meth_858B(var_5.origin)) {
        var_6 = 1;

        if(_id_0547::_id_5565(var_2, "teamClassic")) {
          continue;
        }
        var_2 = "teamVintage";
        var_3 = var_1;
        level notify("team_vintage_start");
      }

      if(!isDefined(var_2)) {
        continue;
      }
      if(!var_6) {
        continue;
      }
      var_7 = var_5._id_0117;
      var_8 = var_7 getentitynumber();
      var_5 _id_0544::_id_8ADD(var_8, 0);
      var_5._id_6FD4 = 0;
      var_5._id_6FCB = 0;
      thread classic_jolt_drop_fx(var_3.origin - (0, 0, 32));
      wait 3;
      classic_game_logic(var_2, var_7);

      if(level.currentclassicdifficultylevel > level.maxclassicdifficultylevel) {
        thread classic_complete(var_2);
        return;
      }

      break;
    }
  }
}

classic_eye_flicker(var_0) {
  var_1 = _func_14B(common_scripts\utility::_id_44F5(var_0), self.origin);
  _func_14C(var_1);

  for(var_2 = 0; var_2 < 60; var_2++) {
    var_1 _meth_805C();
    wait 0.01;
    var_1 _meth_805B();
    wait 0.01;
  }
}

classic_game_logic(var_0, var_1) {
  var_2 = 0;
  var_3 = 0;
  var_4 = 0;

  switch (level.currentclassicdifficultylevel) {
    case 1:
      var_2 = 4;
      var_4 = 1.25;
      var_3 = 6;
      break;
    case 2:
      var_2 = 3;
      var_4 = 0.75;
      var_3 = 8;
      break;
    case 3:
      var_2 = 2;
      var_4 = 0.25;
      var_3 = 10;
      break;
    default:
      break;
  }

  classic_reset_head_positions();
  wait 2;
  var_5 = 0;

  for(;;) {
    var_6 = common_scripts\utility::_id_46B7("classic_corpse_object", "targetname");
    var_7 = undefined;

    for(;;) {
      waitframe();
      var_7 = common_scripts\utility::random(var_6);

      if(common_scripts\utility::_id_562E(var_7._id_4B57))
        continue;
      else
        break;
    }

    var_8 = var_7 classic_head_popup(var_0, var_1, var_2);

    if(var_8) {
      var_5++;
      thread classic_victory_celebration();
    } else {
      classic_failure_celebration(var_0);
      break;
    }

    if(var_5 >= var_3) {
      classic_difficulty_complete_celebration();
      break;
    }

    wait(var_4);
  }
}

classic_head_popup(var_0, var_1, var_2) {
  self._id_00B9 _meth_82B1(self._id_00B9.upposition, 0.25);
  self._id_18A8 _meth_82B1(self._id_18A8.upposition, 0.25);
  var_3 = randomint(100);

  if(var_3 <= 90)
    var_4 = "enemy";
  else
    var_4 = "ally";

  if(!isDefined(self.eyeglowarray))
    self.eyeglowarray = [];

  foreach(var_6 in self.eyefxorg) {
    if(var_0 == "teamClassic") {
      if(var_4 == "ally")
        self.eyeglowarray[self.eyeglowarray.size] = _func_14B(common_scripts\utility::_id_44F5("blueGlow"), var_6.origin);
      else if(var_4 == "enemy")
        self.eyeglowarray[self.eyeglowarray.size] = _func_14B(common_scripts\utility::_id_44F5("redGlow"), var_6.origin);

      continue;
    }

    if(var_0 == "teamVintage") {
      if(var_4 == "ally") {
        self.eyeglowarray[self.eyeglowarray.size] = _func_14B(common_scripts\utility::_id_44F5("redGlow"), var_6.origin);
        continue;
      }

      if(var_4 == "enemy")
        self.eyeglowarray[self.eyeglowarray.size] = _func_14B(common_scripts\utility::_id_44F5("blueGlow"), var_6.origin);
    }
  }

  foreach(var_9 in self.eyeglowarray)
  _func_14C(var_9);

  self._id_00B9 thread classic_head_popup_waittill_timeout(var_2);
  self._id_00B9 thread classic_head_popup_waittill_damage(var_4, var_1);
  var_11 = self._id_00B9 common_scripts\utility::_id_A715("classic_head_popup_timeout", "classic_head_popup_damage");
  thread classic_head_remove_eye_glow();
  self._id_4B57 = 1;
  self._id_00B9.health = 1000000;

  if(var_11 == "classic_head_popup_damage") {
    if(var_4 == "enemy")
      return 1;
    else if(var_4 == "ally")
      return 0;
  } else if(var_11 == "classic_head_popup_timeout") {
    if(var_4 == "enemy")
      return 0;
    else if(var_4 == "ally")
      return 1;
  }
}

classic_head_popup_waittill_damage(var_0, var_1) {
  for(;;) {
    self waittill("damage", var_2, var_3);

    if(var_3 != var_1) {
      continue;
    }
    if(var_0 == "enemy") {
      self notify("classic_head_popup_damage");
      break;
    } else if(var_0 == "ally") {
      break;
    }
  }
}

classic_head_popup_waittill_timeout(var_0) {
  wait(var_0);
  self notify("classic_head_popup_timeout");
}

classic_reset_head_positions() {
  var_0 = common_scripts\utility::_id_46B7("classic_corpse_object", "targetname");

  foreach(var_2 in var_0) {
    var_2._id_00B9 _meth_82B1(var_2._id_00B9.downposition, 0.5, 0.25, 0.25);
    var_2._id_18A8 _meth_82B1(var_2._id_18A8.downposition, 0.5, 0.25, 0.25);
    var_2 thread classic_head_remove_eye_glow();
    var_2._id_4B57 = 0;
  }

  wait 0.5;
}

classic_head_remove_eye_glow() {
  if(isDefined(self.eyeglowarray)) {
    foreach(var_1 in self.eyeglowarray) {
      if(isDefined(var_1)) {
        self.eyeglowarray = common_scripts\utility::_id_0F93(self.eyeglowarray, var_1);
        var_1 delete();
      }
    }
  }
}

classic_failure_celebration(var_0) {
  level notify("classic_fail_notify");
  level.classicfails++;

  if(level.classicfails >= 3)
    thread classic_reset(var_0);

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

classic_complete(var_0) {
  if(var_0 == "teamClassic") {
    var_1 = common_scripts\utility::_id_46B7("vintage_leader_fire_fx_spawn", "targetname");

    foreach(var_3 in var_1) {
      var_4 = _func_14B(common_scripts\utility::_id_44F5("onFireLoop"), var_3.origin);
      _func_14C(var_4);
    }

    _id_0548::_id_09C8("ppsh41_classic_zm", "extended_mag", "none", "none");
    var_6 = common_scripts\utility::_id_46B5("classic_spawn_struct", "targetname");
    thread classic_jolt_drop_fx(var_6.origin);
    var_7 = _id_0586::create_streamed_world_weapon_model("ppsh41_classic_zm+extended_mag", var_6.origin);
    var_7.angles = var_6.angles;
    var_7 _id_0547::_id_AC41(&"ZOMBIES_CLASSIC", undefined, var_6.origin);
    var_7 classic_weapon_pickup("ppsh41_classic_zm+extended_mag");
  } else if(var_0 == "teamVintage") {
    var_1 = common_scripts\utility::_id_46B7("classic_leader_fire_fx_spawn", "targetname");

    foreach(var_3 in var_1) {
      var_4 = _func_14B(common_scripts\utility::_id_44F5("onFireLoop"), var_3.origin);
      _func_14C(var_4);
    }

    _id_0548::_id_09C8("mg42_vintage_zm", "extended_mag_mg42_zm", "none", "none");
    var_6 = common_scripts\utility::_id_46B5("vintage_spawn_struct", "targetname");
    thread classic_jolt_drop_fx(var_6.origin);
    var_7 = _id_0586::create_streamed_world_weapon_model("mg42_vintage_zm+extended_mag_mg42_zm", var_6.origin);
    var_7.angles = var_6.angles;
    var_7 _id_0547::_id_AC41(&"ZOMBIE_WEAPONDLC4_VINTAGE_MG42", undefined, var_6.origin);
    var_7 classic_weapon_pickup("mg42_vintage_zm+extended_mag_mg42_zm");
  }
}

classic_weapon_pickup(var_0) {
  self waittill("player_used", var_1);
  _id_0548::_id_A7D6(var_1, _id_0548::_id_454B(var_1, var_0));
  _id_0547::_id_AC40();
  self delete();
}

classic_jolt_drop_fx(var_0) {
  var_1 = _func_14B(common_scripts\utility::_id_44F5("moneyCloud"), var_0);
  _func_14C(var_1);
  wait 3;
  var_1 delete();
}

_______________________tower_deflect_______________________() {}

tower_deflect_init() {
  if(!isDefined(level.players) || level.players.size < 1)
    wait 1;

  foreach(var_1 in level.players)
  var_1 thread tower_deflect_wait_for_missile();
}

tower_deflect_wait_for_missile() {
  var_0 = self;
  var_1 = getEntArray("tower_deflection_trigger", "targetname");

  for(;;) {
    var_0 waittill("missile_fire", var_2, var_3);

    foreach(var_5 in var_1)
    var_5 thread tower_deflect_track_incoming_missile(var_0, var_2, var_3);

    waitframe();
  }
}

tower_deflect_track_incoming_missile(var_0, var_1, var_2) {
  var_0 endon("projectile_impact");
  var_1 endon("missile_hit_tower");

  for(;;) {
    if(isDefined(var_1) && self _meth_858B(var_1.origin)) {
      var_0 thread tower_deflect_fire_missile(var_1, var_2);
      var_1 delete();
      var_1 notify("missile_hit_tower");
    }

    waitframe();
  }
}

tower_deflect_fire_missile(var_0, var_1) {
  self endon("projectile_impact");
  var_2 = self.origin;
  var_3 = _func_1B5(var_1, var_0.origin, var_2);
  var_4 = 0;
  var_5 = _id_0547::_id_AAF9(var_1, 0, 0);

  switch (var_5) {
    case "fliegerfaust_zm":
    case "panzerschreck_zm":
    case "bazooka_zm":
      var_4 = 1;
  }

  if(var_4) {
    var_6 = undefined;

    for(;;) {
      if(isDefined(var_6))
        var_3 = var_6;

      wait 1.25;

      if(isDefined(var_3)) {
        var_6 = _func_1B5(var_1, var_3.origin, var_2);
        var_3 delete();
      }
    }
  }
}

_______________________grenade_hole_______________________() {}

grenade_hole_init() {
  if(!isDefined(level.players) || level.players.size < 1)
    wait 1;

  level.grenadeholecooldown = 0;

  foreach(var_1 in level.players)
  var_1 thread grenade_hole_wait_for_grenade();
}

grenade_hole_wait_for_grenade() {
  var_0 = self;
  var_1 = getEntArray("grenade_hole_trigger", "targetname");

  for(;;) {
    var_0 waittill("grenade_fire", var_2, var_3);

    if(var_3 != "frag_grenade_zm") {
      continue;
    }
    foreach(var_5 in var_1)
    var_5 thread grenade_hole_track_incoming_grenade(var_0, var_2, var_3);

    waitframe();
  }
}

grenade_hole_track_incoming_grenade(var_0, var_1, var_2) {
  var_0 endon("projectile_impact");
  var_1 endon("grenade_hit_hole");

  for(;;) {
    if(isDefined(var_1) && self _meth_858B(var_1.origin) && !level.grenadeholecooldown) {
      level.grenadeholecooldown = 1;
      var_1 delete();
      wait 2;
      thread grenade_hole_fire_grenades(var_2);
      wait 10;
      level.grenadeholecooldown = 0;
      var_1 notify("grenade_hit_hole");
    }

    waitframe();
  }
}

grenade_hole_fire_grenades(var_0) {
  var_1 = common_scripts\utility::_id_46B7(self.target, "targetname");

  foreach(var_3 in var_1)
  _func_071(var_0, var_3.origin, var_3.origin - (0, 0, 128), _func_0A5(2.5, 4));
}

_______________________outlaw_ravens_______________________() {}

ravens() {
  level.raven_manager = spawnStruct();
  level.raven_manager.raven_spawns = common_scripts\utility::_id_46B7("struct_raven", "targetname");
  level.raven_manager.gold_ravens = getEntArray("gold_ravens", "targetname");
  var_0 = _func_18E("starter_raven", "targetname");
  var_1 = common_scripts\utility::_id_46B5("starter_raven_dir", "targetname");
  var_2 = _func_18E("trig_starter_raven", "targetname");
  level.raven_manager.remaining = 4;
  level.raven_manager.selected_spawns = [];
  level.raven_manager._id_6E97 = [];
  raven_spawn_setup(level.raven_manager.raven_spawns);
  gold_raven_setup(level.raven_manager.gold_ravens);
  level.raven_manager thread gold_ravens_think();
  thread maps\mp\zombies\weapons\_zombie_raven_gun::init();

  for(var_3 = 0; !common_scripts\utility::_id_562E(var_3); var_3 = maps\mp\_utility::_id_3B8E(var_4, var_0, 80))
    var_2 waittill("trigger", var_4);

  var_0 _id_0378::_id_8D74("aud_raven_fly_away");
  playFX(common_scripts\utility::_id_44F5("zmb_dec_crows_fly"), var_1.origin, anglesToForward(var_1.angles));
  playFX(common_scripts\utility::_id_44F5("zmb_desc_raven_feathers_pop"), var_0.origin, var_1.angles);
  var_0 delete();
  var_2 delete();
  level.raven_manager raven_manager();
}

raven_spawn_setup(var_0) {
  foreach(var_2 in var_0) {
    var_3 = common_scripts\utility::_id_44BE(var_2.target, "targetname");

    foreach(var_5 in var_3) {
      switch (var_5._id_0165) {
        case "clip":
          var_2.raven_clip = var_5;
          var_2.raven_clip _meth_82C2();
          break;
      }
    }
  }
}

gold_raven_setup(var_0) {
  foreach(var_2 in var_0)
  var_2 _meth_805C();
}

gold_ravens_think() {
  var_0 = 0;
  var_1 = 0;

  while(!common_scripts\utility::_id_562E(var_0)) {
    level.raven_manager waittill("raven_shot");
    level.raven_manager.gold_ravens[var_1] _meth_805B();
    var_1++;

    if(var_1 >= 4) {
      break;
    }
  }

  common_scripts\utility::flag_set("flag_outlaw_raven_puzzle_complete");
  _id_0548::_id_09C8("raven_gun_zm", "none", "none", "none");
  spawn_raven_guns();
}

spawn_raven_guns() {
  var_0 = common_scripts\utility::_id_46B5("raven_gun_spawn", "targetname");
  var_1 = _id_0586::create_streamed_world_weapon_model("raven_gun_zm", var_0.origin);
  var_1.angles = var_0.angles;
  var_2 = _func_14B(common_scripts\utility::_id_44F5("zmb_desc_raven_feathers_pop"), var_0.origin);
  _func_14C(var_2);
  var_3 = _func_18E(var_0.target, "targetname");
  var_1 thread raven_gun_pickup(var_3);
}

raven_gun_pickup(var_0) {
  var_1 = 0;

  for(;;) {
    var_0 waittill("trigger", var_2);

    if(common_scripts\utility::_id_562E(var_2.hastakenravengun)) {
      continue;
    }
    var_2.hastakenravengun = 1;
    var_1++;
    self _meth_8006(var_2);
    var_3 = _func_258(common_scripts\utility::_id_44F5("zmb_desc_raven_feathers_pop"), self.origin, var_2);
    _func_14C(var_3);
    var_3 common_scripts\utility::_id_2CBE(1, ::delete);
    _id_0548::_id_A7D6(var_2, _id_0548::_id_454B(var_2, "raven_gun_zm"));
    waitframe();
  }
}

set_hidden_but_sent_to_player(var_0) {
  set_shown_only_to_player(var_0);
  self _meth_8511();
}

set_shown_only_to_player(var_0) {
  if(isDefined(var_0)) {
    self _meth_805C();
    self _meth_8005(var_0);
  } else
    self _meth_805B();
}

raven_manager() {
  for(var_0 = 0; var_0 < level.raven_manager.remaining; var_0++) {
    level.raven_manager.selected_spawns["spawn_" + var_0] = get_raven_spawn();
    level.raven_manager.selected_spawns["spawn_" + var_0] thread try_spawn_raven();
  }

  while(level.raven_manager.remaining > 0) {
    level.raven_manager.remaining--;
    level.raven_manager waittill("raven_shot");
  }

  foreach(var_2 in level.raven_manager._id_6E97)
  var_2 notify("outlaw_0_complete");
}

get_raven_spawn() {
  var_0 = undefined;

  while(!isDefined(var_0)) {
    var_1 = common_scripts\utility::random(level.raven_manager.raven_spawns);

    if(isDefined(var_1.isoccupied) && var_1.isoccupied == 1) {
      waitframe();
      continue;
    }

    var_0 = var_1;
  }

  var_0.isoccupied = 1;
  return var_0;
}

try_spawn_raven() {
  var_0 = self;
  var_1 = 1;

  while(common_scripts\utility::_id_562E(var_1)) {
    var_1 = 0;

    foreach(var_3 in level.players) {
      var_4 = maps\mp\_utility::_id_3B8E(var_3, var_0.raven_clip, 100);

      if(common_scripts\utility::_id_562E(var_4)) {
        var_5 = _func_07E(var_3 getEye(), var_0.origin, 0, var_3);

        if(_id_0547::_id_5565(var_5, 1))
          var_1 = 1;
      }
    }

    wait 1;
  }

  var_0 thread spawn_raven();
}

spawn_raven() {
  var_0 = self;
  var_1 = common_scripts\utility::_id_8FFC();
  var_1.origin = var_0.origin;

  if(isDefined(var_0.angles))
    var_1.angles = var_0.angles;
  else
    var_1.angles = (0, 0, 0);

  var_1 _meth_805B();
  var_1.raven_fx = _func_2A8(common_scripts\utility::_id_44F5("zmb_dec_crows_peck"), var_1, "Tag_Origin");
  _func_14C(var_1.raven_fx);
  var_1 _id_0378::_id_8D74("aud_spawn_raven");
  var_0.raven_clip _meth_82C1();
  var_0.raven_clip _meth_82C3(1);
  var_2 = 1;
  var_3 = undefined;
  var_4 = undefined;

  while(common_scripts\utility::_id_562E(var_2)) {
    var_0.raven_clip waittill("damage", var_5, var_4, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_3);

    if(isPlayer(var_4))
      var_2 = 0;
  }

  var_1 _id_0378::_id_8D74("aud_raven_fly_away");
  var_1.raven_fx delete();
  var_1 _meth_805C();
  playFX(common_scripts\utility::_id_44F5("zmb_dec_crows_fly"), var_1.origin, anglesToForward(var_1.angles));
  playFX(common_scripts\utility::_id_44F5("zmb_desc_raven_feathers_pop"), var_1.origin, anglesToForward(var_1.angles));
  var_1 delete();
  var_0.raven_clip _meth_82C2();
  var_0.raven_clip _meth_82C3(0);
  var_0.isoccupied = undefined;

  if(valid_raven_weapon(var_3)) {
    level.raven_manager notify("raven_shot");
    level.raven_manager._id_6E97[level.raven_manager._id_6E97.size] = var_4;
    thread spawn_punisher(var_4);
  } else {
    wait 15;
    var_0 = get_raven_spawn();
    var_0 thread try_spawn_raven();
  }
}

valid_raven_weapon(var_0) {
  if(!isDefined(var_0))
    return 0;

  if(issubstr(var_0, "m1911") || issubstr(var_0, "reich") || issubstr(var_0, "m712") || issubstr(var_0, "p38") || issubstr(var_0, "enfieldno2") || issubstr(var_0, "luger"))
    return 1;

  return 0;
}

spawn_punisher(var_0) {
  wait 1.4;
  var_1 = _id_054D::_id_90BA("zombie_dlc4", undefined, "raven punisher", 1, 1, 1);
  wait 0.5;
  var_1._id_5A36 = maps\mp\zombies\zombie_corpse_eater::get_max_zombies_to_eat();
  wait 0.5;
  var_1 punisher_track_player(var_0);
}

punisher_track_player(var_0) {
  var_1 = self;
  var_1 endon("death");

  if(!isDefined(var_0) || !isalive(var_0) || _id_0547::_id_577E(var_0)) {
    return;
  }
  var_1._id_1928 = var_0;

  while(isDefined(var_0) && isalive(var_0) && !_id_0547::_id_577E(var_0))
    waitframe();

  var_1._id_1928 = undefined;
}

_______________________dark_passenger_______________________() {}

dark_passenger_init() {
  level.dark_passenger = spawnStruct();
  level.dark_passenger.final_destination = common_scripts\utility::_id_46B5("struct_dark_passenger_end", "targetname");
  level.dark_passenger.complete = 0;
  level.dark_passenger.attempt_waves = [];
}

dark_passenger_test(var_0) {
  var_1 = undefined;
  var_2 = undefined;

  foreach(var_4 in var_0) {
    if(!isDefined(var_4)) {
      continue;
    }
    if(_id_0547::_id_5565(level.ravenweaponmanager["spike_emp"]._id_0117, var_4))
      var_1 = var_4;

    if(isDefined(var_4.ismooncontrolled) && var_4.ismooncontrolled == 1)
      var_2 = var_4;
  }

  if(isDefined(var_2) && isDefined(var_1))
    thread dark_passenger_run(var_1, var_2);
}

dark_passenger_zombie_setup() {
  var_0 = self;
  level.dark_passenger.dark_host = var_0;
  var_0.isdarkhost = 1;
  var_0.ispassiveexempt = 1;
  var_0._id_55AB = 1;
  var_0._id_562B = 1;
  var_0._id_0C29 = 0;
  var_0._id_297D = ::host_hc_zombie_custom_movemode;
  var_0.stall_mc_death = 1;
  var_0 dark_host_control_fx();
  var_0 maps\mp\agents\_agent_common::_id_83FD(var_0.maxhealth * 10);
  return var_0;
}

dark_passenger_track_org_for_detach() {
  var_0 = self;
  var_0 endon("dark_host_end_tracking");
  var_0.detachposarray = [];

  while(isDefined(var_0)) {
    var_0.detachposarray = common_scripts\utility::_id_0F86(var_0.detachposarray, var_0.origin, 0);
    wait 0.5;
  }
}

dark_host_control_fx() {
  self endon("death");

  if(isDefined(self.darkhostfx))
    self.darkhostfx delete();

  self notify("dark_host_fx_update");
  self.darkhostfx = _func_2A8(common_scripts\utility::_id_44F5("zmb_red_zmb_blind"), self, "j_head", 1);
  _func_14C(self.darkhostfx);
  self.darkhostfx thread _id_0547::_id_2D19(self);
}

host_hc_zombie_custom_movemode() {
  self._id_64C2 = 0.8 * _id_054D::_id_4440();
  return "sprint";
}

dark_passenger_player_setup(var_0) {
  var_1 = self;
  level.dark_passenger.dark_passenger = var_1;
  var_1 _meth_8322();
  var_1 _meth_812A(0);
  var_1 _meth_8114(0);
  var_1 _meth_8113(0);
  var_1 _meth_82FF("ui_hide_hud", 1);
  var_1.isdarkpassenger = 1;
  var_1 _meth_8003();
  var_0 _meth_8006(var_1);
  var_1 _id_0547::_id_8A6D(1);
  var_1 maps\mp\zombies\_zombies_blood_tubes::enable_blood_vision();
  var_1.safeposbeforepassenger = var_1.origin;
  var_1 thread dark_passenger_track_org_for_detach();
  var_1 dark_passenger_player_attach_to_host(var_0);
  var_1 thread dark_passenger_fury_think();
  var_1 thread dark_passenger_detach();
}

dark_passenger_player_attach_to_host(var_0) {
  var_1 = self;
  var_1.passenger_org = common_scripts\utility::_id_8FFC();
  var_1.passenger_org _meth_805B();
  var_2 = var_0 _meth_8566();
  var_3 = var_0 gettagorigin("tag_origin");
  var_1.darkhost = var_0;
  var_1.passenger_org.angles = var_2;
  var_4 = get_passenger_offset(var_0._id_0A4B);
  var_5 = var_0.origin + anglesToForward(var_0.angles) * var_4[1];
  var_1.passenger_org.origin = var_5;
  var_1 setOrigin(var_1.passenger_org.origin + var_4[0], 1);
  var_1 _meth_833E(var_1.passenger_org.angles);
  var_1.passenger_org linktosynchronizedparent(var_0, "TAG_ORIGIN");
  var_1 _meth_807B(var_1.passenger_org, "TAG_ORIGIN", 0.05);
}

get_passenger_offset(var_0) {
  var_1 = (0, 0, 0);
  var_2 = 12;

  switch (var_0) {
    case "zombie_generic":
      var_1 = (0, 0, 5);
      var_2 = -18;
      break;
    case "zombie_heavy":
      var_1 = (0, 0, 16);
      var_2 = -18;
      break;
    case "zombie_berserker":
      var_1 = (0, 0, 5);
      var_2 = -16;
      break;
    case "zombie_exploder":
      var_1 = (0, 0, 12);
      var_2 = -22;
      break;
    default:
      break;
  }

  return [var_1, var_2];
}

dark_passenger_detach(var_0) {
  var_1 = self;
  var_1 dark_passenger_detach_wait();
  var_1 _meth_8323();
  var_1 _meth_812A(1);
  var_1 _meth_8114(1);
  var_1 _meth_8113(1);
  var_1 _meth_8004();
  var_1 _meth_82FF("ui_hide_hud", 0);
  var_1 maps\mp\zombies\_zombies_blood_tubes::disable_blood_vision();
  var_1 _id_0547::_id_8A6D(0);
  var_1.isdarkpassenger = undefined;
  level.dark_passenger.dark_passenger = undefined;
  var_2 = (var_1.passenger_org.angles[0], var_1.passenger_org.angles[1], 0);
  var_1 _meth_833E(var_2);
  var_3 = var_1.passenger_org gettagorigin("TAG_ORIGIN");
  playFX(common_scripts\utility::_id_44F5("zmb_blood_blast"), var_3);
  var_1 notify("dark_host_end_tracking");
  var_4 = undefined;
  var_5 = var_1.detachposarray;
  var_1.detachposarray = undefined;
  var_5 = common_scripts\utility::_id_0F86(var_5, var_1.origin, 0);

  foreach(var_9, var_7 in var_5) {
    var_8 = var_1 dark_passenger_detach_safe_test(var_7);

    if(common_scripts\utility::_id_562E(var_8[0])) {
      var_4 = var_8[1];
      break;
    }
  }

  if(!isDefined(var_4))
    var_4 = var_1.safeposbeforepassenger;

  var_1 _meth_8057();
  var_1 setOrigin(var_4);
  var_1.safeposbeforepassenger = undefined;

  if(_id_0547::_id_5565(level.dark_passenger.complete, 0)) {
    var_1 _id_056A::_id_95D2();
    var_1 _meth_8059(var_1.health + 1, var_1.origin);
  }

  var_1.passenger_org delete();
}

dark_passenger_detach_safe_test(var_0) {
  var_1 = 64;
  var_2 = 32;
  var_3 = 0;
  var_4 = 4;
  var_5 = [0];

  if(isDefined(var_0)) {
    for(var_6 = 0; var_6 < 2; var_6++) {
      if(!isDefined(var_3))
        var_3 = 0;

      var_3 = var_3 + var_6 * var_4;
      var_7 = var_0 + (0, 0, var_3) + (0, 0, 2);
      var_8 = _func_293(var_7, var_2, var_1, self.darkhost, 0, 0, 1);

      if(common_scripts\utility::_id_562E(var_8)) {
        var_5 = [1, var_7];
        break;
      }
    }
  }

  return var_5;
}

dark_passenger_detach_wait() {
  var_0 = self;
  var_0.darkhost endon("death");
  var_0 waittill("dark_detach");
}

dark_passenger_fury_think() {
  var_0 = self;
  var_0 endon("disconnect");
  var_0 endon("death");
  var_0 childthread dark_passenger_cast_fury();

  while(isDefined(var_0.isdarkpassenger) && common_scripts\utility::_id_562E(var_0.isdarkpassenger)) {
    if(var_0 _meth_8343() || var_0 _meth_8342())
      var_0 notify("dark_fury_pressed");

    waitframe();
  }
}

dark_passenger_cast_fury() {
  var_0 = self;

  for(;;) {
    var_0 waittill("dark_fury_pressed");
    var_0 dark_fury();
    wait 10;
  }
}

dark_fury(var_0) {
  var_1 = self;
  var_2 = "moonorb_control_burst";

  if(isDefined(var_0))
    var_2 = var_0;

  var_3 = _id_0547::_id_408F();
  var_4 = _func_1AC(var_3, var_1.origin, 300, 1);
  playFX(common_scripts\utility::_id_44F5(var_2), var_1 getEye());

  foreach(var_6 in var_4) {
    if(_id_0547::_id_5565(var_1.darkhost, var_6)) {
      continue;
    }
    var_6 _meth_8059(var_6.maxhealth / 2, var_1.origin, var_1, var_1, "MOD_ENERGY");

    if(isDefined(var_6._id_0A4B)) {}
  }
}

dark_passenger_attempted_this_round() {
  var_0 = level._id_A980;

  foreach(var_2 in level.dark_passenger.attempt_waves) {
    if(_id_0547::_id_5565(var_0, var_2))
      return 1;
  }

  return 0;
}

dark_passenger_run(var_0, var_1) {
  if(dark_passenger_attempted_this_round() || common_scripts\utility::_id_562E(var_0.darkpassengercomplete)) {
    return;
  }
  level.dark_passenger.attempt_waves[level.dark_passenger.attempt_waves.size] = level._id_A980;
  var_1 dark_passenger_zombie_setup();
  var_0 dark_passenger_player_setup(var_1);
  _id_0547::register_allykilledfunc(::dark_passenger_host_dead);
  var_1._id_1928 = level.dark_passenger.final_destination;
  var_1 _id_053C::_id_4F7F("dark_passenger");
  var_1 walk_the_dark_path();
  _id_0547::deregister_allykilledfunc(::dark_passenger_host_dead);
}

dark_passenger_host_dead(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(_id_0547::_id_5565(self.isdarkhost, 1)) {
    if(isDefined(self.beingfedon)) {
      level.dark_passenger.complete = 1;
      level.dark_passenger notify("dark_traveled");
    }

    self.isdarkhost = undefined;
    level.dark_passenger.dark_host = undefined;
  }
}

walk_the_dark_path() {
  var_0 = self;
  var_0 endon("death");
  var_0 thread dark_passenger_spawn_eater();
  var_0 thread dark_passenger_host_eaten();

  while(isDefined(var_0._id_1928) && distance(var_0.origin, var_0._id_1928.origin) > 128)
    wait 1;

  var_0 suicide();
}

dark_passenger_host_eaten() {
  var_0 = self;
  var_0 endon("death");
  level waittill("corpse_eater_start_feed", var_1, var_2);

  if(!_id_0547::_id_5565(var_2, var_0)) {
    return;
  }
  var_1 endon("death");
  var_0.beingfedon = var_1;
  var_3 = level.dark_passenger.dark_passenger.passenger_org;
  var_3 _meth_8057();
  var_3 _meth_82B8(vectortoangles(var_1.origin - var_3.origin), 0.4);
  var_1 thread dark_passenger_end_condition();
}

dark_passenger_end_condition() {
  var_0 = self;
  level.dark_passenger waittill("dark_traveled");
  level.dark_passenger.dark_passenger dark_passenger_reward();
  level.dark_passenger.dark_passenger dark_fury("zmb_gk_geistblast_impact");
  var_0 suicide();
}

dark_passenger_spawn_eater() {
  wait 6;
  spawn_dark_eater(level.dark_passenger.dark_host);
}

spawn_dark_eater(var_0) {
  wait 1.4;
  var_1 = _id_054D::_id_90BA("zombie_dlc4", undefined, "raven punisher", 1, 1, 1);
  wait 0.5;
  var_1 dark_eater_track(var_0);
}

dark_eater_track(var_0) {
  var_1 = self;
  var_1 endon("death");
}

dark_passenger_reward() {
  var_0 = self;
  var_0 notify("dark_passenger_survived");
  var_0.darkpassengercomplete = 1;
  var_0 maps\mp\gametypes\zombies::_id_4798(10000);
  var_1 = ["quickrevive", "doubletap", "fastreload", "punchperk", "runperk", "electriccherry"];

  if(level._id_6F5C["quickrevive"]._id_6078 > -1) {
    if(!isDefined(var_0.numperkbuys))
      var_0.numperkbuys = [];

    if(!isDefined(var_0.numperkbuys["quickrevive"]))
      var_0.numperkbuys["quickrevive"] = 0;

    if(isDefined(var_0.numselfrevivedowns) && var_0.numselfrevivedowns >= level._id_6F5C["quickrevive"]._id_6078 && level.players.size == 1)
      var_1 = common_scripts\utility::_id_0F93(var_1, "quickrevive");
  }

  var_2 = common_scripts\utility::random(var_1);

  for(var_3 = 0; var_0 _id_056A::_id_4B7E(var_2); var_2 = common_scripts\utility::random(var_1)) {
    var_1 = common_scripts\utility::_id_0F93(var_1, var_2);

    if(var_1.size <= 0) {
      _id_0555::_id_83DD("blitz_owned", var_0);
      var_3 = 1;
      break;
    }
  }

  if(!isDefined(var_2)) {
    return;
  }
  var_0[[level._id_6F5C[var_2]._id_868B]]();
  self notify("perkmachine_activated");
  var_0 notify("perkmachine_activated", level._id_6F5C[var_2]);
  level notify("perkmachine_activated", level._id_6F5C[var_2]);
  level notify("perkmachine_player", level._id_6F5C[var_2], self.origin, var_0);
  var_0 _id_0547::_id_7ACD();
}

_______________________sewers_______________________() {}

sewers_init() {
  if(!common_scripts\utility::_id_3C83("flag_bonus_plates_filled"))
    common_scripts\utility::flag_init("flag_bonus_plates_filled");

  _id_0551::_id_3D50();
  level._id_3D4F = ["zmb_player_attached_light_wide"];
  level.sewer_spikes_collected = 0;
  level.sewer_spikes_placed = 0;
  level.spike_spawns = [];
  thread maps\mp\_utility::_id_6F74(::sewers_player_flashlight_think);
  var_0 = getEntArray("blitz_all_spikes_plinth", "targetname");

  foreach(var_2 in var_0) {
    var_2.placed = 0;
    var_2 _meth_805C();
  }

  var_4 = _func_18E("blitz_all_place_spike_trig", "targetname");
  var_4 thread sewers_spike_plinth_use_think(var_0);
  var_5 = common_scripts\utility::_id_46B7("blitz_all_spikes_spawn", "targetname");

  for(var_6 = []; var_6.size < var_0.size; var_5 = common_scripts\utility::_id_0F93(var_5, var_7)) {
    var_7 = common_scripts\utility::random(var_5);
    var_6 = common_scripts\utility::_id_0F6F(var_6, var_7);
  }

  level.spike_spawns = var_6;

  foreach(var_2 in level.spike_spawns) {
    var_2.use_trig = _func_18E(var_2.target, "targetname");
    var_2.use_trig _meth_8177(1);
    var_2.spike_model = spawn("script_model", var_2.origin);
    var_2.spike_model setModel("rem_railspike_01");
    var_2.spike_model.angles = var_2.angles;
    var_2 thread sewers_spike_use_think();
  }

  foreach(var_2 in var_5) {
    var_11 = _func_18E(var_2.target, "targetname");

    if(isDefined(var_11))
      var_11 delete();
  }

  level thread sewers_handle_shelf_fill();
  sewers_wait_for_all_plates_full();
  sewers_disable_plinth();
  common_scripts\utility::flag_set("flag_bonus_plates_filled");
  level sewers_handle_plinth_trap_door();
}

sewers_player_setup() {
  var_0 = self;
  var_0.istrial = "sewers";
}

sewers_player_flashlight_think() {
  self endon("disconnect");

  for(;;) {
    if(sewers_player_in_zone()) {
      if(!isDefined(self._id_3D4C))
        _id_0551::_id_3D52(1);
      else if(common_scripts\utility::_id_562E(self.flashlightflicker)) {
        _id_0551::_id_3D52(0);
        waitframe();
        _id_0551::_id_3D52(1);
        waitframe();
        _id_0551::_id_3D52(0);
        waitframe();
        waitframe();
        _id_0551::_id_3D52(1);
        waitframe();
        _id_0551::_id_3D52(0);
        waitframe();
        waitframe();
        _id_0551::_id_3D52(1);
      }
    } else if(isDefined(self._id_3D4C))
      _id_0551::_id_3D52(0);

    wait 1;
  }
}

sewers_player_in_zone() {
  if(!isDefined(self))
    return 0;

  if(!isPlayer(self))
    return 0;

  return _id_055A::_id_7413(self, "zone_sewers");
}

sewers_wait_for_all_plates_full() {
  level endon("flag_bonus_plates_filled");
  var_0 = common_scripts\utility::_id_46B7("blood_plate_struct", "targetname");
  var_1 = [];

  foreach(var_3 in var_0) {
    if(isDefined(var_3._id_8260)) {
      if(var_3._id_8260 == "plate_frontdoor" || var_3._id_8260 == "plate_bonus_room" || var_3._id_8260 == "plate_shelf")
        var_1 = common_scripts\utility::_id_0F6F(var_1, var_3);
    }
  }

  for(;;) {
    common_scripts\utility::_id_A70D(10, var_1[0], "blood_plate_full", var_1[1], "blood_plate_full", var_1[2], "blood_plate_full");
    var_5 = 1;

    foreach(var_7 in var_1) {
      if(!common_scripts\utility::_id_562E(var_7.isbloodfull)) {
        var_5 = 0;
        break;
      }
    }

    if(var_5) {
      break;
    }
  }
}

run_shelf_visit() {
  var_0 = self;
  level.shelf_timeout = 60;
  var_1 = level.blood_plates["shelf"];
  var_0.inasneakyplace = 1;

  if(isDefined(var_1)) {
    if(common_scripts\utility::_id_562E(var_1.isbloodfull))
      level.shelf_timeout = 30;
    else
      thread sewers_shelf_handle_zombies();
  }

  level.shelf_event_happening = 1;
  thread sewers_shelf_timer();
  [var_3, var_4] = common_scripts\utility::_id_A70E(level, "shelf_timeout", level, "players_exitted_shelf", var_0, "death", var_0, "disconnect", var_0, "begin_last_stand");

  if(_id_0547::_id_5565(var_3, "shelf_timeout") || _id_0547::_id_5565(var_3, "begin_last_stand"))
    sewers_shelf_boot_players_from_shelf();

  var_0.inasneakyplace = 0;
  return 1;
}

sewers_shelf_boot_players_from_shelf() {
  var_0 = common_scripts\utility::_id_46B7("shelf_timeout_points", "targetname");

  while(sewers_any_player_in_shelf()) {
    for(var_1 = 0; var_1 < level.players.size; var_1++) {
      if(!isDefined(level.zmb_temp_moon_orb_ent)) {
        level.zmb_temp_moon_orb_ent = level.players[var_1] common_scripts\utility::_id_8FFC();
        level.zmb_temp_moon_orb_ent _meth_805B();
      } else
        level.zmb_temp_moon_orb_ent.origin = level.players[var_1].origin;

      if(common_scripts\utility::_id_562E(level.players[var_1].isinshelfevent))
        level.players[var_1] maps\mp\zombies\weapons\_zombie_dlc4_melee::do_moon_orb_teleportation(var_0[var_1].origin, level.zmb_temp_moon_orb_ent);
    }
  }

  if(isDefined(level.zmb_temp_moon_orb_ent))
    level.zmb_temp_moon_orb_ent delete();
}

sewers_shelf_force_orb_teleport_return() {
  self.inasneakyplace = 0;
  level.shelf_event_happening = 0;
}

sewers_handle_shelf_fill() {
  level thread sewers_shelf_mark_shelf_event_goers();

  for(;;) {
    level waittill("player_entered_shelf", var_0);

    if(!common_scripts\utility::_id_562E(level.shelf_event_happening))
      var_0 thread maps\mp\mp_zombie_descent_ee_main::run_weapon_ritual("zom_shelf_trial_destination");
  }
}

sewers_shelf_handle_zombies() {
  level endon("shelf_timeout");
  level endon("players_exitted_shelf");
  var_0 = common_scripts\utility::_id_46B5("bridge_shelf_spawner", "targetname");
  sewers_shelf_register_killed_func();

  if(!isDefined(level.shelf_zombies))
    level.shelf_zombies = [];

  wait 0.5;

  for(var_1 = level.shelf_zombies.size; var_1 < 8; var_1++) {
    wait(_func_0A5(1, 2));

    if(var_1 == 5)
      var_2 = "zombie_heavy";
    else
      var_2 = common_scripts\utility::random(["zombie_generic", "zombie_berserker"]);

    var_3 = sewers_shelf_spawn_zombie([var_0], var_2);
  }
}

sewers_shelf_register_killed_func() {
  var_0 = ::sewers_clear_shelf_zombie_on_death;

  if(!isDefined(level.shelf_zombies)) {
    foreach(var_2 in level._id_376B) {
      if(var_2 == var_0)
        return;
    }
  }

  _id_0547::_id_7BA9(::sewers_clear_shelf_zombie_on_death);
}

sewers_shelf_spawn_zombie(var_0, var_1) {
  var_2 = _id_054D::_id_90BA(var_1, common_scripts\utility::random(var_0), "shelf zombies", 0, 1, 1);

  if(!isDefined(var_2))
    return undefined;

  var_2.isshelfzombie = 1;
  var_2.isintrial = "zom_shelf_trial_destination";
  var_2._id_6734 = 1;
  level.shelf_zombies[level.shelf_zombies.size] = var_2;
  var_2 thread sewers_shelf_zombie_track_zone();
  return var_2;
}

sewers_shelf_zombie_track_zone() {
  self endon("death");
  var_0 = _func_18E("bridge_shelf", "targetname");

  while(self istouching(var_0) || !common_scripts\utility::_id_562E(self._id_4BA0))
    waitframe();

  self.isshelfzombie = 0;
  level.shelf_zombies = common_scripts\utility::_id_0F93(level.shelf_zombies, self);
}

sewers_clear_shelf_zombie_on_death(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(_id_0547::_id_5565(self.isshelfzombie, 1))
    level.shelf_zombies = common_scripts\utility::_id_0F93(level.shelf_zombies, self);

  if(!isDefined(level.shelf_zombies) || level.shelf_zombies.size < 0)
    _id_0547::_id_2D8C(::sewers_clear_sewer_zombie_on_death);
}

sewers_shelf_mark_shelf_event_goers() {
  _id_0547::_id_A78B();

  for(;;) {
    var_0 = undefined;

    foreach(var_2 in level.players) {
      if(var_2 sewers_is_player_in_shelf() && !_id_0547::_id_577E(var_2)) {
        var_0 = var_2;
        var_2.isinshelfevent = 1;
        continue;
      }

      var_2.isinshelfevent = 0;
    }

    if(isDefined(var_0)) {
      if(!common_scripts\utility::_id_562E(level.shelf_event_happening))
        level notify("player_entered_shelf", var_0);
    } else if(common_scripts\utility::_id_562E(level.shelf_event_happening))
      level notify("players_exitted_shelf");

    waitframe();
  }
}

sewers_is_player_in_shelf() {
  var_0 = _func_18E("bridge_shelf", "targetname");

  if(self istouching(var_0))
    return 1;
  else
    return 0;
}

sewers_any_player_in_shelf() {
  var_0 = 0;

  foreach(var_2 in level.players) {
    if(_id_0547::_id_57E1(var_2)) {
      continue;
    }
    if(var_2.sessionstate == "spectator") {
      continue;
    }
    if(var_2 sewers_is_player_in_shelf())
      return 1;
  }

  return 0;
}

sewers_shelf_timer() {
  while(level.shelf_timeout > 0) {
    wait 1;
    level.shelf_timeout--;
  }

  level notify("shelf_timeout");
}

run_sewers_visit() {
  var_0 = self;
  var_0 thread sewers_trial();
  level waittill("player_exitting_sewers");
  return 0;
}

sewers_trial() {
  var_0 = self;
  level.sewer_timeout = 180;
  thread sewers_handle_zombies();
  level.sewer_event_happening = 1;
  thread sewers_timer(var_0);
  common_scripts\utility::_id_A70C(level, "sewer_timeout", var_0, "sewers_exit", var_0, "death", var_0, "disconnect");

  if(isDefined(var_0))
    level notify("player_exitting_sewers", var_0);
  else
    level notify("player_exitting_sewers");

  level.sewer_event_happening = 0;

  foreach(var_2 in level.sewer_zombies)
  var_2 suicide();

  level.sewer_zombies = [];

  if(isDefined(level.moon_orb_manager) && isDefined(level.moon_orb_manager["moonscepter_orb_active"]))
    level.moon_orb_manager["moonscepter_orb_active"] notify("moonorb_trial_end_stagnate");
}

sewers_handle_plinth_trap_door() {
  var_0 = _func_18E("mdl_sewers_exit_manhole", "targetname");
  var_1 = _func_18E("mdl_sewers_exit_manhole_clip", "targetname");

  for(;;) {
    level waittill("all_perkmachine_activated", var_2);
    var_2 notify("sewers_exit");
    var_2 notify("blood_is_power");
  }
}

sewers_spike_use_think() {
  common_scripts\utility::_id_A70C(self.use_trig, "trigger", level, "all_sewer_spikes_placed");
  self.spike_model delete();
  self.use_trig delete();
  level.sewer_spikes_collected++;
}

sewers_spike_plinth_use_think(var_0) {
  for(;;) {
    [var_2, var_3] = common_scripts\utility::_id_A70E(self, "trigger", level, "all_sewer_spikes_placed");

    if(_id_0547::_id_5565(var_2, "all_sewer_spikes_placed")) {
      foreach(var_5 in var_0) {
        if(common_scripts\utility::_id_562E(var_5.placed)) {
          continue;
        }
        var_5 thread sewers_spike_plinth_place();
      }
    } else {
      if(level.sewer_spikes_placed == level.sewer_spikes_collected) {
        continue;
      }
      foreach(var_5 in var_0) {
        if(common_scripts\utility::_id_562E(var_5.placed)) {
          continue;
        }
        if(level.sewer_spikes_placed < level.sewer_spikes_collected)
          var_5 sewers_spike_plinth_place();
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
  self _meth_805B();
  var_0 = common_scripts\utility::_id_46B5(self.target, "targetname");
  self _meth_82B1(var_0.origin, 0.5, 0.2, 0.2);
  level.sewer_spikes_placed++;
  self.placed = 1;
}

sewers_enable_plinth() {
  var_0 = getEntArray("all_perk_buy", "targetname");

  foreach(var_2 in var_0) {
    if(common_scripts\utility::_id_562E(var_2._id_2307))
      var_2 common_scripts\utility::_id_9DA3();
  }
}

sewers_disable_plinth() {
  var_0 = getEntArray("all_perk_buy", "targetname");

  foreach(var_2 in var_0) {
    if(common_scripts\utility::_id_562E(var_2._id_2307))
      var_2 common_scripts\utility::_id_9D9F();
  }
}

sewers_timer(var_0) {
  var_0 endon("death");
  var_0 endon("disconnect");
  var_0 endon("sewers_exit");

  while(level.sewer_timeout > 0) {
    wait 1;
    level.sewer_timeout--;

    if(level.sewer_timeout <= 60.0) {
      if(isDefined(var_0))
        var_0 thread sewers_flicker_flashlight();
    }
  }

  level notify("sewer_timeout");
}

playersewersflashlightthink() {
  self endon("disconnect");

  for(;;) {
    if(_id_0547::_id_5565(self.isinsewertrial, 1)) {
      if(playerinsewers()) {
        if(!isDefined(self._id_3D4C))
          _id_0551::_id_3D52(1);
        else if(common_scripts\utility::_id_562E(self.flashlightflicker)) {
          _id_0551::_id_3D52(0);
          waitframe();
          _id_0551::_id_3D52(1);
          waitframe();
          _id_0551::_id_3D52(0);
          waitframe();
          waitframe();
          _id_0551::_id_3D52(1);
          waitframe();
          _id_0551::_id_3D52(0);
          waitframe();
          waitframe();
          _id_0551::_id_3D52(1);
        }
      }
    } else if(isDefined(self._id_3D4C))
      _id_0551::_id_3D52(0);

    wait 1;
  }
}

playerinsewers() {
  if(!isDefined(self))
    return 0;

  if(!isPlayer(self))
    return 0;

  return _id_055A::_id_7413(self, "zone_sewers");
}

sewers_flicker_flashlight() {
  self.flashlightflicker = 1;
  wait 1;
  self.flashlightflicker = 0;
}

sewers_handle_zombies() {
  level endon("player_exitting_sewers");
  level endon("sewer_timeout");
  sewers_register_killed_func();

  if(!isDefined(level.sewer_zombies))
    level.sewer_zombies = [];

  wait 0.5;
  var_0 = common_scripts\utility::_id_46B7("zone_sewers_spawners", "targetname");

  for(;;) {
    wait(_func_0A5(0.05, 0.25));

    if(!common_scripts\utility::_id_562E(level.sewer_event_happening)) {
      break;
    }

    if(level.sewer_zombies.size < 4)
      var_1 = sewers_spawn_zombie(var_0);
  }
}

sewers_register_killed_func() {
  var_0 = ::sewers_clear_sewer_zombie_on_death;

  if(!isDefined(level.sewer_zombies)) {
    foreach(var_2 in level._id_376B) {
      if(var_2 == var_0)
        return;
    }
  }

  _id_0547::_id_7BA9(::sewers_clear_sewer_zombie_on_death);
}

sewers_spawn_zombie(var_0) {
  var_1 = _id_054D::_id_90BA("zombie_generic", common_scripts\utility::random(var_0), "sewer zombies", 0, 1, 1);

  if(!isDefined(var_1))
    return undefined;

  var_1.issewerzombie = 1;
  var_1._id_6734 = 1;
  var_1._id_6816 = 1;
  var_1._id_0C29 = 0;
  level.sewer_zombies[level.sewer_zombies.size] = var_1;
  var_1 thread sewers_zombie_track_zone();
  return var_1;
}

sewers_zombie_track_zone() {
  self endon("death");
  var_0 = _func_18E("zone_sewers", "targetname");

  while(self istouching(var_0) || !common_scripts\utility::_id_562E(self._id_4BA0))
    waitframe();

  self.issewerzombie = 0;
  level.sewer_zombies = common_scripts\utility::_id_0F93(level.sewer_zombies, self);
}

sewers_clear_sewer_zombie_on_death(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(_id_0547::_id_5565(self.issewerzombie, 1))
    level.sewer_zombies = common_scripts\utility::_id_0F93(level.sewer_zombies, self);

  if(!isDefined(level.sewer_zombies) || level.sewer_zombies.size < 0)
    _id_0547::_id_2D8C(::sewers_clear_sewer_zombie_on_death);
}

sewers_hitch_a_ride_back() {
  var_0 = self;
  var_0 endon("disconnect");
  var_0 notify("new_hitchhike");
  var_0 endon("new_hitchhike");
  var_1 = level.zmb_bonus_blood_tube_trig;
  var_0.hitchingaride = 1;
  var_0.inasneakyplace = 0;

  while(common_scripts\utility::_id_562E(var_0.hitchingaride)) {
    var_1 notify("trigger", var_0);
    waitframe();
  }
}