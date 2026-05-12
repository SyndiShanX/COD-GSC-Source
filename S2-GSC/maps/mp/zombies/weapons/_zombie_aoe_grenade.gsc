/***********************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\zombies\weapons\_zombie_aoe_grenade.gsc
***********************************************************/

func_00D5() {
  initialize_pommel_grenade_pickups();
  register_pommel_step_func(::apply_health_to_players, "players", 1);
  register_pommel_step_func(::apply_damage_buff_to_players, "players", 1);
  register_pommel_step_func(::apply_special_meter_boost_to_players, "players", 1);
  lib_054D::register_grenadier_immune_zombie_equipment("island_grenade_hc_zm");
  lib_054D::register_persistent_tactical_zombie_equipment("island_grenade_hc_zm");
  level.damagebuffzonemultiplier = 1.6;
  level.powerbuffzonemultiplier = 1.8;
  level.var_0611["zmb_pommel_zmb_dmg"] = loadfx("vfx/zombie/prototype_fx/zmb_pommel_zmb_dmg");
  level.var_0611["zmb_pommel_energy_field"] = loadfx("vfx/zombie/prototype_fx/zmb_pommel_energy_field");
  level.var_0611["zmb_pommel_energy_field_burst"] = loadfx("vfx/zombie/prototype_fx/zmb_pommel_energy_field_burst");
  level.var_0611["zmb_pommel_pickup_energy"] = loadfx("vfx/zombie/prototype_fx/zmb_pommel_pickup_energy");
  level.var_0611["zmb_isl_geis_pommel_float"] = loadfx("vfx/map/mp_zombie_island/zmb_isl_geis_pommel_float");
  lib_0547::func_7BA9(::handle_pommel_kills);
  if(maps\mp\_utility::func_4571() != "mp_zombie_island") {
    init_pommel_aud();
  }

  level thread maps\mp\_utility::func_6F74(::init_pommel_kill_tracking);
  level thread maps\mp\_utility::func_6F74(::track_player_pommel_boosts);
  level thread maps\mp\_utility::func_6F74(::notify_pommel_fired);
  level thread maps\mp\_utility::func_6F74(::notify_pommel_picked_up);
  level thread maps\mp\_utility::func_6F74(::track_player_aoe_grenade);
  level.zmb_active_pommel_grenades = [];
}

notify_pommel_fired() {
  for(;;) {
    self waittill("grenade_fire", var_00, var_01);
    if(var_01 == "island_grenade_hc_zm") {
      thread handle_aoe_state_change("fired", var_01, 0);
    }
  }
}

notify_pommel_picked_up() {
  for(;;) {
    self waittill("weapon_switch_started", var_00);
    if(var_00 != "island_grenade_hc_zm") {
      thread handle_aoe_state_change("switching to other weapon", self getcurrentweapon(), 0);
      continue;
    } else {
      thread handle_aoe_state_change("switching to loaded sawgun", var_00, 1);
    }
  }
}

handle_aoe_state_change(param_00, param_01, param_02) {
  if(!lib_0547::func_5565("island_grenade_hc_zm", param_01)) {
    return;
  }

  if(param_02) {
    lib_0378::func_8D74("zmb_pomel_grenade_cook");
    return;
  }

  self notify("aud_stop_pomel_nade_cook");
}

initialize_pommel_grenade_pickups() {
  var_00 = common_scripts\utility::func_46B7("zmb_hc_grenade_pickup", "targetname");
  foreach(var_02 in var_00) {
    var_03 = common_scripts\utility::func_44BE(var_02.var_01A2, "targetname");
    foreach(var_05 in var_03) {
      switch (var_05.var_0165) {
        case "pommel_spawn":
          var_02.model_spawn = spawn("script_model", var_05.var_0116);
          var_02.model_spawn setModel("npc_zom_barb_pommel");
          var_02.model_spawn method_805C();
          var_02.var_3F2F = lib_0547::func_8FBA(var_05, "zmb_isl_geis_pommel_float");
          break;

        case "pommel_trigger":
          var_02.var_9D65 = var_05;
          break;
      }
    }
  }
}

