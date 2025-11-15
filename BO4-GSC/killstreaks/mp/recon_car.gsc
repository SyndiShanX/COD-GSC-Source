/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: killstreaks\mp\recon_car.gsc
***********************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\scoreevents_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\core_common\vehicle_shared;
#include scripts\killstreaks\killstreak_detect;
#include scripts\killstreaks\killstreaks_shared;
#include scripts\killstreaks\mp\killstreak_vehicle;
#include scripts\killstreaks\remote_weapons;
#include scripts\mp_common\player\player_utils;

#namespace recon_car;

autoexec __init__system__() {
  system::register(#"recon_car", &__init__, undefined, #"killstreaks");
}

__init__() {
  killstreak_detect::init_shared();
  remote_weapons::init_shared();
  killstreaks::function_b5b6ef3e(&init_killstreak);
}

init_killstreak() {
  bundle = struct::get_script_bundle("killstreak", sessionmodeiswarzonegame() ? "killstreak_recon_car_wz" : "killstreak_recon_car");
  killstreak_vehicle::init_killstreak(bundle);
  killstreaks::register_alt_weapon("recon_car", getweapon(#"hash_38ffd09564931482"));
  callback::on_connect(&onplayerconnect);
  vehicle::add_main_callback("vehicle_t8_drone_recon", &function_d1661ada);
}

onplayerconnect() {
  self.entnum = self getentitynumber();
}

function_d1661ada() {
  self killstreak_vehicle::init_vehicle();
  self util::make_sentient();
  self.var_7d4f75e = 1;
  self.ignore_death_jolt = 1;
  self.var_92043a49 = 1;
  self disabledriverfiring(1);
}