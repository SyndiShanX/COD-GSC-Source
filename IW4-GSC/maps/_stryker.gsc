/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: maps\_stryker.gsc
********************************************************/

#include maps\_vehicle_aianim;
#include maps\_vehicle;
#include maps\_utility;
#include common_scripts\utility;
#using_animtree("vehicles");
main(model, type, no_destroyed) {
  build_template("stryker", model, type);
  build_localinit(::init_local);

  if(!isDefined(no_destroyed)) {
    build_deathmodel("vehicle_stryker", "vehicle_stryker_destroyed");
    build_deathfx("explosions/large_vehicle_explosion", undefined, "exp_armor_vehicle");
  }

  build_drive(%stryker_movement, %stryker_movement_backwards, 10);
  build_treadfx();
  build_life(999, 500, 1500);
  build_team("allies");
  build_mainturret();
  build_compassicon("tank");
  build_frontarmor(.33);

  level._effect["stryker_shell"] = loadfx("shellejects/stryker_shell");
}

init_local() {
  thread additional_firing_anims();
}

additional_firing_anims() {
  self endon("death");

  anims = [];
  anims["fire"] = % stryker_cannon_fire;
  anims["hatch"] = % stryker_shell_hatch;

  fx = getfx("stryker_shell");

  for(;;) {
    self waittill("weapon_fired");
    foreach(animation in anims) {
      self SetAnimRestart(animation, 1, 0, 1);
    }

    playFXOnTag(fx, self, "tag_ammo_fx");
  }
}

set_vehicle_anims(positions) {
  return positions;
}

#using_animtree("generic_human");

setanims() {
  positions = [];
  for(i = 0; i < 11; i++) {
    positions[i] = spawnStruct();
  }

  positions[0].getout_delete = true;
  return positions;
}