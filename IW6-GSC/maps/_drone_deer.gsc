/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_drone_deer.gsc
*****************************************************/

#using_animtree("animals");

init() {
  level.drone_anims["team3"]["stand"]["idle"] = % deer_idle_iw6;
  level.drone_anims["team3"]["stand"]["run"] = % deer_run_iw6;
  level.drone_anims["team3"]["stand"]["death"] = % deer_death_iw6;
  maps\_drone::initglobals();
}

deer_dronespawn(var_0) {
  if(!isDefined(var_0))
    var_0 = self;

  var_0 maps\_utility::script_delay();
  var_1 = deer_dronespawn_internal(var_0);
  var_1 deer_drone_spawn_func();
  var_1[[level.drone_spawn_func]]();
  var_1.spawn_funcs = var_0.spawn_functions;
  return var_1;
}

deer_dronespawn_internal(var_0) {
  var_1 = var_0 spawndrone();
  var_1.spawner = var_0;
  var_1.drone_delete_on_unload = isDefined(var_0.script_noteworthy) && var_0.script_noteworthy == "drone_delete_on_unload";
  var_0 notify("drone_spawned", var_1);
  return var_1;
}

deer_drone_spawn_func() {
  self.noragdoll = 1;
  self.health = 250;
  self.drone_idle_custom = 1;
  self.drone_idle_override = ::deer_drone_custom_idle;
  self.drone_loop_custom = 1;
  self.drone_loop_override = ::deer_drone_custom_loop;
  self.drone_run_speed = randomintrange(580, 620);
  thread deer_damage_fx();
}

deer_damage_fx() {
  self endon("entitydeleted");

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

    if(isDefined(var_7) && var_7 != "")
      playFXOnTag(common_scripts\utility::getfx("melee_knife_ai"), self, var_7);
  }
}

deer_drone_custom_idle() {
  self clearanim( % root, 0.2);
  self stopanimscripted();
  var_0 = undefined;
  var_1 = level.drone_anims["team3"]["stand"]["idle"];

  if(isarray(var_1)) {
    if(var_1.size > 1)
      var_0 = common_scripts\utility::random(var_1);
  } else
    var_0 = var_1;

  self setflaggedanimknoballrestart("drone_anim", var_0, % root, 1, 0.2, 1);
  self.droneanim = var_1;
}

deer_drone_custom_loop(var_0, var_1) {
  wait(randomfloatrange(0.1, 0.35));
  self clearanim( % deer, 0.2);
  self stopanimscripted();
  self setanimknob(var_0, 1, 0.2, var_1);
  self.droneanim = var_0;
}