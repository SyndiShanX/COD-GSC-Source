/****************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\zombies\zombie_assassin_freefire.gsc
****************************************************************/

seek_special_ability_use() {
  return !common_scripts\utility::_id_562E(self.specialoverheated) && player_in_view();
}

activate_special_ability() {
  self endon("death");
  childthread maps\mp\zombies\zombie_assassin::recharge_special_ability(5.5);
}

special_assassin_damaged(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {}

throw_razors_at_players() {
  self endon("death");
  self endon("assin_stop_fire");
  var_0 = ["J_poker2_LE", "J_poker1_RI"];
  var_1 = 512 * vectorNormalize(anglesToForward(self.angles));

  foreach(var_3 in var_0) {
    var_4 = self gettagorigin(var_3);
    var_5 = var_4 + (0, 0, -32) + var_1;

    if(isDefined(self.forcedtarget)) {
      var_5 = self.forcedtarget.origin + (0, 0, 40);
    }

    var_6 = _magicbullet("razergun_zm", var_4, var_5, level.player);
    var_6 maps\mp\zombies\weapons\_zombie_razer_gun::transform_razer_projectile(self, "razergun_zm", "zmb_razergun_yellow_trail", 1);
  }
}

player_in_view() {
  self endon("death");

  foreach(var_1 in level.players) {
    if(distance(var_1.origin, self.origin) < 712 && maps\mp\_utility::_id_3B8E(self, var_1, 35)) {
      return 1;
    }
  }

  return 0;
}

assassin_throw_notetrack_handler(var_0, var_1, var_2, var_3) {
  var_4 = 0;

  switch (var_0) {
    case "aud_assassin_melee_hit_vox":
      self.myprojectilefx = [];
      self.myprojectilefx[self.myprojectilefx.size] = maps\mp\zombies\zombie_assassin::play_fx_on_zmb_assassin("razergun_projectile_assassin", "J_poker1_RI");
      self.myprojectilefx[self.myprojectilefx.size] = maps\mp\zombies\zombie_assassin::play_fx_on_zmb_assassin("zmb_razergun_yellow_trail", "J_poker1_RI");
      self.myprojectilefx[self.myprojectilefx.size] = maps\mp\zombies\zombie_assassin::play_fx_on_zmb_assassin("razergun_projectile_assassin", "J_poker2_LE");
      self.myprojectilefx[self.myprojectilefx.size] = maps\mp\zombies\zombie_assassin::play_fx_on_zmb_assassin("zmb_razergun_yellow_trail", "J_poker2_LE");
      var_5 = maps\mp\mp_zombie_island_aud::get_closest_alive_player(self.origin);
      self.target_origin = var_5.origin;
      break;
    case "footstep_walk_right_asn":
      if(isDefined(self.myprojectilefx)) {
        foreach(var_7 in self.myprojectilefx) {
          var_7 delete();
        }

        self.myprojectilefx = [];
      }

      thread throw_razors_at_players();
      break;
  }
}