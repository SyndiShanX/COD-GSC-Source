/*********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_plunder_dispenser.gsc
*********************************************************/

function init() {
  if(!isenabled()) {
    return;
  }

  level.plunder_dispensers_data = spawnStruct();
  level.plunder_dispensers_data.plunderinstances = [];
  level.plunder_dispensers_data.availableyawoffsets = [];
  level.plunder_dispensers_data.next_available_id = 0;
  level.plunder_dispensers_data.max_dispensed = getdvarint("scr_plunder_dispenser_max_dispensed", 0);
  level.plunder_dispensers_data.min_restart_delay_sec = getdvarint("scr_plunder_dispenser_min_restart_delay_sec", 0);
  level.plunder_dispensers_data.max_restart_delay_sec = getdvarint("scr_plunder_dispenser_max_restart_delay_sec", 0);
  level.plunder_dispensers_data.spawn_percent = getdvarfloat("scr_plunder_dispenser_percent_spawn", 1);
  scripts\engine\scriptable::scriptable_addusedcallback(&scriptable_used);
  scripts\engine\scriptable::ref_12F57(&scriptable_used);
  scripts\mp\gametypes\br_pickups::registerpickupremovedforspacecallback(&removed_for_space);
  level.plunder_dispensers_data.conf_fx["sparks"] = loadfx("vfx/iw8_br/gameplay/vfx_sparks_atm.vfx");
}

function isenabled() {
  if(getdvarint("scr_broken_atm_disabled", 1)) {
    return false;
  }

  if(!istrue(level.br_plunder_enabled)) {
    return false;
  }

  return true;
}

function registerandstartupdatingdispenser(var_0, var_1, var_2) {
  var_0.dispenserid = level.plunder_dispensers_data.next_available_id;
  level.plunder_dispensers_data.next_available_id++;
  level.plunder_dispensers_data.plunderinstances[var_0.dispenserid] = [];
  var_0 setscriptablepartstate("broken_atm", "disabled");
  thread dispenser_spawn_plunder(var_0, var_1);
}

function onprematchdone() {
  if(!isenabled()) {
    return;
  }

  var_0 = getentitylessscriptablearrayinradius("scriptable_broken_atm_scriptable", "classname");
  var_1 = int(var_0.size * level.plunder_dispensers_data.spawn_percent);
  level.plunder_dispensers_data.a_scr_atms_placed = scripts\mp\gametypes\br_functional_poi::ai_shooting_watch(var_0, var_1);
  var_2 = getdvarfloat("scr_plunder_dispenser_spawn_plunder_interval_seconds", 5);
  var_3 = getdvarint("scr_plunder_dispenser_spawned_plunder_limit", 3);

  foreach(var_5 in level.plunder_dispensers_data.a_scr_atms_placed) {
    if(!isDefined(var_5)) {
      continue;
    }

    registerandstartupdatingdispenser(var_5, var_2, var_3);
  }
}

function dispenser_create(var_0, var_1, var_2, var_3) {
  if(!isenabled()) {
    return;
  }

  var_4 = easepower("broken_atm_scriptable", var_0, var_1);
  registerandstartupdatingdispenser(var_4, var_2, var_3);
  return var_4;
}