spawn_pommel_special_pickup(param_00, param_01, param_02) {
  var_03 = common_scripts\utility::func_46B7("zmb_hc_grenade_pickup", "targetname");
  var_04 = undefined;
  foreach(var_06 in var_03) {
    if(lib_0547::func_5565(var_06.var_0165, param_00)) {
      var_04 = var_06;
      break;
    }
  }

  if(isDefined(param_02)) {
    var_04 = spawn("script_model", param_02);
    var_04 setModel("tag_origin");
    var_04.var_0116 = param_02;
    var_04.model_spawn = spawn("script_model", param_02);
    var_04.model_spawn setModel("npc_zom_barb_pommel");
    var_04.var_3F2F = spawnlinkedfx(common_scripts\utility::func_44F5("zmb_isl_geis_pommel_float"), var_04, "tag_origin");
    var_04 lib_0547::func_AC41(&"ZOMBIES_EMPTY_STRING", (0, 0, 8));
    level.zmb_spawned_pommel_pickup = var_04;
  }

  triggerfx(var_04.var_3F2F);
  var_04.model_spawn method_805B();
  var_04.model_spawn lib_0378::func_8D74("pommel_pickup");
  var_04 thread rotate_pommel();
  var_08 = 1;
  for(;;) {
    var_04.var_9D65 waittill("trigger", var_09);
    if(common_scripts\utility::func_0F79(var_09 getweaponslistall(), "island_grenade_hc_zm")) {
      continue;
    }

    if(var_08) {
      var_08 = 0;
      if(maps\mp\_utility::func_4571() == "mp_zombie_island") {
        maps\mp\gametypes\zombies::func_47A8("DLC1_ZM_DARKER");
      }
    }

    level thread maps\mp\zombies\_zombies_magicbox::func_A7D5(var_09, "island_grenade_hc_zm", undefined);
    var_09 thread lib_0367::func_8E3C("pommelpickup", level.var_744A);
    common_scripts\utility::func_3C8F(param_01);
  }
}

rotate_pommel() {
  self.var_9D65 endon("trigger");
  for(;;) {
    self.model_spawn rotateby((25, 25, 25), 1);
    wait(1);
  }
}

register_pommel_step_func(param_00, param_01, param_02) {
  if(!isDefined(level.pommel_step_funcs_zombies)) {
    level.pommel_step_funcs_zombies = [];
  }

  if(!isDefined(level.pommel_step_funcs_players)) {
    level.pommel_step_funcs_players = [];
  }

  var_03 = spawnStruct();
  var_03.var_3F02 = param_00;
  var_03.agent_target = param_01;
  var_03.looping = param_02;
  switch (param_01) {
    case "players":
      level.pommel_step_funcs_players = common_scripts\utility::func_0F6F(level.pommel_step_funcs_players, var_03);
      break;
  }
}

apply_health_to_players() {
  if(self.var_00BC < self.var_00FB) {
    self.var_00BC = self.var_00BC + 4;
  }

  if(self.var_00BC > self.var_00FB) {
    self.var_00BC = self.var_00FB;
  }
}

apply_damage_buff_to_players() {
  self.indamagebuffzone = 1;
}

apply_special_meter_boost_to_players() {
  self.powerbuffamount = level.powerbuffzonemultiplier;
}

track_player_aoe_grenade() {
  self endon("disconnect");
  self notify("new_pommel_tracking");
  self endon("new_pommel_tracking");
  var_00 = undefined;
  self.pommelkills = 0;
  for(;;) {
    self waittill("grenade_fire", var_01, var_02);
    if(isDefined(var_02) && issubstr(var_02, "island_grenade_hc_zm")) {
      var_03 = common_scripts\utility::func_A70F(8, var_01, "missile_stuck");
      if(!lib_0547::func_5565(var_03[1], "timeout")) {
        var_04 = var_01 replace_projectile_with_model();
        var_04 common_scripts\utility::func_3799("pommel_stone_running");
        level.zmb_active_pommel_grenades = common_scripts\utility::func_0F6F(level.zmb_active_pommel_grenades, var_04);
        playFX(level.var_0611["zmb_pommel_energy_field_burst"], var_04.var_0116);
        lib_0378::func_8D74("zmb_pomel_grenade_detonate", var_04.var_0116);
        var_05 = var_04 initial_burst(self);
        var_00 = thread handle_pommel_energy_field(var_04);
        var_04 thread run_pommel_aoe(var_05);
        var_04 common_scripts\utility::func_379C("pommel_stone_running");
        level.zmb_active_pommel_grenades = common_scripts\utility::func_0F93(level.zmb_active_pommel_grenades, var_04);
        playFX(level.var_0611["zmb_pommel_energy_field_burst"], var_04.var_0116);
        lib_0378::func_8D74("zmb_pomel_grenade_final_explosion", var_04.var_0116);
        var_05 = var_04 initial_burst(self);
        if(isDefined(var_00)) {
          var_00 delete();
        }

        self.pommelkills = 0;
        var_06 = 999;
        wait(8);
        for(;;) {
          var_07 = self.var_0116 + (0, 0, 48);
          var_06 = distance(var_07, var_04.var_0116);
          var_08 = var_06 / 950;
          if(var_08 < 0.125) {
            break;
          }

          var_04 lib_0378::func_8D74("zmb_pomel_grenade_float", self);
          var_04 moveto(var_07, var_08);
          wait(0.15);
        }

        lib_0378::func_8D74("zmb_pomel_grenade_retrieval");
        var_04 delete();
      } else {
        var_01 delete();
      }

      maps\mp\zombies\_zombies_magicbox::func_3AC1(self, "island_grenade_hc_zm");
    }
  }
}

