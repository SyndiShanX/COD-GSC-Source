/*******************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\zombies\weapons\_zombie_aoe_grenade.gsc
*******************************************************************/

init() {
  initialize_pommel_grenade_pickups();
  register_pommel_step_func(::apply_health_to_players, "players", 1);
  register_pommel_step_func(::apply_damage_buff_to_players, "players", 1);
  register_pommel_step_func(::apply_special_meter_boost_to_players, "players", 1);
  _id_054D::register_grenadier_immune_zombie_equipment("island_grenade_hc_zm");
  _id_054D::register_persistent_tactical_zombie_equipment("island_grenade_hc_zm");
  level.damagebuffzonemultiplier = 1.6;
  level.powerbuffzonemultiplier = 1.8;
  level._effect["zmb_pommel_zmb_dmg"] = loadfx("vfx/zombie/prototype_fx/zmb_pommel_zmb_dmg");
  level._effect["zmb_pommel_energy_field"] = loadfx("vfx/zombie/prototype_fx/zmb_pommel_energy_field");
  level._effect["zmb_pommel_energy_field_burst"] = loadfx("vfx/zombie/prototype_fx/zmb_pommel_energy_field_burst");
  level._effect["zmb_pommel_pickup_energy"] = loadfx("vfx/zombie/prototype_fx/zmb_pommel_pickup_energy");
  level._effect["zmb_isl_geis_pommel_float"] = loadfx("vfx/map/mp_zombie_island/zmb_isl_geis_pommel_float");
  _id_0547::_id_7BA9(::handle_pommel_kills);

  if(maps\mp\_utility::_id_4571() != "mp_zombie_island") {
    init_pommel_aud();
  }

  level thread maps\mp\_utility::_id_6F74(::init_pommel_kill_tracking);
  level thread maps\mp\_utility::_id_6F74(::track_player_pommel_boosts);
  level thread maps\mp\_utility::_id_6F74(::notify_pommel_fired);
  level thread maps\mp\_utility::_id_6F74(::notify_pommel_picked_up);
  level thread maps\mp\_utility::_id_6F74(::track_player_aoe_grenade);
  level.zmb_active_pommel_grenades = [];
}

notify_pommel_fired() {
  for(;;) {
    self waittill("grenade_fire", var_0, var_1);

    if(var_1 == "island_grenade_hc_zm") {
      thread handle_aoe_state_change("fired", var_1, 0);
    }
  }
}

notify_pommel_picked_up() {
  for(;;) {
    self waittill("weapon_switch_started", var_0);

    if(var_0 != "island_grenade_hc_zm") {
      thread handle_aoe_state_change("switching to other weapon", self getcurrentweapon(), 0);
      continue;
    } else
      thread handle_aoe_state_change("switching to loaded sawgun", var_0, 1);
  }
}

handle_aoe_state_change(var_0, var_1, var_2) {
  if(!_id_0547::_id_5565("island_grenade_hc_zm", var_1)) {
    return;
  }
  if(var_2) {
    _id_0378::_id_8D74("zmb_pomel_grenade_cook");
  } else {
    self notify("aud_stop_pomel_nade_cook");
  }
}

initialize_pommel_grenade_pickups() {
  var_0 = common_scripts\utility::_id_46B7("zmb_hc_grenade_pickup", "targetname");

  foreach(var_2 in var_0) {
    var_3 = common_scripts\utility::_id_44BE(var_2.target, "targetname");

    foreach(var_5 in var_3) {
      switch (var_5._id_0165) {
        case "pommel_spawn":
          var_2.model_spawn = spawn("script_model", var_5.origin);
          var_2.model_spawn setModel("npc_zom_barb_pommel");
          var_2.model_spawn hide();
          var_2.fx = _id_0547::_id_8FBA(var_5, "zmb_isl_geis_pommel_float");
          break;
        case "pommel_trigger":
          var_2._id_9D65 = var_5;
          break;
      }
    }
  }
}

