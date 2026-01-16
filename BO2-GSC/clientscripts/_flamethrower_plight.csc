/**************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\_flamethrower_plight.csc
**************************************************/

init() {
  level._effect["ft_pilot_light"] = loadfx("weapon/muzzleflashes/fx_pilot_light");
}

play_pilot_light_fx(localclientnum) {
  self notify("new_pilot_light");
  self endon("new_pilot_light");
  self endon("entityshutdown");

  if(!isDefined(level._ft_pilot_on) || !isDefined(level._ft_pilot_on[localclientnum]))
    level._ft_pilot_on[localclientnum] = 0;

  while(true) {
    new_weapon = getcurrentweapon(localclientnum);

    if(getsubstr(new_weapon, 0, 3) == "ft_" && !level._ft_pilot_on[localclientnum]) {
      assert(isDefined(level._effect["ft_pilot_light"]), "Need to call 'clientscripts_flamethrower_plight::init();' in you client script.");
      level._ft_pilot_light = playviewmodelfx(localclientnum, level._effect["ft_pilot_light"], "tag_flamer_pilot_light");
      level._ft_pilot_on[localclientnum] = 1;
    } else if(getsubstr(new_weapon, 0, 3) != "ft_" && level._ft_pilot_on[localclientnum]) {
      deletefx(localclientnum, level._ft_pilot_light);
      level._ft_pilot_on[localclientnum] = 0;
    }

    wait 0.5;
  }
}