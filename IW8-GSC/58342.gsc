/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: 58342.gsc
***********************************************/

function ref_1380c(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_5)) {
    var_5 = 1;
  }

  ammo_manager();

  if(!ammo_cache_used()) {
    return;
  }

  if(isDefined(self.ref_136e6)) {
    if(isDefined(self.ref_136e6.type) && self.ref_136e6.type == var_0) {
      ref_12cbb(var_0, var_1);
      return;
    } else {
      if(isDefined(var_4)) {
        self.ref_136e6.sb_custom_fov_applied• = undefined;
      }

      ref_138c8();
    }
  }

  _init_speed_boost_struct(var_0);
  thread ammo_crate_think(var_0, var_1, var_2, var_3, var_4, var_5);
}

function _init_speed_boost_struct(var_0) {
  self.ref_136e6 = spawnStruct();
  self.ref_136e6.type = var_0;
  self.ref_136e6.sb_custom_suit_applied = undefined;
  self.ref_136e6.sb_custom_fov_applied• = undefined;
}

function preinfilstreamfunc() {
  if(isDefined(self.ref_136e6) && isDefined(self.ref_136e6.type)) {
    return self.ref_136e6.type;
  }

  return undefined;
}

function ref_12cbb(var_0, var_1) {
  if(isDefined(self.ref_136e6) && isDefined(self.ref_136e6.type)) {
    self notify("speed_boost_" + var_0 + "_timer_reset", var_1);
    return;
  }
}

function ref_138c8() {
  if(isDefined(self.ref_136e6) && isDefined(self.ref_136e6.type)) {
    ammo_crate_spawn();
    var_0 = self.ref_136e6.type;
    self.ref_136e6 = undefined;
    self notify("stop_speed_boost_" + var_0);
    return;
  }
}

function ammo_crate_think(var_0, var_1, var_2, var_3, var_4, var_5) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("stop_speed_boost_" + var_0);
  self notify("start_speed_boost_" + var_0);

  if(istrue(var_5)) {
    GscBinSkip4(0x35);
  }

  GscBinSkip4(0x35);
}

function ammo_crates() {
  scripts\engine\utility::ref_143a5("death", "player_set_infinate_super_sprint");
  thread ref_138c8();
}

function ammo_crate_trial_think() {
  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

    if(level.gametype == "br" && (var_4 == "MOD_TRIGGER_HURT" || var_4 == "MOD_UNKNOWN")) {
      continue;
    }

    thread ref_138c8();
    return;
  }
}

function ammo_crate_use() {
  level scripts\engine\utility::ref_143a5("game_ended");
  thread ref_138c8();
}

function ammobox_bufferedattachmentweapon(var_0, var_1) {
  var_2 = ref_143cc("speed_boost_" + var_0 + "_timer_reset", var_1);

  if(isstring(var_2) && var_2 == "timeout") {
    return;
  }

  ammobox_bufferedattachmentweapon(var_0, var_2);
}

function ammo_cache_setup(var_0, var_1, var_2) {
  self.movespeedscaler = var_0;
  scripts\mp\weapons::updatemovespeedscale();

  if(!scripts\mp\gametypes\br_public::shouldlink()) {
    scripts\mp\utility\perk::giveperk("specialty_sprintmelee");
    scripts\mp\utility\perk::giveperk("specialty_sprintads");
    scripts\mp\utility\perk::giveperk("specialty_marathon");
  }

  GscBinSkip4(0x35, var_1);
}

function ammo_crate_spawn() {
  if(ammo_cache_used()) {
    if(scripts\mp\utility\perk::_hasperk("specialty_lightweight")) {
      self.movespeedscaler = scripts\mp\utility\perk::lightweightscalar();
    } else {
      self.movespeedscaler = 1;
    }

    scripts\mp\weapons::updatemovespeedscale();
  }

  if(!scripts\mp\gametypes\br_public::shouldlink()) {
    scripts\mp\utility\perk::removeperk("specialty_sprintmelee");
    scripts\mp\utility\perk::removeperk("specialty_sprintads");
    scripts\mp\utility\perk::removeperk("specialty_marathon");
  }

  if(isDefined(self.ref_136e6.sb_custom_suit_applied)) {
    thread ammo_restock();
  }

  if(ammo_cache_think() && isDefined(self.ref_136e6.sb_custom_fov_applied•)) {
    self lerpfovbypreset("default_2seconds");
    return;
  }
}

