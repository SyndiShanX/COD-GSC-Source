/************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\vehicles\player_tank.csc
************************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\vehicle_shared;
#namespace player_tank;

function private autoexec __init__system__() {
  system::register(#"player_tank", &preinit, undefined, undefined, #"player_vehicle");
}

function private preinit(localclientnum) {
  vehicle::add_vehicletype_callback("player_tank", &function_c0f1d81b);
  clientfield::register("scriptmover", "tank_deathfx", 1, 1, "int", &function_de69d, 0, 0);
  clientfield::register("vehicle", "tank_shellejectfx", 1, 1, "int", &function_5c44d585, 0, 0);
}

function private function_c0f1d81b(localclientnum) {}

function private function_de69d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump) {
    self util::playFXOnTag(fieldname, "vehicle/fx9_vdest_mil_ru_tank_t72_death_turret", self, "tag_turret_animate");
  }
}

function private function_5c44d585(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump) {
    self util::playFXOnTag(fieldname, "vehicle/fx9_mil_tank_ru_t72_shell_eject", self, "tag_fx_shell_eject");
  }
}