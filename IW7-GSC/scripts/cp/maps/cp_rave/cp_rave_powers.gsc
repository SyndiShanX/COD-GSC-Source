/******************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_rave\cp_rave_powers.gsc
******************************************************/

init() {
  scripts\cp\powers\coop_powers::powersetupfunctions("power_transponder", ::scripts\cp\powers\coop_powers::settransponder, ::scripts\cp\powers\coop_powers::unsettransponder, undefined, "transponder_update", "powers_transponder_used", undefined);
  scripts\cp\powers\coop_powers::powersetupfunctions("power_armageddon", undefined, undefined, ::scripts\cp\powers\coop_powers::usearmageddon, undefined, undefined, undefined);
  scripts\cp\powers\coop_powers::powersetupfunctions("power_microTurret", undefined, undefined, undefined, "microTurret_update", "powers_microTurret_used", undefined);
  scripts\cp\powers\coop_powers::powersetupfunctions("power_rewind", ::scripts\cp\powers\coop_powers::setrewind, ::scripts\cp\powers\coop_powers::unsetrewind, ::scripts\cp\powers\coop_powers::userewind, undefined, "powers_rewind_used", undefined);
  scripts\cp\powers\coop_powers::powersetupfunctions("power_repulsor", undefined, undefined, ::scripts\cp\powers\coop_powers::userepulsor, undefined, undefined, undefined);
  scripts\cp\powers\coop_powers::powersetupfunctions("power_blackholeGrenade", undefined, undefined, undefined, undefined, "powers_blackholeGrenade_used", undefined);
  scripts\cp\powers\coop_powers::powersetupfunctions("power_tripMine", undefined, undefined, undefined, "trip_mine_update", undefined, undefined);
  scripts\cp\powers\coop_powers::powersetupfunctions("power_portalGenerator", undefined, undefined, undefined, undefined, "powers_portalGenerator_used", undefined);
  scripts\cp\powers\coop_powers::powersetupfunctions("power_c4", undefined, undefined, undefined, "c4_update", undefined, undefined);
  scripts\cp\powers\coop_powers::powersetupfunctions("power_bait", ::setbait, ::unsetbait, undefined, undefined, undefined, undefined);
  thread scripts\cp\powers\coop_repulsor::init();
  thread scripts\cp\powers\coop_transponder::init();
  thread scripts\cp\powers\coop_microturret::init();
  thread scripts\cp\powers\coop_trip_mine::tripmine_init();
  thread scripts\cp\powers\coop_blackholegrenade::blackholegrenadeinit();
}

listen_for_bait_throw() {
  self endon("disconnect");
  self endon("stop_bait_listen");
  for(;;) {
    self waittill("grenade_fire", var_00, var_01);
    if(isDefined(var_00) && isDefined(var_01)) {
      var_00 thread wait_for_impact(var_01, self);
    }
  }
}

wait_for_impact(param_00, param_01) {
  self endon("disconnect");
  self endon("stop_bait_listen");
  if(!isDefined(self.weapon_name) || self.weapon_name != "iw7_bait_zm") {
    return;
  }

  self waittill("explode", var_02);
  var_03 = getEntArray("bait_head", "targetname");
  var_04 = scripts\engine\utility::getclosest(var_02, var_03, 500);
  if(isDefined(var_04)) {
    if(isDefined(var_04.bait)) {
      var_04.bait delete();
    }

    var_04.bait = spawn("script_origin", var_02);
    var_04.bait_time = gettime();
  }
}

setbait(param_00) {
  self notify("stop_bait_listen");
  thread listen_for_bait_throw();
}

unsetbait() {
  self notify("stop_bait_listen");
}