spawn_pommel_special_pickup(var_0, var_1, var_2) {
  var_3 = common_scripts\utility::_id_46B7("zmb_hc_grenade_pickup", "targetname");
  var_4 = undefined;

  foreach(var_6 in var_3) {
    if(_id_0547::_id_5565(var_6._id_0165, var_0)) {
      var_4 = var_6;
      break;
    }
  }

  if(isDefined(var_2)) {
    var_4 = spawn("script_model", var_2);
    var_4 setModel("tag_origin");
    var_4.origin = var_2;
    var_4.model_spawn = spawn("script_model", var_2);
    var_4.model_spawn setModel("npc_zom_barb_pommel");
    var_4.fx = _spawnlinkedfx(common_scripts\utility::_id_44F5("zmb_isl_geis_pommel_float"), var_4, "tag_origin");
    var_4 _id_0547::_id_AC41(&"ZOMBIES_EMPTY_STRING", (0, 0, 8));
    level.zmb_spawned_pommel_pickup = var_4;
  }

  _triggerfx(var_4.fx);
  var_4.model_spawn show();
  var_4.model_spawn _id_0378::_id_8D74("pommel_pickup");
  var_4 thread rotate_pommel();
  var_8 = 1;

  for(;;) {
    var_4._id_9D65 waittill("trigger", var_9);

    if(common_scripts\utility::_id_0F79(var_9 getweaponlistall(), "island_grenade_hc_zm")) {
      continue;
    }
    if(var_8) {
      var_8 = 0;

      if(maps\mp\_utility::_id_4571() == "mp_zombie_island") {
        maps\mp\gametypes\zombies::_id_47A8("DLC1_ZM_DARKER");
      }
    }

    level thread _id_0548::_id_A7D5(var_9, "island_grenade_hc_zm", undefined);
    var_9 thread _id_0367::_id_8E3C("pommelpickup", level.players);
    common_scripts\utility::flag_set(var_1);
  }
}

rotate_pommel() {
  self._id_9D65 endon("trigger");

  for(;;) {
    self.model_spawn rotateby((25, 25, 25), 1);
    wait 1;
  }
}

register_pommel_step_func(var_0, var_1, var_2) {
  if(!isDefined(level.pommel_step_funcs_zombies)) {
    level.pommel_step_funcs_zombies = [];
  }

  if(!isDefined(level.pommel_step_funcs_players)) {
    level.pommel_step_funcs_players = [];
  }

  var_3 = spawnStruct();
  var_3._id_3F02 = var_0;
  var_3.agent_target = var_1;
  var_3.looping = var_2;

  switch (var_1) {
    case "players":
      level.pommel_step_funcs_players = common_scripts\utility::_id_0F6F(level.pommel_step_funcs_players, var_3);
      break;
  }
}

