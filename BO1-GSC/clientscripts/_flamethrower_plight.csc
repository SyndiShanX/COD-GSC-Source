/**************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\_flamethrower_plight\.csc
**************************************************/

init() {
  level._effect["ft_pilot_light"] = LoadFX("weapon/muzzleflashes/fx_pilot_light");
}
play_pilot_light_fx(localClientNum) {
  self notify("new_pilot_light");
  self endon("new_pilot_light");
  self endon("entityshutdown");
  if(!isDefined(level._ft_pilot_on) || !isDefined(level._ft_pilot_on[localClientNum])) {
    level._ft_pilot_on[localClientNum] = false;
  }
  while(true) {
    new_weapon = GetCurrentWeapon(localClientNum);
    if(GetSubStr(new_weapon, 0, 3) == "ft_" && !level._ft_pilot_on[localClientNum]) {
      AssertEx(isDefined(level._effect["ft_pilot_light"]), "Need to call 'clientscripts\_flamethrower_plight::init();' in you client script.");
      level._ft_pilot_light = PlayViewmodelFx(localClientNum, level._effect["ft_pilot_light"], "tag_flamer_pilot_light");
      level._ft_pilot_on[localClientNum] = true;
    } else if(GetSubStr(new_weapon, 0, 3) != "ft_" && level._ft_pilot_on[localClientNum]) {
      DeleteFX(localClientNum, level._ft_pilot_light);
      level._ft_pilot_on[localClientNum] = false;
    }
    wait 0.5;
  }
}