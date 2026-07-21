/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: common\ai.gsc
***********************************************/

set_forcegoal() {
  if(isDefined(self.set_forcedgoal)) {
    return;
  }
  self.oldfightdist = self.pathenemyfightdist;
  self.oldmaxdist = self.pathenemylookahead;
  self.oldmaxsight = self.maxsightdistsqrd;
  self.pathenemyfightdist = 8;
  self.pathenemylookahead = 8;
  self.maxsightdistsqrd = 1;
  self.set_forcedgoal = 1;
}

unset_forcegoal() {
  if(!isDefined(self.set_forcedgoal)) {
    return;
  }
  self.pathenemyfightdist = self.oldfightdist;
  self.pathenemylookahead = self.oldmaxdist;
  self.maxsightdistsqrd = self.oldmaxsight;
  self.set_forcedgoal = undefined;
}

disable_exits() {
  self.disableexits = 1;
}

enable_exits() {
  self.disableexits = 0;
}

disable_turnanims() {
  self.noturnanims = 1;
}

enable_turnanims() {
  self.noturnanims = undefined;
}

disable_arrivals() {
  self.disablearrivals = 1;
}

enable_arrivals() {
  self endon("_encstr_AD75063D571AE108");
  waittillframeend;
  self.disablearrivals = 0;
}

set_rebel(var_0) {
  self._blackboard.isrebel = var_0;
}

spawn_failed(var_0) {
  if(!isalive(var_0))
    return 1;

  if(scripts\common\utility::issp() && !isDefined(var_0.finished_spawning))
    var_0 scripts\engine\utility::waittill_either("_encstr_B29312AA98120B8BD20DF3B9D79B2A3718BB80BF", "_encstr_AD75063D571AE108");

  if(isalive(var_0))
    return 0;

  return 1;
}

gun_remove() {
  if(isai(self))
    scripts\engine\utility::script_func("_encstr_83A4130BE6D2B6EB83630BD895EEB20BE07BCDF6E6", self.weapon, "_encstr_8BBA05185F8B99");
  else if(isDefined(self.fake_weapon_models))
    set_strict_ff();
  else
    self detach(getweaponmodel(self.weapon), "_encstr_91AC11A5C6EA277BF50F837BCB371383322C1D");
}

set_strict_ff() {
  if(isDefined(self.fake_weapon_models)) {
    for(var_0 = self.fake_weapon_models.size - 1; var_0 >= 0; var_0--)
      self detach(self.fake_weapon_models[var_0]);

    self.fake_weapon_models = undefined;
  }
}

set_start_cash(var_0) {
  foreach(var_2 in var_0) {
    if(issubstr(var_2, "_encstr_849208231881C2DF7879") || issubstr(var_2, "_encstr_8862096B409B5DCF938E44")) {
      if(var_0.size > 1) {
        var_0 = scripts\engine\utility::array_remove(var_0, var_2);
        var_0 = scripts\engine\utility::array_insert(var_0, var_2, 1);
      }
    }
  }

  foreach(var_2 in var_0)
  self attach(var_2);

  self.fake_weapon_models = var_0;
}

gun_recall() {
  if(isai(self))
    scripts\engine\utility::script_func("_encstr_83A4130BE6D2B6EB83630BD895EEB20BE07BCDF6E6", self.weapon, "_encstr_8253060E2B5FE330");
  else
    self attach(getweaponmodel(self.weapon), "_encstr_91AC11A5C6EA277BF50F837BCB371383322C1D");
}

set_gunpose(var_0, var_1) {
  if(var_0 == "_encstr_B6DA0A585D47F6B52C1D961B")
    var_0 = undefined;

  self.gunposeoverride = var_0;
  self.gundiscipline = isDefined(var_1) && var_1;
}

reset_gunpose() {
  self.gunposeoverride = undefined;
  self.gundiscipline = 1;
}

poi_enable(var_0, var_1) {
  scripts\asm\shared\utility::toggle_poi(var_0, var_1);
}

stop_use_turret() {
  self notify("_encstr_928A10073312DF11852A51EE136DB0166A9B");
  self unlink();
  self._blackboard.requestedturret = undefined;
  self._blackboard.requestedturretpose = undefined;
}

stop_magic_bullet_shield() {
  self notify("_encstr_AD7319B613FAE9EE6D7FC8A06F87812B72BD25BDA15381104DA3D8");

  if(isai(self)) {
    if(isDefined(self.old_attackeraccuracy)) {
      self.attackeraccuracy = self.old_attackeraccuracy;
      self.old_attackeraccuracy = undefined;
    } else
      self.attackeraccuracy = 1;
  }

  self.magic_bullet_shield = undefined;
  self.damageshield = 0;
  self notify("_encstr_84FD2219ADD02FB348A94A61F39D0FA23103899FDB1BF9CBEDE042CA3B60271C688B0CE4");
}

