/*********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\_zombiemode_weap_thundergun.csc
*********************************************************/

#include clientscripts\_utility;
#include clientscripts\_fx;
#include clientscripts\_music;

init() {
  if(getDvar(#"createfx") == "on") {
    return;
  }
  if(!thundergun_exists()) {
    return;
  }
  level._effect["thundergun_viewmodel_power_cell1"] = loadfx("weapon/thunder_gun/fx_thundergun_power_cell_view1");
  level._effect["thundergun_viewmodel_power_cell2"] = loadfx("weapon/thunder_gun/fx_thundergun_power_cell_view2");
  level._effect["thundergun_viewmodel_power_cell3"] = loadfx("weapon/thunder_gun/fx_thundergun_power_cell_view3");
  level._effect["thundergun_viewmodel_steam"] = loadfx("weapon/thunder_gun/fx_thundergun_steam_view");
  level._effect["thundergun_viewmodel_power_cell_upgraded1"] = loadfx("weapon/thunder_gun/fx_thundergun_power_cell_view1");
  level._effect["thundergun_viewmodel_power_cell_upgraded2"] = loadfx("weapon/thunder_gun/fx_thundergun_power_cell_view2");
  level._effect["thundergun_viewmodel_power_cell_upgraded3"] = loadfx("weapon/thunder_gun/fx_thundergun_power_cell_view3");
  level._effect["thundergun_viewmodel_steam"] = loadfx("weapon/thunder_gun/fx_thundergun_steam_view");
  level._effect["thundergun_viewmodel_steam_upgraded"] = loadfx("weapon/thunder_gun/fx_thundergun_steam_view");
  level.thundergun_steam_vents = 3;
  level.thundergun_power_cell_fx_handles = [];
  level.thundergun_power_cell_fx_handles[level.thundergun_power_cell_fx_handles.size] = -1;
  level.thundergun_power_cell_fx_handles[level.thundergun_power_cell_fx_handles.size] = -1;
  level.thundergun_power_cell_fx_handles[level.thundergun_power_cell_fx_handles.size] = -1;
  level thread player_init();
  level thread thundergun_notetrack_think();
}

player_init() {
  waitforclient(0);
  level.thundergun_play_fx_power_cell = [];
  players = getLocalPlayers();
  for(i = 0; i < players.size; i++) {
    level.thundergun_play_fx_power_cell[i] = true;
    players[i] thread thundergun_fx_power_cell(i);
  }
}

thundergun_fx_power_cell(localClientNum) {
  self endon("disconnect");
  oldAmmo = -1;
  oldCount = -1;
  self thread thundergun_fx_listener(localClientNum);
  for(;;) {
    realwait(0.1);
    while(!clientHasSnapshot(0)) {
      wait(0.05);
    }
    weaponname = undefined;
    currentweapon = GetCurrentWeapon(localClientNum);
    if(!level.thundergun_play_fx_power_cell[localclientnum] || IsThrowingGrenade(localClientNum) || IsMeleeing(localClientNum) || IsOnTurret(localClientNum) || (currentweapon != "thundergun_zm" && currentweapon != "thundergun_upgraded_zm")) {
      if(oldAmmo != -1) {
        thundergun_play_power_cell_fx(localClientNum, 0);
      }
      oldAmmo = -1;
      oldCount = -1;
      continue;
    }
    ammo = GetWeaponAmmoClip(localClientNum, currentweapon);
    if(oldAmmo > 0 && oldAmmo != ammo) {
      thundergun_fx_fire(localClientNum);
    }
    oldAmmo = ammo;
    if(ammo > level.thundergun_power_cell_fx_handles.size) {
      ammo = level.thundergun_power_cell_fx_handles.size;
    }
    if(oldCount == -1 || oldCount != ammo) {
      level thread thundergun_play_power_cell_fx(localClientNum, ammo);
    }
    oldCount = ammo;
  }
}

thundergun_play_power_cell_fx(localClientNum, count) {
  level notify("kill_power_cell_fx");
  for(i = 0; i < level.thundergun_power_cell_fx_handles.size; i++) {
    if(isDefined(level.thundergun_power_cell_fx_handles[i]) && level.thundergun_power_cell_fx_handles[i] != -1) {
      deletefx(localClientNum, level.thundergun_power_cell_fx_handles[i]);
      level.thundergun_power_cell_fx_handles[i] = -1;
    }
  }
  if(!count) {
    return;
  }
  level endon("kill_power_cell_fx");
  currentweapon = GetCurrentWeapon(localClientNum);
  for(;;) {
    for(i = count; i > 0; i--) {
      fx = level._effect["thundergun_viewmodel_power_cell" + i];
      if(currentweapon == "thundergun_upgraded_zm") {
        fx = level._effect["thundergun_viewmodel_power_cell_upgraded" + i];
      }
      level.thundergun_power_cell_fx_handles[i - 1] = PlayViewmodelFx(localClientNum, fx, "tag_bulb" + i);
    }
    realwait(3);
  }
}

thundergun_fx_fire(localClientNum) {
  currentweapon = GetCurrentWeapon(localClientNum);
  fx = level._effect["thundergun_viewmodel_steam"];
  if(currentweapon == "thundergun_upgraded_zm") {
    fx = level._effect["thundergun_viewmodel_steam_upgraded"];
  }
  for(i = level.thundergun_steam_vents; i > 0; i--) {
    PlayViewmodelFx(localClientNum, fx, "tag_steam" + i);
  }
}

thundergun_notetrack_think() {
  for(;;) {
    level waittill("notetrack", localclientnum, note);
    switch (note) {
      case "thundergun_putaway_start":
        level.thundergun_play_fx_power_cell[localclientnum] = false;
        break;
      case "thundergun_pullout_start":
        level.thundergun_play_fx_power_cell[localclientnum] = true;
        break;
      case "thundergun_fire_start":
        thundergun_fx_fire(localClientNum);
        break;
    }
  }
}

thundergun_death_effects(localClientNum, weaponname, userdata) {}
thread_zombie_vox() {
  ent = spawn(0, self.origin, "script_origin");
  playSound(0, "wpn_thundergun_proj_impact_zombie", ent.origin);
  wait(5);
  ent delete();
}

thundergun_fx_listener(localClientNum) {
  self endon("disconnect");
  while(1) {
    level waittill("tgfx0");
    level.thundergun_play_fx_power_cell[localclientnum] = false;
    level waittill("tgfx1");
    level.thundergun_play_fx_power_cell[localclientnum] = true;
  }
}

thundergun_exists() {
  if(GetDvarInt(#"zombiemode") == 0) {
    return true;
  }
  if(!isDefined(level._box_weapons)) {
    return false;
  }
  for(i = 0; i < level._box_weapons.size; i++) {
    if("thundergun_zm" == level._box_weapons[i]) {
      return true;
    }
  }
  return false;
}