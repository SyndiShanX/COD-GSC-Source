/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\common\ai.gsc
***********************************************/

function set_forcegoal() {
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

function unset_forcegoal() {
  if(!isDefined(self.set_forcedgoal)) {
    return;
  }

  self.pathenemyfightdist = self.oldfightdist;
  self.pathenemylookahead = self.oldmaxdist;
  self.maxsightdistsqrd = self.oldmaxsight;
  self.set_forcedgoal = undefined;
}

function disable_exits() {
  self.disableexits = 1;
}

function enable_exits() {
  self.disableexits = 0;
}

function disable_turnanims() {
  self.noturnanims = 1;
}

function enable_turnanims() {
  self.noturnanims = undefined;
}

function disable_arrivals() {
  self.disablearrivals = 1;
}

function enable_arrivals() {
  self endon("death");
  waittillframeend();
  self.disablearrivals = 0;
}

function set_rebel(var0) {
  self._blackboard.isrebel = var0;
}

function spawn_failed(var0) {
  if(!isalive(var0)) {
    return true;
  }

  if(scripts\common\utility::issp() && !isDefined(var0.finished_spawning)) {
    var0 scripts\engine\utility::waittill_either("finished spawning", "death");
  }

  if(isalive(var0)) {
    return false;
  }

  return true;
}

function gun_remove() {
  if(isai(self)) {
    scripts\engine\utility::script_func("anim_placeweaponon", self.weapon, "none");
    return;
  }

  if(isDefined(self.fake_weapon_models)) {
    set_strict_ff();
    return;
  }

  self detach(getweaponmodel(self.weapon), "tag_weapon_right");
}

function set_strict_ff() {
  if(isDefined(self.fake_weapon_models)) {
    for(var0 = self.fake_weapon_models.size - 1; var0 >= 0; var0--) {
      self detach(self.fake_weapon_models[var0]);
    }

    self.fake_weapon_models = undefined;
    return;
  }
}

function set_start_cash(var0) {
  foreach(var2 in var0) {
    if(issubstr(var2, "toprail") || issubstr(var2, "railcust")) {
      if(var0.size > 1) {
        var0 = scripts\engine\utility::array_remove(var0, var2);
        var0 = scripts\engine\utility::array_insert(var0, var2, 1);
      }
    }
  }

  foreach(var2 in var0) {
    self attach(var2);
  }

  self.fake_weapon_models = var0;
}

function gun_recall() {
  if(isai(self)) {
    scripts\engine\utility::script_func("anim_placeweaponon", self.weapon, "right");
    return;
  }

  self attach(getweaponmodel(self.weapon), "tag_weapon_right");
}

function set_gunpose(var0, var1) {
  if(var0 == "automatic") {
    var0 = undefined;
  }

  self.gunposeoverride = var0;
  self.gundiscipline = isDefined(var1) && var1;
}

function reset_gunpose() {
  self.gunposeoverride = undefined;
  self.gundiscipline = 1;
}

function poi_enable(var0, var1) {
  scripts\asm\shared\utility::toggle_poi(var0, var1);
}

function stop_use_turret() {
  self notify("stop_use_turret");
  self unlink();
  self._blackboard.requestedturret = undefined;
  self._blackboard.requestedturretpose = undefined;
}

function stop_magic_bullet_shield() {
  self notify("stop_magic_bullet_shield");

  if(isai(self)) {
    if(isDefined(self.old_attackeraccuracy)) {
      self.attackeraccuracy = self.old_attackeraccuracy;
      self.old_attackeraccuracy = undefined;
    } else {
      self.attackeraccuracy = 1;
    }
  }

  self.magic_bullet_shield = undefined;
  self.damageshield = 0;
  self notify("internal_stop_magic_bullet_shield");
}

function magic_bullet_death_detection() {}

function magic_bullet_shield(var0) {
  if(isai(self)) {} else {
    self.health = 100000;
  }

  self endon("internal_stop_magic_bullet_shield");

  if(isai(self)) {
    self.old_attackeraccuracy = self.attackeraccuracy;
    self.attackeraccuracy = 0.1;
  }

  self notify("magic_bullet_shield");
  self.magic_bullet_shield = 1;
  self.damageshield = 1;
}

function force_long_death_on_back_with_pistol(var0) {
  self.forcelongdeath = 4;

  if(istrue(var0)) {
    self.skipdyingbackcrawl = 1;
  }

  self asmsetstate(self.asmname, "choose_long_death");
}

function force_long_death_crawling_away() {
  self.forcelongdeath = 3;
}

function force_long_death_stumbling() {
  self.forcelongdeath = 2;
}

function find_and_teleport_to_cover(var0) {
  var1 = 0;
  var2 = undefined;
  var3 = 1;
  var4 = self findbestcovernode(var0, var1, var2, var3);

  if(isDefined(var4)) {
    var5 = var4.angles;
    var6 = var4.origin;

    if(!issubstr(var4.type, "Prone")) {
      if(issubstr(var4.type, "Left")) {
        var5 += (0, 90, 0);
      } else if(issubstr(var4.type, "Right") || issubstr(var4.type, "Cover Crouch") || issubstr(var4.type, "Conceal") || issubstr(var4.type, "Cover Stand")) {
        var5 -= (0, 90, 0);
      }
    }

    self forceteleport(var6, var5);
    self usecovernode(var4, 1);
    self setgoalnode(var4);
    return true;
  }

  return false;
}

function bot_ctf_get_node_chance(var0) {
  if(!isDefined(self._blackboard.bot_cur_loadout_num)) {
    self._blackboard.bot_cur_loadout_num = 1;
    self._blackboard.bot_ctf_recover_flag = var0;
    return true;
  }

  return false;
}

function bot_ctf_flag_picked_up_of_team() {
  if(isDefined(self._blackboard.bot_cur_loadout_num) && self._blackboard.bot_cur_loadout_num == 1) {
    self._blackboard.bot_cur_loadout_num = 2;
    return;
  }
}

function bot_ctf_enemy_team_flag_is_picked_up() {
  if(isDefined(self._blackboard.bot_cur_loadout_num)) {
    if(self._blackboard.bot_cur_loadout_num == 1) {
      self._blackboard.bot_cur_loadout_num = undefined;
      self._blackboard.bot_ctf_recover_flag = undefined;
      return true;
    } else if(self._blackboard.bot_cur_loadout_num == 2) {
      self._blackboard.bot_cur_loadout_num = 3;
      return true;
    }
  }

  return false;
}

function bot_ctf_flag_is_home_of_team() {
  if(isDefined(self._blackboard.bot_cur_loadout_num) && self._blackboard.bot_cur_loadout_num == 3) {
    self._blackboard.bot_cur_loadout_num = undefined;
    self._blackboard.bot_ctf_recover_flag = undefined;
    return;
  }
}

function bomber_spawn_origins(var0, var1) {
  if(!isDefined(var0) || !isalive(var0)) {
    return;
  }

  var2 = bot_ctf_get_node_chance(var0, var1);

  if(var2) {
    var0.ignoreall = 1;
    var0.ignoreme = 1;
    return;
  }
}

function blueprintextract_createtempobjective(var0) {
  if(!isDefined(var0) || !isalive(var0)) {
    return;
  }

  var1 = bot_ctf_enemy_team_flag_is_picked_up(var0);

  if(var1) {
    var0.ignoreall = 0;
    var0.ignoreme = 0;
    return;
  }
}