function dispenser_spawn_plunder(var_0, var_1) {
  level endon("game_ended");
  level endon("force_end");
  var_2 = getdvarfloat("scr_plunder_dispenser_roundstart_wait_seconds", 0);

  if(var_2 > 0) {
    wait var_2;
  }

  self setscriptablepartstate("broken_atm", "visible");
  var_3 = self.angles[1];
  level.plunder_dispensers_data.availableyawoffsets[self.dispenserid] = [var_3];

  if(var_1 > 1) {
    var_4 = 360 / var_1;

    for(var_5 = 1; var_5 < var_1; var_5++) {
      var_6 = var_3 + var_4;
      var_3 = scripts\engine\utility::ter_op(var_6 > 360, var_6 - 360, var_6);
      level.plunder_dispensers_data.availableyawoffsets[self.dispenserid] = scripts\engine\utility::array_add(level.plunder_dispensers_data.availableyawoffsets[self.dispenserid], var_3);
    }
  }

  var_7 = 1;
  var_8 = 0;
  var_9 = 0;

  for(;;) {
    wait var_0;
    var_10 = level.plunder_dispensers_data.plunderinstances[self.dispenserid].size;

    if(var_10 >= var_1) {
      continue;
    }

    if(level.plunder_dispensers_data.max_dispensed > 0 && var_8 >= level.plunder_dispensers_data.max_dispensed) {
      if(level.plunder_dispensers_data.min_restart_delay_sec > 0 || level.plunder_dispensers_data.max_restart_delay_sec > 0) {
        if(var_9 == 0) {
          var_11 = randomintrange(level.plunder_dispensers_data.min_restart_delay_sec, level.plunder_dispensers_data.max_restart_delay_sec);
          var_9 = gettime() + var_11 * 1000;
          continue;
        } else if(var_9 < gettime()) {
          var_9 = 0;
          var_8 = 0;
          var_7 = 1;
          self setscriptablepartstate("broken_atm", "visible");
        } else {
          continue;
        }
      } else {
        return;
      }
    }

    var_12 = isDefined(level.br_plunder) && isDefined(level.br_plunder.ref_12954) && level.br_plunder.ref_12954.size > 0;

    if(!var_12) {
      continue;
    }

    var_13 = level.plunder_dispensers_data.availableyawoffsets[self.dispenserid][level.plunder_dispensers_data.availableyawoffsets[self.dispenserid].size - 1];
    level.plunder_dispensers_data.availableyawoffsets[self.dispenserid] = scripts\engine\utility::array_remove_index(level.plunder_dispensers_data.availableyawoffsets[self.dispenserid], level.plunder_dispensers_data.availableyawoffsets[self.dispenserid].size - 1);
    var_14 = int(clamp(getdvarint("scr_plunder_dispenser_spawned_plunder_rarity_index", 4), 0, level.br_plunder.ref_12954.size - 1));
    var_15 = scripts\mp\gametypes\br_pickups::test_ai_anim();
    var_16 = scripts\mp\gametypes\br_pickups::getitemdroporiginandangles(var_15, self.origin, self.angles, undefined, var_13);
    var_17 = scripts\mp\gametypes\br_pickups::spawnpickup(level.br_plunder.names[var_14], var_16, level.br_plunder.ref_12954[var_14], 1);
    var_18 = scripts\mp\gametypes\br_public::shouldusegoldbarassets();
    var_19 = "br_drop_plunder_";
    var_20 = "cash";

    if(var_18) {
      var_20 = "gold";
    }

    playsoundatpos(self.origin, var_19 + var_20);

    if(isDefined(var_17)) {
      var_17.dispenserid = self.dispenserid;
      var_17.yawused = var_13;
      level.plunder_dispensers_data.plunderinstances[self.dispenserid] = scripts\engine\utility::array_add(level.plunder_dispensers_data.plunderinstances[self.dispenserid], var_17);
      var_8++;
    }

    if(level.plunder_dispensers_data.max_dispensed > 0 && var_8 >= level.plunder_dispensers_data.max_dispensed && var_7) {
      var_7 = 0;
      self setscriptablepartstate("broken_atm", "disabled");
    }
  }
}

function scriptable_used(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_0.dispenserid)) {
    if(isDefined(level.br_plunder) && isDefined(level.br_plunder.ref_127BF) && isDefined(var_3) && isDefined(var_3.plundercount) && var_3.plundercount >= level.br_plunder.ref_127BF) {
      return;
    }

    removeinstacefromplunderdata(var_0);
    return;
  }
}

function removed_for_space() {
  if(isDefined(self.dispenserid)) {
    removeinstacefromplunderdata();
    return;
  }
}

function removeinstacefromplunderdata() {
  if(isDefined(self.dispenserid)) {
    if(isDefined(self.yawused)) {
      if(!scripts\engine\utility::array_contains(level.plunder_dispensers_data.availableyawoffsets[self.dispenserid], self.yawused)) {
        level.plunder_dispensers_data.availableyawoffsets[self.dispenserid] = scripts\engine\utility::array_add_safe(level.plunder_dispensers_data.availableyawoffsets[self.dispenserid], self.yawused);
      }
    }

    level.plunder_dispensers_data.plunderinstances[self.dispenserid] = scripts\engine\utility::array_remove(level.plunder_dispensers_data.plunderinstances[self.dispenserid], self);
    return;
  }
}