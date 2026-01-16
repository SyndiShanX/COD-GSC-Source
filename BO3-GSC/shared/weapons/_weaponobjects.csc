/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\weapons\_weaponobjects.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\array_shared;
#using scripts\shared\audio_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\duplicaterender_mgr;
#using scripts\shared\filter_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#namespace weaponobjects;

function init_shared() {
  callback::on_localplayer_spawned( & on_localplayer_spawned);
  clientfield::register("toplayer", "proximity_alarm", 1, 2, "int", & proximity_alarm_changed, 0, 1);
  clientfield::register("missile", "retrievable", 1, 1, "int", & retrievable_changed, 0, 1);
  clientfield::register("scriptmover", "retrievable", 1, 1, "int", & retrievable_changed, 0, 0);
  clientfield::register("missile", "enemyequip", 1, 2, "int", & enemyequip_changed, 0, 1);
  clientfield::register("scriptmover", "enemyequip", 1, 2, "int", & enemyequip_changed, 0, 0);
  clientfield::register("missile", "teamequip", 1, 1, "int", & teamequip_changed, 0, 1);
  level._effect["powerLight"] = "weapon/fx_equip_light_os";
  if(!isdefined(level.retrievable)) {
    level.retrievable = [];
  }
  if(!isdefined(level.enemyequip)) {
    level.enemyequip = [];
  }
}

function on_localplayer_spawned(local_client_num) {
  if(self != getlocalplayer(local_client_num)) {
    return;
  }
  self thread watch_perks_changed(local_client_num);
  self thread watch_killstreak_tap_activation(local_client_num);
}

function watch_killstreak_tap_activation(local_client_num) {
  self notify("watch_killstreak_tap_activation");
  self endon("watch_killstreak_tap_activation");
  self endon("death");
  self endon("disconnect");
  self endon("entityshutdown");
  while (isdefined(self)) {
    self waittill("notetrack", note);
    if(note == "activate_datapad") {
      uimodel = createuimodel(getuimodelforcontroller(local_client_num), "hudItems.killstreakActivated");
      setuimodelvalue(uimodel, 1);
    }
    if(note == "deactivate_datapad") {
      uimodel = createuimodel(getuimodelforcontroller(local_client_num), "hudItems.killstreakActivated");
      setuimodelvalue(uimodel, 0);
    }
  }
}

function proximity_alarm_changed(local_client_num, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  update_sound(local_client_num, bnewent, newval, oldval);
}

function update_sound(local_client_num, bnewent, newval, oldval) {
  if(newval == 2) {
    if(!isdefined(self._proximity_alarm_snd_ent)) {
      self._proximity_alarm_snd_ent = spawn(local_client_num, self.origin, "script_origin");
      self thread sndproxalert_entcleanup(local_client_num, self._proximity_alarm_snd_ent);
    }
    playsound(local_client_num, "uin_c4_proximity_alarm_start", (0, 0, 0));
    self._proximity_alarm_snd_ent playloopsound("uin_c4_proximity_alarm_loop", 0.1);
  } else {
    if(newval == 1) {} else if(newval == 0 && isdefined(oldval) && oldval != newval) {
      playsound(local_client_num, "uin_c4_proximity_alarm_stop", (0, 0, 0));
      if(isdefined(self._proximity_alarm_snd_ent)) {
        self._proximity_alarm_snd_ent stopallloopsounds(0.5);
      }
    }
  }
}

function teamequip_changed(local_client_num, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self updateteamequipment(local_client_num, newval);
}

function updateteamequipment(local_client_num, newval) {
  self checkteamequipment(local_client_num);
}

function retrievable_changed(local_client_num, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(isdefined(level.var_f12ccf06)) {
    self[[level.var_f12ccf06]](local_client_num, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump);
  } else {
    self util::add_remove_list(level.retrievable, newval);
    self updateretrievable(local_client_num, newval);
  }
}

function updateretrievable(local_client_num, newval) {
  if(isdefined(self.owner) && self.owner == getlocalplayer(local_client_num)) {
    self duplicate_render::set_item_retrievable(local_client_num, newval);
  } else if(isdefined(self.currentdrfilter)) {
    self duplicate_render::set_item_retrievable(local_client_num, 0);
  }
}

function enemyequip_changed(local_client_num, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(isdefined(level.var_c301d021)) {
    self[[level.var_c301d021]](local_client_num, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump);
  } else {
    newval = newval != 0;
    self util::add_remove_list(level.enemyequip, newval);
    self updateenemyequipment(local_client_num, newval);
  }
}

