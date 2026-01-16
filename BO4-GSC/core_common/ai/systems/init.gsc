/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\ai\systems\init.gsc
***********************************************/

#include scripts\core_common\ai\archetype_utility;
#include scripts\core_common\ai\systems\shared;
#include scripts\core_common\name_shared;

#namespace init;

initweapon(weapon) {
  self.weaponinfo[weapon.name] = spawnStruct();
  self.weaponinfo[weapon.name].position = "none";
  self.weaponinfo[weapon.name].hasclip = 1;

  if(isDefined(weapon.clipmodel)) {
    self.weaponinfo[weapon.name].useclip = 1;
    return;
  }

  self.weaponinfo[weapon.name].useclip = 0;
}

main() {
  self.a = spawnStruct();
  self.a.weaponpos = [];

  if(self.weapon == level.weaponnone) {
    self aiutility::setcurrentweapon(level.weaponnone);
  }

  self aiutility::setprimaryweapon(self.weapon);

  if(self.secondaryweapon == level.weaponnone) {
    self aiutility::setsecondaryweapon(level.weaponnone);
  }

  self aiutility::setsecondaryweapon(self.secondaryweapon);
  self aiutility::setcurrentweapon(self.primaryweapon);
  self.initial_primaryweapon = self.primaryweapon;
  self.initial_secondaryweapon = self.secondaryweapon;
  self initweapon(self.primaryweapon);
  self initweapon(self.secondaryweapon);
  self initweapon(self.sidearm);
  self.weapon_positions = array("left", "right", "chest", "back");

  for(i = 0; i < self.weapon_positions.size; i++) {
    self.a.weaponpos[self.weapon_positions[i]] = level.weaponnone;
  }

  self.lastweapon = self.weapon;
  firstinit();
  self.a.rockets = 3;
  self.a.rocketvisible = 1;
  self.a.pose = "stand";
  self.a.prevpose = self.a.pose;
  self.a.movement = "stop";
  self.a.special = "none";
  self.a.gunhand = "none";
  shared::placeweaponon(self.primaryweapon, "right");

  if(isDefined(self.secondaryweaponclass) && self.secondaryweaponclass != "none" && self.secondaryweaponclass != "pistol") {
    shared::placeweaponon(self.secondaryweapon, "back");
  }

  self.a.combatendtime = gettime();
  self.a.nextgrenadetrytime = 0;
  self.a.isaiming = 0;
  self.rightaimlimit = 45;
  self.leftaimlimit = -45;
  self.upaimlimit = 45;
  self.downaimlimit = -45;
  self.walk = 0;
  self.sprint = 0;
  self.a.postscriptfunc = undefined;
  self.baseaccuracy = self.accuracy;

  if(!isDefined(self.script_accuracy)) {
    self.script_accuracy = 1;
  }

  self.a.misstime = 0;
  self.ai.bulletsinclip = self.weapon.clipsize;
  self.lastenemysighttime = 0;
  self.combattime = 0;
  self.suppressed = 0;
  self.suppressedtime = 0;
  self.suppressionthreshold = 0.75;
  self.randomgrenaderange = 128;
  self.reacquire_state = 0;
}

