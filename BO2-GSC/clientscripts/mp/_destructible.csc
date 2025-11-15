/**********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\mp\_destructible.csc
**********************************************/

#include clientscripts\mp\_utility;

init() {
  level._client_flag_callbacks["scriptmover"][12] = ::destructible_car_animate;
}

#using_animtree("mp_vehicles");

destructible_car_animate(localclientnum, set) {
  if(!set) {
    return;
  }
  player = getlocalplayer(localclientnum);

  if(!isDefined(player)) {
    return;
  }
  if(player getinkillcam(localclientnum)) {
    return;
  }
  self useanimtree(#animtree);
  self setanim( % veh_car_destroy, 1.0, 0.0, 1.0);
}