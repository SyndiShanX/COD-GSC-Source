/******************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_sumpf\cp_sumpf_trap.gsc
******************************************************/

init() {
  level._effect["trap_electric_active"] = loadfx("vfx/s4/level/cp_sumpf/vfx_electric_arc_machine_md.vfx");
  level._effect["trap_electric_light_on"] = loadfx("vfx/s4/zombie/vfx_light_cagelight_green.vfx");
  level._effect["trap_electric_light_off"] = loadfx("vfx/s4/zombie/vfx_light_cagelight_red.vfx");
  level._effect["trap_electric_zombie"] = loadfx("vfx/s4/zombie/vfx_elec_smoke.vfx");
  level._effect["trap_electric_player"] = loadfx("vfx/s4/zombie/vfx_screen_elec_shock_bot.vfx");
  level.trap_electric_lightning_params = scripts\cp\zombies\zm_lightning_chain::create_lightning_chain_params(10, 20, 200, 20, 75, 0.11, 128, 4, 1);
  level.trap_electric_lightning_params.stun_duration = 1;
  level.trap_electric_lightning_params.lightning_chain_damage_func = ::lightning_chain_damage_func;
  level.trap_electric_lightning_params.can_apply_lightning_stun = ::can_apply_lightning_stun;
  level.trap_electric_lightning_params.can_apply_lightning_effect = ::can_apply_lightning_effect;
  level thread _init_traps();
}

_init_traps() {
  scripts\engine\utility::_id_5C24("interactions_initialized");
  _id_0737::_id_C266("trap_electric", ::get_electric_trap_hint, ::active_electric_trap, ::init_electric_traps);
  level._id_8393["trap_electric"]._id_E3FF = "trap_electric";
  level._id_8393["trap_electric"]._id_3D91 = 1000;
  level._id_8393["trap_electric"].hint_type_func = ::get_electric_trap_hint_type;
  level._id_835D["trap_electric"] = &"CP_SUMPF/TRAP_ACTIVATE";
  level._id_835D["trap_electric_need_money"] = &"CP_SUMPF/TRAP_ACTIVATE_NEED_MONEY";
  level._id_835D["trap_electric_cooldown"] = &"CP_SUMPF/TRAP_COOLDOWN";
  level._id_835D["trap_electric_inuse"] = &"CP_SUMPF/TRAP_INUSE";
}

get_electric_trap_hint(var_0, var_1) {
  if(istrue(var_0._id_7D7E)) {
    return level._id_835D["trap_electric_inuse"];
  } else if(istrue(var_0._id_3D11)) {
    return level._id_835D["trap_electric_cooldown"];
  } else if(isDefined(level._id_8393["trap_electric"]._id_3D91) && !var_1 _id_074E::_id_B4C5(level._id_8393["trap_electric"]._id_3D91)) {
    return level._id_835D["trap_electric_need_money"];
  } else {
    return level._id_835D["trap_electric"];
  }
}

get_electric_trap_hint_type(var_0, var_1) {
  if(istrue(var_0._id_3D11) || istrue(var_0._id_7D7E)) {
    return "HINT_NOBUTTON";
  }

  return "HINT_NOICON";
}

init_electric_traps(var_0) {
  level.a_traps = var_0;

  foreach(var_2 in var_0) {
    var_2 thread init_electric_trap();
  }
}

init_electric_trap() {
  level endon("game_ended");
  self.damage_volumes = getEntArray(self._id_0481, "target");

  if(isDefined(self._id_CD4B)) {
    var_0 = strtok(self._id_CD4B, ",");
    scripts\engine\utility::_id_5C28(var_0);
  }

  var_1 = getent(self.target, "script_noteworthy");
  var_2 = getent(self.target, "targetname");

  if(isDefined(var_1)) {
    var_1.light_fx = var_2;
    var_1 thread handle_switch_set_state("on");
    self._id_73E3 = var_1;
  }

  _id_0737::add_interaction_marker_internal(self, "trap_electric", "v_ui_icons_zombies_minimap_electric_trap", 0);
}

