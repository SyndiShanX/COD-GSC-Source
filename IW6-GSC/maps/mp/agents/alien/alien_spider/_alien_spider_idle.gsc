/********************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\agents\alien\alien_spider\_alien_spider_idle.gsc
********************************************************************/

main() {
  self endon("killanimscript");
  init_alien_idle();
  thread wait_for_downed_state();

  for(;;) {
    if(!isDefined(self.stage) || self.vulnerable) {
      wait 0.05;
      continue;
    }

    if(try_move_idle()) {
      continue;
    }
    play_idle();
  }
}

init_alien_idle() {
  self.idle_anim_counter = 0;
}

play_idle() {
  self endon("vulnerable");
  facetarget();
  var_0 = selectidleanimstate();
  self scragentsetanimmode("anim deltas");
  self scragentsetorientmode("face angle abs", self.angles);
  maps\mp\agents\_scriptedagents::playanimnuntilnotetrack(var_0, undefined, var_0, "end", maps\mp\agents\alien\alien_spider\_alien_spider::handlespidernotetracks);
}

gettarget() {
  var_0 = undefined;

  if(isalive(self.enemy) && distancesquared(self.enemy.origin, self.origin) < 2560000)
    var_0 = self.enemy;
  else if(isDefined(self.owner))
    var_0 = self.owner;

  return var_0;
}

facetarget() {
  var_0 = gettarget();

  if(isDefined(var_0))
    maps\mp\agents\alien\_alien_anim_utils::turntowardsentity(var_0);
}

selectidleanimstate() {
  var_0 = getdesiredanimstate();

  if(isDefined(self.anim_state_modifier))
    var_0 = self.anim_state_modifier + var_0;

  return var_0;
}

getdesiredanimstate() {
  if(self.idle_anim_counter < 2 + randomintrange(0, 1)) {
    var_0 = "idle_default";
    self.idle_anim_counter = self.idle_anim_counter + 1;
  } else {
    var_0 = "idle";
    self.idle_anim_counter = 0;
  }

  return var_0;
}

is_moving() {
  return isDefined(self.idle_move_data) && self.idle_move_data.active;
}

try_move_idle() {
  if(!isDefined(self.idle_move_data))
    return 0;

  if(isDefined(self.disable_idle_move) && self.disable_idle_move)
    return 0;

  if(maps\mp\agents\alien\alien_spider\_alien_spider::candoelevatedeggattack())
    return 0;

  if(gettime() < self.idle_move_data.next_valid_move_time)
    return 0;

  if(!common_scripts\utility::cointoss())
    return 0;

  perform_move(0);
  self.idle_move_data.next_valid_move_time = gettime() + 15000;
  return 1;
}

init_idle_move() {
  var_0 = spawnStruct();
  var_0.next_valid_move_time = gettime() + 15000;
  var_0.active = 0;
  var_0.last_position_index = -1;
  var_1 = level.alien_types[self.alien_type].attributes["movement_radius"];
  var_2 = anglesToForward(self.angles);
  var_3 = anglestoright(self.angles);
  var_0.valid_positions[0] = self.origin;
  var_0.valid_positions[1] = self.origin + var_2 * var_1;
  var_0.valid_positions[2] = self.origin - var_2 * var_1;
  var_0.valid_positions[3] = self.origin + var_3 * var_1;
  var_0.valid_positions[4] = self.origin - var_3 * var_1;
  self.idle_move_data = var_0;
}

perform_move(var_0) {
  if(var_0)
    var_1 = 0;
  else
    var_1 = get_move_target_position_index();

  var_2 = self.idle_move_data.valid_positions[var_1];
  var_3 = 25.0;

  if(distance2dsquared(var_2, self.origin) < var_3) {
    return;
  }
  self.idle_move_data.active = 1;
  var_4 = get_move_target_facing(var_2);
  play_move_anim(var_4["animIndex"], var_4["direction"], var_2, var_0);
  self.idle_move_data.last_position_index = var_1;
  clean_up_move();
}

clean_up_move() {
  self.idle_move_data.active = 0;
  self scragentsetgoalpos(self.origin);
  self scragentsetgoalradius(4096);
}

play_move_anim(var_0, var_1, var_2, var_3) {
  self endon("move_anim_timeout");
  self endon("vulnerable");
  maps\mp\agents\alien\_alien_anim_utils::turntowardsvector(var_1);
  var_4 = self getanimentry("idle_move", var_0);
  var_5 = length(getmovedelta(var_4));
  var_6 = length(var_2 - self.origin);
  self.xyanimscale = var_6 / var_5;

  if(!var_3)
    self.xyanimscale = min(self.xyanimscale, 1.0);

  self.statelocked = 1;
  self scragentsetanimscale(self.xyanimscale, 1.0);
  self scragentsetanimmode("anim deltas");
  self scragentsetorientmode("face angle abs", vectortoangles(var_1));
  thread move_anim_timeout();
  maps\mp\agents\_scriptedagents::playanimnuntilnotetrack("idle_move", var_0, "idle_move", "end", maps\mp\agents\alien\alien_spider\_alien_spider::handlespidernotetracks);
  self.statelocked = 0;
  self notify("move_anim_complete");
}

move_anim_timeout() {
  self endon("move_anim_complete");
  self endon("vulnerable");
  var_0 = 10.0;
  wait(var_0);
  self notify("move_anim_timeout");
}

get_move_target_position_index() {
  var_0 = self.idle_move_data.valid_positions.size;

  if(self.idle_move_data.last_position_index != -1)
    var_0--;

  var_1 = randomint(var_0);

  if(self.idle_move_data.last_position_index != -1 && var_1 >= self.idle_move_data.last_position_index)
    var_1++;

  return var_1;
}

get_move_target_facing(var_0) {
  var_1 = vectornormalize(var_0 - self.origin);
  var_2 = maps\mp\agents\alien\_alien_anim_utils::getprojectiondata(anglesToForward(self.angles), var_1, anglestoup(self.angles));

  if(var_2.rotatedyaw < 45) {
    var_3["direction"] = vectornormalize(var_0 - self.origin);
    var_3["animIndex"] = 0;
  } else if(var_2.rotatedyaw > 135) {
    var_3["direction"] = vectornormalize(self.origin - var_0);
    var_3["animIndex"] = 1;
  } else {
    if(var_2.projintooutright > 0) {
      var_4 = vectornormalize(var_0 - self.origin);
      var_3["animIndex"] = 2;
    } else {
      var_4 = vectornormalize(self.origin - var_0);
      var_3["animIndex"] = 3;
    }

    var_3["direction"] = vectorcross((0, 0, 1), var_4);
  }

  return var_3;
}

wait_for_downed_state() {
  self endon("killanimscript");
  self waittill("vulnerable");

  if(isDefined(self.idle_move_data) && self.idle_move_data.active)
    clean_up_move();

  self.statelocked = 1;
  self.idle_downed = 1;
  maps\mp\agents\alien\alien_spider\_alien_spider_melee::downed_state();
  self.idle_downed = 0;
  self.statelocked = 0;
}