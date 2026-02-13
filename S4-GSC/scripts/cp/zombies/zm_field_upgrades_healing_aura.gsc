/*****************************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\cp\zombies\zm_field_upgrades_healing_aura.gsc
*****************************************************************/

init() {
  level._effect["healing_aura_1p_effect"] = loadfx("vfx/s4/zombie_weapon/vfx_fld_healing_aura_pulse_head_1p.vfx");
  level._effect["healing_aura_3p_torso_effect"] = loadfx("vfx/s4/zombie_weapon/vfx_fld_healing_aura_pulse_torso_3p.vfx");
  level._effect["zm_field_upgrade_ha_beam"] = loadfx("vfx/s4/zombie_weapon/vfx_fld_healing_aura_aoe.vfx");
  level._effect["healing_aura_zmb_stun_effect"] = loadfx("vfx/s4/zombie_weapon/vfx_fld_healing_aura_zmb_stun.vfx");
  _id_06CB::_id_AA4E(::healing_aura_player_setup_on_connect);
  _id_06CB::_id_AA65(::healing_aura_player_setup_on_spawned);
}

healing_aura_player_setup_on_connect() {
  self.a_healing_aura_regen_healer = [];
}

healing_aura_player_setup_on_spawned() {
  scripts\engine\utility::_id_5473("zm_field_upgrade_in_use");
  level scripts\engine\utility::_id_5473("healing_aura_in_use");
  self.b_healing_aura_active = undefined;
}

do_healing_aura() {
  scripts\engine\utility::_id_5474("zm_field_upgrade_in_use");
  self.b_healing_aura_active = 1;
  thread healing_aura_active();
  return 1;
}

monitor_healing_aura_end() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self.n_healing_aura_end_time = scripts\cp\utility::_id_459B(self.n_healing_aura_end_time, gettime());

  for(;;) {
    if(!isDefined(self.n_healing_aura_end_time)) {
      break;
    }

    var_0 = self.n_healing_aura_end_time - gettime();

    if(var_0 > 0) {
      wait(scripts\cp\utility::_id_A2B8(var_0));
      continue;
    }

    break;
  }

  self.b_healing_aura_active = undefined;
  scripts\engine\utility::_id_5470("zm_field_upgrade_in_use");
}

delay_healing_aura_end_time(var_0) {
  var_1 = gettime() + scripts\cp\utility::_id_CFF0(scripts\cp\utility::_id_459B(var_0, 0));

  if(isDefined(self.n_healing_aura_end_time)) {
    self.n_healing_aura_end_time = max(self.n_healing_aura_end_time, var_1);
  } else {
    self.n_healing_aura_end_time = var_1;
  }
}

get_healing_aura_level() {
  return self.super_level;
}

healing_aura_active() {
  self endon("disconnect");
  var_0 = get_healing_aura_level();
  var_1 = self getentitynumber();
  var_2 = var_0 >= 1;
  var_3 = var_0 >= 4;
  self playsoundtoplayer("zmb_fieldup_healingaura_activate", self, self);

  if(var_2) {
    level thread knockdown_zombies(self);
  }

  level heal_all_players(self, var_1, var_0);

  if(var_3) {
    foreach(var_5 in scripts\cp\utility::_id_6C5C()) {
      if(!isalive(var_5)) {
        continue;
      }
      var_5 thread create_heal_beam(self, var_1, var_0);
    }

    delay_healing_aura_end_time(10);
  }

  thread monitor_healing_aura_end();
}

apply_stun_effect() {
  self endon("death");
  playFXOnTag(scripts\engine\utility::getfx("healing_aura_zmb_stun_effect"), self, "j_head");
  wait 2;
  stopFXOnTag(scripts\engine\utility::getfx("healing_aura_zmb_stun_effect"), self, "j_head");
}

knockdown_zombies(var_0) {
  var_0.knockdownzombies = [];

  foreach(var_2 in scripts\cp\utility::_id_6C5C()) {
    if(!isalive(var_2)) {
      continue;
    }
    var_3 = _func_0071(var_2.origin, 256, level._id_11056);

    foreach(var_5 in var_3) {
      if(!isalive(var_5)) {
        continue;
      }
      var_0.knockdownzombies = scripts\engine\utility::array_add(var_0.knockdownzombies, var_5);

      if(var_5 _id_06FE::is_zm_normal()) {
        var_6 = vectornormalize(var_5.origin - var_2.origin);
        var_5 scripts\aitypes\zombie_common\push::knockdown(var_6);
        continue;
      }

      if(var_5 _id_06FE::is_zm_special()) {
        var_5 scripts\aitypes\zombie_common\stun::stun(2);
        var_5.isknockeddown = 1;
        waitframe();

        if(isalive(var_5)) {
          var_5 thread apply_stun_effect();
          var_5 thread knock_down_timer(2);
        }
      }
    }

    waitframe();
  }
}

