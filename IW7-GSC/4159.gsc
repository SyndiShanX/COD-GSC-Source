/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 4159.gsc
**************************************/

main() {
  if(!getdvarint("r_reflectionProbeGenerate")) {
    scripts\sp\maps\ja_wreckage\gen\ja_wreckage_fx::main();
    scripts\sp\maps\ja_wreckage\gen\ja_wreckage_sound::main();
  }

  level._effect["vfx_space_debris_field_01"] = loadfx("vfx/iw7/levels/ja_assault/vfx_space_debris_field_particulate_generic_01.vfx");
  level._effect["vfx_space_debris_field_debris_sml"] = loadfx("vfx/iw7/levels/ja_assault/vfx_space_debris_field_particulate_debris_sml_01.vfx");
  level._effect["vfx_ja_space_gas_cloud_02"] = loadfx("vfx/iw7/levels/ja_assault/vfx_ja_space_gas_cloud_02.vfx");
  level._effect["vfx_sunflare_wreckage"] = loadfx("vfx/iw7/levels/ja_assault/vfx_wreckage_sunfx.vfx");
  level._effect["vfx_ja_space_gas_cloud_04"] = loadfx("vfx/iw7/levels/ja_assault/vfx_ja_space_gas_cloud_04.vfx");
  level._effect["vfx_jaw_camcentr_space_dust"] = loadfx("vfx/iw7/levels/ja_wreckage/vfx_jaw_camcentr_space_dust.vfx");
}