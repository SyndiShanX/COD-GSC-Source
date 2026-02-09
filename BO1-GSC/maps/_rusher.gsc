/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_rusher.gsc
**************************************/

#include maps\_utility;
#include common_scripts\utility;
#include animscripts\Utility;
#include animscripts\combat_utility;
#include animscripts\anims_table;
#using_animtree("generic_human");

init_rusher() {
  level.RUSHER_DEFAULT_GOALRADIUS = 64;
  level.RUSHER_DEFAULT_PATHENEMYDIST = 64;
  level.RUSHER_PISTOL_PATHENEMYDIST = 300;
}
rush(endon_flag, timeout) {
  self endon("death");
  if(!IsAlive(self)) {
    return;
  }
  if(isDefined(self.rusher)) {
    return;
  }
  self.rusher = true;
  if(self.animType == "vc") {
    self.moveplaybackrate = 1.6;
  }
  self set_rusher_type();
  self setup_rusher_anims();
  self.oldgoalradius = self.goalradius;
  self.goalradius = level.RUSHER_DEFAULT_GOALRADIUS;
  if(self.rusherType == "pistol") {
    self.oldpathenemyFightdist = self.pathenemyFightdist;
    self.pathenemyFightdist = level.RUSHER_PISTOL_PATHENEMYDIST;
  } else {
    self.oldpathenemyFightdist = self.pathenemyFightdist;
    self.pathenemyFightdist = level.RUSHER_DEFAULT_PATHENEMYDIST;
    self.disableExits = true;
    self.disableArrivals = true;
  }
  self disable_react();
  self.ignoresuppression = true;
  self.health = self.health + 100;
  player = get_closest_player(self.origin);
  self.rushing_goalent = spawn("script_origin", player.origin);
  self.rushing_goalent LinkTo(player);
  self thread keep_rushing_player(player);
  if(!isDefined(self.noWoundedRushing) || self.noWoundedRushing == false) {
    self thread change_to_wounded();
  }
  self thread rusher_yelling();
  if(isDefined(endon_flag) || isDefined(timeout)) {
    self thread rusher_go_back_to_normal(endon_flag, timeout);
  }
}
rusher_go_back_to_normal(endon_flag, timeout) {
  self endon("death");
  if(isDefined(timeout)) {
    self thread notifyTimeOut(timeout, false, "stop_rushing_timeout");
  }
  if(!isDefined(endon_flag)) {
    endon_flag = "nothing";
  }
  self waittill_any(endon_flag, "stop_rushing_timeout");
  self notify("stop_rushing");
  self rusher_reset();
}
rusher_reset() {
  self reset_rusher_anims();
  self.rusher = false;
  self.goalradius = self.oldgoalradius;
  self.pathenemyFightdist = self.oldpathenemyFightdist;
  self.moveplaybackrate = 1;
  self enable_react();
  self.ignoresuppression = false;
  self.disableExits = false;
  self.disableArrivals = false;
  self.rushing_goalent Delete();
}
change_to_wounded() {
  self endon("death");
  self endon("stop_rushing");
  self.isRusherWounded = false;
  woundedTrheshold = self.health - 100;
  while(1) {
    if(self.health > woundedTrheshold) {
      wait(0.05);
      continue;
    }
    self.alwaysRunForward = true;
    self.moveplaybackrate = 1;
    setup_rusher_wounded_anim();
    break;
  }
}
keep_rushing_player(player) {
  self endon("death");
  self endon("stop_rushing");
  while(1) {
    self SetGoalEntity(self.rushing_goalent);
    self thread notifyTimeOut(5, true, "timeout");
    self waittill_any("goal", "timeout");
  }
}
notifyTimeOut(timeout, endon_goal, notify_string) {
  self endon("death");
  self endon("stop_rushing");
  if(isDefined(endon_goal) && endon_goal) {
    self endon("goal");
  }
  wait(timeOut);
  self notify(notify_string);
}
rusher_yelling() {
  self endon("death");
  self endon("stop_rushing");
  if(isDefined(self.noRusherYell) && self.noRusherYell) {
    return;
  }
  while(1) {
    wait(RandomFloatRange(1, 3));
    self playSound("chr_npc_charge_viet");
  }
}
set_rusher_type() {
  if(self usingShotgun()) {
    self.rusherType = "shotgun";
    self.perfectAim = 1;
    self.noRusherYell = true;
    self.noWoundedRushing = true;
  } else if(self usingPistol()) {
    self.rusherType = "pistol";
    self.noRusherYell = true;
    self.noWoundedRushing = true;
    self.disableIdleStrafing = true;
    self.disableArrivals = true;
    self.disableExits = true;
    self.disableReact = true;
    self.disableTurns = true;
    self.leftGunModel = spawn("script_model", self.origin);
    self.leftGunModel setModel(GetWeaponModel(self.weapon));
    self.leftGunModel UseWeaponHideTags(self.weapon);
    self.leftGunModel LinkTo(self, "tag_weapon_left", (0, 0, 0), (0, 0, 0));
    self.rightGunModel = spawn("script_model", self.origin);
    self.rightGunModel setModel(GetWeaponModel(self.weapon));
    self.rightGunModel UseWeaponHideTags(self.weapon);
    self.rightGunModel LinkTo(self, "tag_weapon_right", (0, 0, 0), (0, 0, 0));
    self.rightGunModel Hide();
    self.secondGunHand = "left";
    self thread dualWeaponDropLogic();
    self thread fakeDualWieldShooting();
    self thread deleteFakeWeaponsOnDeath();
  } else {
    self.rusherType = "default";
    if(self.animType == "spetsnaz") {
      self.noRusherYell = true;
      self.noWoundedRushing = true;
    }
  }
}
fakeDualWieldShooting() {
  self endon("death");
  while(1) {
    self waittill("shoot");
    if(self.secondGunHand == "left") {
      self animscripts\shared::placeWeaponOn(self.weapon, "left");
      self.leftGunModel Hide();
      self.rightGunModel Show();
      self.secondGunHand = "right";
    } else {
      self animscripts\shared::placeWeaponOn(self.weapon, "right");
      self.leftGunModel Show();
      self.rightGunModel Hide();
      self.secondGunHand = "left";
    }
  }
}
deleteFakeWeaponsOnDeath() {
  self waittill("death");
  self.leftGunModel Delete();
  self.rightGunModel Delete();
}
dualWeaponDropLogic() {
  dualWeaponName = "";
  switch (self.weapon) {
    case "makarov_sp":
      dualWeaponName = "makarovdw_sp";
      break;
    case "cz75_sp":
      dualWeaponName = "cz75dw_sp";
      break;
    case "cz75_auto_sp":
      dualWeaponName = "cz75dw_auto_sp";
      break;
    case "python_sp":
      dualWeaponName = "pythondw_sp";
      break;
    case "m1911_sp":
      dualWeaponName = "m1911dw_sp";
      break;
  }
  if(IsAssetLoaded("weapon", dualWeaponName)) {
    self.script_dropweapon = dualWeaponName;
  }
}