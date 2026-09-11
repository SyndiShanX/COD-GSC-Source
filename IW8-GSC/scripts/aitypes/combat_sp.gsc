/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\aitypes\combat_sp.gsc
***********************************************/

function initcombatfunctions(var0) {
  self.fnresetmisstime = &resetmisstime;
  self.fngetturretaimangles = &getturretaimanglessp;
  self.fngetusedturret = &getusedturret;
  self.fnlaseron = &turnonlaser;
  self.fnlaseroff = &turnofflaser;
  self.fnsetlaserflag = &callsetlaserflag;
  self.fnsaygenericdialogue = &saygenericdialogue;
  self.fnupdatefrantic = &updatefrantic;
  scripts\aitypes\stealth::initstealthfunctions();
  initstealthfunctionssp();
  return anim.success;
}

function initstealthfunctionssp() {
  self.fnstealthflashlighton = &scripts\sp\nvg\nvg_ai::flashlight_on;
  self.fnstealthflashlightoff = &scripts\sp\nvg\nvg_ai::flashlight_off;
  self.fnstealthmusictransition = &scripts\sp\stealth\utility::stealth_music_transition_sp;
  self.fnupdatelightmeter = &scripts\sp\nvg\nvg_ai::updatelightmeter;
  self.fnstealthgotonode = &scripts\sp\spawner::go_to_node;
}

function soldier_init(var0) {
  scripts\aitypes\combat::soldier_init_common();
  self enableteamwalking(1);
  self enablemissedbulletclientonly(0);
  return anim.success;
}

function resetmisstime() {
  scripts\common\gameskill::resetmisstime();
}

function turnonlaser() {
  self laserforceon();
}

function turnofflaser() {
  self laserforceoff();
}

function callsetlaserflag(var0) {
  self setlaserflag(var0);
}

function saygenericdialogue(var0) {
  scripts\anim\face::saygenericdialogue(var0);
}

function getturretaimanglessp(var0) {
  return var0 turretgetaim();
}

function getusedturret() {
  return self getturret();
}

function updatefrantic() {
  if(self.unittype == "c6i" || scripts\engine\utility::actor_is3d() || self.team == "neutral") {
    return anim.success;
  }

  var0 = gettime();

  if(!isDefined(self._blackboard.franticcooldowntime) || self._blackboard.franticcooldowntime > var0) {
    var1 = getaiarray(scripts\engine\utility::get_enemy_team(self.team));
    var2 = 0;
    var3 = 10000;
    var4 = 4194304;
    var5 = 5;
    self._blackboard.franticcooldowntime = var0 + 10000;
    self._blackboard.franticstate = "combat";

    foreach(var7 in var1) {
      var8 = distancesquared(self lastknownpos(var7), self.origin);

      if(var8 > var4) {
        continue;
      }

      var9 = gettime() - self lastknowntime(var7);

      if(var9 > var3) {
        continue;
      }

      var2++;

      if(var7.unittype == "c8" || var7.unittype == "c12") {
        self._blackboard.franticstate = "frantic";
        break;
      }

      if(var2 >= 3) {
        self._blackboard.franticstate = "frantic";
        break;
      }
    }
  }

  return anim.success;
}

function soldier_damagesubparthandler(var0) {
  switch (var0.partname) {
    case "helmet":
      if(isDefined(self.nohelmetpop) && self.nohelmetpop) {}

      if(isDefined(self.onlyhelmetpopondeath) && self.onlyhelmetpopondeath) {}

      scripts\asm\soldier\death::helmetpop();
      break;
  }
}