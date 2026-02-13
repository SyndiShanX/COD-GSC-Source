/***************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\cp\zombies\zm_ww_riotshield.gsc
***************************************************/

init() {
  level.monitorshieldalternatemeleethread = ::monitor_shield_ground_slam_usage;
  level.chargedshieldslamdamagecalculation = ::shield_ground_slam_explode_damage_calculation;
  level.chargedshieldonchangeweapon = ::charged_shield_on_change_weapon;
  level.onshieldmodelattached = ::on_shield_model_attached;
  level.onshieldmodeldetached = ::on_shield_model_detached;
  level.shield_explosion_inner_radius_squared = 62500;
  level.shield_explosion_outer_radius_squared = 250000;
  level.shield_explosion_annihilate_radius_squared = 40000;
  level.shield_explosion_vfx = loadfx("vfx/s4/zombie_weapon/vfx_ww_shield_concussive_blast.vfx");
  level.shield_hit_vfx = loadfx("vfx/s4/zombie_weapon/vfx_ww_shield_strike_smk.vfx");
  level.shield_eye_big_vfx_3p = loadfx("vfx/s4/zombie_weapon/vfx_ww_shield_ambient_eye_big_3p.vfx");
  level.shield_eye_middle_vfx_3p = loadfx("vfx/s4/zombie_weapon/vfx_ww_shield_ambient_eye_middle_3p.vfx");
  level.shield_eye_small_vfx_3p = loadfx("vfx/s4/zombie_weapon/vfx_ww_shield_ambient_eye_small_3p.vfx");
  _id_06CB::_id_AA4A(::ww_riotshield_on_ai_killed);
  _id_06CB::_id_AA49(::ww_riotshield_on_ai_damage);
  level.decimator_pickup_dialogue = "decimator_pickup";
  level.decimator_melee_kill_dialogue = "decimator_melee_kill";
  level.decimator_ability_ready_dialogue = "decimator_ability_ready";
  level.decimator_concussive_blast_dialogue = "decimator_concussive_blast";
  level.decimator_block_attack_dialogue = "decimator_block_attack";
  level.decimator_block_attack_dialogue_chance = 25;
  level.wonder_weapon_name = "s4_me_rindigoww_mp";
}

on_shield_model_attached(var_0) {
  if(var_0 == "wm_shield_demonic_zm_200" && !istrue(self.shield_eye_3p_vfxs_played)) {
    thread delayed_play_3p_shield_vfx();
  }
}

delayed_play_3p_shield_vfx() {
  waitframe();

  if(!isDefined(self)) {
    return;
  }
  self.shield_eye_3p_vfxs_played = 1;

  if(scripts\engine\utility::hastag(self.model, "out_eye01")) {
    playFXOnTag(level.shield_eye_big_vfx_3p, self, "out_eye01");
  }

  if(scripts\engine\utility::hastag(self.model, "ou_eye03")) {
    playFXOnTag(level.shield_eye_middle_vfx_3p, self, "ou_eye03");
  }

  if(scripts\engine\utility::hastag(self.model, "ou_eye02")) {
    playFXOnTag(level.shield_eye_small_vfx_3p, self, "ou_eye02");
  }
}

on_shield_model_detached(var_0) {
  self.shield_eye_3p_vfxs_played = 0;

  if(scripts\engine\utility::hastag(self.model, "out_eye01")) {
    _func_012F(level.shield_eye_big_vfx_3p, self, "out_eye01");
  }

  if(scripts\engine\utility::hastag(self.model, "ou_eye03")) {
    _func_012F(level.shield_eye_middle_vfx_3p, self, "ou_eye03");
  }

  if(scripts\engine\utility::hastag(self.model, "ou_eye02")) {
    _func_012F(level.shield_eye_small_vfx_3p, self, "ou_eye02");
  }
}

