/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 4153.gsc
**************************************/

main() {
  if(!getdvarint("r_reflectionProbeGenerate")) {
    scripts\sp\maps\ja_mining\gen\ja_mining_fx::main();
    scripts\sp\maps\ja_mining\gen\ja_mining_sound::main();
  }

  level._effect["sun_sprite"] = loadfx("vfx/iw7/levels/ja_assault/vfx_ja_sun.vfx");
  level._effect["vfx_space_debris_field_embers"] = loadfx("vfx/iw7/levels/ja_assault/vfx_space_debris_field_particulate_embers_01.vfx");
  level._effect["vfx_ja_space_asteroid_debris"] = loadfx("vfx/iw7/levels/ja_assault/vfx_ja_space_asteroid_debris_01.vfx");
  level._effect["vfx_ja_deathfire"] = loadfx("vfx/iw7/levels/ja_assault/vfx_jackal_sunexposure.vfx");
}