apply_health_to_players() {
  if(self.health < self.maxhealth) {
    self.health = self.health + 4;
  }

  if(self.health > self.maxhealth) {
    self.health = self.maxhealth;
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
  var_0 = undefined;
  self.pommelkills = 0;

  for(;;) {
    self waittill("grenade_fire", var_1, var_2);

    if(isDefined(var_2) && issubstr(var_2, "island_grenade_hc_zm")) {
      var_3 = common_scripts\utility::_id_A70F(8, var_1, "missile_stuck");

      if(!_id_0547::_id_5565(var_3[1], "timeout")) {
        var_4 = var_1 replace_projectile_with_model();
        var_4 common_scripts\utility::_id_3799("pommel_stone_running");
        level.zmb_active_pommel_grenades = common_scripts\utility::_id_0F6F(level.zmb_active_pommel_grenades, var_4);
        playFX(level._effect["zmb_pommel_energy_field_burst"], var_4.origin);
        _id_0378::_id_8D74("zmb_pomel_grenade_detonate", var_4.origin);
        var_5 = var_4 initial_burst(self);
        var_0 = thread handle_pommel_energy_field(var_4);
        var_4 thread run_pommel_aoe(var_5);
        var_4 common_scripts\utility::_id_379C("pommel_stone_running");
        level.zmb_active_pommel_grenades = common_scripts\utility::_id_0F93(level.zmb_active_pommel_grenades, var_4);
        playFX(level._effect["zmb_pommel_energy_field_burst"], var_4.origin);
        _id_0378::_id_8D74("zmb_pomel_grenade_final_explosion", var_4.origin);
        var_5 = var_4 initial_burst(self);

        if(isDefined(var_0)) {
          var_0 delete();
        }

        self.pommelkills = 0;
        var_6 = 999;
        wait 8;

        for(;;) {
          var_7 = self.origin + (0, 0, 48);
          var_6 = distance(var_7, var_4.origin);
          var_8 = var_6 / 950;

          if(var_8 < 0.125) {
            break;
          }

          var_4 _id_0378::_id_8D74("zmb_pomel_grenade_float", self);
          var_4 moveTo(var_7, var_8);
          wait 0.15;
        }

        _id_0378::_id_8D74("zmb_pomel_grenade_retrieval");
        var_4 delete();
      } else
        var_1 delete();

      _id_0548::_id_3AC1(self, "island_grenade_hc_zm");
    }
  }
}

handle_pommel_energy_field(var_0) {
  var_1 = _spawnlinkedfx(common_scripts\utility::_id_44F5("zmb_pommel_energy_field"), var_0._id_95AB, "TAG_ORIGIN");
  _id_0378::_id_8D74("zmb_pomel_grenade_force_field", var_0.origin);
  _triggerfx(var_1);
  return var_1;
}

run_pommel_aoe(var_0) {
  var_1 = var_0;
  var_2 = 1;
  var_3 = 15 * (var_1 / 18) + 5;

  if(var_3 > 0) {
    for(var_4 = 0; var_4 < var_3; var_4 = var_4 + 0.5) {
      var_2 = 0;
      var_4 = var_4 + 0.5;
      wait 0.5;
    }
  } else
    wait 2.5;

  common_scripts\utility::_id_379A("pommel_stone_running");
  self notify("pommel_done");
}

initial_burst(var_0) {
  var_1 = [];
  var_2 = _id_0547::_id_408F();

  if(isDefined(level.additional_pommel_targets)) {
    var_2 = common_scripts\utility::_id_0F73(var_2, level.additional_pommel_targets);
  }

  foreach(var_4 in var_2) {
    var_5 = var_4 is_close_to(self);

    if(!var_5) {
      continue;
    }
    var_1 = common_scripts\utility::_id_0F6F(var_1, var_4);
  }

  var_7 = 0;

  foreach(var_4 in var_1) {
    if(_isagent(var_4)) {
      var_4 thread zap_zombies_vfx();
      var_4 thread apply_pommel_damage(var_0, var_7);
      var_7++;
      continue;
    }

    var_4 notify("pommel_damage");
  }

  return var_7;
}

apply_pommel_damage(var_0, var_1) {
  var_2 = maps\mp\gametypes\zombies::_id_1E59(_id_0547::_id_0A51("zombie_generic"), 30);

  if(var_1 > 8) {
    var_2 = var_2 / 2;
  }

  self dodamage(var_2 / 2, self.origin, var_0, self, "MOD_RIFLE_BULLET", "island_grenade_hc_zm");
  waitframe();
  self dodamage(var_2 / 2, self.origin, var_0, self, "MOD_RIFLE_BULLET", "island_grenade_hc_zm");
}

register_as_pommel_grenade_target(var_0) {
  if(!isDefined(level.additional_pommel_targets)) {
    level.additional_pommel_targets = [];
  }

  level.additional_pommel_targets = common_scripts\utility::_id_0F6F(level.additional_pommel_targets, var_0);
}

zap_zombies_vfx() {
  self endon("death");
  self.pommel_damage = _spawnlinkedfx(level._effect["zmb_pommel_zmb_dmg"], self, "J_Spine4");
  _triggerfx(self.pommel_damage);
  maps\mp\agents\_agent_utility::deleteentonagentdeath(self.pommel_damage);
  wait 0.5;

  if(isDefined(self.pommel_damage)) {
    self.pommel_damage delete();
  }
}

apply_pommel_funcs(var_0, var_1) {
  if(var_0 is_close_to(self)) {
    foreach(var_3 in var_1) {
      var_0 apply_aoe_func(var_3);
    }
  }
}

is_close_to(var_0) {
  if(distance(var_0.origin, self.origin) > 128) {
    return 0;
  }

  if(_abs(var_0.origin[2] - self.origin[2]) > 64) {
    return 0;
  }

  return 1;
}

apply_aoe_func(var_0) {
  self thread[[var_0._id_3F02]]();
}

replace_projectile_with_model() {
  var_0 = spawn("script_model", self.origin);
  var_0 setModel("npc_zom_barb_pommel");
  var_0._id_95AB = spawn("script_model", var_0.origin);
  var_0._id_95AB setModel("tag_origin");
  var_0._id_95AB.angles = (-90, 0, 0);
  self delete();
  return var_0;
}

handle_pommel_kills(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(!isPlayer(var_1)) {
    return;
  }
  if(issubstr(var_4, "island_grenade_hc_zm")) {
    var_1.pommelkills++;
    var_1.lifetimepommelkills++;

    if(var_1.lifetimepommelkills == 250 && maps\mp\_utility::_id_4571() == "mp_zombie_island") {
      var_1 maps\mp\gametypes\zombies::_id_47C8("DLC1_ZM_POMMEL");
    }
  }
}

track_player_pommel_boosts() {
  self endon("disconnect");

  for(;;) {
    wait 0.5;
    var_0 = 0;

    foreach(var_2 in level.zmb_active_pommel_grenades) {
      if(is_close_to(var_2)) {
        var_0 = 1;
        apply_pommel_funcs(self, level.pommel_step_funcs_players);
      }
    }

    if(!var_0) {
      self.indamagebuffzone = 0;
      self.powerbuffamount = undefined;
    }
  }
}

init_pommel_kill_tracking() {
  self.lifetimepommelkills = 0;
}

init_pommel_aud() {
  _id_0378::_id_8DC7("zmb_pomel_grenade_cook", ::zmb_pommel_grenade_cook);
  _id_0378::_id_8DC7("zmb_pomel_grenade_detonate", ::zmb_pommel_grenade_detonate);
  _id_0378::_id_8DC7("zmb_pomel_grenade_force_field", ::zmb_pommel_grenade_force_field);
  _id_0378::_id_8DC7("zmb_pomel_grenade_final_explosion", ::zmb_pommel_grenade_final_explosion);
  _id_0378::_id_8DC7("zmb_pomel_grenade_float", ::zmb_pommel_grenade_float);
  _id_0378::_id_8DC7("zmb_pomel_grenade_retrieval", ::zmb_pommel_grenade_retrieval);
  _id_0378::_id_8DC7("pommel_pickup", ::zmb_pommel_grenade_pickup);
}

zmb_pommel_grenade_cook() {
  var_0 = self;
  var_1 = _id_0380::_id_6844("zmb_big_pommel_energy_lp", undefined, var_0, 0.5);
  var_0 waittill("aud_stop_pomel_nade_cook");
  _id_0380::_id_6850(var_1);
  var_1 = undefined;
}

zmb_pommel_grenade_detonate(var_0) {
  _id_0380::_id_2889("wpn_pomel_grenade_detonate", undefined, var_0);
}

zmb_pommel_grenade_force_field(var_0) {
  _id_0380::_id_2889("wpn_pomel_grenade_force_field", undefined, var_0);
}

zmb_pommel_grenade_final_explosion(var_0) {
  _id_0380::_id_2889("wpn_pomel_grenade_explosion", undefined, var_0);
}

zmb_pommel_grenade_float(var_0) {
  var_1 = self;
  var_2 = _id_0380::_id_6844("zmb_pommel_energy_lp", undefined, var_1, 0.5);
  var_0 waittill("aud_stop_pommel_float_lp");
  _id_0380::_id_6850(var_2);
  var_2 = undefined;
}

zmb_pommel_grenade_retrieval() {
  var_0 = self;
  var_0 notify("aud_stop_pommel_float_lp");
  _id_0380::_id_288B("zmb_pommel_pick_up", undefined, var_0);
}

zmb_pommel_grenade_pickup() {
  var_0 = self;
  var_1 = var_0.origin;
  var_2 = _id_0380::_id_6844("zmb_pommel_energy_lp", undefined, var_0, 1.5);
  level waittill("aud_stop_pommel_energy_loop");
  _id_0380::_id_6850(var_2);
  var_2 = undefined;
  _id_0380::_id_2889("zmb_pommel_pick_up", undefined, var_1);
}