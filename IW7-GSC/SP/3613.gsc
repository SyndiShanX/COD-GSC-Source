/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: SP\3613.gsc
*********************************************/

func_2840(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!isDefined(level.var_CAF7)) {
    level.var_CAF7 = [];
  }

  level.var_CAF7 = scripts\engine\utility::array_add(level.var_CAF7, self);
  self.var_C528 = undefined;
  self.var_111AD = var_0;
  self.var_9D62 = 1;
  self setCanDamage(1);
  self.var_2836 = var_1;
  self.var_CAF6 = var_2;
  self.var_CAEC = var_3;
  self.var_CAEB = var_4;
  self.var_B74E = var_5;
  self.var_109DB = [];
  thread func_2832();
  thread func_2838();
}

func_2838() {
  var_0 = createnavobstaclebybounds(self.origin, (12, 12, 50), (0, 0, 0));
  while(isDefined(self) && self.var_109DB.size <= 0) {
    wait(0.05);
  }

  if(!isDefined(self)) {
    destroynavobstacle(var_0);
    return;
  }

  var_1 = self.var_CAF6 / 4.5;
  var_2 = "barrel" + self getentitynumber();
  createnavrepulsor(var_2, -1, self.origin, var_1, 1);
  while(isDefined(self)) {
    wait(0.05);
  }

  destroynavobstacle(var_0);
  destroynavrepulsor(var_2);
}

func_2832() {
  scripts\engine\utility::waittill_either("barrel_death", "entitydeleted");
  level.var_CAF7 = scripts\engine\utility::array_remove(level.var_CAF7, self);
}

func_7855(var_0) {
  if(!isDefined(var_0)) {
    return level.var_CAF7;
  }

  var_1 = [];
  foreach(var_3 in level.var_CAF7) {
    if(isDefined(var_3.var_111AD) && var_3.var_111AD == var_0) {
      var_1 = scripts\engine\utility::array_add(var_1, var_3);
    }
  }

  return var_1;
}

func_2835(var_0) {
  self endon("barrel_death");
  self notify("new_barrel_timer");
  self endon("new_barrel_timer");
  wait(var_0);
  while(isDefined(self.var_5945)) {
    scripts\engine\utility::waitframe();
  }

  self notify("barrel_death");
}

func_2831(var_0, var_1) {
  if(level.player scripts\sp\utility::func_65DB("no_grenade_block_gesture") || level.player isthrowinggrenade() || level.player func_8448()) {
    return;
  }

  var_2 = distance2dsquared(level.player.origin, var_1);
  if(var_2 > squared(var_0)) {
    return;
  }

  if(var_2 > squared(var_0 * 0.25)) {
    var_3 = vectordot(scripts\engine\utility::flatten_vector(vectornormalize(var_1 - level.player.origin)), anglesToForward(level.player.angles));
    if(var_3 < 0) {
      return;
    }
  }

  if(!scripts\common\trace::ray_trace_passed(var_1 + (0, 0, 12), level.player getEye(), undefined, scripts\common\trace::create_world_contents())) {
    return;
  }

  level.player thread func_283F(var_1);
}

func_283F(var_0) {
  self endon("death");
  var_1 = scripts\engine\utility::spawn_tag_origin(var_0, (0, 0, 0));
  thread scripts\engine\utility::delete_on_death(var_1);
  var_2 = "ges_frag_block";
  var_3 = self playgestureviewmodel(var_2, var_1, 1, 0.1);
  if(var_3) {
    childthread lib_0E49::func_D092(var_2, 0, 0, 0, 0, 1, 0, 1, 0, 0, 1, 0, 1.4);
    for(;;) {
      self waittill("gesture_stopped", var_2);
      if(var_2 == "ges_frag_block") {
        break;
      }
    }
  }

  if(isDefined(var_1)) {
    var_1 delete();
  }
}

func_2837(var_0, var_1, var_2) {
  self endon("barrel_death");
  wait(var_2);
  if(!isDefined(self)) {
    return;
  }

  var_3 = vectornormalize(self.origin - var_0);
  var_4 = self.var_CAEC;
  if(var_1 <= self.var_B74E) {
    var_4 = self.var_CAEB;
  }

  var_5 = self.var_CAF6 - var_1;
  var_6 = var_5 / self.var_CAF6;
  var_6 = var_6 * var_4;
  self physicslaunchserver(self.origin, var_3 * var_6);
}

func_2839() {
  self waittill("damage");
  scripts\engine\utility::waitframe();
  scripts\engine\utility::waitframe();
  self notify("barrel_death");
}

func_283E() {
  self endon("entitydeleted");
  for(;;) {
    while(distancesquared(level.player.origin, self.origin) > squared(40)) {
      wait(0.05);
    }

    var_0 = self physics_getentitycenterofmass();
    var_0 = var_0["unscaled"] + (0, 0, 4);
    self physicslaunchserver(var_0, vectornormalize(self.origin - level.player.origin) * 1000);
    wait(0.05);
  }
}

func_2833() {
  self endon("barrel_death");
  var_0 = undefined;
  var_1 = undefined;
  setdvarifuninitialized("barrel_debug", 0);
  for(;;) {
    if(!getdvarint("barrel_debug")) {} else {
      thread scripts\sp\utility::draw_circle(self.origin, 250, (1, 0, 0), 1, 0, 1);
    }

    wait(0.05);
  }
}