magic_bullet_death_detection() {}

magic_bullet_shield(var_0) {
  if(isai(self)) {} else
    self.health = 100000;

  self endon("_encstr_84FD2219ADD02FB348A94A61F39D0FA23103899FDB1BF9CBEDE042CA3B60271C688B0CE4");

  if(isai(self)) {
    self.old_attackeraccuracy = self.attackeraccuracy;
    self.attackeraccuracy = 0.1;
  }

  self notify("_encstr_8EC614B5853BB48D7D89AEC68D568EFAE634A595D846");
  self.magic_bullet_shield = 1;
  self.damageshield = 1;
}

force_long_death_on_back_with_pistol(var_0) {
  self.forcelongdeath = 4;

  if(istrue(var_0))
    self.skipdyingbackcrawl = 1;

  self asmsetstate(self.asmname, "_encstr_87D2121BD0F6F63759D78D7BB9B3BE8CCAC2471A");
}

force_long_death_crawling_away() {
  self.forcelongdeath = 3;
}

force_long_death_stumbling() {
  self.forcelongdeath = 2;
}

find_and_teleport_to_cover(var_0) {
  var_1 = 0;
  var_2 = undefined;
  var_3 = 1;
  var_4 = self findbestcovernode(var_0, var_1, var_2, var_3);

  if(isDefined(var_4)) {
    var_5 = var_4.angles;
    var_6 = var_4.origin;

    if(!issubstr(var_4.type, "_encstr_922406B1A6FD5E05")) {
      if(issubstr(var_4.type, "_encstr_A5AD0568019C63"))
        var_5 = var_5 + (0, 90, 0);
      else if(issubstr(var_4.type, "_encstr_8253061E2B5FE330") || issubstr(var_4.type, "_encstr_87AB0D4BD7B857DB077503DA9B8EEB") || issubstr(var_4.type, "_encstr_8BF608EDC8D8CFD8F9A8") || issubstr(var_4.type, "_encstr_AFFF0C6E8FE899DDE6174B068510"))
        var_5 = var_5 - (0, 90, 0);
    }

    self forceteleport(var_6, var_5);
    self usecovernode(var_4, 1);
    self setgoalnode(var_4);
    return 1;
  }

  return 0;
}

bot_ctf_get_node_chance(var_0) {
  if(!isDefined(self._blackboard.bot_cur_loadout_num)) {
    self._blackboard.bot_cur_loadout_num = 1;
    self._blackboard.bot_ctf_recover_flag = var_0;
    return 1;
  }

  return 0;
}

bot_ctf_flag_picked_up_of_team() {
  if(isDefined(self._blackboard.bot_cur_loadout_num) && self._blackboard.bot_cur_loadout_num == 1)
    self._blackboard.bot_cur_loadout_num = 2;
}

bot_ctf_enemy_team_flag_is_picked_up() {
  if(isDefined(self._blackboard.bot_cur_loadout_num)) {
    if(self._blackboard.bot_cur_loadout_num == 1) {
      self._blackboard.bot_cur_loadout_num = undefined;
      self._blackboard.bot_ctf_recover_flag = undefined;
      return 1;
    } else if(self._blackboard.bot_cur_loadout_num == 2) {
      self._blackboard.bot_cur_loadout_num = 3;
      return 1;
    }
  }

  return 0;
}

bot_ctf_flag_is_home_of_team() {
  if(isDefined(self._blackboard.bot_cur_loadout_num) && self._blackboard.bot_cur_loadout_num == 3) {
    self._blackboard.bot_cur_loadout_num = undefined;
    self._blackboard.bot_ctf_recover_flag = undefined;
  }
}

bomber_spawn_origins(var_0, var_1) {
  if(!isDefined(var_0) || !isalive(var_0)) {
    return;
  }
  var_2 = var_0 bot_ctf_get_node_chance(var_1);

  if(var_2) {
    var_0.ignoreall = 1;
    var_0.ignoreme = 1;
  }
}

blueprintextract_createtempobjective(var_0) {
  if(!isDefined(var_0) || !isalive(var_0)) {
    return;
  }
  var_1 = var_0 bot_ctf_enemy_team_flag_is_picked_up();

  if(var_1) {
    var_0.ignoreall = 0;
    var_0.ignoreme = 0;
  }
}