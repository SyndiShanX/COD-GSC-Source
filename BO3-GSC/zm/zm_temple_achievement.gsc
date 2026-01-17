/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_temple_achievement.gsc
*************************************************/

#using scripts\shared\callbacks_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm;
#using scripts\zm\_zm_utility;
#namespace zm_temple_achievement;

function autoexec __init__sytem__() {
  system::register("zm_temple_achievement", &__init__, undefined, undefined);
}

function __init__() {
  level thread achievement_temple_sidequest();
  callback::on_connect(&onplayerconnect);
}

function onplayerconnect() {
  self thread achievement_small_consolation();
}

function achievement_temple_sidequest() {
  level waittill("temple_sidequest_achieved");
  level thread zm::set_sidequest_completed("EOA");
  level zm_utility::giveachievement_wrapper("DLC4_ZOM_TEMPLE_SIDEQUEST", 1);
}

function achievement_zomb_disposal() {
  level endon("end_game");
  level waittill("zomb_disposal_achieved");
}

function achievement_monkey_see_monkey_dont() {
  level waittill("monkey_see_monkey_dont_achieved");
}

function achievement_blinded_by_the_fright() {
  level endon("end_game");
  self endon("disconnect");
  self waittill("blinded_by_the_fright_achieved");
}

function achievement_small_consolation() {
  level endon("end_game");
  self endon("disconnect");
  while(true) {
    self waittill("weapon_fired");
    currentweapon = self getcurrentweapon();
    if(currentweapon.name != "shrink_ray" && currentweapon.name != "shrink_ray_upgraded") {
      continue;
    }
    waittillframeend();
    if(isDefined(self.shrinked_zombies) && (isDefined(self.shrinked_zombies["zombie"]) && self.shrinked_zombies["zombie"]) && (isDefined(self.shrinked_zombies["sonic_zombie"]) && self.shrinked_zombies["sonic_zombie"]) && (isDefined(self.shrinked_zombies["napalm_zombie"]) && self.shrinked_zombies["napalm_zombie"]) && (isDefined(self.shrinked_zombies["monkey_zombie"]) && self.shrinked_zombies["monkey_zombie"])) {
      break;
    }
  }
  self zm_utility::giveachievement_wrapper("DLC4_ZOM_SMALL_CONSOLATION");
}