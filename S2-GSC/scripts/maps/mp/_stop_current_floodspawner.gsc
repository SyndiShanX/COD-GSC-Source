/**********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\_stop_current_floodspawner.gsc
**********************************************************/

_id_9DB1(var_0, var_1) {
  var_0 endon("death");
  var_0 waittill("trigger", var_2);
  var_0 common_scripts\utility::script_delay();
  maps\mp\_utility::_id_0FA8(var_0.target);

  if(isDefined(var_1))
    common_scripts\utility::flag_set(var_1, var_2);
}

_id_9D7C(var_0) {
  var_0 endon("death");
  var_0 waittill("trigger");
  var_0 common_scripts\utility::script_delay();
  var_1 = getEntArray(var_0.target, "targetname");
  common_scripts\utility::_id_0FB2(var_1, ::_id_3D85);
}

_id_3D85() {
  self endon("death");
  self notify("stop_current_floodspawner");
  self endon("stop_current_floodspawner");

  if(!isDefined(self._id_005C) || self._id_005C <= 0) {
    return;
  }
  while(self._id_005C > 0) {
    [var_1] = maps\mp\_utility::_id_0FA7([self]);

    if(!isDefined(var_1)) {
      wait 2;
      continue;
    }

    var_1 waittill("death", var_2);

    if(!common_scripts\utility::setautorotationdelay())
      wait(_randomfloatrange(5, 9));
  }
}