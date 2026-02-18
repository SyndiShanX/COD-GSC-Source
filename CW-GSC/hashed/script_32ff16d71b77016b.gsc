/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_32ff16d71b77016b.gsc
***********************************************/

#using scripts\core_common\animation_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\damagefeedback_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\name_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\util_shared;
#using scripts\cp_common\friendlyfire;
#using scripts\cp_common\util;
#namespace namespace_4e75a347;

function event_handler[event_7d801d3e] function_2f02dc73(eventstruct) {
  function_3475cd5c();
  assert(isDefined(level.var_279714e8), "<dev string:x38>");
  self[[level.var_279714e8]](eventstruct.entity);
}

function private function_3475cd5c() {
  if(!isDefined(level.var_279714e8)) {
    if(!isDefined(level.var_279714e8)) {
      level.var_279714e8 = &function_86d89f13;
    }
  }
}

function function_86d89f13(spawner) {
  self.drone = spawnStruct();
  self.script_allowdeath = spawner.script_allowdeath;
  self.script_friendly_fire_disable = spawner.script_friendly_fire_disable;
  self.script_moveoverride = spawner.script_moveoverride;
  self.drone.skipdeathanim = spawner.skipdeathanim;
  self.drone.var_155ac8ec = spawner.dronerunoffset;
  self.drone.demeanor = isDefined(spawner.script_demeanor) ? spawner.script_demeanor : "COMBAT";
  self.drone.var_44b606c4 = isDefined(spawner.var_c64ce08) ? spawner.var_c64ce08 : 0;
  self.var_c2c86d65 = spawner.var_e1b853e3;
  self.script_moveplaybackrate = isDefined(spawner.script_moveplaybackrate) ? spawner.script_moveplaybackrate : 1;
  self.drone.aitype = spawner.aitype;
  self setCanDamage(1);
  self.health = 1;
  self.maxhealth = 1;

  if(isDefined(self.script_moveplaybackrate)) {
    self.drone.moveplaybackrate = self.script_moveplaybackrate;
  } else {
    self.drone.moveplaybackrate = 1;
  }

  function_8adcfb4f(self.drone.aitype);
  self thread function_beea5074();

  if(!isDefined(self.drone.var_6f219852)) {
    self.drone.var_6f219852 = 100;
  }

  function_8069a99d();
}

function private function_8069a99d() {
  if(isDefined(self.target)) {
    if(isDefined(self.script_moveoverride)) {
      self thread function_35f3d336();
    } else {
      self thread function_54f05251();
    }

    return;
  }

  self thread drone_idle();
}

