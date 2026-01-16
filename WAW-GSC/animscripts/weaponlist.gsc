/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\weaponlist.gsc
*****************************************************/

#using_animtree("generic_human");

usingAutomaticWeapon() {
  if(weaponIsSemiAuto(self.weapon))
    return false;
  if(weaponIsBoltAction(self.weapon))
    return false;
  class = weaponClass(self.weapon);
  if(class == "rifle" || class == "mg" || class == "smg")
    return true;
  return false;
}

usingSemiAutoWeapon() {
  return (weaponIsSemiAuto(self.weapon));
}

usingShotgunWeapon() {
  return (weaponClass(self.weapon) == "spread");
}

autoShootAnimRate() {
  if(usingAutomaticWeapon()) {
    return 0.1 / weaponFireTime(self.weapon) * getdvarfloat("scr_ai_auto_fire_rate");
  } else {
    return 0.2;
  }
}

burstShootAnimRate() {
  if(usingAutomaticWeapon()) {
    return 0.16 / weaponFireTime(self.weapon);
  } else {
    return 0.2;
  }
}

waitAfterShot() {
  return 0.25;
}

shootAnimTime(semiAutoFire) {
  if(!usingAutomaticWeapon() || (isDefined(semiAutofire) && (semiAutofire == true))) {
    rand = 0.5 + randomfloat(1);
    return weaponFireTime(self.weapon) * rand;
  } else {
    return weaponFireTime(self.weapon);
  }
}

RefillClip() {
  assertEX(isDefined(self.weapon), "self.weapon is not defined for " + self.model);
  if(self.weapon == "none") {
    self.bulletsInClip = 0;
    return false;
  }
  if(weaponClass(self.weapon) == "rocketlauncher") {
    if(!self.a.rocketVisible)
      self thread animscripts\combat_utility::showRocketWhenReloadIsDone();
  }
  if(!isDefined(self.bulletsInClip)) {
    self.bulletsInClip = weaponClipSize(self.weapon);
  } else {
    self.bulletsInClip = weaponClipSize(self.weapon);
  }
  assertEX(isDefined(self.bulletsInClip), "RefillClip failed");
  if(self.bulletsInClip <= 0)
    return false;
  else
    return true;
}

precacheClipFx() {
  if(getdebugdvar("replay_debug") == "1")
    println("File: weaponList.gsc. Function: precacheClipFx()\n");
  clipEffects = [];
  clipEffects["weapon_m16_clip"] = "shellejects/clip_m16";
  clipEffects["weapon_ak47_clip"] = "shellejects/clip_ak47";
  clipEffects["weapon_saw_clip"] = "shellejects/clip_saw";
  clipEffects["weapon_mp5_clip"] = "shellejects/clip_mp5";
  clipEffects["weapon_dragunov_clip"] = "shellejects/clip_dragunov";
  clipEffects["weapon_g3_clip"] = "shellejects/clip_g3";
  clipEffects["weapon_g36_clip"] = "shellejects/clip_g36";
  clipEffects["weapon_m14_clip"] = "shellejects/clip_m14";
  clipEffects["weapon_ak74u_clip"] = "shellejects/clip_ak74u";
  if(getdvar("scr_generateClipModels") != "" && getdvar("scr_generateClipModels") != "0") {
    spawnedAITypes = [];
    level.weapons_list = [];
    spawners = getSpawnerArray();
    for (i = 0; i < spawners.size; i++) {
      spawner = spawners[i];
      if(isDefined(spawnedAITypes[spawner.classname]))
        continue;
      spawnedAITypes[spawner.classname] = true;
      oldCount = spawner.count;
      spawner.count = 1;
      fakeai = spawner stalingradSpawn();
      if(!isDefined(fakeai)) {
        spawner.count = oldCount;
        continue;
      }
      if(isDefined(fakeai.primaryWeapon))
        level.weapons_list[fakeai.primaryWeapon] = true;
      if(isDefined(fakeai.secondaryWeapon))
        level.weapons_list[fakeai.secondaryWeapon] = true;
      if(isDefined(fakeai.sidearm))
        level.weapons_list[fakeai.sidearm] = true;
      fakeai delete();
      spawner.count = oldCount;
    }
    ai = getAiArray();
    for (i = 0; i < ai.size; i++) {
      if(isDefined(ai[i].primaryWeapon))
        level.weapons_list[ai[i].primaryWeapon] = true;
      if(isDefined(ai[i].secondaryWeapon))
        level.weapons_list[ai[i].secondaryWeapon] = true;
      if(isDefined(ai[i].sidearm))
        level.weapons_list[ai[i].sidearm] = true;
    }
    weapons = getarraykeys(level.weapons_list);
    println("The following is a list of weapons in the level: ");
    for (i = 0; i < weapons.size; i++) {
      println(weapons[i]);
    }
    println("\n\n^1Put the following array definition before your call to maps\_load::main():");
    println("\n\n^1level.weaponClipModels = [];");
    printIndex = 0;
    printedModel = [];
    for (i = 0; i < weapons.size; i++) {
      weapon = weapons[i];
      model = getWeaponClipModel(weapon);
      if(model == "")
        continue;
      if(isDefined(printedModel[model]))
        continue;
      printedModel[model] = true;
      println("^1level.weaponClipModels[" + printIndex + "] = \"" + model + "\";");
      printIndex++;
    }
    println("\n\n^1Put the following in your fastfile:\n");
    printIndex = 0;
    printedModel = [];
    for (i = 0; i < weapons.size; i++) {
      weapon = weapons[i];
      model = getWeaponClipModel(weapon);
      if(model == "")
        continue;
      if(isDefined(printedModel[model]))
        continue;
      printedModel[model] = true;
      println("^1fx," + clipEffects[model]);
      printIndex++;
    }
    println("\n\n");
    missionFailed();
    return;
  }
  setdvar("scr_generateClipModels", 0);
  if(!isDefined(anim._effect))
    anim._effect = [];
  if(isDefined(level.weaponClipModels)) {
    for (i = 0; i < level.weaponClipModels.size; i++) {
      model = level.weaponClipModels[i];
      assert(isDefined(model));
      assert(isDefined(clipEffects[model]));
      precacheModel(model);
      anim._effect[model] = loadfx(clipEffects[model]);
    }
    level.weaponClipModels = undefined;
    level.weaponClipModelsLoaded = true;
  } else {}
  if(getdebugdvar("replay_debug") == "1")
    println("File: weaponList.gsc. Function: precacheClipFx() - COMPLETE\n");
}

bugLDAboutClipModels() {
  waittillframeend;
  if(isDefined(level.testmap)) {
    return;
  }
  waittime = 1;
  while (1) {
    println("^1No weaponClipModels in this map!");
    println("^1Set dvar scr_generateClipModels to 1 and map_restart, then follow instructions in console.");
    waittime += 1;
    wait waittime;
  }
}

add_weapon(name, type, time, clipsize, anims) {
  assert(isDefined(name));
  assert(isDefined(type));
  if(!isDefined(time))
    time = 3.0;
  if(!isDefined(clipsize))
    time = 1;
  if(!isDefined(anims))
    anims = "rifle";
  name = tolower(name);
  anim.AIWeapon[name]["type"] = type;
  anim.AIWeapon[name]["time"] = time;
  anim.AIWeapon[name]["clipsize"] = clipsize;
  anim.AIWeapon[name]["anims"] = anims;
}
addTurret(turret) {
  anim.AIWeapon[tolower(turret)]["type"] = "turret";
}