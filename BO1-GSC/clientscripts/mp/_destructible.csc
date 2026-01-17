/**********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\mp\_destructible.csc
**********************************************/

#include clientscripts\mp\_utility;
#using_animtree("mp_vehicles");
init() {
  level._client_flag_callbacks["scriptmover"][level.const_flag_destructible_car] = ::destructible_car_animate;
}
destructible_car_animate(localClientNum, set) {
  if(!set) {
    return;
  }
  player = GetLocalPlayer(localClientNum);
  if(!isDefined(player)) {
    return;
  }
  if(player GetInKillcam(localClientNum)) {
    return;
  }
  self UseAnimTree(#animtree);
  self SetAnim( % veh_car_destroy, 1.0, 0.0, 1.0);
}
#using_animtree("fxanim_props");
destructible_init(localClientNum) {
  destructibles = getEntArray(localClientNum, "destructible", "targetname");
  if(!isDefined(destructibles)) {
    return;
  }
  for(i = 0; i < destructibles.size; i++) {
    if(destructibles[i].destructibledef == "fxanim_gp_ceiling_fan_modern_mod_MP" ||
      destructibles[i].destructibledef == "fxanim_gp_ceiling_fan_old_mod_MP") {
      destructibles[i] thread destructible_ceiling_fan_think(localClientNum);
    }
  }
}
destructible_ceiling_fan_think(localClientNum) {
  self waittill_dobj(localClientNum);
  speed = RandomFloatRange(0.5, 1);
  self UseAnimTree(#animtree);
  self SetAnim( % fxanim_gp_ceiling_fan_old_slow_anim, 1.0, 0.0, speed);
  for(;;) {
    self waittill("broken", event);
    if(event == "stop_idle") {
      self ClearAnim( % fxanim_gp_ceiling_fan_old_slow_anim, 0.0);
      self SetAnim( % fxanim_gp_ceiling_fan_old_dest_anim, 1.0, 0.0, speed);
      return;
    }
  }
}