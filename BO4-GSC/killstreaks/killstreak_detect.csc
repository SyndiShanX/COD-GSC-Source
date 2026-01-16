/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: killstreaks\killstreak_detect.csc
***********************************************/

#include scripts\core_common\array_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\renderoverridebundle;
#include scripts\core_common\shoutcaster;
#include scripts\core_common\util_shared;
#include scripts\killstreaks\killstreak_bundles;

#namespace killstreak_detect;

init_shared() {
  if(!isDefined(level.var_c662dc2d)) {
    level.var_c662dc2d = {};
    callback::on_localplayer_spawned(&watch_killstreak_detect_perks_changed);
    clientfield::register("scriptmover", "enemyvehicle", 1, 2, "int", &enemyscriptmovervehicle_changed, 0, 0);
    clientfield::register("vehicle", "enemyvehicle", 1, 2, "int", &enemyvehicle_changed, 0, 1);
    clientfield::register("missile", "enemyvehicle", 1, 2, "int", &enemymissilevehicle_changed, 0, 1);
    clientfield::register("actor", "enemyvehicle", 1, 2, "int", &function_430c370a, 0, 1);
    clientfield::register("vehicle", "vehicletransition", 1, 1, "int", &vehicle_transition, 0, 1);

    if(!isDefined(level.enemyvehicles)) {
      level.enemyvehicles = [];
    }

    if(!isDefined(level.enemymissiles)) {
      level.enemymissiles = [];
    }

    if(!isDefined(level.var_51afeae4)) {
      level.var_51afeae4 = [];
    }

    function_8ac48939(level.killstreakcorebundle);
    level.emp_killstreaks = [];
    renderoverridebundle::function_f72f089c(#"hash_7d4b6b0d84ddafa3", #"friendly", sessionmodeiscampaigngame() ? #"rob_sonar_set_friendlyequip_cp" : #"rob_sonar_set_friendlyequip_mp", &function_95f96f3e);
  }
}

function_95f96f3e(local_client_num, bundle, param) {
  if(!self function_4e0ca360()) {
    return false;
  }

  if(!(isDefined(level.friendlycontentoutlines) && level.friendlycontentoutlines)) {
    return false;
  }

  if(shoutcaster::is_shoutcaster(local_client_num)) {
    return false;
  }

  if(self.type === "vehicle" && self function_4add50a7()) {
    return false;
  }

  if(isDefined(level.vision_pulse[local_client_num]) && level.vision_pulse[local_client_num]) {
    return false;
  }

  player = function_5c10bd79(local_client_num);

  if(self == player) {
    return false;
  }

  if(player.var_33b61b6f === 1) {
    bundle.force_kill = 1;
    return false;
  }

  return true;
}

function_7181329a(entity) {
  if(isplayer(entity)) {
    return false;
  }

  if(entity.type != "missile" && entity.type != "vehicle" && entity.type != "scriptmover" && entity.type != "actor") {
    return false;
  }

  if(self clientfield::get("enemyvehicle") != 0) {
    return true;
  }

  if(entity.type != "actor" && self.type !== "vehicle" && self clientfield::get("enemyequip") != 0) {
    return true;
  }

  return false;
}

function_903bbed3(local_client_num, bundle) {
  if(self function_4e0ca360()) {
    return false;
  }

  if(shoutcaster::is_shoutcaster(local_client_num)) {
    return false;
  }

  if(self.type === "vehicle" && self function_4add50a7()) {
    return false;
  }

  if(isDefined(self.isbreachingfirewall) && self.isbreachingfirewall == 1) {
    return false;
  }

  if(function_5778f82(local_client_num, #"specialty_showenemyvehicles") && !isplayer(self) && function_7181329a(self)) {
    return true;
  }

  player = function_5c10bd79(local_client_num);

  if(isDefined(player) && player.var_33b61b6f === 1) {
    bundle.force_kill = 1;
    return true;
  }

  return false;
}

function_d859c344(local_client_num, newval) {
  bundle = self killstreak_bundles::function_48e9536e();

  if(!isDefined(bundle)) {
    bundle = level.killstreakcorebundle;
  }

  if(isDefined(bundle)) {
    show_friendly = bundle.("ksROBShowFriendly");

    if(isDefined(show_friendly) && show_friendly) {
      self renderoverridebundle::function_c8d97b8e(local_client_num, #"friendly", bundle.kstype + "friendly");
    }

    show_enemy = bundle.("ksROBShowEnemy");

    if(isDefined(show_enemy) && show_enemy) {
      self renderoverridebundle::function_c8d97b8e(local_client_num, #"enemy", bundle.kstype + "enemy");
    }

    return;
  }

  self renderoverridebundle::function_c8d97b8e(local_client_num, #"friendly", #"hash_7d4b6b0d84ddafa3");
}

vehicle_transition(local_client_num, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  function_d859c344(local_client_num, newval);

  if(isDefined(level.var_7cc76271)) {
    [[level.var_7cc76271]](local_client_num, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump);
  }
}

should_set_compass_icon(local_client_num) {
  return self function_83973173() || function_5778f82(local_client_num, #"specialty_showenemyvehicles");
}

enemyscriptmovervehicle_changed(local_client_num, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(isDefined(level.scriptmovercompassicons) && isDefined(self.model)) {
    if(isDefined(level.scriptmovercompassicons[self.model])) {
      if(self should_set_compass_icon(local_client_num)) {
        self setcompassicon(level.scriptmovercompassicons[self.model]);
      }
    }
  }

  enemyvehicle_changed(local_client_num, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump);
}

enemymissilevehicle_changed(local_client_num, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(isDefined(level.missilecompassicons) && isDefined(self.weapon)) {
    if(isDefined(level.missilecompassicons[self.weapon])) {
      if(self should_set_compass_icon(local_client_num)) {
        self setcompassicon(level.missilecompassicons[self.weapon]);
      }
    }
  }

  enemymissile_changed(local_client_num, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump);
}

enemymissile_changed(local_client_num, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self updateteammissiles(local_client_num, newval);
  self util::add_remove_list(level.enemymissiles, newval);
}

enemyvehicle_changed(local_client_num, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(isDefined(level.draftstage) && (level.draftstage > 0 || isDefined(level.var_8c099032) && level.var_8c099032)) {
    self function_d05902d9(local_client_num, newval);
    return;
  }

  self updateteamvehicles(local_client_num, newval);
  self util::add_remove_list(level.enemyvehicles, newval);
  self updateenemyvehicles(local_client_num, newval);

  if(isDefined(self.model) && self.model == "wpn_t7_turret_emp_core" && self.type === "vehicle") {
    if(!isDefined(level.emp_killstreaks)) {
      level.emp_killstreaks = [];
    } else if(!isarray(level.emp_killstreaks)) {
      level.emp_killstreaks = array(level.emp_killstreaks);
    }

    level.emp_killstreaks[level.emp_killstreaks.size] = self;
  }
}

function_430c370a(local_client_num, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(isDefined(level.draftstage) && (level.draftstage > 0 || isDefined(level.var_8c099032) && level.var_8c099032)) {
    self function_f27ffe49(local_client_num, newval);
    return;
  }

  self util::add_remove_list(level.var_51afeae4, newval);
  self function_f884010a(local_client_num, newval);
}

updateteamvehicles(local_client_num, newval) {
  self checkteamvehicles(local_client_num);
}

updateteammissiles(local_client_num, newval) {
  self checkteammissiles(local_client_num);
}

function_f884010a(local_client_num, newval) {
  if(!isDefined(self)) {
    return;
  }

  function_d859c344(local_client_num, newval);
}

updateenemyvehicles(local_client_num, newval) {
  if(!isDefined(self)) {
    return;
  }

  function_d859c344(local_client_num, newval);
}

updateenemymissiles(local_client_num, newval) {
  if(!isDefined(self)) {
    return;
  }

  function_d859c344(local_client_num, newval);
}

watch_killstreak_detect_perks_changed(local_client_num) {
  if(!self function_21c0fa55()) {
    return;
  }

  self notify(#"watch_killstreak_detect_perks_changed");
  self endon(#"watch_killstreak_detect_perks_changed");
  self endon(#"death");
  self endon(#"disconnect");

  while(isDefined(self)) {
    waitframe(1);
    util::clean_deleted(level.var_51afeae4);
    util::clean_deleted(level.enemyvehicles);
    util::clean_deleted(level.enemymissiles);
    array::thread_all(level.var_51afeae4, &function_f884010a, local_client_num, 1);
    array::thread_all(level.enemyvehicles, &updateenemyvehicles, local_client_num, 1);
    array::thread_all(level.enemymissiles, &updateenemymissiles, local_client_num, 1);
    self waittill(#"perks_changed");
  }
}

checkteamvehicles(localclientnum) {
  if(!isDefined(self.owner) || !isDefined(self.owner.team)) {
    return;
  }

  if(!isDefined(self.vehicleoldteam)) {
    self.vehicleoldteam = self.team;
  }

  if(!isDefined(self.vehicleoldownerteam)) {
    self.vehicleoldownerteam = self.owner.team;
  }

  var_fd9de919 = function_9b3f0ed1(localclientnum);

  if(!isDefined(self.vehicleoldwatcherteam)) {
    self.vehicleoldwatcherteam = var_fd9de919;
  }

  if(self.vehicleoldteam != self.team || self.vehicleoldownerteam != self.owner.team || self.vehicleoldwatcherteam != var_fd9de919) {
    self.vehicleoldteam = self.team;
    self.vehicleoldownerteam = self.owner.team;
    self.vehicleoldwatcherteam = var_fd9de919;
    self notify(#"team_changed");
  }
}

checkteammissiles(localclientnum) {
  if(!isDefined(self.owner) || !isDefined(self.owner.team)) {
    return;
  }

  if(!isDefined(self.missileoldteam)) {
    self.missileoldteam = self.team;
  }

  if(!isDefined(self.missileoldownerteam)) {
    self.missileoldownerteam = self.owner.team;
  }

  var_fd9de919 = function_9b3f0ed1(localclientnum);

  if(!isDefined(self.missileoldwatcherteam)) {
    self.missileoldwatcherteam = var_fd9de919;
  }

  if(self.missileoldteam != self.team || self.missileoldownerteam != self.owner.team || self.missileoldwatcherteam != var_fd9de919) {
    self.missileoldteam = self.team;
    self.missileoldownerteam = self.owner.team;
    self.missileoldwatcherteam = var_fd9de919;
    self notify(#"team_changed");
  }
}

function_8ac48939(bundle) {
  show_friendly = bundle.("ksROBShowFriendly");

  if(isDefined(show_friendly) && show_friendly) {
    renderoverridebundle::function_f72f089c(bundle.kstype + "friendly", bundle.("ksROBFriendly"), &function_95f96f3e);
  }

  show_enemy = bundle.("ksROBShowEnemy");

  if(isDefined(show_enemy) && show_enemy) {
    renderoverridebundle::function_f72f089c(bundle.kstype + "enemy", bundle.("ksROBEnemy"), &function_903bbed3);
  }
}

private function_d05902d9(local_client_num, newval) {
  if(!isDefined(level.var_b1dca2fb)) {
    level.var_b1dca2fb = [];
  }

  if(!isDefined(level.var_b1dca2fb[local_client_num])) {
    level.var_b1dca2fb[local_client_num] = [];
  }

  var_55251088 = spawnStruct();
  var_55251088.vehicle = self;
  var_55251088.newval = newval;

  if(!isDefined(level.var_b1dca2fb[local_client_num])) {
    level.var_b1dca2fb[local_client_num] = [];
  } else if(!isarray(level.var_b1dca2fb[local_client_num])) {
    level.var_b1dca2fb[local_client_num] = array(level.var_b1dca2fb[local_client_num]);
  }

  level.var_b1dca2fb[local_client_num][level.var_b1dca2fb[local_client_num].size] = var_55251088;
}

function_32c8b999(local_client_num) {
  if(!isDefined(level.var_b1dca2fb) || !isDefined(level.var_b1dca2fb[local_client_num])) {
    return;
  }

  for(i = level.var_b1dca2fb[local_client_num].size - 1; i >= 0; i--) {
    vehicle = level.var_b1dca2fb[local_client_num][i].vehicle;
    newval = level.var_b1dca2fb[local_client_num][i].newval;

    if(isDefined(vehicle) && isalive(vehicle)) {
      vehicle enemyvehicle_changed(local_client_num, undefined, newval);
    }

    level.var_b1dca2fb[local_client_num][i] = undefined;
  }

  arrayremoveindex(level.var_b1dca2fb, local_client_num);

  if(level.var_b1dca2fb.size == 0) {
    level.var_b1dca2fb = undefined;
  }
}

private function_f27ffe49(local_client_num, newval) {
  if(!isDefined(level.inserted_pop_)) {
    level.inserted_pop_ = [];
  }

  if(!isDefined(level.inserted_pop_[local_client_num])) {
    level.inserted_pop_[local_client_num] = [];
  }

  var_a87a8991 = spawnStruct();
  var_a87a8991.actor = self;
  var_a87a8991.newval = newval;

  if(!isDefined(level.inserted_pop_[local_client_num])) {
    level.inserted_pop_[local_client_num] = [];
  } else if(!isarray(level.inserted_pop_[local_client_num])) {
    level.inserted_pop_[local_client_num] = array(level.inserted_pop_[local_client_num]);
  }

  level.inserted_pop_[local_client_num][level.inserted_pop_[local_client_num].size] = var_a87a8991;
}

function_3eff7815(local_client_num) {
  if(!isDefined(level.inserted_pop_) || !isDefined(level.inserted_pop_[local_client_num])) {
    return;
  }

  for(i = level.inserted_pop_[local_client_num].size - 1; i >= 0; i--) {
    actor = level.inserted_pop_[local_client_num][i].actor;
    newval = level.inserted_pop_[local_client_num][i].newval;

    if(isDefined(actor) && isalive(actor)) {
      actor function_430c370a(local_client_num, undefined, newval);
    }

    level.inserted_pop_[local_client_num][i] = undefined;
  }

  arrayremoveindex(level.inserted_pop_, local_client_num);

  if(level.inserted_pop_.size == 0) {
    level.inserted_pop_ = undefined;
  }
}