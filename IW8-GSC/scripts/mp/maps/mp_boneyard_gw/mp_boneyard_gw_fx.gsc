/****************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_boneyard_gw\mp_boneyard_gw_fx.gsc
****************************************************************/

function main() {
  level._effect["gas_realfar"] = loadfx("vfx/iw8_br/gameplay/circle/vfx_br_circle_gas_port_realfar.vfx");
  level._effect["gas_far"] = loadfx("vfx/iw8_br/gameplay/circle/vfx_br_circle_gas_port_far.vfx");
  level._effect["gas_medium"] = loadfx("vfx/iw8_br/gameplay/circle/vfx_br_circle_gas_port_medium.vfx");
  level._effect["gas_close"] = loadfx("vfx/iw8_br/gameplay/circle/vfx_br_circle_gas_port_close.vfx");
}