function private function_8adcfb4f(aitype) {
  if(isDefined(aitype)) {
    primaryweapons = function_401e2eeb(aitype);

    if(primaryweapons.size > 0) {
      var_8df2011a = primaryweapons[randomintrange(0, primaryweapons.size)];
      var_8df2011a = function_eefa18e(var_8df2011a);
      randomweapon = getweapon(var_8df2011a);

      if(isDefined(randomweapon) && randomweapon.name != "none") {
        self.weapon = randomweapon;
      }
    }
  }

  if(!isDefined(self.weapon)) {
    if(self.team != "neutral") {
      self.weapon = getweapon(#"ar_accurate_t9");
    }
  }

  if(isDefined(self.weapon)) {
    self animation::attach_weapon(self.weapon);
    self.drone.weaponfx = "weapon/fx8_muz_ar_acc_3p";

    if(isDefined(self.weapon.firesound) && self.weapon.firesound != "") {
      self.drone.weaponsound = self.weapon.firesound;
      return;
    }

    self.drone.weaponsound = self.weapon.firesounddistant;
  }
}

function private function_eefa18e(str) {
  if(strendswith(str, "_cp") || strendswith(str, "_zm") || strendswith(str, "_mp")) {
    return getsubstr(str, 0, str.size - 3);
  }

  return str;
}

function private function_beea5074() {
  self endon(#"entitydeleted");
  results = self waittill(#"damage");
  eattacker = results.attacker;
  einflictor = results.inflictor;
  idamage = results.amount;
  smeansofdeath = results.mod;
  shitloc = results.part_name;
  weapon = results.weapon;

  if(!isDefined(self)) {
    return;
  }

  same_team = isDefined(eattacker) && (self.team === eattacker.team || util::function_9b7092ef(self.team, eattacker.team));
  var_24c578bc = !isDefined(self.script_allowdeath) || self.script_allowdeath;

  if(same_team || !var_24c578bc) {
    self.health = self.maxhealth;

    if(same_team) {
      self thread function_beea5074();
      return;
    }
  }

  if(isDefined(eattacker) && eattacker != self) {
    if(!isDefined(einflictor) || !isai(einflictor) || isvehicle(einflictor) && einflictor getseatoccupant(0) === eattacker) {
      if(idamage > 0 && !same_team && self.team != # "neutral" && shitloc !== "riotshield") {
        fatal = var_24c578bc && self.health <= 0;
        eattacker thread damagefeedback::update(smeansofdeath, einflictor, undefined, weapon, self, undefined, shitloc, fatal);
      }
    }
  }

  if(!var_24c578bc) {
    self thread function_beea5074();
    return;
  }

  if(!isDefined(self.script_friendly_fire_disable)) {
    self thread friendlyfire::function_1ad87afd(self, idamage, eattacker, smeansofdeath, undefined, einflictor);
  }

  s_params = {
    #eattacker: eattacker, #einflictor: einflictor, #idamage: idamage, #smeansofdeath: smeansofdeath, #shitloc: shitloc, #weapon: weapon
  };
  kill_drone(s_params);
}

function kill_drone(s_params) {
  if(!isDefined(self) || is_true(self.drone.isdead)) {
    return;
  }

  playdeathanim = 1;

  if(isDefined(self.drone.skipdeathanim)) {
    playdeathanim = 0;
  } else if(isDefined(self.drone.deathanim)) {
    deathanim = self.drone.deathanim;
  } else {
    playdeathanim = 0;
  }

  if(self.health > 0) {
    self.health = 0;
  }

  self.drone.isdead = 1;
  self notify(#"death");

  if(playdeathanim && isDefined(self.drone.noragdoll)) {
    self play_anim(deathanim);
  } else if(!playdeathanim) {
    self function_19f971bb();
  } else {
    self play_anim(deathanim);
    self function_19f971bb();
  }

  if(isDefined(self)) {
    self notsolid();

    if(!isDefined(self.drone.nocorpsedelete)) {
      self thread function_e7956bb6();
    }

    if(isDefined(level.var_9c483e1)) {
      self[[level.var_9c483e1]](s_params);
    }
  }
}

function private function_e7956bb6() {
  self endon(#"entitydeleted");
  wait 5;
  self.drone.var_9e843395 = 0;
  allplayers = function_58385b58();

  while(isDefined(self)) {
    wait 5;

    if(!function_bfc92d86(self)) {
      self delete();
    }
  }
}

function private function_bfc92d86(drone) {
  allplayers = function_58385b58();

  foreach(player in allplayers) {
    if(util::within_fov(player getplayercamerapos(), player getplayerangles(), drone.origin, 0.5)) {
      return true;
    }
  }

  return false;
}

function private function_19f971bb() {
  self moveto(self.origin, 0.05);
  self rotateto(self.angles, 0.05);
  wait 0.1;
  var_361f5589 = getfakeaiarray();
  var_9789086c = 54;
  var_6076a7b7 = 10;
  var_d5f6126 = [];
  var_c2b552df = [];
  var_b6cd5ad8 = [];

  foreach(drone in var_361f5589) {
    if(drone != self && !isalive(drone)) {
      var_d5f6126[var_d5f6126.size] = drone;

      if(is_true(drone.drone.var_9e843395)) {
        var_b6cd5ad8[var_b6cd5ad8.size] = drone;
      }

      var_c2b552df[var_c2b552df.size] = drone;
    }
  }

  var_96d24dec = var_b6cd5ad8.size >= var_6076a7b7;

  if(var_96d24dec || var_c2b552df.size >= var_9789086c) {
    if(var_96d24dec) {
      var_d5f6126 = var_b6cd5ad8;
    } else {
      var_d5f6126 = var_c2b552df;
    }

    var_edd53fe8 = [];

    foreach(drone in var_d5f6126) {
      if(!function_bfc92d86(drone)) {
        var_edd53fe8[var_edd53fe8.size] = drone;
      }
    }

    if(var_edd53fe8.size > 0) {
      var_93b03e74 = var_edd53fe8;
    } else {
      var_93b03e74 = var_d5f6126;
    }

    var_f7055e = arraysort(var_93b03e74, level.players[0].origin, 0);
    var_570aa734 = var_f7055e[0];
    var_570aa734 delete();
  }

  if(isDefined(self)) {
    self startragdoll();
    self.drone.var_9e843395 = 1;
  }
}

function function_cab4b520(demeanor = "COMBAT") {
  self.drone.demeanor = demeanor;
  self.drone.var_fe46433f = [];

  if(isDefined(self.drone.var_544c8017)) {
    self.drone.var_e1c463c8 = 1;
  }
}

function private function_44dd1cfb(var_ceb8c425, var_e325076f) {
  hasanim = 0;

  if(!isDefined(self.drone.var_fe46433f[var_ceb8c425][var_e325076f])) {
    self.drone.var_fe46433f[var_ceb8c425][var_e325076f] = self function_99406724("drone@drone", "_animation_alias", "_cover_type", var_ceb8c425, "_drone_state", var_e325076f, "_human_demeanor", self.drone.demeanor);
  }

  if(self.drone.var_fe46433f[var_ceb8c425][var_e325076f].size > 0) {
    hasanim = 1;
  }

  return hasanim;
}

function private function_f2582c66(var_ceb8c425, var_e325076f) {
  if(self function_44dd1cfb(var_ceb8c425, var_e325076f)) {
    randomindex = randomintrange(0, self.drone.var_fe46433f[var_ceb8c425][var_e325076f].size);
    var_302d3447 = self.drone.var_fe46433f[var_ceb8c425][var_e325076f][randomindex];
    return var_302d3447;
  }
}

function private play_anim(droneanim, rate, mode) {
  self notify(#"stop_idle");
  play_single_anim(droneanim, rate, mode);
}

function private function_98f16d76(droneanim, rate, mode) {
  play_single_anim(droneanim, rate, mode);
}

function private play_single_anim(droneanim, rate = 1, mode = "server script") {
  animorigin = self.origin;
  animangles = self.angles;

  if(isDefined(self.node)) {
    animorigin = self.node[# "origin"];
    self.origin = animorigin;
  }

  self thread animation::play(droneanim, animorigin, animangles, rate, 0.2, 0.2, 0, 0, 0, 0, undefined, 0, mode);
}

function drone_idle(stance) {
  self notify(#"stop_idle");
  self endon(#"stop_idle", #"death", #"entitydeleted");

  if(!isDefined(stance)) {
    stance = "cover_exposed";
  }

  if(isDefined(self.idleanim) || self function_44dd1cfb(stance, "IDLE")) {
    while(isDefined(self)) {
      self stopanimscripted();

      if(isDefined(self.idleanim)) {
        idleanim = self.idleanim;
      } else {
        randomindex = randomintrange(0, self.drone.var_fe46433f[stance][# "idle"].size);
        idleanim = self.drone.var_fe46433f[stance][# "idle"][randomindex];
      }

      self thread function_98f16d76(idleanim);
      var_447218d2 = getanimlength(idleanim);
      wait var_447218d2 - 0.2;
    }
  }
}

function private function_eaea34d2(lastnode) {
  self.drone.var_544c8017 = undefined;
  self.node = lastnode;
  self notify(#"hash_276eb2b6c51bf236");

  if(isDefined(lastnode) && isDefined(lastnode[# "script_noteworthy"]) && lastnode[# "script_noteworthy"] != "idle") {
    if(!self check_delete(lastnode[# "script_noteworthy"])) {
      self thread drone_fight(lastnode[# "script_noteworthy"]);
    }

    return;
  }

  if(isDefined(lastnode) && isDefined(lastnode[# "script_noteworthy"]) && lastnode[# "script_noteworthy"] != "idle") {
    stance = function_4e864a71("", lastnode[# "script_noteworthy"]);
  } else {
    stance = function_4e864a71();
  }

  self thread drone_idle(stance);
}

function drone_fight(stance) {
  self endon(#"death", #"entitydeleted", #"hash_1b1ebb63b6197fd7");
  self.drone.stance = stance;
  self thread drone_idle(stance);
  wait 0.3;

  while(isDefined(self)) {
    var_73e5bfb2 = 0;
    var_87aec447 = 100;

    if(math::cointoss()) {
      var_c10115e8 = 0;

      if(var_87aec447 > randomint(100)) {
        var_c10115e8 = 1;

        if(self function_44dd1cfb(stance, "IDLE_TO_ATTACK")) {
          animation = self function_f2582c66(stance, "IDLE_TO_ATTACK");
          self play_anim(animation);
          waittime = getanimlength(animation) - 0.1;
          wait waittime;
        } else {
          var_73e5bfb2 = 0.5;
        }
      }

      if(self function_44dd1cfb(stance, "ATTACK")) {
        if(var_c10115e8) {
          animation = self function_f2582c66(stance, "ATTACK");
          self thread play_anim(animation);
          wait 0.1;
        }

        if(var_73e5bfb2 > 0) {
          wait var_73e5bfb2;
          var_73e5bfb2 = 0;
        }

        self drone_fire_randomly();
      }

      wait 0.5;

      if(var_c10115e8) {
        if(self function_44dd1cfb(stance, "ATTACK_TO_IDLE")) {
          animation = self function_f2582c66(stance, "ATTACK_TO_IDLE");
          self play_anim(animation);
          waittime = getanimlength(animation) - 0.1;
          wait waittime;
        } else {
          wait 0.5;
        }
      }

      self thread drone_idle(stance);
      wait 0.3;

      if(self function_44dd1cfb(stance, "RELOAD") && math::cointoss()) {
        animation = self function_f2582c66(stance, "RELOAD");
        self play_anim(animation);
        waittime = getanimlength(animation) - 0.1;
        wait waittime;
      }

      wait 1;
      continue;
    }

    wait 1;
  }
}

function private drone_fire_randomly() {
  self endon(#"death", #"entitydeleted");

  if(math::cointoss()) {
    self drone_shoot();
    wait 0.1;
    self drone_shoot();
    wait 0.1;
    self drone_shoot();

    if(math::cointoss()) {
      wait 0.1;
      self drone_shoot();
    }

    if(math::cointoss()) {
      wait 0.1;
      self drone_shoot();
      wait 0.1;
      self drone_shoot();
      wait 0.1;
    }

    if(math::cointoss()) {
      wait randomfloatrange(1, 2);
    }

    return;
  }

  self drone_shoot();
  wait randomfloatrange(0.25, 0.75);
  self drone_shoot();
  wait randomfloatrange(0.15, 0.75);
  self drone_shoot();
  wait randomfloatrange(0.15, 0.75);
  self drone_shoot();
  wait randomfloatrange(0.15, 0.75);
}

function private drone_shoot() {
  self notify(#"firing");
  self endon(#"death", #"entitydeleted", #"firing");
  drone_shoot_fx();

  if(is_true(self.drone.var_44b606c4)) {
    self thread function_d3d685b8();
  }

  fireanim = self function_f2582c66(self.drone.stance, "ATTACK");
  self thread animation::play(fireanim, self.origin, self.angles, 1, 1, 0.2);
  util::delay(0.25, undefined, &clearanim, fireanim, 0);
}

function private drone_shoot_fx() {
  playFXOnTag(self.drone.weaponfx, self, "tag_flash");
  self thread drone_play_weapon_sound(self.drone.weaponsound);
}

function private drone_play_weapon_sound(weaponsound) {
  if(isDefined(weaponsound) && soundexists(weaponsound)) {
    self playSound(weaponsound);
  }
}

function private function_d3d685b8() {
  startpos = self gettagorigin("tag_flash");
  angles = self gettagangles("tag_flash");
  forward = anglesToForward(angles);
  endpos = startpos + vectorscale(forward, 1000);
  startpos += vectorscale(forward, 10);
  magicbullet(self.weapon, startpos, endpos, self);
}

function private function_35f3d336() {
  self endon(#"death", #"entitydeleted");
  self waittill(#"move");
  self thread function_54f05251();
}

function private get_anim_data(runanim) {
  run_speed = 170;
  anim_relative = 1;
  anim_time = getanimlength(runanim);
  anim_delta = getmovedelta(runanim, 0, 1);
  anim_dist = length(anim_delta);

  if(anim_time > 0 && anim_dist > 0) {
    run_speed = anim_dist / anim_time;
    anim_relative = 0;
  }

  struct = spawnStruct();
  struct.anim_relative = anim_relative;
  struct.run_speed = run_speed;
  struct.anim_time = anim_time;
  return struct;
}

function function_f89df05b() {
  runanim = self function_f2582c66("cover_exposed", "RUN");
  var_6fc8022e = get_anim_data(runanim);

  if(!is_true(self.var_c2c86d65)) {
    self.drone.run_speed = var_6fc8022e.run_speed;
  }

  self thread play_anim(runanim, self.drone.moveplaybackrate, "mover");
}

function private function_54f05251() {
  self endon(#"death", #"entitydeleted");
  self.node = undefined;
  wait 0.05;
  path = self function_7bce6b25(self.target, self.origin);
  assert(isDefined(path));
  assert(isDefined(path[0]));
  function_f89df05b();
  path_index = 0;
  var_38c05d54 = 0;

  if(isDefined(path[path.size - 1][# "dist"]) && path[path.size - 1][# "dist"] > 0) {
    var_38c05d54 = 1;
  }

  var_23273fef = 0;
  self.drone.var_544c8017 = path[path_index][# "origin"];

  while(path_index < path.size) {
    assert(isDefined(path[path_index]));
    assert(isDefined(path[path_index][# "dist"]));
    destination = path[path_index][# "origin"];

    if(self.drone.var_6f219852 > 0) {
      var_792c52e4 = self.origin;

      for(var_946a08d6 = self.drone.var_6f219852; var_946a08d6 > 0 && path_index < path.size; var_946a08d6 = 0) {
        destination = path[path_index][# "origin"];
        distance = distance2d(destination, var_792c52e4);

        if(distance <= var_946a08d6) {
          var_792c52e4 = destination;
          var_946a08d6 -= distance;
          path_index++;

          if(path_index >= path.size) {
            if(var_38c05d54) {
              path_index = 0;
            } else {
              var_23273fef = 1;
            }
          }

          continue;
        }

        direction = vectornormalize(destination - var_792c52e4);
        destination = var_792c52e4 + direction * var_946a08d6;
      }

      distance = distance2d(destination, self.origin);
    } else {
      distance = distance2d(destination, self.origin);
      path_index++;

      if(path_index >= path.size) {
        if(var_38c05d54) {
          path_index = 0;
        } else {
          var_23273fef = 1;
        }
      }
    }

    var_d7e06ec6 = distance / self.drone.run_speed * self.drone.moveplaybackrate;
    self.drone.var_544c8017 = destination;

    if(var_23273fef) {
      self thread function_35b3aa66((0, path[path.size - 1][# "angles"][1], 0), min(var_d7e06ec6, 0.25), var_d7e06ec6 - 0.35);
    } else {
      var_df8541a5 = vectortoangles(destination - self.origin);
      self rotateto((0, var_df8541a5[1], 0), min(0.5, var_d7e06ec6));
    }

    self moveto(destination, var_d7e06ec6);
    wait var_d7e06ec6;

    if(isDefined(path[path_index][# "notify"])) {
      self notify(path[path_index][# "notify"]);
      level notify(path[path_index][# "notify"]);
    }

    if(is_true(self.drone.var_e1c463c8)) {
      self.drone.var_e1c463c8 = 0;
      self thread drone_idle();
      wait 0.2;
      function_f89df05b();
    }
  }

  self thread function_eaea34d2(path[path.size - 1]);
}

function private function_35b3aa66(angle, duration, delay) {
  self endon(#"death", #"entitydeleted");

  if(delay > 0) {
    wait delay;
  }

  self rotateto(angle, duration);
}

function private function_7bce6b25(var_3d70749c, var_a3375299) {
  assert(isDefined(var_3d70749c));
  assert(isDefined(var_a3375299));
  hasnextnode = 0;
  index = 0;
  nodes = [];
  var_62e82494 = [];
  currentnode = spawner::get_goal(var_3d70749c);

  if(isDefined(currentnode)) {
    hasnextnode = 1;
  }

  while(hasnextnode) {
    hasnextnode = 0;
    nodes[index][# "origin"] = function_a7879d43(currentnode);
    nodes[index][# "dist"] = 0;
    nodes[index][# "angles"] = currentnode.angles;

    if(isDefined(currentnode.script_notify)) {
      nodes[index][# "notify"] = currentnode.script_notify;
    }

    var_62e82494[currentnode.targetname] = index;

    if(isDefined(currentnode.target)) {
      if(isDefined(var_62e82494[currentnode.target])) {
        nextnodeindex = var_62e82494[currentnode.target];
        nextnode = nodes[nextnodeindex];
        nodes[index][# "dist"] = distance(currentnode.origin, nextnode[# "origin"]);
      } else {
        nextnode = spawner::get_goal(currentnode.target);

        if(isDefined(nextnode)) {
          nodes[index][# "dist"] = distance(currentnode.origin, nextnode.origin);
          currentnode = nextnode;
          hasnextnode = 1;
          index++;
        }
      }

      continue;
    }

    nodes[index][# "script_noteworthy"] = function_4e864a71(currentnode.type, currentnode.script_noteworthy);
  }

  return nodes;
}

function private function_4e864a71(nodetype, noteworthy) {
  result = noteworthy;

  if(!isDefined(noteworthy)) {
    result = "cover_exposed";

    if(nodetype === "Cover Right") {
      result = "cover_right";
    } else if(nodetype === "Cover Left") {
      result = "cover_left";
    } else if(nodetype === "Cover Pillar") {
      result = "cover_pillar";
    } else if(nodetype === "Cover Crouch" || nodetype === "Cover Crouch Window") {
      result = "cover_crouch";
    } else if(nodetype === "Cover Prone") {
      result = "cover_exposed";
    }
  }

  return result;
}

function private function_a7879d43(node) {
  adjustedorigin = node.origin;

  if(isDefined(node.radius) && node.radius > 0) {
    if(!isDefined(self.drone.var_155ac8ec)) {
      self.drone.var_155ac8ec = -1 + randomfloat(2);
    }

    if(!isDefined(node.angles)) {
      node.angles = (0, 0, 0);
    }

    forwardvec = anglesToForward(node.angles);
    rightvec = anglestoright(node.angles);
    upvec = anglestoup(node.angles);
    relativeoffset = (0, self.drone.var_155ac8ec * node.radius, 0);
    adjustedorigin += forwardvec * relativeoffset[0];
    adjustedorigin += rightvec * relativeoffset[1];
    adjustedorigin += upvec * relativeoffset[2];
  }

  return adjustedorigin;
}

function private check_delete(script_noteworthy) {
  if(!isDefined(self)) {
    return true;
  }

  if(!isDefined(script_noteworthy)) {
    return true;
  }

  if(script_noteworthy == "delete_on_goal") {
    self delete();
    return true;
  } else if(script_noteworthy == "die_on_goal") {
    self kill_drone();
    return true;
  }

  return false;
}