knock_down_timer(var_0) {
  level endon("game_ended");
  self endon("death");
  wait 2;
  self.isknockeddown = 0;
}

heal_player() {
  self.health = self.maxhealth;
}

heal_player_from_revive(var_0) {
  self notify("heal_player_from_revive");
  self endon("heal_player_from_revive");
  self endon("death");
  self waittill("exit_last_stand");
  heal_player();

  if(var_0) {
    _id_073B::restore_perks_lost_on_last_stand();
  }
}

heal_all_players(var_0, var_1, var_2) {
  var_3 = var_2 >= 2;
  var_4 = var_2 >= 3;

  foreach(var_6 in scripts\cp\utility::_id_6C5C()) {
    if(!isalive(var_6)) {
      continue;
    }
    if(_id_073B::_id_B4EF(var_6)) {
      if(var_3 && !istrue(var_6.b_force_laststand)) {
        var_6 thread heal_player_from_revive(var_4);

        if(isDefined(var_0)) {
          var_0 thread _id_0752::_id_7003("healing_aura_revive");
        }

        var_6 _id_073B::_id_8302(var_6);
      }

      continue;
    }

    if(isDefined(var_0) && var_6.health < var_6.maxhealth) {
      var_0 thread _id_0752::_id_7003("healing_aura_heal");
    }

    var_6 heal_player();
  }

  foreach(var_6 in scripts\cp\utility::_id_6C5C()) {
    var_6 thread do_self_regen(var_1, 10);
  }

  if(isDefined(var_0)) {
    var_0 delay_healing_aura_end_time(10);
  }
}

do_self_regen(var_0, var_1) {
  self notify("do_self_regen" + var_0);
  self endon("do_self_regen" + var_0);
  self endon("death_or_disconnect");

  if(!isalive(self)) {
    return;
  }
  if(self.a_healing_aura_regen_healer.size == 0) {
    self setscriptablepartstate("healingAura", "active");
  }

  self.a_healing_aura_regen_healer = scripts\cp\utility::_id_1B8C(self.a_healing_aura_regen_healer, var_0);
  var_2 = 0;

  while(var_2 <= var_1) {
    thread apply_tick_effects();

    if(!_id_073B::_id_B4EF(self)) {
      if(_func_02B7(self.health) && _func_02B7(self.maxhealth)) {
        self.health = int(min(self.health + 150, self.maxhealth));
      }
    }

    var_2 = var_2 + 1;
    wait 1;
  }

  if(_func_0107(self.a_healing_aura_regen_healer)) {
    self.a_healing_aura_regen_healer = scripts\engine\utility::array_remove(self.a_healing_aura_regen_healer, var_0);

    if(self.a_healing_aura_regen_healer.size == 0) {
      self playsoundtoplayer("zmb_fieldup_healingaura_end", self, self);
      self setscriptablepartstate("healingAura", "inactive");
    }
  }
}

apply_tick_effects() {
  if(isDefined(self)) {
    _func_019D(scripts\engine\utility::getfx("healing_aura_1p_effect"), self, "j_head", self);
  }

  waitframe();

  if(isDefined(self)) {
    playFXOnTag(scripts\engine\utility::getfx("healing_aura_3p_torso_effect"), self, "j_spine4");
  }
}

create_heal_beam(var_0, var_1, var_2) {
  level endon("game_ended");
  var_3 = scripts\common\utility::groundpos(self.origin);
  var_4 = scripts\cp\utility::_id_E190("tag_origin", var_3);
  var_4.owner = var_0;
  waitframe();
  playFXOnTag(scripts\engine\utility::getfx("zm_field_upgrade_ha_beam"), var_4, "tag_origin");
  playsoundatpos(var_3, "zmb_fieldup_tree_start");
  var_4 playLoopSound("zmb_fieldup_tree_lp");
  var_4 thread do_beam_heal(var_1, var_2);
}

do_beam_heal(var_0, var_1) {
  self endon("death");
  var_2 = 0;

  while(var_2 <= 10) {
    var_3 = 0;

    foreach(var_5 in scripts\cp\utility::_id_6C5C()) {
      if(!isalive(var_5)) {
        continue;
      }
      if(distance2d(self.origin, var_5.origin) <= 64) {
        var_3 = 1;
        break;
      }
    }

    if(var_3) {
      level heal_all_players(self.owner, var_0, var_1);
    }

    var_2 = var_2 + 1;
    wait 1;
  }

  self stoploopsound("zmb_fieldup_tree_lp");
  playsoundatpos(self.origin, "zmb_fieldup_tree_end");
  stopFXOnTag(scripts\engine\utility::getfx("zm_field_upgrade_ha_beam"), self, "tag_origin");
  thread scripts\cp\utility::_id_46C7(0.5);
}