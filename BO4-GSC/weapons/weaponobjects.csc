/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: weapons\weaponobjects.csc
***********************************************/

#include scripts\core_common\array_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\duplicaterender_mgr;
#include scripts\core_common\flag_shared;
#include scripts\core_common\renderoverridebundle;
#include scripts\core_common\util_shared;

#namespace weaponobjects;

init_shared(friendly_rob, var_4885f19e) {
  callback::on_localplayer_spawned(&on_localplayer_spawned);
  clientfield::register("toplayer", "proximity_alarm", 1, 3, "int", &proximity_alarm_changed, 0, 1);
  clientfield::register("missile", "retrievable", 1, 1, "int", &retrievable_changed, 0, 1);
  clientfield::register("scriptmover", "retrievable", 1, 1, "int", &retrievable_changed, 0, 0);
  clientfield::register("missile", "enemyequip", 1, 2, "int", &enemyequip_changed, 0, 1);
  clientfield::register("scriptmover", "enemyequip", 1, 2, "int", &enemyequip_changed, 0, 0);
  clientfield::register("missile", "teamequip", 1, 1, "int", &teamequip_changed, 0, 1);
  clientfield::register("clientuimodel", "hudItems.proximityAlarm", 1, 3, "int", undefined, 0, 0);
  clientfield::register("missile", "friendlyequip", 1, 1, "int", &friendly_outline, 0, 1);
  clientfield::register("scriptmover", "friendlyequip", 1, 1, "int", &friendly_outline, 0, 0);
  level._effect[#"powerlight"] = #"weapon/fx8_equip_light_os";

  if(getgametypesetting(#"hash_48670d9509071424")) {
    level.var_58253868 = friendly_rob;
  }

  level.var_420d7d7e = var_4885f19e;
  level.var_4de4699b = #"rob_sonar_set_enemy";

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

on_localplayer_spawned(local_client_num) {
  if(!self function_21c0fa55()) {
    return;
  }

  self thread watch_perks_changed(local_client_num);
}

proximity_alarm_changed(local_client_num, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  update_sound(local_client_num, bnewent, newval, oldval);
}

update_sound(local_client_num, bnewent, newval, oldval) {
  if(newval == 2) {
    if(!isDefined(self._proximity_alarm_snd_ent)) {
      self._proximity_alarm_snd_ent = spawn(local_client_num, self.origin, "script_origin");
      self thread sndproxalert_entcleanup(local_client_num, self._proximity_alarm_snd_ent);
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

teamequip_changed(local_client_num, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self updateteamequipment(local_client_num, newval);
}

updateteamequipment(local_client_num, newval) {
  self checkteamequipment(local_client_num);
}

retrievable_changed(local_client_num, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self util::add_remove_list(level.retrievable, newval);
  self updateretrievable(local_client_num, newval);
}

updateretrievable(local_client_num, newval) {
  if(self function_b9b8fbc7()) {
    self duplicate_render::set_item_retrievable(local_client_num, newval);
    return;
  }

  if(isDefined(self.currentdrfilter)) {
    self duplicate_render::set_item_retrievable(local_client_num, 0);
  }
}

function_f89c4b81() {
  if(isDefined(self.weapon) && self.weapon.statname == #"ac130") {
    return false;
  }

  if(isDefined(self.weapon) && self.weapon.statname == #"tr_flechette_t8") {
    return false;
  }

  return true;
}

enemyequip_changed(local_client_num, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  newval = newval != 0;

  if(self function_f89c4b81()) {
    self util::add_remove_list(level.enemyequip, newval);
    self updateenemyequipment(local_client_num, newval);
  }
}

function_6a5648dc(local_client_num, bundle) {
  if(!self function_4e0ca360() || self.team === #"free") {
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
    return false;
  }

  return true;
}

function_232f3acf(local_client_num, bundle) {
  if(self function_4e0ca360() && self.team !== #"free") {
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
    if(function_5778f82(local_client_num, #"specialty_showenemyequipment") && isDefined(self.var_f19b4afd) && self.var_f19b4afd) {
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

updateenemyequipment(local_client_num, newval) {
  if(isDefined(level.var_58253868)) {
    self renderoverridebundle::function_c8d97b8e(local_client_num, #"friendly", #"hash_66ac79c57723c169");
  }

  if(isDefined(level.var_420d7d7e)) {
    self renderoverridebundle::function_c8d97b8e(local_client_num, #"enemy", #"hash_691f7dc47ae8aa08");
  }
}

friendly_outline(local_client_num, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {}

watch_perks_changed(local_client_num) {
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

checkteamequipment(localclientnum) {
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

equipmentteamobject(localclientnum) {
  if(isDefined(level.disable_equipment_team_object) && level.disable_equipment_team_object) {
    return;
  }

  self endon(#"death");
  self util::waittill_dobj(localclientnum);
  waitframe(1);
  fx_handle = self thread playflarefx(localclientnum);
  self thread equipmentwatchteamfx(localclientnum, fx_handle);
  self thread equipmentwatchplayerteamchanged(localclientnum, fx_handle);
}

playflarefx(localclientnum) {
  self endon(#"death");
  level endon(#"player_switch");

  if(!isDefined(self.equipmenttagfx)) {
    self.equipmenttagfx = "tag_origin";
  }

  if(!isDefined(self.equipmentfriendfx)) {
    self.equipmenttagfx = level._effect[#"powerlightgreen"];
  }

  if(!isDefined(self.equipmentenemyfx)) {
    self.equipmenttagfx = level._effect[#"powerlight"];
  }

  if(self function_83973173()) {
    fx_handle = util::playFXOnTag(localclientnum, self.equipmentfriendfx, self, self.equipmenttagfx);
  } else {
    fx_handle = util::playFXOnTag(localclientnum, self.equipmentenemyfx, self, self.equipmenttagfx);
  }

  return fx_handle;
}

equipmentwatchteamfx(localclientnum, fxhandle) {
  msg = self waittill(#"death", #"team_changed", #"player_switch");

  if(isDefined(fxhandle)) {
    stopfx(localclientnum, fxhandle);
  }

  waittillframeend();

  if(msg._notify != "death" && isDefined(self)) {
    self thread equipmentteamobject(localclientnum);
  }
}

equipmentwatchplayerteamchanged(localclientnum, fxhandle) {
  self endon(#"death");
  self notify(#"team_changed_watcher");
  self endon(#"team_changed_watcher");
  watcherplayer = function_5c10bd79(localclientnum);

  while(true) {
    waitresult = level waittill(#"team_changed");
    player = function_5c10bd79(waitresult.localclientnum);

    if(watcherplayer == player) {
      self notify(#"team_changed");
    }
  }
}

sndproxalert_entcleanup(localclientnum, ent) {
  level waittill(#"snddede", #"demo_jump", #"player_switch", #"killcam_begin", #"killcam_end");

  if(isDefined(ent)) {
    ent stopallloopsounds(0.5);
    ent delete();
  }
}