active_electric_trap(var_0, var_1) {
  var_0 endon("death");
  var_0._id_7D7E = 1;
  level thread play_electric_trap_use_vo();

  if(isDefined(var_0._id_73E3)) {
    var_0._id_73E3 thread handle_switch_set_state("off");
  }

  foreach(var_3 in var_0.damage_volumes) {
    var_3.s_trap = var_0;
    var_3 thread active_electric_trap_volume(var_1);
  }

  var_0 scripts\engine\utility::_id_5479("trap_broken", 20);
  var_0._id_7D7E = undefined;
  var_0._id_3D11 = 1;
  var_0 scripts\engine\utility::_id_5479("trap_broken", 30);
  var_0 scripts\engine\utility::_id_547B("trap_broken");

  if(var_0 scripts\engine\utility::_id_546E("fuse_return")) {
    var_0 scripts\engine\utility::_id_5470("fuse_return");
    return;
  }

  if(isDefined(var_0._id_73E3)) {
    var_0._id_73E3 handle_switch_set_state("on");
    playsoundatpos(var_0._id_73E3.origin, "zmb_electrical_trap_ready_alert");
  }

  var_0._id_3D11 = undefined;
  var_0._id_8797 = 1;
  wait 0.1;
  var_0._id_8797 = undefined;
}

active_electric_trap_volume(var_0) {
  self endon("death");
  self.tesla_enemies_hit = 1;
  self.tesla_arc_count = 0;
  self.tesla_network_death_choke = 0;
  self.b_actived = 1;
  self.owner = var_0;
  self.score_event_string = "cp_sumpf_trap";
  var_1 = gettime() + 20000;
  var_2 = self _meth_86AD();
  var_3 = max(max(var_2[0], var_2[1]), var_2[2]) + 50;
  var_4 = spawn("script_model", self.origin);
  var_4 setModel("tag_origin");
  var_4.angles = self.angles;

  if(isDefined(self._id_0481)) {
    var_5 = scripts\engine\utility::getstruct(self._id_0481, "target");
    var_4.origin = var_5.origin;
    var_4.angles = var_5.angles;
  }

  waitframe();
  playFXOnTag(scripts\engine\utility::getfx("trap_electric_active"), var_4, "tag_origin");

  while(gettime() < var_1 && !self.s_trap scripts\engine\utility::_id_546E("trap_broken")) {
    var_6 = gettime();
    var_7 = _func_0071(self.origin, var_3, level._id_11056);

    foreach(var_9 in var_7) {
      if(!isalive(var_9)) {
        continue;
      }
      if(!isDefined(var_9.trap_electric_damage_time)) {
        var_9.trap_electric_damage_time = 0;
      }

      if(var_6 > var_9.trap_electric_damage_time && var_9 istouching(self)) {
        var_9 thread scripts\cp\zombies\zm_lightning_chain::arc_damage(var_9, self, 1, level.trap_electric_lightning_params);
      }
    }

    foreach(var_12 in level.players) {
      if(!isalive(var_12)) {
        continue;
      }
      if(!isDefined(var_12.trap_electric_damage_time)) {
        var_12.trap_electric_damage_time = 0;
      }

      if(var_6 > var_12.trap_electric_damage_time && var_12 istouching(self)) {
        var_12.trap_electric_damage_time = var_6 + 1000;
        var_12 dodamage(100, var_12.origin, undefined, self);
        var_12 thread handle_player_electric_effect();
      }
    }

    waitframe();
  }

  self.b_actived = undefined;
  var_4 delete();
}

handle_player_electric_effect() {
  level endon("game_ended");
  self endon("disconnect");
  self notify("handle_player_electric_effect_singleton");
  self endon("handle_player_electric_effect_singleton");

  if(!istrue(self.b_playing_electric_effect)) {
    _func_019D(scripts\engine\utility::getfx("trap_electric_player"), self, "j_head", self);
    self.b_playing_electric_effect = 1;
  }

  self shellshock("s4_frag_usa_mk2_mp", 1.5);
  wait 1.5;
  _func_02D1(scripts\engine\utility::getfx("trap_electric_player"), self, "j_head", self);
  self.b_playing_electric_effect = undefined;
}