handle_pommel_energy_field(param_00) {
  var_01 = spawnlinkedfx(common_scripts\utility::func_44F5("zmb_pommel_energy_field"), param_00.var_95AB, "TAG_ORIGIN");
  lib_0378::func_8D74("zmb_pomel_grenade_force_field", param_00.var_0116);
  triggerfx(var_01);
  return var_01;
}

run_pommel_aoe(param_00) {
  var_01 = param_00;
  var_02 = 1;
  var_03 = 15 * var_01 / 18 + 5;
  if(var_03 > 0) {
    var_04 = 0;
    while(var_04 < var_03) {
      var_02 = 0;
      var_04 = var_04 + 0.5;
      wait(0.5);
      var_04 = var_04 + 0.5;
    }
  } else {
    wait(2.5);
  }

  common_scripts\utility::func_379A("pommel_stone_running");
  self notify("pommel_done");
}

initial_burst(param_00) {
  var_01 = [];
  var_02 = lib_0547::func_408F();
  if(isDefined(level.additional_pommel_targets)) {
    var_02 = common_scripts\utility::func_0F73(var_02, level.additional_pommel_targets);
  }

  foreach(var_04 in var_02) {
    var_05 = var_04 is_close_to(self);
    if(!var_05) {
      continue;
    }

    var_01 = common_scripts\utility::func_0F6F(var_01, var_04);
  }

  var_07 = 0;
  foreach(var_04 in var_01) {
    if(function_01EF(var_04)) {
      var_04 thread zap_zombies_vfx();
      var_04 thread apply_pommel_damage(param_00, var_07);
      var_07++;
      continue;
    }

    var_04 notify("pommel_damage");
  }

  return var_07;
}

apply_pommel_damage(param_00, param_01) {
  var_02 = maps\mp\gametypes\zombies::func_1E59(lib_0547::func_0A51("zombie_generic"), 30);
  if(param_01 > 8) {
    var_02 = var_02 / 2;
  }

  self dodamage(var_02 / 2, self.var_0116, param_00, self, "MOD_RIFLE_BULLET", "island_grenade_hc_zm");
  wait 0.05;
  self dodamage(var_02 / 2, self.var_0116, param_00, self, "MOD_RIFLE_BULLET", "island_grenade_hc_zm");
}

register_as_pommel_grenade_target(param_00) {
  if(!isDefined(level.additional_pommel_targets)) {
    level.additional_pommel_targets = [];
  }

  level.additional_pommel_targets = common_scripts\utility::func_0F6F(level.additional_pommel_targets, param_00);
}

zap_zombies_vfx() {
  self endon("death");
  self.pommel_damage = spawnlinkedfx(level.var_0611["zmb_pommel_zmb_dmg"], self, "J_Spine4");
  triggerfx(self.pommel_damage);
  maps\mp\agents\_agent_utility::deleteentonagentdeath(self.pommel_damage);
  wait(0.5);
  if(isDefined(self.pommel_damage)) {
    self.pommel_damage delete();
  }
}

apply_pommel_funcs(param_00, param_01) {
  if(param_00 is_close_to(self)) {
    foreach(var_03 in param_01) {
      param_00 apply_aoe_func(var_03);
    }
  }
}