charged_shield_on_change_weapon(var_0) {
  if(var_0.basename == "s4_me_rindigoww_mp") {
    if(!istrue(self.wwshield_use_hint_displayed)) {
      level thread charged_shield_try_to_display_use_hint(self);
      self.wwshield_use_hint_displayed = 1;
    }

    if(shield_ground_slam_cooldown_ready()) {
      self setclientomnvar("csc_wwshield_fx_state", 2);
    } else {
      self setclientomnvar("csc_wwshield_fx_state", 1);
    }

    thread charged_shield_monitor_inspect();
  } else {
    self setclientomnvar("csc_wwshield_fx_state", 0);
    self notify("ww_riotshield_switched_away");
  }
}

charged_shield_monitor_inspect() {
  self endon("death");
  self endon("ww_riotshield_switched_away");

  for(;;) {
    if(!isDefined(self)) {
      return;
    }
    var_0 = self.charged_shield_inspecting;
    self.charged_shield_inspecting = self _meth_887C();

    if(!istrue(var_0) && istrue(self.charged_shield_inspecting)) {
      scripts\cp\utility::_id_B8F4("zm_wwds_wdrs_dcmt_wdin", self);
    }

    wait 0.5;
  }
}

charged_shield_try_to_display_use_hint(var_0) {
  level endon("game_ended");
  wait 0.5;

  if(!isDefined(var_0)) {
    return;
  }
  var_1 = 0;

  while(var_1 < 3) {
    if(isDefined(var_0)) {
      var_0 scripts\cp\utility::_id_7970("wwshield_use_hint", 1, 10);
    }

    var_1++;
    wait 30;

    if(!isDefined(var_0) || istrue(var_0.used_shield_ground_slam)) {
      return;
    }
  }
}

monitor_shield_ground_slam_usage() {
  self notifyonplayercommand("ads_pressed", "+speed_throw");
  childthread monitor_shield_ads_pressed();

  for(;;) {
    self waittill("melee_fired", var_0, var_1);

    if(istrue(var_1) && isDefined(var_0) && var_0.basename == "s4_me_rindigoww_mp" && can_use_shield_ground_slam()) {
      do_shield_ground_slam();
      self.used_shield_ground_slam = 1;
      self _meth_871C(1);
      self.shield_ground_slam_in_cooldown = 1;
      thread shield_ground_slam_cooldown();
    }
  }
}

shield_ground_slam_cooldown() {
  self endon("death_or_disconnect");
  scripts\engine\utility::_id_108A7(30, "shield_charged");

  if(!isDefined(self) || _func_0458(self)) {
    return;
  }
  self _meth_871C(0);
  self.shield_ground_slam_in_cooldown = 0;

  if(istrue(self.hasriotshieldww)) {
    if(isDefined(level.decimator_ability_ready_dialogue)) {
      _id_0720::_id_BEC0(level.decimator_ability_ready_dialogue, 1);
    }

    if(isDefined(level.shield_charged_screen)) {
      _func_019D(level.shield_charged_screen, self, "j_head", self);
    }

    self playsoundtoplayer("wpn_decimator_ready_alert", self);
    self setclientomnvar("csc_wwshield_fx_state", 2);
  }
}

monitor_shield_ads_pressed() {
  for(;;) {
    self waittill("ads_pressed");
    var_0 = self getcurrentweapon();

    if(var_0.basename == "s4_me_rindigoww_mp" && can_use_shield_ground_slam() && !istrue(self.shield_ground_slam_sound_in_cooldown)) {
      self playsoundtoplayer("wpn_decimator_start_plr", self);
      self playsoundtoteam("wpn_decimator_start_npc", self.team, self);
      self.shield_ground_slam_sound_in_cooldown = 1;
      thread shield_ground_slam_sound_cooldown();
    }
  }
}

shield_ground_slam_sound_cooldown() {
  level endon("game_ended");
  wait 5;

  if(!isDefined(self)) {
    return;
  }
  self.shield_ground_slam_sound_in_cooldown = 0;
}

can_use_shield_ground_slam() {
  return shield_ground_slam_cooldown_ready();
}

shield_ground_slam_cooldown_ready() {
  return !istrue(self.shield_ground_slam_in_cooldown);
}

