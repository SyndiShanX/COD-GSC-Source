/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: aitypes\combat_sp.gsc
***********************************************/

initcombatfunctions(var_0) {
  self.fnresetmisstime = ::resetmisstime;
  self.fngetturretaimangles = ::getturretaimanglessp;
  self.fngetusedturret = ::getusedturret;
  self.fnlaseron = ::turnonlaser;
  self.fnlaseroff = ::turnofflaser;
  self.fnsetlaserflag = ::callsetlaserflag;
  self.fnsaygenericdialogue = ::saygenericdialogue;
  self.fnupdatefrantic = ::updatefrantic;
  scripts\aitypes\stealth::initstealthfunctions();
  initstealthfunctionssp();
  return anim.success;
}

initstealthfunctionssp() {
  self.fnstealthflashlighton = scripts\sp\nvg\nvg_ai::flashlight_on;
  self.fnstealthflashlightoff = scripts\sp\nvg\nvg_ai::flashlight_off;
  self.fnstealthmusictransition = scripts\sp\stealth\utility::stealth_music_transition_sp;
  self.fnupdatelightmeter = scripts\sp\nvg\nvg_ai::updatelightmeter;
  self.fnstealthgotonode = scripts\sp\spawner::go_to_node;
}

soldier_init(var_0) {
  scripts\aitypes\combat::soldier_init_common();
  self enableteamwalking(1);
  self enablemissedbulletclientonly(0);
  return anim.success;
}

resetmisstime() {
  scripts\common\gameskill::resetmisstime();
}

turnonlaser() {
  self laserforceon();
}

turnofflaser() {
  self laserforceoff();
}

callsetlaserflag(var_0) {
  self setlaserflag(var_0);
}

saygenericdialogue(var_0) {
  scripts\anim\face.gsc::saygenericdialogue(var_0);
}

getturretaimanglessp(var_0) {
  return var_0 turretgetaim();
}

getusedturret() {
  return self getturret();
}

updatefrantic() {
  if(self.unittype == "c6i" || scripts\engine\utility::actor_is3d() || self.team == "neutral")
    return anim.success;

  var_0 = gettime();

  if(!isDefined(self._blackboard.franticcooldowntime) || self._blackboard.franticcooldowntime > var_0) {
    var_1 = getaiarray(scripts\engine\utility::get_enemy_team(self.team));
    var_2 = 0;
    var_3 = 10000;
    var_4 = 4194304;
    var_5 = 5;
    self._blackboard.franticcooldowntime = var_0 + 10000;
    self._blackboard.franticstate = "combat";

    foreach(var_7 in var_1) {
      var_8 = distancesquared(self lastknownpos(var_7), self.origin);

      if(var_8 > var_4) {
        continue;
      }
      var_9 = gettime() - self lastknowntime(var_7);

      if(var_9 > var_3) {
        continue;
      }
      var_2++;

      if(var_7.unittype == "c8" || var_7.unittype == "c12") {
        self._blackboard.franticstate = "frantic";
        break;
      }

      if(var_2 >= 3) {
        self._blackboard.franticstate = "frantic";
        break;
      }
    }
  }

  return anim.success;
}

soldier_damagesubparthandler(var_0) {
  switch (var_0.partname) {
    case "helmet":
      if(isDefined(self.nohelmetpop) && self.nohelmetpop) {}

      if(isDefined(self.onlyhelmetpopondeath) && self.onlyhelmetpopondeath) {}

      scripts\asm\soldier\death::helmetpop();
      break;
  }
}