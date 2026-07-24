/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 4155.gsc
**************************************/

main() {
  if(!getdvarint("r_reflectionProbeGenerate")) {
    scripts\sp\maps\ja_spacestation\gen\ja_spacestation_fx::main();
    scripts\sp\maps\ja_spacestation\gen\ja_spacestation_sound::main();
  }

  level._effect["vfx_space_debris_field_debris_sml"] = loadfx("vfx/iw7/levels/ja_assault/vfx_space_debris_field_particulate_debris_sml_01.vfx");
  level._effect["vfx_ja_space_gas_cloud"] = loadfx("vfx/iw7/levels/ja_assault/vfx_ja_space_gas_cloud_01.vfx");
  level._effect["vfx_space_debris_field_01"] = loadfx("vfx/iw7/levels/ja_assault/vfx_space_debris_field_particulate_generic_01.vfx");
}