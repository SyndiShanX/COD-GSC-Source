/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: SP\3613.gsc
************************/

func_2840(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  if(!isDefined(level.var_CAF7)) {
    level.var_CAF7 = [];
  }

  level.var_CAF7 = scripts\engine\utility::array_add(level.var_CAF7, self);
  self.var_C528 = undefined;
  self.var_111AD = param_00;
  self.var_9D62 = 1;
  self setCanDamage(1);
  self.var_2836 = param_01;
  self.var_CAF6 = param_02;
  self.var_CAEC = param_03;
  self.var_CAEB = param_04;
  self.var_B74E = param_05;
  self.var_109DB = [];
  thread func_2832();
  thread func_2838();
}

func_2838() {
  var_00 = createnavobstaclebybounds(self.origin, (12, 12, 50), (0, 0, 0));
  while(isDefined(self) && self.var_109DB.size <= 0) {
    wait(0.05);
  }

  if(!isDefined(self)) {
    destroynavobstacle(var_00);
    return;
  }

  var_01 = self.var_CAF6 / 4.5;
  var_02 = "barrel" + self getentitynumber();
  createnavrepulsor(var_02, -1, self.origin, var_01, 1);
  while(isDefined(self)) {
    wait(0.05);
  }

  destroynavobstacle(var_00);
  destroynavrepulsor(var_02);
}

func_2832() {
  scripts\engine\utility::waittill_either("barrel_death", "entitydeleted");
  level.var_CAF7 = scripts\engine\utility::array_remove(level.var_CAF7, self);
}

func_7855(param_00) {
  if(!isDefined(param_00)) {
    return level.var_CAF7;
  }

  var_01 = [];
  foreach(var_03 in level.var_CAF7) {
    if(isDefined(var_03.var_111AD) && var_03.var_111AD == param_00) {
      var_01 = scripts\engine\utility::array_add(var_01, var_03);
    }
  }

  return var_01;
}

func_2835(param_00) {
  self endon("barrel_death");
  self notify("new_barrel_timer");
  self endon("new_barrel_timer");
  wait(param_00);
  while(isDefined(self.var_5945)) {
    scripts\engine\utility::waitframe();
  }

  self notify("barrel_death");
}

func_2831(param_00, param_01) {
  if(level.player scripts\sp\utility::func_65DB("no_grenade_block_gesture") || level.player isthrowinggrenade() || level.player func_8448()) {
    return;
  }

  var_02 = distance2dsquared(level.player.origin, param_01);
  if(var_02 > squared(param_00)) {
    return;
  }

  if(var_02 > squared(param_00 * 0.25)) {
    var_03 = vectordot(scripts\engine\utility::flatten_vector(vectornormalize(param_01 - level.player.origin)), anglesToForward(level.player.angles));
    if(var_03 < 0) {
      return;
    }
  }

  if(!scripts\common\trace::ray_trace_passed(param_01 + (0, 0, 12), level.player getEye(), undefined, scripts\common\trace::create_world_contents())) {
    return;
  }

  level.player thread func_283F(param_01);
}

func_283F(param_00) {
  self endon("death");
  var_01 = scripts\engine\utility::spawn_tag_origin(param_00, (0, 0, 0));
  thread scripts\engine\utility::delete_on_death(var_01);
  var_02 = "ges_frag_block";
  var_03 = self playgestureviewmodel(var_02, var_01, 1, 0.1);
  if(var_03) {
    childthread lib_0E49::func_D092(var_02, 0, 0, 0, 0, 1, 0, 1, 0, 0, 1, 0, 1.4);
    for(;;) {
      self waittill("gesture_stopped", var_02);
      if(var_02 == "ges_frag_block") {
        break;
      }
    }
  }

  if(isDefined(var_01)) {
    var_01 delete();
  }
}

func_2837(param_00, param_01, param_02) {
  self endon("barrel_death");
  wait(param_02);
  if(!isDefined(self)) {
    return;
  }

  var_03 = vectornormalize(self.origin - param_00);
  var_04 = self.var_CAEC;
  if(param_01 <= self.var_B74E) {
    var_04 = self.var_CAEB;
  }

  var_05 = self.var_CAF6 - param_01;
  var_06 = var_05 / self.var_CAF6;
  var_06 = var_06 * var_04;
  self physicslaunchserver(self.origin, var_03 * var_06);
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

    var_00 = self physics_getentitycenterofmass();
    var_00 = var_00["unscaled"] + (0, 0, 4);
    self physicslaunchserver(var_00, vectornormalize(self.origin - level.player.origin) * 1000);
    wait(0.05);
  }
}

func_2833() {
  self endon("barrel_death");
  var_00 = undefined;
  var_01 = undefined;
  setdvarifuninitialized("barrel_debug", 0);
  for(;;) {
    if(!getdvarint("barrel_debug")) {} else {
      thread scripts\sp\utility::draw_circle(self.origin, 250, (1, 0, 0), 1, 0, 1);
    }

    wait(0.05);
  }
}