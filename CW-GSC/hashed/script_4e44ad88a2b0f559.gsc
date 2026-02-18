/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_4e44ad88a2b0f559.gsc
***********************************************/

#using scripts\core_common\bots\bot;
#namespace namespace_87549638;

function preinit() {}

function think() {
  pixbeginevent(#"");

  if(self isinexecutionvictim() || self isinexecutionattack()) {
    pixendevent();
    return;
  }

  if(isDefined(self.bot.var_5efe88e4)) {
    self botsetlookangles(self.bot.var_5efe88e4);
    self.bot.var_9931c7dc = 0;
  } else if(self isplayinganimscripted() || self arecontrolsfrozen() || self.bot.flashed) {
    self.bot.var_9931c7dc = 0;
  } else if(self function_37d408b6()) {
    self function_23401de9();
    self.bot.var_9931c7dc = 0;
  } else if(isDefined(self.bot.var_87751145)) {
    self.bot.var_9931c7dc = self function_2f110827();
  } else if(self.bot.enemyvisible) {
    entity = self.enemy;

    if(isPlayer(self.enemy)) {
      if(self.enemy isinvehicle() && !self.enemy isremotecontrolling()) {
        entity = self.enemy getvehicleoccupied();
      } else if(isDefined(self.enemy.prop)) {
        entity = self.enemy.prop;
      }
    }

    self.bot.var_9931c7dc = self aim_at_entity(entity, self.bot.enemydist, self.bot.var_2d563ebf);
  } else if(self.bot.enemyseen && self function_204b5b9c() && self function_8174b063(self.enemylastseenpos)) {
    self.bot.var_9931c7dc = self function_e958519b();
  } else if(self function_b21ea513()) {
    self.bot.var_9931c7dc = 0;
  } else if(isDefined(self.bot.var_941ba251) && self function_8174b063(self.bot.var_941ba251)) {
    self function_19ef91d7();
    self.bot.var_9931c7dc = 1;
  } else if(self haspath()) {
    self function_311aed8b();
    self.bot.var_9931c7dc = 0;
  } else if(isDefined(self.bot.traversal)) {
    self function_23401de9();
    self.bot.var_9931c7dc = 0;
  } else {
    self function_eb94f73e();
    self.bot.var_9931c7dc = 0;
  }

  pixendevent();
}

function private function_8174b063(aimpoint) {
  pixbeginevent(#"");
  eye = self.origin + (0, 0, self getplayerviewheight());
  pixendevent();
  return bullettracepassed(eye, aimpoint, 0, self, self.enemy, 1, 1, 1);
}

function private function_37d408b6(traversal) {
  if(!isDefined(traversal)) {
    return false;
  }

  return traversal.type == # "ladder" || traversal.type == # "jump" || traversal.deltaz >= 50;
}

function private function_9b25bbe5(traversal, aimpoint) {
  if(!self function_37d408b6(traversal)) {
    return false;
  }

  eye = self.origin + (0, 0, self getplayerviewheight());
  dir = vectornormalize(eye - aimpoint);
  return vectordot(traversal.normal, dir) < 0.5;
}

function private function_204b5b9c() {
  point = self.enemylastseenpos;

  if(distance2dsquared(self.origin, point) <= 9216) {
    return false;
  }

  normal = self.bot.var_a0b6205e;

  if(isDefined(normal)) {
    dir = self.origin - self.enemylastseenpos;
    return (vectordot(dir, normal) > 0);
  }

  return true;
}

function private function_b21ea513() {
  if(self.bot.enemyseen || self.ignoreall) {
    return false;
  }

  enemies = self getenemiesinradius(self.origin, 1000);
  var_8a75d6bc = undefined;
  var_6e4e5c17 = undefined;

  foreach(enemy in enemies) {
    if(is_true(enemy.ignoreme)) {
      continue;
    }

    var_f1e73cd = self lastknowntime(enemy);
    enemypos = self lastknownpos(enemy);

    if(!isDefined(var_f1e73cd) || !isDefined(enemypos) || var_f1e73cd + 3000 < gettime()) {
      continue;
    }

    if(!isDefined(var_6e4e5c17) || var_6e4e5c17 < var_f1e73cd) {
      var_6e4e5c17 = var_f1e73cd;
      var_8a75d6bc = enemypos;
    }
  }

  if(!isDefined(var_8a75d6bc)) {
    return false;
  }

  var_8a75d6bc += (0, 0, self getplayerviewheight());
  self function_b5460039(var_8a75d6bc, #"hash_4d7ab907ebdddd3c", (1, 0.5, 0));
  return true;
}

function private function_2f110827() {
  point = self.bot.var_87751145;

  if(self function_9b25bbe5(self.bot.traversal, point)) {
    self function_23401de9();
    return 0;
  }

  self function_b5460039(point, #"point", (0, 1, 1));
  return self function_8174b063(point);
}

function private function_e958519b() {
  point = self.enemylastseenpos;

  if(self function_9b25bbe5(self.bot.traversal, point)) {
    self function_23401de9();
    return false;
  }

  self function_b5460039(point, #"hash_517fc0a2cf80dbb8", (1, 0, 1));
  return true;
}

function private function_19ef91d7() {
  point = self.bot.var_941ba251;

  if(self function_9b25bbe5(self.bot.traversal, point)) {
    self function_23401de9();
    return;
  }

  self function_b5460039(point, #"threat", (1, 0.5, 0));
}

function private aim_at_entity(ent, dist, tag) {
  if(self function_9b25bbe5(self.bot.traversal, ent.origin)) {
    self function_23401de9();
    return false;
  }

  if(isDefined(self.scriptenemy) && self.scriptenemy == ent) {
    tag = self.scriptenemytag;
  } else if(isDefined(ent.shootattag)) {
    tag = ent.shootattag;
  }

  if(isDefined(tag)) {
    tagorigin = ent gettagorigin(tag);

    if(isDefined(tagorigin)) {
      self function_b5460039(tagorigin, tag, (1, 0, 1));
      return true;
    }
  } else if(isvehicle(ent) && target_istarget(ent)) {
    tagorigin = target_getorigin(ent);
    self function_b5460039(tagorigin, #"hash_7b9926f357c45aa8", (1, 0, 1));
    return true;
  } else {
    point = self function_466e841e(ent, dist);

    if(isDefined(point)) {
      self function_b5460039(point, #"entity", (1, 0, 1));
      return true;
    }
  }

  centroid = ent getcentroid();
  self function_b5460039(centroid, #"centroid", (1, 0, 1));
  return true;
}

function private function_466e841e(ent, dist) {
  pixbeginevent(#"");
  defaultorigin = ent gettagorigin("j_spineupper");

  if(!isDefined(defaultorigin)) {
    pixendevent();
    return undefined;
  }

  if(dist >= 250) {
    pixendevent();
    return defaultorigin;
  }

  var_d7b829fb = ent gettagorigin("j_neck");

  if(!isDefined(var_d7b829fb)) {
    pixendevent();
    return defaultorigin;
  }

  t = max(dist / 250, 0.25);
  pixendevent();
  return vectorlerp(var_d7b829fb, defaultorigin, t);
}

function private function_311aed8b() {
  var_8be65bb9 = self function_f04bd922();

  if(isDefined(var_8be65bb9)) {
    if(self function_35170b35(var_8be65bb9.var_b8c123c0, 128, #"hash_c5ef7c07caa7856", (0, 1, 1))) {
      return;
    }

    if(self function_35170b35(var_8be65bb9.var_bef48941, 64, #"hash_77da0a5a26fe7baf", (0, 0, 1))) {
      return;
    }

    if(self function_35170b35(var_8be65bb9.var_2cfdc66d, 32, #"hash_4c52ca575ab8182b", (1, 0, 1))) {
      return;
    }
  }

  self function_eb94f73e();
}

function private function_35170b35(var_104d463, mindist, var_e125ba43, debugcolor) {
  if(!isDefined(var_104d463) || distance2dsquared(self.origin, var_104d463) < mindist * mindist) {
    return false;
  }

  if(self isplayerswimming()) {
    eye = self.origin + (0, 0, self getplayerviewheight());
    var_42e28bb1 = (var_104d463[0], var_104d463[1], eye[2]);
    self function_b5460039(var_42e28bb1, var_e125ba43, debugcolor);
  } else {
    aimoffset = (0, 0, self getplayerviewheight());
    self function_b5460039(var_104d463 + aimoffset, var_e125ba43, debugcolor);
  }

  return true;
}

function private function_eb94f73e() {
  movedir = self bot::move_dir();

  if(lengthsquared(movedir) > 0.0001) {
    eye = self.origin + (0, 0, self getplayerviewheight());
    var_d9100e0 = eye + vectornormalize(movedir) * 128;
    self function_b5460039(var_d9100e0, #"forward", (0, 1, 1));
    return;
  }

  self botsetlookangles(self.angles);
}

function private function_23401de9() {
  traversal = self.bot.traversal;
  enddist = vectordot(self.origin - traversal.var_15dca465, traversal.normal);

  if(enddist > 15) {
    endpoint = traversal.end_position + (0, 0, self getplayerviewheight());
    self function_b5460039(endpoint, #"hash_7d35f3d861b9ec10", (1, 1, 0));
    return;
  }

  dir = (0, 0, 0) - traversal.normal;
  self botsetlookdir(dir);
}

function private function_b5460039(point, var_e125ba43, debugcolor) {
  var_a3375299 = undefined;

  if(isDefined(self.bot.var_32d8dabe)) {
    var_a3375299 = point;
    point += rotatepoint(self.bot.var_32d8dabe, self.angles + (0, 180, 0));
  }

  if(self bot::should_record("<dev string:x38>")) {
    recordbox(point, (-1.5, -1.5, -1.5), (1.5, 1.5, 1.5), self.angles[1], debugcolor, "<dev string:x49>", self);
    record3dtext(function_9e72a96(var_e125ba43), point + (0, 0, -0.75), (1, 1, 1), "<dev string:x49>", self, 0.5);

    if(isDefined(var_a3375299)) {
      recordbox(var_a3375299, (-1.5, -1.5, -1.5), (1.5, 1.5, 1.5), self.angles[1], (0.75, 0.75, 0.75), "<dev string:x49>", self);
      recordline(var_a3375299, point, (0.75, 0.75, 0.75), "<dev string:x49>", self);

      if(isDefined(self.bot.var_9e5aaf8d)) {
        record3dtext(self.bot.var_9e5aaf8d + "<dev string:x53>", var_a3375299, (1, 1, 0), "<dev string:x49>", self, 0.5);
      }
    }
  }

  if(isDefined(self.bot.var_f50fa466)) {
    var_deb75a87 = self botgetprojectileaimangles(self.bot.var_f50fa466, point);

    if(isDefined(var_deb75a87)) {
      self botsetlookangles(var_deb75a87.var_478aeacd);
    } else {
      self botsetlookcurrent();
    }

    return;
  }

  self botsetlookpoint(point);
}