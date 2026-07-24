/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 4151.gsc
**************************************/

main() {
  if(!getdvarint("r_reflectionProbeGenerate")) {
    scripts\sp\maps\ja_asteroid\gen\ja_asteroid_fx::main();
    scripts\sp\maps\ja_asteroid\gen\ja_asteroid_sound::main();
  }

  level._effect["vfx_space_debris_field_ice"] = loadfx("vfx/iw7/levels/ja_assault/vfx_space_debris_field_particulate_ice_01.vfx");
  level._effect["vfx_ja_space_asteroid_debris"] = loadfx("vfx/iw7/levels/ja_assault/vfx_ja_space_asteroid_debris_01.vfx");
  level._effect["vfx_ja_space_gas_cloud_01"] = loadfx("vfx/iw7/levels/ja_assault/vfx_ja_space_gas_cloud_02.vfx");
  level._effect["vfx_space_debris_field_debris_sml"] = loadfx("vfx/iw7/levels/ja_assault/vfx_space_debris_field_particulate_debris_sml_01.vfx");
  level._effect["vfx_ja_space_gas_cloud_03"] = loadfx("vfx/iw7/levels/ja_assault/vfx_ja_space_gas_cloud_03.vfx");
}