function updateenemyequipment(local_client_num, newval) {
  watcher = getlocalplayer(local_client_num);
  friend = self util::friend_not_foe(local_client_num, 1);
  if(!friend && isdefined(watcher) && watcher hasperk(local_client_num, "specialty_showenemyequipment")) {
    self duplicate_render::set_item_friendly_equipment(local_client_num, 0);
    self duplicate_render::set_item_enemy_equipment(local_client_num, newval);
  } else {
    if(friend && isdefined(watcher) && watcher duplicate_render::show_friendly_outlines(local_client_num)) {
      self duplicate_render::set_item_enemy_equipment(local_client_num, 0);
      self duplicate_render::set_item_friendly_equipment(local_client_num, newval);
    } else {
      self duplicate_render::set_item_enemy_equipment(local_client_num, 0);
      self duplicate_render::set_item_friendly_equipment(local_client_num, 0);
    }
  }
}

function equipmentdr(local_client_num) {}

function watch_perks_changed(local_client_num) {
  self notify("watch_perks_changed");
  self endon("watch_perks_changed");
  self endon("death");
  self endon("disconnect");
  self endon("entityshutdown");
  while (isdefined(self)) {
    wait(0.016);
    util::clean_deleted(level.retrievable);
    util::clean_deleted(level.enemyequip);
    array::thread_all(level.retrievable, & updateretrievable, local_client_num, 1);
    array::thread_all(level.enemyequip, & updateenemyequipment, local_client_num, 1);
    self waittill("perks_changed");
  }
}

function checkteamequipment(localclientnum) {
  if(!isdefined(self.owner)) {
    return;
  }
  if(!isdefined(self.equipmentoldteam)) {
    self.equipmentoldteam = self.team;
  }
  if(!isdefined(self.equipmentoldownerteam)) {
    self.equipmentoldownerteam = self.owner.team;
  }
  watcher = getlocalplayer(localclientnum);
  if(!isdefined(self.equipmentoldwatcherteam)) {
    self.equipmentoldwatcherteam = watcher.team;
  }
  if(self.equipmentoldteam != self.team || self.equipmentoldownerteam != self.owner.team || self.equipmentoldwatcherteam != watcher.team) {
    self.equipmentoldteam = self.team;
    self.equipmentoldownerteam = self.owner.team;
    self.equipmentoldwatcherteam = watcher.team;
    self notify("team_changed");
  }
}

function equipmentteamobject(localclientnum) {
  if(isdefined(level.disable_equipment_team_object) && level.disable_equipment_team_object) {
    return;
  }
  self endon("entityshutdown");
  self util::waittill_dobj(localclientnum);
  wait(0.05);
  fx_handle = self thread playflarefx(localclientnum);
  self thread equipmentwatchteamfx(localclientnum, fx_handle);
  self thread equipmentwatchplayerteamchanged(localclientnum, fx_handle);
  self thread equipmentdr();
}

function playflarefx(localclientnum) {
  self endon("entityshutdown");
  level endon("player_switch");
  if(!isdefined(self.equipmenttagfx)) {
    self.equipmenttagfx = "tag_origin";
  }
  if(!isdefined(self.equipmentfriendfx)) {
    self.equipmenttagfx = level._effect["powerLightGreen"];
  }
  if(!isdefined(self.equipmentenemyfx)) {
    self.equipmenttagfx = level._effect["powerLight"];
  }
  if(self util::friend_not_foe(localclientnum, 1)) {
    fx_handle = playfxontag(localclientnum, self.equipmentfriendfx, self, self.equipmenttagfx);
  } else {
    fx_handle = playfxontag(localclientnum, self.equipmentenemyfx, self, self.equipmenttagfx);
  }
  return fx_handle;
}

function equipmentwatchteamfx(localclientnum, fxhandle) {
  msg = self util::waittill_any_return("entityshutdown", "team_changed", "player_switch");
  if(isdefined(fxhandle)) {
    stopfx(localclientnum, fxhandle);
  }
  waittillframeend();
  if(msg != "entityshutdown" && isdefined(self)) {
    self thread equipmentteamobject(localclientnum);
  }
}

function equipmentwatchplayerteamchanged(localclientnum, fxhandle) {
  self endon("entityshutdown");
  self notify("team_changed_watcher");
  self endon("team_changed_watcher");
  watcherplayer = getlocalplayer(localclientnum);
  while (true) {
    level waittill("team_changed", clientnum);
    player = getlocalplayer(clientnum);
    if(watcherplayer == player) {
      self notify("team_changed");
    }
  }
}

function sndproxalert_entcleanup(localclientnum, ent) {
  level util::waittill_any("sndDEDe", "demo_jump", "player_switch", "killcam_begin", "killcam_end");
  if(isdefined(ent)) {
    ent stopallloopsounds(0.5);
    ent delete();
  }
}