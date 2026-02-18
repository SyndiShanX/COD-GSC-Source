/******************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: abilities\gadgets\gadget_cymbal_monkey.gsc
******************************************************/

#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace gadget_cymbal_monkey;

function private autoexec __init__system__() {
  system::register(#"cymbal_monkey", &preinit, &postinit, &finalize, undefined);
}

function private preinit() {
  level.var_7d95e1ed = [];
  level.var_15e68c97 = [];
  level.var_7c5c96dc = &function_4f90c4c2;
  level thread function_a23699fe();
}

function private postinit() {
  level._effect[# "monkey_glow"] = # "hash_5d0dd3293cfdb3dd";
}

function private finalize() {
  if(isDefined(level.var_a5dacbea)) {
    [[level.var_a5dacbea]](getweapon(#"cymbal_monkey"), &function_127fb8f3);
  }
}

function private function_a23699fe() {
  level endon(#"game_ended");
  sticker_iw9_512 = 250;

  while(true) {
    for(i = 0; i < level.var_7d95e1ed.size; i++) {
      monkey = level.var_7d95e1ed[i];

      if(!isDefined(monkey) || is_true(monkey.fuse_lit)) {
        continue;
      }

      if(!isDefined(monkey.var_38af96b9)) {
        monkey delete();
        continue;
      }

      monkey thread function_b9934c1d();
      waitframe(1);
    }

    arrayremovevalue(level.var_7d95e1ed, undefined);
    arrayremovevalue(level.var_15e68c97, undefined);
    waitframe(1);
  }
}

function private function_7e60533f(monkey, radius) {
  nearby_players = getentitiesinradius(monkey.origin, radius, 1);

  foreach(player in nearby_players) {
    if(function_17c51c94(monkey, player)) {
      return true;
    }
  }

  var_b1de6a06 = getentitiesinradius(monkey.origin, radius, 15);

  foreach(actor in var_b1de6a06) {
    if(function_17c51c94(monkey, actor)) {
      return true;
    }
  }

  return false;
}

function private function_17c51c94(monkey, ent) {
  if(!isDefined(ent)) {
    return false;
  }

  if(isPlayer(ent) && util::function_fbce7263(ent.team, monkey.team)) {
    return true;
  }

  if(isactor(ent) && ent.archetype == "zombie" && util::function_fbce7263(ent.team, monkey.team)) {
    return true;
  }

  return false;
}

function private event_handler[grenade_fire] function_4776caf4(eventstruct) {
  if(eventstruct.weapon.name == # "cymbal_monkey") {
    e_grenade = eventstruct.projectile;
    e_grenade ghost();
    e_grenade.angles = self.angles;
    mdl_monkey = util::spawn_model(e_grenade.model, e_grenade.origin, e_grenade.angles);
    e_grenade.mdl_monkey = mdl_monkey;
    e_grenade.mdl_monkey linkto(e_grenade);
    e_grenade.mdl_monkey.var_38af96b9 = e_grenade;
    e_grenade.mdl_monkey.team = e_grenade.team;
    e_grenade.mdl_monkey.var_dfa42180 = &function_948b1eea;
    e_grenade.mdl_monkey clientfield::set("enemyequip", 1);
    e_grenade.mdl_monkey callback::function_d8abfc3d(#"cant_move", &function_8690bb8);
    array::add(level.var_15e68c97, e_grenade.mdl_monkey);
    e_grenade waittill(#"stationary", #"death");

    if(!isDefined(e_grenade) && isDefined(mdl_monkey)) {
      mdl_monkey delete();
    }

    if(isDefined(e_grenade) && isDefined(e_grenade.mdl_monkey)) {
      e_grenade.mdl_monkey.var_acdc8d71 = getclosestpointonnavmesh(e_grenade.mdl_monkey.origin, 720, 15.1875);
      array::add(level.var_7d95e1ed, e_grenade.mdl_monkey);

      if(isDefined(self)) {
        self callback::callback(#"hash_3c09ead7e9d8a968", e_grenade.mdl_monkey);
      }
    }
  }
}

function function_b9934c1d() {
  self endon(#"death");

  if(isDefined(level.var_2746aef8)) {
    [[level.var_2746aef8]](self);
  }

  if(isDefined(level.var_e3d7278e)) {
    [[level.var_e3d7278e]](self);
  }

  self unlink();
  self.fuse_lit = 1;

  if(isDefined(level.var_1b5a1f0d) && ![[level.var_1b5a1f0d]](self.origin)) {
    arrayremovevalue(level.var_15e68c97, self);
    level thread grenade_stolen_by_sam(self.var_38af96b9, self);
    return;
  } else if(isDefined(self.var_acdc8d71) && isDefined(self.var_38af96b9)) {
    self function_1beaca16();
  }

  if(isDefined(level.var_c50ca517)) {
    [[level.var_c50ca517]](self);
  } else {
    self playSound(#"hash_4509539f9e7954e2");
  }

  playFXOnTag(level._effect[# "monkey_glow"], self, "tag_weapon");
  self thread scene::play(#"cin_t8_monkeybomb_dance", self);
  self thread util::delay(6.5, "death", &function_4e61e1d);
  var_de3026af = gettime() + int(8 * 1000);

  while(gettime() < var_de3026af) {
    if(!isDefined(self.var_38af96b9)) {
      break;
    }

    waitframe(1);
  }

  self function_4f90c4c2();
}

function private function_1beaca16() {
  queryresult = positionquery_source_navigation(self.origin, 8, 150, 30, 8, 1, 8);
  var_7162cf15 = self.var_acdc8d71;
  var_4eed21d6 = min(queryresult.data.size, 32);
  self.var_1a14c72d = 0;
  self.var_4dbbbb75 = [];
  self.var_9473fdb8 = [];

  for(i = 0; i < var_4eed21d6; i++) {
    var_45889380 = queryresult.data[i].origin;

    if(!tracepassedonnavmesh(var_7162cf15, var_45889380, 15)) {
      recordstar(var_45889380, (1, 0, 0));
      record3dtext("<dev string:x38>", queryresult.data[i].origin + (0, 0, 8), (1, 0, 0));

      continue;
    }

    if(!isDefined(self.var_4dbbbb75)) {
      self.var_4dbbbb75 = [];
    } else if(!isarray(self.var_4dbbbb75)) {
      self.var_4dbbbb75 = array(self.var_4dbbbb75);
    }

    self.var_4dbbbb75[self.var_4dbbbb75.size] = undefined;

    if(!isDefined(self.var_9473fdb8)) {
      self.var_9473fdb8 = [];
    } else if(!isarray(self.var_9473fdb8)) {
      self.var_9473fdb8 = array(self.var_9473fdb8);
    }

    self.var_9473fdb8[self.var_9473fdb8.size] = var_45889380;
  }

  arraysortclosest(self.var_9473fdb8, var_7162cf15);
}

function function_4e61e1d() {
  self playSound(#"zmb_vox_monkey_explode");
}

function function_4f90c4c2() {
  if(isDefined(self.var_38af96b9)) {
    self callback::callback(#"hash_6aa0232dd3c8376a");
    playsoundatposition(#"wpn_claymore_alert", self.origin);
    self.var_38af96b9 detonate();
  }

  self delete();
}

function function_4a5dff80(zombie, var_d2b7321d = 1) {
  var_2d9e38fc = sqr(var_d2b7321d ? 720 : 3000);
  arrayremovevalue(level.var_15e68c97, undefined);
  best_monkey = arraygetclosest(zombie.origin, level.var_15e68c97, var_2d9e38fc);
  return best_monkey;
}

function function_948b1eea(zombie) {
  if(isDefined(self.var_9473fdb8)) {
    var_5800c2e0 = undefined;

    for(i = 0; i < self.var_9473fdb8.size; i++) {
      slot = {
        #zombie: self.var_4dbbbb75[i], #pos: self.var_9473fdb8[i]
      };

      if(!isDefined(slot.zombie)) {
        if(!isDefined(var_5800c2e0)) {
          var_5800c2e0 = i;
        }
      }

      if(slot.zombie === zombie) {
        return slot.pos;
      }
    }

    if(isDefined(var_5800c2e0)) {
      if(isDefined(level.var_6df2b61b)) {
        thread[[level.var_6df2b61b]](self, zombie);
      }

      self.var_4dbbbb75[var_5800c2e0] = zombie;
      return self.var_9473fdb8[var_5800c2e0];
    }
  }

  target_pos = undefined;

  if(!isDefined(self.var_acdc8d71)) {
    target_pos = groundtrace(self.origin + (0, 0, 8), self.origin + (0, 0, -100000), 0, self)[# "position"];
  } else {
    target_pos = self.var_acdc8d71;
  }

  if(isDefined(level.var_1b5a1f0d) && ![[level.var_1b5a1f0d]](target_pos)) {
    return undefined;
  }

  return target_pos;
}

function function_127fb8f3(cymbal_monkey, attackingplayer) {
  attackingplayer endon(#"death");
  randangle = randomfloat(360);

  if(isDefined(level._equipment_emp_destroy_fx)) {
    playFX(level._equipment_emp_destroy_fx, attackingplayer.origin + (0, 0, 5), (cos(randangle), sin(randangle), 0), anglestoup(attackingplayer.angles));
  }

  wait 1.1;
  playFX(#"hash_65c5042becfbaa7d", attackingplayer.origin);
  attackingplayer function_4f90c4c2();
}

function function_8690bb8(zombie) {
  if(!isDefined(zombie) || !isDefined(self.var_9473fdb8)) {
    return;
  }

  for(i = 0; i < self.var_9473fdb8.size; i++) {
    if(self.var_4dbbbb75[i] === zombie) {
      self.var_9473fdb8[i] = zombie.origin;
    }
  }
}

function grenade_stolen_by_sam(e_grenade, e_actor) {
  if(!isDefined(e_grenade.mdl_monkey)) {
    return;
  }

  direction = e_grenade.mdl_monkey.origin;
  direction = (direction[1], direction[0], 0);

  if(direction[1] < 0 || direction[0] > 0 && direction[1] > 0) {
    direction = (direction[0], direction[1] * -1, 0);
  } else if(direction[0] < 0) {
    direction = (direction[0] * -1, direction[1], 0);
  }

  if(isDefined(level.zmb_laugh_alias)) {
    players = getplayers();

    for(i = 0; i < players.size; i++) {
      if(isalive(players[i])) {
        players[i] playlocalsound(level.zmb_laugh_alias);
      }
    }
  }

  if(isDefined(level.var_3da1a113)) {
    playFXOnTag(level.var_3da1a113, e_grenade.mdl_monkey, "tag_origin");
  }

  e_grenade.mdl_monkey movez(60, 1, 0.25, 0.25);
  e_grenade.mdl_monkey vibrate(direction, 1.5, 2.5, 1);
  e_grenade.mdl_monkey waittill(#"movedone");
  e_grenade.mdl_monkey delete();

  if(isDefined(e_actor)) {
    e_actor delete();
  }

  if(isDefined(e_grenade)) {
    if(isDefined(e_grenade.damagearea)) {
      e_grenade.damagearea delete();
    }

    e_grenade delete();
  }
}