is_close_to(param_00) {
  if(distance(param_00.var_0116, self.var_0116) > 128) {
    return 0;
  }

  if(abs(param_00.var_0116[2] - self.var_0116[2]) > 64) {
    return 0;
  }

  return 1;
}

apply_aoe_func(param_00) {
  self thread[[param_00.var_3F02]]();
}

replace_projectile_with_model() {
  var_00 = spawn("script_model", self.var_0116);
  var_00 setModel("npc_zom_barb_pommel");
  var_00.var_95AB = spawn("script_model", var_00.var_0116);
  var_00.var_95AB setModel("tag_origin");
  var_00.var_95AB.var_001D = (-90, 0, 0);
  self delete();
  return var_00;
}

handle_pommel_kills(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08) {
  if(!isPlayer(param_01)) {
    return;
  }

  if(issubstr(param_04, "island_grenade_hc_zm")) {
    param_01.pommelkills++;
    param_01.lifetimepommelkills++;
    if(param_01.lifetimepommelkills == 250 && maps\mp\_utility::func_4571() == "mp_zombie_island") {
      param_01 maps\mp\gametypes\zombies::func_47C8("DLC1_ZM_POMMEL");
    }
  }
}

track_player_pommel_boosts() {
  self endon("disconnect");
  for(;;) {
    wait(0.5);
    var_00 = 0;
    foreach(var_02 in level.zmb_active_pommel_grenades) {
      if(is_close_to(var_02)) {
        var_00 = 1;
        apply_pommel_funcs(self, level.pommel_step_funcs_players);
      }
    }

    if(!var_00) {
      self.indamagebuffzone = 0;
      self.powerbuffamount = undefined;
    }
  }
}

init_pommel_kill_tracking() {
  self.lifetimepommelkills = 0;
}

init_pommel_aud() {
  lib_0378::func_8DC7("zmb_pomel_grenade_cook", ::zmb_pommel_grenade_cook);
  lib_0378::func_8DC7("zmb_pomel_grenade_detonate", ::zmb_pommel_grenade_detonate);
  lib_0378::func_8DC7("zmb_pomel_grenade_force_field", ::zmb_pommel_grenade_force_field);
  lib_0378::func_8DC7("zmb_pomel_grenade_final_explosion", ::zmb_pommel_grenade_final_explosion);
  lib_0378::func_8DC7("zmb_pomel_grenade_float", ::zmb_pommel_grenade_float);
  lib_0378::func_8DC7("zmb_pomel_grenade_retrieval", ::zmb_pommel_grenade_retrieval);
  lib_0378::func_8DC7("pommel_pickup", ::zmb_pommel_grenade_pickup);
}

zmb_pommel_grenade_cook() {
  var_00 = self;
  var_01 = lib_0380::func_6844("zmb_big_pommel_energy_lp", undefined, var_00, 0.5);
  var_00 waittill("aud_stop_pomel_nade_cook");
  lib_0380::func_6850(var_01);
  var_01 = undefined;
}

zmb_pommel_grenade_detonate(param_00) {
  lib_0380::func_2889("wpn_pomel_grenade_detonate", undefined, param_00);
}

zmb_pommel_grenade_force_field(param_00) {
  lib_0380::func_2889("wpn_pomel_grenade_force_field", undefined, param_00);
}

zmb_pommel_grenade_final_explosion(param_00) {
  lib_0380::func_2889("wpn_pomel_grenade_explosion", undefined, param_00);
}

zmb_pommel_grenade_float(param_00) {
  var_01 = self;
  var_02 = lib_0380::func_6844("zmb_pommel_energy_lp", undefined, var_01, 0.5);
  param_00 waittill("aud_stop_pommel_float_lp");
  lib_0380::func_6850(var_02);
  var_02 = undefined;
}

zmb_pommel_grenade_retrieval() {
  var_00 = self;
  var_00 notify("aud_stop_pommel_float_lp");
  lib_0380::func_288B("zmb_pommel_pick_up", undefined, var_00);
}

zmb_pommel_grenade_pickup() {
  var_00 = self;
  var_01 = var_00.var_0116;
  var_02 = lib_0380::func_6844("zmb_pommel_energy_lp", undefined, var_00, 1.5);
  level waittill("aud_stop_pommel_energy_loop");
  lib_0380::func_6850(var_02);
  var_02 = undefined;
  lib_0380::func_2889("zmb_pommel_pick_up", undefined, var_01);
}