/*****************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\cp\zombies\zm_lightning_chain.gsc
*****************************************************/

init() {
  level.default_lightning_chain_params = create_lightning_chain_params(5, 10, 300, 20, 75, 0.11, 128, 4, 1);
  level._effect["tesla_bolt"] = loadfx("vfx/s4/zombie/vfx_tesla_elec_bolt_01.vfx");
  level._effect["tesla_shock"] = loadfx("vfx/s4/zombie/vfx_tesla_shock_zmb.vfx");
  level._effect["tesla_shock_nonfatal"] = loadfx("vfx/s4/zombie/vfx_tesla_bolt_secondary_zmb.vfx");
  level._effect["tesla_shock_eyes"] = loadfx("vfx/s4/zombie/vfx_tesla_shock_eyes_zmb.vfx");
  level._effect["tesla_shock_ground"] = loadfx("vfx/s4/zombie/vfx_tesla_shock_ground.vfx");
  level._effect["tesla_bolt_pap"] = loadfx("vfx/s4/zombie/vfx_tesla_elec_bolt_ug_01.vfx");
  level._effect["tesla_shock_pap"] = loadfx("vfx/s4/zombie/vfx_tesla_shock_ug_zmb.vfx");
  level._effect["tesla_shock_nonfatal_pap"] = loadfx("vfx/s4/zombie/vfx_tesla_bolt_secondary_zmb.vfx");
  level._effect["tesla_shock_eyes_pap"] = loadfx("vfx/s4/zombie/vfx_tesla_shock_eyes_ug_zmb.vfx");
  level._effect["tesla_shock_ground_pap"] = loadfx("vfx/s4/zombie/vfx_tesla_shock_ug_ground.vfx");
  level._effect["dg2_elec_lensglare"] = loadfx("vfx/s4/zombie/vfx_tesla_lensglare_bottom");
  _id_06CB::_id_AA4E(::_id_AA5D);
  _id_06CB::_id_AA65(::on_player_spawned);
  _id_06CB::_id_AA49(::lc_on_ai_damage);
}

create_lightning_chain_params(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_9 = spawnStruct();
  var_9.max_arcs = var_0;
  var_9.max_enemies_killed = var_1;
  var_9.radius_start = var_2;
  var_9.radius_decay = var_3;
  var_9.head_gib_chance = var_4;
  var_9.arc_travel_time = var_5;
  var_9.min_fx_distance = var_6;
  var_9.network_death_choke = var_7;
  var_9.should_kill_enemies = var_8;
  return var_9;
}

_id_AA5D() {
  self.tesla_network_death_choke = 0;
  self.tesla_arc_count = 0;
}

on_player_spawned() {
  thread watch_lc_stunned_zombie_nearby();
}

watch_lc_stunned_zombie_nearby() {
  self endon("death_or_disconnect");
  level endon("game_ended");

  for(;;) {
    var_0 = 0;
    var_1 = scripts\cp\utility::_id_66CD(200, self.origin);

    foreach(var_3 in var_1) {
      if(!isalive(var_3)) {
        continue;
      }
      if(istrue(var_3.lc_stunned)) {
        var_4 = vectornormalize(var_3.origin - self.origin);
        var_5 = anglesToForward(self getplayerangles());
        var_6 = vectordot(var_4, var_5);

        if(var_6 > 0.5) {
          var_0 = 1;
          break;
        }
      }
    }

    if(istrue(var_0)) {
      if(!isDefined(self.near_lc_vfx_ent)) {
        self.near_lc_vfx_ent = _func_020D(level._effect["dg2_elec_lensglare"], self getEye(), self);
        triggerfx(self.near_lc_vfx_ent);
        self.near_lc_vfx_ent _meth_8322();
      }
    } else if(isDefined(self.near_lc_vfx_ent)) {
      self.near_lc_vfx_ent delete();
      self.near_lc_vfx_ent = undefined;
    }

    wait 0.1;
  }
}

arc_damage(var_0, var_1, var_2, var_3) {
  var_1 endon("disconnect");

  if(istrue(self.b_in_lightning_chain)) {
    return;
  }
  self.b_in_lightning_chain = 1;

  if(!isDefined(var_3)) {
    var_3 = level.default_lightning_chain_params;
  }

  thread lc_stun(var_3);
  var_4 = var_3.radius_decay * var_2;
  var_5 = self gettagorigin("j_head");

  if(!isDefined(var_5)) {
    var_5 = self.origin;
  }

  waitframe();
  thread lc_do_damage(var_0, var_2, var_1, var_3);
  var_6 = lc_get_enemies_in_area(var_5, var_3.radius_start - var_4, var_1);

  for(var_7 = 0; var_7 < var_6.size; var_7++) {
    if(!isalive(var_6[var_7]) || var_6[var_7] == self) {
      continue;
    }
    if(lc_end_arc_damage(var_2 + 1, var_1.tesla_enemies_hit, var_3)) {
      continue;
    }
    var_1.tesla_enemies_hit++;

    if(isDefined(level.on_tgun_hit_multiple_targets)) {
      var_1[[level.on_tgun_hit_multiple_targets]](var_1.tesla_enemies_hit, var_3);
    }

    var_6[var_7] thread lc_stun(var_3);
    var_6[var_7] arc_damage(self, var_1, var_2 + 1, var_3);
  }
}