function ammobox_addrandomweapon(var_0) {
  while(isDefined(self.vehicle)) {
    waitframe();
  }

  if(isDefined(self.ref_136e6.sb_custom_suit_applied)) {
    self.ref_136e6.sb_custom_suit_applied = var_0;
    self.operatorcustomization.suit = var_0;
    scripts\mp\utility\player::_setsuit(var_0);
    return;
  }

  if(!isDefined(self.ref_12147) && is_custom_suit_valid(var_0)) {
    self.ref_12147 = self.operatorcustomization.suit;
    self.ref_136e6.sb_custom_suit_applied = var_0;
    self.operatorcustomization.suit = var_0;
    scripts\mp\utility\player::_setsuit(var_0);
    return;
  }
}

function ammo_restock() {
  level endon("game_ended");
  self endon("disconnect");
  var_0 = self.ref_136e6.sb_custom_suit_applied;

  while(isDefined(self.ref_136e6)) {
    waitframe();
  }

  while(isDefined(self.vehicle)) {
    waitframe();
  }

  if(isDefined(self.ref_136e6)) {
    self.ref_136e6.sb_custom_suit_applied = var_0;
    return;
  }

  var_1 = isDefined(self.operatorcustomization) && isDefined(self.operatorcustomization.suit) && self.operatorcustomization.suit == var_0;

  if(isDefined(self.ref_12147) && var_1) {
    self.operatorcustomization.suit = self.ref_12147;
    scripts\mp\utility\player::_setsuit(self.ref_12147);
    self.ref_12147 = undefined;
    return;
  }
}

function ammo_cache_used() {
  if((!isDefined(self.isjuiced) || !istrue(self.isjuiced)) && (!isDefined(self.cranked) || !istrue(self.cranked)) && (!isDefined(self.isjuggernaut) || !istrue(self.isjuggernaut)) && (!isDefined(self.adrenalinepoweractive) || !istrue(self.adrenalinepoweractive)) && !allassassin_initteamlist_timed("speed_boost")) {
    return true;
  }

  return false;
}

function is_custom_suit_valid(var_0) {
  var_1 = isDefined(self.operatorcustomization) && isDefined(self.operatorcustomization.suit);
  return isDefined(var_0) && var_1;
}

function ammo_cache_think() {
  if((!isDefined(self.adrenalinepoweractive) || !istrue(self.adrenalinepoweractive)) && !allassassin_initteamlist_timed("speed_boost")) {
    return true;
  }

  return false;
}

function ammo_manager() {
  if(allassassin_initteamlist_timed("speed_boost")) {
    if(isDefined(level.ref_12838) && isDefined(level.ref_12838.area1_targets)) {
      foreach(var_1 in level.ref_12838.area1_targets) {
        if(var_1.ref_138fd == "speed_boost") {
          var_2 = _keypadscriptableused_bunkeralt::ref_1249c(var_1.ref_138fd);

          if(isDefined(var_2)) {
            var_2 thread _keypadscriptableused_bunkeralt::isempdamage();
          }
        }
      }

      return;
    }

    return;
  }
}

function allassassin_initteamlist_timed(var_0) {
  if(!isDefined(level.ref_12838) || !isDefined(level.ref_12838.applyquest)) {
    return false;
  }

  var_1 = level.ref_12838.applyquest[var_0];

  if(isDefined(var_1) && scripts\engine\utility::array_contains(var_1, self)) {
    return true;
  }

  return false;
}

function ref_143cc(var_0, var_1) {
  var_2 = spawnStruct();
  thread ref_143cd(var_2, var_0);
  thread scripts\engine\utility::waittill_timeout_proc(var_2, var_1);
  var_2 waittill("waittill_proc", var_3);
  return var_3;
}

function ref_143cd(var_0, var_1) {
  var_0 endon("waittill_proc");
  self waittill(var_1, var_2);
  var_0 notify("waittill_proc", var_2);
}