setnameandrank() {
  self endon(#"death");
  self name::get();
}

donothing() {}

set_anim_playback_rate() {
  self.animplaybackrate = 0.9 + randomfloat(0.2);
  self.moveplaybackrate = 1;
}

trackvelocity() {
  self endon(#"death");

  for(;;) {
    self.oldorigin = self.origin;
    wait 0.2;
  }
}

checkapproachangles(transtypes) {
  idealtransangles[1] = 45;
  idealtransangles[2] = 0;
  idealtransangles[3] = -45;
  idealtransangles[4] = 90;
  idealtransangles[6] = -90;
  idealtransangles[7] = 135;
  idealtransangles[8] = 180;
  idealtransangles[9] = -135;
  waitframe(1);

  for(i = 1; i <= 9; i++) {
    for(j = 0; j < transtypes.size; j++) {
      trans = transtypes[j];
      idealadd = 0;

      if(trans == "<dev string:x38>" || trans == "<dev string:x3f>") {
        idealadd = 90;
      } else if(trans == "<dev string:x4d>" || trans == "<dev string:x55>") {
        idealadd = -90;
      }

      if(isDefined(anim.covertransangles[trans][i])) {
        correctangle = angleclamp180(idealtransangles[i] + idealadd);
        actualangle = angleclamp180(anim.covertransangles[trans][i]);

        if(absangleclamp180(actualangle - correctangle) > 7) {
          println("<dev string:x64>" + trans + "<dev string:xa6>" + i + "<dev string:xac>" + actualangle + "<dev string:xb7>" + correctangle + "<dev string:xd4>");
        }
      }
    }
  }

  for(i = 1; i <= 9; i++) {
    for(j = 0; j < transtypes.size; j++) {
      trans = transtypes[j];
      idealadd = 0;

      if(trans == "<dev string:x38>" || trans == "<dev string:x3f>") {
        idealadd = 90;
      } else if(trans == "<dev string:x4d>" || trans == "<dev string:x55>") {
        idealadd = -90;
      }

      if(isDefined(anim.coverexitangles[trans][i])) {
        correctangle = angleclamp180(-1 * (idealtransangles[i] + idealadd + 180));
        actualangle = angleclamp180(anim.coverexitangles[trans][i]);

        if(absangleclamp180(actualangle - correctangle) > 7) {
          println("<dev string:xda>" + trans + "<dev string:xa6>" + i + "<dev string:xac>" + actualangle + "<dev string:xb7>" + correctangle + "<dev string:xd4>");
        }
      }
    }
  }
}

getexitsplittime(approachtype, dir) {
  return anim.coverexitsplit[approachtype][dir];
}

gettranssplittime(approachtype, dir) {
  return anim.covertranssplit[approachtype][dir];
}

firstinit() {
  if(isDefined(anim.notfirsttime)) {
    return;
  }

  anim.notfirsttime = 1;
  anim.grenadetimers[#"player_frag_grenade_sp"] = randomintrange(1000, 20000);
  anim.grenadetimers[#"player_flash_grenade_sp"] = randomintrange(1000, 20000);
  anim.grenadetimers[#"player_double_grenade"] = randomintrange(10000, 60000);
  anim.grenadetimers[#"ai_frag_grenade_sp"] = randomintrange(0, 20000);
  anim.grenadetimers[#"ai_flash_grenade_sp"] = randomintrange(0, 20000);
  anim.numgrenadesinprogresstowardsplayer = 0;
  anim.lastgrenadelandednearplayertime = -1000000;
  anim.lastfraggrenadetoplayerstart = -1000000;
  thread setnextplayergrenadetime();

  if(!isDefined(level.flag)) {
    level.flag = [];
  }

  level.painai = undefined;
  anim.covercrouchleanpitch = -55;
}

onplayerconnect() {
  player = self;
  firstinit();
  player.invul = 0;
}

setnextplayergrenadetime() {
  waittillframeend();

  if(isDefined(anim.playergrenaderangetime)) {
    maxtime = int(anim.playergrenaderangetime * 0.7);

    if(maxtime < 1) {
      maxtime = 1;
    }

    anim.grenadetimers[#"player_frag_grenade_sp"] = randomintrange(0, maxtime);
    anim.grenadetimers[#"player_flash_grenade_sp"] = randomintrange(0, maxtime);
  }

  if(isDefined(anim.playerdoublegrenadetime)) {
    maxtime = int(anim.playerdoublegrenadetime);
    mintime = int(maxtime / 2);

    if(maxtime <= mintime) {
      maxtime = mintime + 1;
    }

    anim.grenadetimers[#"player_double_grenade"] = randomintrange(mintime, maxtime);
  }
}

addtomissiles(grenade) {
  if(!isDefined(level.missileentities)) {
    level.missileentities = [];
  }

  if(!isDefined(level.missileentities)) {
    level.missileentities = [];
  } else if(!isarray(level.missileentities)) {
    level.missileentities = array(level.missileentities);
  }

  level.missileentities[level.missileentities.size] = grenade;

  while(isDefined(grenade)) {
    waitframe(1);
  }

  arrayremovevalue(level.missileentities, grenade);
}

event_handler[grenade_fire] function_960adbea(eventstruct) {
  grenade = eventstruct.projectile;
  weapon = eventstruct.weapon;

  if(isDefined(grenade)) {
    grenade.owner = self;
    grenade.weapon = weapon;
    level thread addtomissiles(grenade);
  }
}

event_handler[grenade_launcher_fire] function_c6ddaa47(eventstruct) {
  eventstruct.projectile.owner = self;
  eventstruct.projectile.weapon = eventstruct.weapon;
  level thread addtomissiles(eventstruct.projectile);
}

event_handler[missile_fire] function_596d3a28(eventstruct) {
  eventstruct.projectile.owner = self;
  eventstruct.projectile.weapon = eventstruct.weapon;
  level thread addtomissiles(eventstruct.projectile);
}

end_script() {}