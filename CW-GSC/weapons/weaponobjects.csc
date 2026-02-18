/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: weapons\weaponobjects.csc
***********************************************/

#using script_13da4e6b98ca81a1;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\renderoverridebundle;
#using scripts\core_common\util_shared;
#namespace weaponobjects;

function init_shared(friendly_rob, var_4885f19e) {
  callback::on_localplayer_spawned(&on_localplayer_spawned);
  clientfield::register("toplayer", "proximity_alarm", 1, 3, "int", &proximity_alarm_changed, 0, 1);
  clientfield::register("missile", "retrievable", 1, 1, "int", &retrievable_changed, 0, 1);
  clientfield::register("scriptmover", "retrievable", 1, 1, "int", &retrievable_changed, 0, 0);
  clientfield::register("missile", "enemyequip", 1, 2, "int", &enemyequip_changed, 0, 1);
  clientfield::register("scriptmover", "enemyequip", 1, 2, "int", &enemyequip_changed, 0, 0);
  clientfield::register("missile", "teamequip", 1, 1, "int", &teamequip_changed, 0, 1);
  clientfield::register_clientuimodel("hudItems.proximityAlarm", #"hud_items", #"proximityalarm", 1, 3, "int", undefined, 0, 0);
  clientfield::register("missile", "friendlyequip", 1, 1, "int", &friendly_outline, 0, 1);
  clientfield::register("scriptmover", "friendlyequip", 1, 1, "int", &friendly_outline, 0, 0);
  level._effect[# "powerlight"] = # "weapon/fx8_equip_light_os";

  if(getgametypesetting(#"hash_48670d9509071424") && false) {
    level.var_58253868 = friendly_rob;
  }

  if(isDefined(var_4885f19e)) {
    function_6aae3df3(var_4885f19e);
  }

  level.var_420d7d7e = var_4885f19e;
  level.var_4de4699b = # "rob_sonar_set_enemy";

  if(!isDefined(level.retrievable)) {
    level.retrievable = [];
  }

  if(!isDefined(level.enemyequip)) {
    level.enemyequip = [];
  }

  if(isDefined(level.var_58253868)) {
    renderoverridebundle::function_f72f089c(#"hash_66ac79c57723c169", level.var_58253868, &function_6a5648dc, undefined, undefined, 1);
  }

  if(isDefined(level.var_420d7d7e)) {
    renderoverridebundle::function_f72f089c(#"hash_691f7dc47ae8aa08", level.var_420d7d7e, &function_232f3acf, undefined, level.var_4de4699b, 1);
  }
}

function on_localplayer_spawned(local_client_num) {
  if(!self function_21c0fa55()) {
    return;
  }

  self thread watch_perks_changed(local_client_num);
}

function proximity_alarm_changed(local_client_num, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  update_sound(bnewent, bwastimejump, fieldname, binitialsnap);
}

function update_sound(local_client_num, bnewent, newval, oldval) {
  if(newval == 2) {
    if(!isDefined(self._proximity_alarm_snd_ent)) {
      self._proximity_alarm_snd_ent = spawn(bnewent, self.origin, "script_origin");
      self thread sndproxalert_entcleanup(bnewent, self._proximity_alarm_snd_ent);
    }

    return;
  }

  if(newval == 1) {
    return;
  }

  if(newval == 0 && isDefined(oldval) && oldval != newval) {
    if(isDefined(self._proximity_alarm_snd_ent)) {
      self._proximity_alarm_snd_ent stopallloopsounds(0.5);
    }
  }
}

function teamequip_changed(local_client_num, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self updateteamequipment(fieldname, bwastimejump);
}

function updateteamequipment(local_client_num, newval) {
  self checkteamequipment(newval);
}

function retrievable_changed(local_client_num, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self util::add_remove_list(level.retrievable, bwastimejump);
  self updateretrievable(fieldname, bwastimejump);
}

function updateretrievable(local_client_num, newval) {
  if(self function_b9b8fbc7()) {}
}

function function_f89c4b81() {
  if(isDefined(self.weapon) && self.weapon.statname == # "ac130") {
    return false;
  }

  if(isDefined(self.weapon) && self.weapon.statname == # "tr_flechette_t8") {
    return false;
  }

  return true;
}

function enemyequip_changed(local_client_num, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  bwastimejump = bwastimejump != 0;

  if(self function_f89c4b81()) {
    self util::add_remove_list(level.enemyequip, bwastimejump);
    self updateenemyequipment(fieldname, bwastimejump);
  }
}

function function_6a5648dc(local_client_num, bundle) {
  if(codcaster::function_b8fe9b52(bundle)) {
    return true;
  }

  if(!self function_e9fc6a64() || self.team === # "none") {
    return false;
  }

  if(is_true(level.vision_pulse[bundle])) {
    return false;
  }

  player = function_5c10bd79(bundle);

  if(self == player) {
    return false;
  }

  if(player.var_33b61b6f === 1) {
    return false;
  }

  type = self.type;

  if((type == "missile" || type == "scriptmover") && self clientfield::get("friendlyequip") === 0) {
    return false;
  }

  return true;
}

function function_232f3acf(local_client_num, bundle) {
  if(codcaster::function_b8fe9b52(local_client_num)) {
    return true;
  }

  if(self function_e9fc6a64() && self.team !== # "none") {
    return false;
  }

  if(self.var_6abc296 === 1) {
    return true;
  }

  type = self.type;

  if((type == "missile" || type == "scriptmover") && self clientfield::get("enemyequip") === 0) {
    return false;
  }

  if(sessionmodeiswarzonegame()) {
    if(function_5778f82(local_client_num, #"specialty_showenemyequipment") && is_true(self.var_f19b4afd)) {
      return true;
    }
  } else {
    if(function_5778f82(local_client_num, #"specialty_showenemyequipment")) {
      return true;
    }

    bundle.var_1a5b7293 = 1;
  }

  return false;
}

function updateenemyequipment(local_client_num, newval) {
  if(codcaster::function_b8fe9b52(newval)) {
    var_7eda7144 = self codcaster::is_friendly(newval) ? # "friendly" : # "enemy";
    robkey = self codcaster::is_friendly(newval) ? # "hash_2476e7ae62469f70" : # "hash_2476eaae6246a489";
    self renderoverridebundle::function_c8d97b8e(newval, var_7eda7144, robkey);
    return;
  }

  if(isDefined(level.var_58253868)) {
    self renderoverridebundle::function_c8d97b8e(newval, #"friendly", #"hash_66ac79c57723c169");
  }

  if(isDefined(level.var_420d7d7e)) {
    self renderoverridebundle::function_c8d97b8e(newval, #"enemy", #"hash_691f7dc47ae8aa08");
  }
}

function friendly_outline(local_client_num, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(isDefined(level.var_58253868)) {
    self renderoverridebundle::function_c8d97b8e(bwastimejump, #"friendly", #"hash_66ac79c57723c169");
  }
}

function watch_perks_changed(local_client_num) {
  self notify(#"watch_perks_changed");
  self endon(#"watch_perks_changed");
  self endon(#"death");
  self endon(#"disconnect");

  while(isDefined(self)) {
    waitframe(1);
    util::clean_deleted(level.retrievable);
    util::clean_deleted(level.enemyequip);
    array::thread_all(level.retrievable, &updateretrievable, local_client_num, 1);
    array::thread_all(level.enemyequip, &updateenemyequipment, local_client_num, 1);
    self waittill(#"perks_changed");
  }
}

function checkteamequipment(localclientnum) {
  if(!isDefined(self.owner)) {
    return;
  }

  if(!isDefined(self.equipmentoldteam)) {
    self.equipmentoldteam = self.team;
  }

  if(!isDefined(self.equipmentoldownerteam)) {
    self.equipmentoldownerteam = self.owner.team;
  }

  var_fd9de919 = function_73f4b33(localclientnum);

  if(!isDefined(self.equipmentoldwatcherteam)) {
    self.equipmentoldwatcherteam = var_fd9de919;
  }

  if(self.equipmentoldteam != self.team || self.equipmentoldownerteam != self.owner.team || self.equipmentoldwatcherteam != var_fd9de919) {
    self.equipmentoldteam = self.team;
    self.equipmentoldownerteam = self.owner.team;
    self.equipmentoldwatcherteam = var_fd9de919;
    self notify(#"team_changed");
  }
}

function equipmentteamobject(localclientnum) {
  if(is_true(level.disable_equipment_team_object)) {
    return;
  }

  self endon(#"death");
  self util::waittill_dobj(localclientnum);
  waitframe(1);
  fx_handle = self playflarefx(localclientnum);
  self thread equipmentwatchteamfx(localclientnum, fx_handle);
  self thread equipmentwatchplayerteamchanged(localclientnum, fx_handle);
}

function playflarefx(localclientnum) {
  self endon(#"death");
  level endon(#"player_switch");

  if(!isDefined(self.var_7701a848)) {
    self.var_7701a848 = "tag_origin";
  }

  if(!isDefined(self.equipmentfriendfx)) {
    self.equipmentfriendfx = level._effect[# "powerlightgreen"];
  }

  if(!isDefined(self.equipmentenemyfx)) {
    self.equipmentenemyfx = level._effect[# "powerlight"];
  }

  if(self function_ca024039()) {
    fx_handle = util::playFXOnTag(localclientnum, self.equipmentfriendfx, self, self.var_7701a848);
  } else {
    fx_handle = util::playFXOnTag(localclientnum, self.equipmentenemyfx, self, self.var_7701a848);
  }

  return fx_handle;
}

function equipmentwatchteamfx(localclientnum, fxhandle) {
  msg = self waittill(#"death", #"team_changed", #"player_switch");

  if(isDefined(fxhandle)) {
    stopfx(localclientnum, fxhandle);
  }

  waittillframeend();

  if(msg._notify != "death" && isDefined(self)) {
    self thread equipmentteamobject(localclientnum);
  }
}

function equipmentwatchplayerteamchanged(localclientnum, fxhandle) {
  self endon(#"death");
  self notify(#"team_changed_watcher");
  self endon(#"team_changed_watcher");
  watcherplayer = function_5c10bd79(fxhandle);

  while(true) {
    waitresult = level waittill(#"team_changed");
    player = function_5c10bd79(waitresult.localclientnum);

    if(watcherplayer == player) {
      self notify(#"team_changed");
    }
  }
}

function sndproxalert_entcleanup(localclientnum, ent) {
  level waittill(#"snddede", #"demo_jump", #"player_switch", #"killcam_begin", #"killcam_end");

  if(isDefined(ent)) {
    ent stopallloopsounds(0.5);
    ent delete();
  }
}