lc_end_arc_damage(var_0, var_1, var_2) {
  if(var_0 >= var_2.max_arcs) {
    return 1;
  }

  if(var_1 >= var_2.max_enemies_killed) {
    return 1;
  }

  var_3 = var_2.radius_decay * var_0;

  if(var_2.radius_start - var_3 <= 0) {
    return 1;
  }

  return 0;
}

lc_stun(var_0) {
  self endon("death");

  if(isDefined(var_0.can_apply_lightning_stun)) {
    if(!self[[var_0.can_apply_lightning_stun]]()) {
      return;
    }
  } else if(isDefined(self.zm_ai_category) && (self.zm_ai_category == "special" || self.zm_ai_category == "elite")) {
    return;
  }
  var_1 = scripts\cp\utility::_id_459B(var_0.stun_duration, 3);
  scripts\aitypes\zombie_common\stun::stun(var_1, "dead_wire");
  self.lc_stunned = 1;
  self notify("zombie_lc_stunned");

  if(isDefined(var_0.dg2_level) && var_0.dg2_level > 0) {
    self setscriptablepartstate("electricity", "active_red");
  } else {
    self setscriptablepartstate("electricity", "active");
  }

  self playLoopSound("zmb_deadwire_stun_lp");
  wait(var_1);
  self setscriptablepartstate("electricity", "neutral");
  self stoploopsound("zmb_deadwire_stun_lp");
  self.lc_stunned = 0;
}

lc_get_enemies_in_area(var_0, var_1, var_2) {
  if(var_1 <= 0) {
    return [];
  }

  var_3 = var_1 * var_1;
  var_4 = [];
  var_5 = scripts\cp\utility::_id_66CD(var_1, var_0);

  if(isDefined(var_5)) {
    for(var_6 = 0; var_6 < var_5.size; var_6++) {
      if(!isDefined(var_5[var_6])) {
        continue;
      }
      if(istrue(var_5[var_6].lightning_chain_immune)) {
        continue;
      }
      var_4[var_4.size] = var_5[var_6];
    }
  }

  return var_4;
}

lc_do_damage(var_0, var_1, var_2, var_3) {
  var_2 endon("disconnect");

  if(var_1 > 1) {
    wait(randomfloatrange(0.2, 0.6) * var_1);
  }

  if(!isalive(self)) {
    return;
  }
  var_4 = 1;

  if(isDefined(var_3.can_apply_lightning_effect)) {
    var_4 = self[[var_3.can_apply_lightning_effect]](var_0);
  }

  if(var_4) {
    if(isDefined(var_0) && var_0 != self) {
      if(var_2.tesla_arc_count > 3) {
        waitframe();
        var_2.tesla_arc_count = 0;
      }

      var_2.tesla_arc_count++;
      var_0 lc_play_arc_fx(self, var_3);
    }

    lc_play_death_fx(var_1, var_3);
  }

  if(var_2.tesla_network_death_choke > var_3.network_death_choke) {
    wait 0.1;
    var_2.tesla_network_death_choke = 0;
  }

  if(!isalive(self)) {
    return;
  }
  var_2.tesla_network_death_choke++;

  if(!isalive(self)) {
    return;
  }
  self.tesla_death = var_3.should_kill_enemies;

  if(isDefined(var_3.str_mod)) {
    var_5 = var_3.str_mod;
  } else {
    var_5 = "MOD_UNKNOWN";
  }

  var_6 = var_2.origin;

  if(isDefined(var_0) && var_0 != self) {
    var_6 = var_0.origin;
  }

  if(!isalive(self)) {
    return;
  }
  self.b_in_lightning_chain = undefined;
  var_7 = var_2;

  if(!isPlayer(var_2)) {
    var_7 = var_2;
    var_2 = var_2.owner;
  }

  if(isDefined(var_3.lightning_chain_damage_func)) {
    self[[var_3.lightning_chain_damage_func]](var_6, var_2, var_7, var_3);
  } else {
    if(var_3.should_kill_enemies) {
      if(isDefined(self.tesla_damage_func) && isDefined(var_3.dg2_level)) {
        self[[self.tesla_damage_func]](var_6, var_2, var_1, var_3);
        return;
        return;
      }

      if(istrue(var_3.prevent_weapon_kill_credit)) {
        self dodamage(lc_damage_calculation(var_3), var_6, var_2, var_7, var_5, level.weaponnone, "none");
        return;
      }

      var_8 = level.weaponnone;

      if(isDefined(var_3._id_04F6)) {
        var_8 = var_3._id_04F6;
      }

      var_9 = lc_damage_calculation(var_3);
      self dodamage(var_9, var_6, var_2, var_7, var_5, var_8, "head");
      return;
      return;
      return;
    }

    if(isDefined(self.tesla_damage_func)) {
      self[[self.tesla_damage_func]](var_6, var_2, var_3);
      return;
    }
  }
}

