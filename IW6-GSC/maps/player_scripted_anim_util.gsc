/**********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\player_scripted_anim_util.gsc
**********************************************/

waittill_trigger_activate_looking_at(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_0 endon("valid_trigger");
  var_6 = 1;

  if(!isDefined(var_2))
    var_2 = 0.8;

  if(isDefined(var_3) && var_3)
    var_6 = undefined;

  var_7 = isDefined(var_4) && var_4;
  var_0 thread _trigger_handle_triggering(var_7);

  for(;;) {
    if(isDefined(var_0.force_off) && var_0.force_off)
      var_0 common_scripts\utility::trigger_off();
    else if(level.player getstance() == "prone")
      var_0 common_scripts\utility::trigger_off();
    else if(level.player player_looking_at_relative(var_1.origin, var_2, var_6, level.player, var_5))
      var_0 common_scripts\utility::trigger_on();
    else
      var_0 common_scripts\utility::trigger_off();

    wait 0.1;
  }
}

_trigger_handle_triggering(var_0) {
  self endon("death");

  for(;;) {
    self waittill("trigger");
    var_1 = !level.player ismeleeing();
    var_2 = !level.player issprintsliding();
    var_3 = level.player isonground() || level.player islinked();
    var_4 = !isDefined(self.force_off) || !self.force_off;
    var_5 = level.player getstance() != "prone";
    var_6 = !level.player isthrowinggrenade();

    if(var_4 && var_1 && var_2 && var_3 && var_5 && var_6) {
      break;
    }
  }

  self notify("valid_trigger");

  if(var_0)
    self delete();
  else
    common_scripts\utility::trigger_off();
}

player_looking_at_relative(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_1))
    var_1 = 0.8;

  var_5 = maps\_utility::get_player_from_self();
  var_6 = var_5 getEye();
  var_7 = vectortoangles(var_0 - var_6);
  var_8 = anglesToForward(var_7);
  var_9 = var_5 getplayerangles();

  if(isDefined(var_4))
    var_9 = combineangles(var_4.angles, var_9);

  var_10 = anglesToForward(var_9);
  var_11 = vectordot(var_8, var_10);

  if(var_11 < var_1)
    return 0;

  if(isDefined(var_2))
    return 1;

  var_12 = bulletTrace(var_0, var_6, 0, var_3);
  return var_12["fraction"] == 1;
}