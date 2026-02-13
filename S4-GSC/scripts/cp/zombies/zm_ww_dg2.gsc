/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\cp\zombies\zm_ww_dg2.gsc
*************************************************/

init() {
  level.wonder_weapon_name = "s4_ar_tgun_mp";
  level.can_drop_wonder_weapon = 1;
  level.tgun_lightning_params = scripts\cp\zombies\zm_lightning_chain::create_lightning_chain_params(5, 10, 300, 20, 75, 0.15, 50, 4, 1);
  level.on_tgun_hit_multiple_targets = ::ww_dg2_chained_multiple_targets;
  _id_06CB::_id_AA49(::ww_dg2_on_ai_damage);
  level.no_knockdown_weapon_names = scripts\engine\utility::_id_1B8D(level.no_knockdown_weapon_names, "s4_ar_tgun_mp");
  level.no_headshot_refill_weapon = scripts\engine\utility::_id_1B8D(level.no_headshot_refill_weapon, "s4_ar_tgun_mp");
  level.dg2_damage_to_specials = [];
  level.dg2_damage_to_specials["jugg"] = [];
  level.dg2_damage_to_specials["jugg"][0] = 4000;
  level.dg2_damage_to_specials["jugg"][1] = 8000;
  level.dg2_damage_to_specials["jugg"][2] = 9000;
  level.dg2_damage_to_specials["jugg"][3] = 10000;
  level.dg2_damage_to_specials["trickster"] = [];
  level.dg2_damage_to_specials["trickster"][0] = 4000;
  level.dg2_damage_to_specials["trickster"][1] = 8000;
  level.dg2_damage_to_specials["trickster"][2] = 9000;
  level.dg2_damage_to_specials["trickster"][3] = 10000;
  level._effect["dg2_splash_vfx"] = loadfx("vfx/s4/zombie/vfx_tesla_splash_damage");
  level.dg2_splash_vfx_func = ::dg2_splash_damage_vfx;
  level.can_drop_wonder_weapon_func = ::dg2_drop_limit_check;
  level.no_restoration_weapon_func = ::dg2_no_restoration_check;
  scripts\cp\zombies\zm_lightning_chain::init();
}

ww_dg2_on_ai_damage(var_0) {
  if(isPlayer(var_0._id_50FF) && var_0._id_04F6.basename == "s4_ar_tgun_mp" && var_0._id_DE2B == "MOD_PROJECTILE" && !istrue(self.is_in_lc_death_wait)) {
    var_0._id_50FF.tesla_enemies_hit = 1;
    var_0._id_50FF.tesla_enemies = undefined;
    var_0._id_50FF.tesla_arc_count = 0;
    var_0._id_50FF.tesla_firing = 1;
    var_1 = level.tgun_lightning_params;
    var_1._id_04F6 = var_0._id_04F6;
    var_1.should_gib_head = 1;
    var_1.dg2_level = var_0._id_50FF _id_0774::_id_684B(var_0._id_04F6);
    thread scripts\cp\zombies\zm_lightning_chain::arc_damage(self, var_0._id_50FF, 1, var_1);
  }
}

ww_dg2_chained_multiple_targets(var_0, var_1) {
  if(var_0 < 5 || !isDefined(var_1._id_04F6) || var_1._id_04F6.basename != "s4_ar_tgun_mp" || istrue(self.happy_sound_in_cooldown) || _func_0458(self)) {
    return;
  }
  scripts\cp\utility::_id_B8F4("wpn_dg2_happy", self);
  self.happy_sound_in_cooldown = 1;
  thread dg2_wait_to_play_calm_sound();
  thread dg2_happy_sound_cooldown();
  thread dg2_watch_fired();
}

dg2_wait_to_play_calm_sound() {
  self endon("death");
  self endon("dg2_fired");
  level endon("game_ended");
  wait 15;

  if(!isDefined(self)) {
    return;
  }
  scripts\cp\utility::_id_B8F4("wpn_dg2_calm", self);
  self notify("dg2_calm_sound_played");
}

dg2_happy_sound_cooldown() {
  self endon("death");
  level endon("game_ended");
  wait 20;

  if(isDefined(self)) {
    self.happy_sound_in_cooldown = 0;
  }
}

dg2_watch_fired() {
  self endon("death");
  self endon("dg2_calm_sound_played");
  level endon("game_ended");

  for(;;) {
    self waittill("weapon_fired", var_0);

    if(isDefined(var_0) && isDefined(var_0.basename) && var_0.basename == "s4_ar_tgun_mp") {
      self notify("dg2_fired");
      return;
    }
  }
}

dg2_drop_limit_check(var_0) {
  if(!isDefined(var_0) || var_0 != "s4_ar_tgun_mp") {
    return 1;
  } else {
    var_1 = 0;
    var_2 = scripts\engine\utility::ter_op(istrue(level.extend_wonder_weapon_drop_limit), 4, 2);

    foreach(var_4 in level.players) {
      if(!isDefined(var_4) || !isalive(var_4)) {
        continue;
      }
      var_5 = var_4 getweaponslistprimaries();

      foreach(var_7 in var_5) {
        if(var_7.basename == "s4_ar_tgun_mp") {
          var_1++;

          if(var_1 >= var_2) {
            return 0;
          }
        }
      }
    }

    return 1;
  }
}

dg2_splash_damage_vfx() {
  self endon("death");
  self endon("disconnect");
  var_0 = _func_020D(level._effect["dg2_splash_vfx"], self getEye(), self);
  triggerfx(var_0);
  var_0 _meth_8322();
  wait 0.5;
  var_0 delete();
}

dg2_no_restoration_check() {
  if(!isDefined(self._id_3D58) || !istrue(self.dropped_dg2)) {
    return 0;
  }

  self.dropped_dg2 = 0;

  foreach(var_1 in self._id_3D58) {
    if(isnullweapon(var_1)) {
      continue;
    }
    if(var_1.basename == "s4_ar_tgun_mp") {
      self._id_3D58 = scripts\engine\utility::array_remove(self._id_3D58, var_1);
      return 1;
    }
  }

  return 0;
}