handle_switch_set_state(var_0) {
  self endon("death");

  if(!isDefined(var_0)) {
    return;
  }
  if(!isDefined(self._id_E747)) {
    self._id_E747 = "on";

    if(isDefined(self.light_fx)) {
      playFXOnTag(scripts\engine\utility::getfx("trap_electric_light_on"), self.light_fx, "tag_origin");
    }
  }

  if(self._id_E747 != var_0) {
    switch (var_0) {
      case "on":
        self rotatepitch(-180, 0.5, 0, 0.1);
        break;
      case "off":
        self rotatepitch(180, 0.5, 0.1, 0);
        break;
    }

    playsoundatpos(self.origin, "zmb_log_trap_motor_switch");
    wait 0.5;

    if(isDefined(self.light_fx)) {
      _func_012F(scripts\engine\utility::getfx("trap_electric_light_" + self._id_E747), self.light_fx, "tag_origin");
      playFXOnTag(scripts\engine\utility::getfx("trap_electric_light_" + var_0), self.light_fx, "tag_origin");
    }

    self._id_E747 = var_0;
  }
}

lightning_chain_damage_func(var_0, var_1, var_2, var_3) {
  if(!isDefined(self.trap_electric_damage_time)) {
    self.trap_electric_damage_time = 0;
  }

  var_4 = gettime();

  if(var_4 < self.trap_electric_damage_time) {
    return;
  }
  self.trap_electric_damage_time = var_4 + 1000;

  if(_func_0458(var_1)) {
    var_1 = undefined;
  }

  switch (self._id_110B0) {
    case "trickster":
      if(!isDefined(self.force_escape_position)) {
        var_5 = var_2.origin + anglesToForward(var_2.angles) * 150;
        var_6 = var_2.origin - anglesToForward(var_2.angles) * 150;
        var_7 = var_5;

        if(isDefined(self._id_0192) && distancesquared(var_6, self._id_0192.origin) < distancesquared(var_5, self._id_0192.origin)) {
          var_7 = var_6;
        }

        self.force_escape_position = _func_02A9(var_7, 150);
        self.trap_electric_damage_time = 0;
      }

      break;
    case "juggernaut":
      self.trap_electric_damage_time = var_4 + 2000;

      if(istrue(self.need_break_backpack)) {
        wait 1;

        if(!isalive(self)) {
          return;
        }
        self dodamage(self.backpackhealth, self.origin - anglesToForward(self.angles), var_1, var_2, "MOD_UNKNOWN", level.weaponnone, "head");
      } else {
        self.force_damage_pain = 1;
        self._id_A4C0 = 0;
        self dodamage(self.maxhealth * 0.2, var_0, var_1, var_2, "MOD_UNKNOWN", level.weaponnone, "none");
      }

      break;
    default:
      self dodamage(self.health + 666, var_0, var_1, var_2, "MOD_UNKNOWN", level.weaponnone, "none");
  }
}

can_apply_lightning_stun() {
  switch (self._id_110B0) {
    case "juggernaut":
      if(randomfloat(1) < 0.25) {
        self.need_break_backpack = 1;
        return 1;
      }
    case "trickster":
      return 0;
  }

  playFXOnTag(scripts\engine\utility::getfx("trap_electric_zombie"), self, "j_spine4");
  return 1;
}

can_apply_lightning_effect(var_0) {
  switch (self._id_110B0) {
    case "trickster":
      return 0;
  }

  return 1;
}

play_electric_trap_use_vo() {
  level endon("game_ended");

  if(!level scripts\engine\utility::_id_5C00("electric_trap_use_vo_played")) {
    level scripts\engine\utility::_id_5C11("electric_trap_use_vo_played");
    level scripts\engine\utility::_id_5C1B("electric_trap_use_vo_played");
    level thread _id_0720::play_narration(["zm_cpm4_rbm4_krft_mgm1", "zm_cpm4_rbm4_krft_mgm2", "zm_cpm4_rbm4_krft_mgm3", "zm_cpm4_rbm4_krft_mgm4"], 1, 0);
    level waittill("dialogue_finished");
  }
}