do_shield_ground_slam() {
  self setclientomnvar("csc_wwshield_fx_state", 1);
  thread shield_ground_slam_explode();

  if(isDefined(level.decimator_concussive_blast_dialogue)) {
    _id_0720::_id_BEC0(level.decimator_concussive_blast_dialogue, 1);
  }

  self playsoundtoplayer("wpn_decimator_impact_plr", self);
  self playsoundtoteam("wpn_decimator_impact_npc", self.team, self);
  playsoundatpos(self.origin, "wpn_decimator_debris");
  playFX(level.shield_explosion_vfx, self.origin);
  self playrumbleonentity("grenade_rumble");
}

shield_ground_slam_explode() {
  self radiusdamage(self.origin, 500, 300, 300, self, "MOD_EXPLOSIVE", "s4_me_rindigoww_mp", 1);
  physicsexplosionsphere(self.origin, 250, 250, 200);
  var_0 = scripts\cp\utility::_id_66CD(500, self.origin);

  foreach(var_2 in var_0) {
    if(!isalive(var_2)) {
      continue;
    }
    var_2 dodamage(1, var_2.origin + (0, 0, 50), self, self, "MOD_EXPLOSIVE", "s4_me_rindigoww_mp", "torso_lower");
    waitframe();
  }
}

shield_ground_slam_explode_damage_calculation(var_0, var_1, var_2) {
  if(var_1 == "MOD_EXPLOSIVE") {
    var_3 = _func_0135(var_0);

    if(var_3 <= level.shield_explosion_inner_radius_squared) {
      var_4 = 300;
    } else {
      var_5 = (var_3 - level.shield_explosion_inner_radius_squared) / (level.shield_explosion_outer_radius_squared - level.shield_explosion_inner_radius_squared);
      var_4 = 300 - 225 * var_5;
    }

    switch (self.zm_ai_category) {
      case "special":
        var_4 = var_4 * 3;
        break;
      case "elite":
        var_4 = var_4 * 10;
        break;
      default:
        break;
    }
  } else {
    var_4 = var_2;

    if(isDefined(level._id_11049) && level._id_11049 > 12) {
      var_6 = (min(level._id_11049, 20) - 12) * 6;
      var_4 = var_2 - var_6;
    }
  }

  var_7 = _id_09A4::zombiegethealthroundscale();
  return var_4 * var_7;
}

ww_riotshield_on_ai_killed(var_0) {
  if(!isPlayer(var_0._id_50FF)) {
    return;
  }
  if(var_0._id_04F6.basename != "s4_me_rindigoww_mp") {
    return;
  }
  if(var_0._id_DE2B != "MOD_EXPLOSIVE") {
    if(isDefined(level.decimator_melee_kill_dialogue)) {
      var_0._id_50FF _id_0720::_id_BEC0(level.decimator_melee_kill_dialogue);
    }

    return;
  }

  if(self.zm_ai_category == "normal") {
    var_1 = self.origin - var_0._id_50FF.origin;

    if(_func_0135(var_1) <= level.shield_explosion_annihilate_radius_squared && randomint(100) <= 33) {
      self._id_5FF5 = 1;
      self._id_A546 = 1;
      return;
    }

    var_2 = vectornormalize((var_1[0], var_1[1], 0));
    var_3 = _func_01C6((0, 0, 1), var_2, 10 - randomint(20));
    var_3 = var_3 * (4000 + randomint(3000));
    var_3 = (var_3[0], var_3[1], randomint(3) + 1);
    self._id_BF53 = var_3;
    self._id_BF52 = "torso_lower";
  }
}

ww_riotshield_on_ai_damage(var_0) {
  if(!isPlayer(var_0._id_50FF)) {
    return;
  }
  if(var_0._id_04F6.basename != "s4_me_rindigoww_mp") {
    return;
  }
  if(var_0._id_DE2B != "MOD_EXPLOSIVE") {
    playFXOnTag(level.shield_hit_vfx, self, "j_spine4");
    return;
  }

  if(var_0._id_7C8D < self.health && (self.zm_ai_category == "special" || self.zm_ai_category == "elite")) {
    scripts\aitypes\zombie_common\stun::stun(10);
    _id_072A::addplayereffects("energy_mine_stun", self, var_0._id_50FF, 10);
    var_0._id_50FF _id_0752::_id_7003("energy_mine_stunned_enemy", undefined, undefined, undefined, self);
  }
}