lc_damage_calculation(var_0) {
  if(isDefined(self.zm_ai_category) && (self.zm_ai_category == "special" || self.zm_ai_category == "elite")) {
    if(isDefined(var_0.arc_damage_to_elite)) {
      return self.maxhealth * var_0.arc_damage_to_elite;
    } else {
      return self.maxhealth * 0.3;
    }
  } else
    return self.health + 666;
}

lc_play_arc_fx(var_0, var_1) {
  if(!isalive(self) || !isalive(var_0)) {
    wait(var_1.arc_travel_time);
    return;
  }

  var_2 = "J_SpineUpper";
  var_3 = "J_SpineUpper";
  var_4 = self gettagorigin(var_2);
  var_5 = var_0 gettagorigin(var_3);
  var_6 = var_1.min_fx_distance * var_1.min_fx_distance;

  if(distancesquared(var_4, var_5) < var_6) {
    return;
  }
  var_7 = scripts\cp\utility::_id_E190("tag_origin", var_4);

  if(isDefined(var_1.dg2_level) && var_1.dg2_level > 0) {
    var_8 = "tesla_bolt_pap";
  } else {
    var_8 = "tesla_bolt";
  }

  var_9 = playFXOnTag(level._effect[var_8], var_7, "tag_origin");
  playsoundatpos(var_7.origin, "prj_dg2_bounce");
  var_7 moveto(var_5, var_1.arc_travel_time);
  var_7 waittill("movedone");
  var_7 delete();
}

lc_play_death_fx(var_0, var_1) {
  if(isDefined(var_1.dg2_level) && var_1.dg2_level > 0) {
    var_2 = 1;
  } else {
    var_2 = 0;
  }

  var_3 = "J_SpineUpper";

  if(var_2) {
    var_4 = "tesla_shock_pap";
  } else {
    var_4 = "tesla_shock";
  }

  if(var_0 > 1) {
    var_4 = undefined;
  } else {
    if(var_2) {
      var_5 = "tesla_shock_ground_pap";
    } else {
      var_5 = "tesla_shock_ground";
    }

    playFXOnTag(level._effect[var_5], self, "tag_origin");
  }

  if(!var_1.should_kill_enemies) {
    var_4 = "tesla_shock_nonfatal";
  }

  if(isDefined(var_4) && scripts\engine\utility::hastag(self.model, var_3)) {
    playFXOnTag(level._effect[var_4], self, var_3);
  }

  if(istrue(var_1.should_gib_head) && isDefined(self.zm_ai_category) && self.zm_ai_category == "normal" && isDefined(self._id_110B0) && self._id_110B0 == "base" && !istrue(self.head_gibbed) && istrue(var_1.should_kill_enemies)) {
    if(randomint(100) < 70) {
      self.pending_lightning_headgib = 1;
    } else if(self tagexists("J_Eyeball_LE")) {
      if(var_2) {
        var_6 = "tesla_shock_eyes_pap";
      } else {
        var_6 = "tesla_shock_eyes";
      }

      playFXOnTag(level._effect[var_6], self, "J_Eyeball_LE");
    }
  }
}

lc_on_ai_damage(var_0) {
  if(var_0._id_7C8D > self.health && istrue(self.lc_stunned)) {
    self.health = var_0._id_7C8D + 1;

    if(!istrue(self.is_in_lc_death_wait)) {
      thread lc_wait_till_stun_end(var_0);
    }
  }
}

lc_wait_till_stun_end(var_0) {
  self notify("lc_wait_till_stun_end");
  self endon("lc_wait_till_stun_end");
  self endon("death");
  self.is_in_lc_death_wait = 1;

  while(istrue(self.lc_stunned)) {
    var_1 = gettime();

    if(istrue(self.pending_lightning_headgib) && !istrue(self.head_gibbed) && isDefined(self.stunendtimems) && self.stunendtimems - var_1 <= 500) {
      self.pending_lightning_headgib = 0;
      _id_0AF3::_id_4B3E(16, 1, 0);
    }

    waitframe();
  }

  if(!isDefined(self) || !isalive(self)) {
    return;
  }
  var_2 = undefined;

  if(isDefined(var_0._id_511D) && !_func_0458(var_0._id_511D)) {
    var_2 = var_0._id_511D;
  } else if(isDefined(var_0._id_50FF) && !_func_0458(var_0._id_50FF)) {
    var_2 = var_0._id_50FF;
  }

  var_3 = undefined;

  if(isDefined(var_0._id_50FF) && !_func_0458(var_0._id_50FF)) {
    var_3 = var_0._id_50FF;
  }

  self dodamage(self.health, self.origin, var_3, var_2, var_0._id_DE2B, var_0._id_04F6, var_0._id_D9E0);
}