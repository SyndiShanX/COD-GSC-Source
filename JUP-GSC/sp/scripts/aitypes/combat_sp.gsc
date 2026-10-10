/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\aitypes\combat_sp.gsc
***********************************************/

#using scripts\aitypes\bt_util;
#using scripts\aitypes\combat;
#using scripts\anim\face;
#using scripts\anim\shared;
#using scripts\anim\utility_common;
#using scripts\asm\shared\utility;
#using scripts\asm\soldier\death;
#using scripts\asm\soldier\patrol;
#using scripts\asm\track;
#using scripts\common\utility;
#using scripts\engine\utility;
#using scripts\sp\nvg\nvg_ai;
#using scripts\sp\spawner;
#using scripts\sp\stealth\utility;
#namespace combat_sp;

function initcombatfunctions(taskid) {
  self.fngetturretaimangles = &getturretaimanglessp;
  self.fngetusedturret = &getusedturret;
  self.fnlaseron = &turnonlaser;
  self.fnlaseroff = &turnofflaser;
  self.fnsetlaserflag = &callsetlaserflag;
  self.fnsaygenericdialogue = &saygenericdialogue;
  self.fnupdatefrantic = &updatefrantic;
  scripts\asm\soldier\patrol::function_3aba5f22b60d37f5();
  initstealthfunctionssp();
  level thread scripts\aitypes\combat::low_cover_combat_areas();
  return anim.success;
}

function initstealthfunctionssp() {
  self.fnstealthflashlighton = &scripts\sp\nvg\nvg_ai::flashlight_on;
  self.fnstealthflashlightoff = &scripts\sp\nvg\nvg_ai::flashlight_off;
  self.fnstealthmusictransition = &scripts\sp\stealth\utility::stealth_music_transition_sp;
  self.fnupdatelightmeter = &scripts\sp\nvg\nvg_ai::updatelightmeter;
  self.fnstealthgotonode = &scripts\sp\spawner::go_to_node;
}

function soldier_init(taskid) {
  scripts\aitypes\combat::soldier_init_common();
  self.var_cbd87a0bc497b778 = 1;
  self.var_689bf433cb5c5322 = "melee_sp";
  self enableteamwalking(1);
  self enablemissedbulletclientonly(0);
  return anim.success;
}

function turnonlaser() {
  self laserforceon();
}

function turnofflaser() {
  self laserforceoff();
}

function callsetlaserflag(flag) {
  self setlaserflag(flag);
}

function saygenericdialogue(typestring) {
  scripts\anim\face::saygenericdialogue(typestring);
}

function getturretaimanglessp(turret) {
  return turret turretgetaim();
}

function getusedturret() {
  return self getturret();
}

function updatefrantic() {
  if(self.unittype == "c6i" || actor_is3d() || self.team == "neutral") {
    return anim.success;
  }

  curtime = gettime();

  if(!isDefined(self._blackboard.franticcooldowntime) || self._blackboard.franticcooldowntime > curtime) {
    enemy_array = getaiarray(scripts\engine\utility::get_enemy_team(self.team));
    var_775b9dd7cee9529 = 0;
    timeout = 10000;
    var_8bbc3c1a2867361f = 4194304;
    var_ae15e053b9483e7c = 5;
    self._blackboard.franticcooldowntime = curtime + 10000;
    self._blackboard.franticstate = "combat";

    foreach(enemy in enemy_array) {
      dist_sqr = distancesquared(self lastknownpos(enemy), self.origin);

      if(dist_sqr > var_8bbc3c1a2867361f) {
        continue;
      }

      elapsed_time = gettime() - self lastknowntime(enemy);

      if(elapsed_time > timeout) {
        continue;
      }

      var_775b9dd7cee9529++;

      if(enemy.unittype == "c8" || enemy.unittype == "c12") {
        self._blackboard.franticstate = "frantic";
        break;
      }

      if(var_775b9dd7cee9529 >= 3) {
        self._blackboard.franticstate = "frantic";
        break;
      }
    }

    if(getdvarint(@ "hash_9bbeebe174825fd4", 0) == 1) {
      thread function_5d2b29a5f8d0c582(self._blackboard.franticcooldowntime);
    }
  }

  return anim.success;
}

function soldier_damagesubparthandler(partdata) {
  switch (partdata.partname) {
    case #"hash_8a1772f5f912c880":
      if(isDefined(self.nohelmetpop) && self.nohelmetpop) {
        assertmsg("noHelmetPop is not supported for SDF enemies with helmets. Spawn nohelmet versions.");
      }

      if(isDefined(self.onlyhelmetpopondeath) && self.onlyhelmetpopondeath) {
        assertmsg("onlyHelmetPopOnDeath is not supported for SDF enemies with helmets. Spawn nohelmet versions.");
      }

      scripts\asm\soldier\death::helmetpop();
      break;
  }
}

function function_5d2b29a5f8d0c582(end_time) {
  self notify("<dev string:x1c>");
  self endon("<dev string:x1c>");
  self endon("<dev string:x2f>");

  while(gettime() < end_time) {
    print3d(self.origin + (0, 0, 32), self._blackboard.franticstate, (1, 0, 0), 1, 1, 1);
    wait 0.05;
  }
}

# /