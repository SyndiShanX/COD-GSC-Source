/***********************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\zombies\zombie_assassin_frontline_basic.gsc
***********************************************************************/

seek_special_ability_use() {
  return !common_scripts\utility::_id_562E(self.specialoverheated);
}

activate_special_ability() {
  self endon("death");
  childthread maps\mp\zombies\zombie_assassin_basic::recharge_special_ability(14);
  childthread buff_nearby_zombies();
  _id_0378::_id_8D74("aud_assassin_use_taunt");
}

special_assassin_damaged(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {}

buff_nearby_zombies() {
  self notify("new_assassin_buff");
  self endon("new_assassin_buff");
  var_0 = 0;
  var_1 = gettime();
  self.assassinabilitysustained = 1;

  while((gettime() - var_1) / 1000 < 8) {
    var_2 = _id_0547::_id_408F();

    foreach(var_4 in var_2) {
      if(isDefined(var_4.assassin_modifier) && var_4 maps\mp\zombies\zombie_assassin_basic::is_boss_assassin()) {
        continue;
      }
      if(var_4 is_boss_buffed()) {
        continue;
      }
      if(distance(self.origin, var_4.origin) > 256) {
        continue;
      }
      var_4 thread apply_boss_buff(self);
    }

    wait 0.125;
  }

  self.assassinabilitysustained = 0;
  maps\mp\zombies\zombie_assassin_basic::disable_assassin_chest_fx();
}

apply_boss_buff(var_0) {
  self endon("death");

  if(!isDefined(level.frontline_assassin_buff_count))
    level.frontline_assassin_buff_count = 0;

  level.frontline_assassin_buff_count++;
  var_1 = undefined;
  self.started_boss_buff = 1;

  if(!isDefined(level.loc_beams))
    level.loc_beams = [];

  if(level.loc_beams.size < 3) {
    var_1 = _func_382("zmb_tesla_storm_beam", var_0, "J_Spine4", self, "J_Spine4");
    level.loc_beams = common_scripts\utility::_id_0F6F(level.loc_beams, var_1);
  }

  wait 0.55;
  spawn_assassin_frontline_fx();

  if(isDefined(var_1)) {
    level.loc_beams = common_scripts\utility::_id_0F93(level.loc_beams, var_1);
    var_1 delete();
  }

  set_boss_buff();
}

spawn_assassin_frontline_fx() {
  if(isDefined(self.bufffx))
    self.bufffx delete();

  var_0 = _func_2A8(common_scripts\utility::_id_44F5("zmi_assassin_buff"), self, "J_Spine4");
  maps\mp\agents\_agent_utility::deleteentonagentdeath(var_0);
  _func_14C(var_0);
  self.bufffx = var_0;
}

set_boss_buff() {
  self endon("death");
  self._id_6941 = 1;
  self.zombie_shielding_func = ::handle_boss_buff;

  if(common_scripts\utility::_id_562E(self.bossintrozombiespawn) && !common_scripts\utility::_id_562E(self._id_2FDA) && _id_0547::_id_5565(self._id_6250, 0)) {
    self notify("assassin_awoken");
    self.is_boss_buffed = 1;

    if(!_id_0547::_id_5565(self._id_0A4B, "zombie_generic")) {
      return;
    }
    self _meth_83A2(1);
    maps\mp\agents\_scripted_agent_anim_util::_id_8732(1, "assassin intro taunt");
    var_0 = maps\mp\agents\_scripted_agent_anim_util::_id_7A35("board_taunt_base");
    maps\mp\agents\_scripted_agent_anim_util::_id_71FA("board_taunt_base", var_0, 1.0, "taunt_anim");
    maps\mp\agents\_scripted_agent_anim_util::_id_8732(0, "assassin intro taunt");
    self _meth_83A2(0);
  }
}

handle_boss_buff(var_0) {
  if(!isDefined(self.zombie_magic_sheild_health))
    self.zombie_magic_sheild_health = 2500;

  self.zombie_magic_sheild_health = self.zombie_magic_sheild_health - var_0;

  if(self.zombie_magic_sheild_health <= 0)
    self_remove_boss_buff();
}

self_remove_boss_buff() {
  self.started_boss_buff = 0;
  self.is_boss_buffed = 0;
  self.zombie_shielding_func = undefined;
  self.zombie_magic_sheild_health = 0;

  if(isDefined(self.bufffx))
    self.bufffx delete();
}

is_boss_buffed() {
  return common_scripts\utility::_id_562E(self.is_boss_buffed) || common_scripts\utility::_id_562E(self.started_boss_buff);
}