/**********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\cp\rave_interaction_fx.gsc
**********************************************/

main() {
  level._effect["debris_buy"] = loadfx("vfx\iw7\core\zombie\vfx_zmb_gatebuy_01.vfx");
  level._effect["laser_window_trap"] = loadfx("vfx\iw7\_requests\coop\zmb_laser_window.vfx");
  level._effect["zombie_freeze_shatter"] = loadfx("vfx\iw7\core\zombie\zombie_ice_chunks.vfx");
  level._effect["zombie_freeze_impact"] = loadfx("vfx\iw7\core\zombie\zombie_freeze.vfx");
  level._effect["magicwheel_light"] = loadfx("vfx\iw7\_requests\coop\vfx_magicwheel_light.vfx");
  level._effect["souvenir_pickup"] = loadfx("vfx\iw7\core\zombie\vfx_zom_souvenir_pickup.vfx");
  level._effect["crafting_gem_pickup"] = loadfx("vfx\iw7\core\zombie\crafting\vfx_gem_pickup_main.vfx");
  level._effect["crafting_souvenir"] = loadfx("vfx\iw7\_requests\coop\zmb_souvenir_craft.vfx");
  level._effect["souvenir_glow"] = loadfx("vfx\iw7\_requests\coop\zmb_souvenir_glow.vfx");
}