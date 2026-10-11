/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_155dfa0cc34a5062.gsc
*************************************************/

#using script_155dfa0cc34a5062;
#using script_1e172edbfbe283b6;
#using script_4dac3680f88a01c3;
#using script_6202afd5acdbf2da;
#using scripts\anim\dialogue;
#using scripts\anim\notetracks_sp;
#using scripts\anim\shared;
#using scripts\common\ai;
#using scripts\common\ai_lookat;
#using scripts\common\anim;
#using scripts\common\scene;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\engine\sp\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\sp\anim;
#using scripts\sp\friendlyfire;
#using scripts\sp\hud_util;
#using scripts\sp\maps\sp_jup_hijack\sp_jup_hijack_lighting;
#using scripts\sp\player;
#using scripts\sp\utility;
#using scripts\stealth\threat_sight;
#using scripts\stealth\utility;
#namespace namespace_1372601db13b5bbc;

function function_ebad7db0ae66fe42() {}

function function_9b348eda8aba43ce(struct_name, var_96d11d0d148248f4) {
  level.player setstance("stand");
  current_struct = getStruct(struct_name, "targetname");

  if(!isDefined(current_struct.angles)) {
    current_struct.angles = (0, 0, 0);
  }

  var_e0e9bcc402a552d4 = (0, 0, -60);
  cam = spawn("script_origin", current_struct.origin + var_e0e9bcc402a552d4);
  cam.angles = current_struct.angles;
  level.player playerlinkTo(cam, undefined, 0, 0, 0, 0, 0, 0);

  if(istrue(var_96d11d0d148248f4)) {
    level.player playerlinktoblend(cam, undefined, 2);
  }

  while(true) {
    wait_time = float(current_struct.script_noteworthy);

    if(isDefined(wait_time)) {
      wait wait_time;
    }

    if(!isDefined(current_struct.target)) {
      break;
    }

    next_struct = getStruct(current_struct.target, "targetname");

    if(!isDefined(next_struct)) {
      break;
    }

    if(!isDefined(next_struct.angles)) {
      next_struct.angles = (0, 0, 0);
    }

    travel_time = float(current_struct.script_parameters);

    if(!isDefined(travel_time) || is_equal(travel_time, 0)) {
      cam dontinterpolate();
      cam.origin = next_struct.origin + var_e0e9bcc402a552d4;
      cam.angles = next_struct.angles;
    } else {
      cam moveTo(next_struct.origin + var_e0e9bcc402a552d4, travel_time);
      cam rotateTo(next_struct.angles, travel_time);
      wait travel_time;
    }

    current_struct = next_struct;
  }

  level.player unlink();
  cam delete();
}

function function_3890eaf25f4d31ce(struct_name, var_96d11d0d148248f4, endon_flag) {
  level.player setstance("stand");
  current_struct = getStruct(struct_name, "targetname");

  if(!isDefined(current_struct)) {
    return;
  }

  var_e0e9bcc402a552d4 = (0, 0, -60);
  cam = spawn_tag_origin(current_struct.origin + var_e0e9bcc402a552d4, current_struct.angles);
  level.player playerlinkTo(cam, "tag_origin", 1, 60, 60, 50, 50, 0);

  if(istrue(var_96d11d0d148248f4)) {
    level.player playerlinktoblend(cam, undefined, 2);
    wait 2;
    level.player playerlinkTo(cam, "tag_origin", 1, 60, 60, 50, 50, 0);
  }

  if(isDefined(endon_flag)) {
    flag_wait(endon_flag);
  }

  level.player unlink();
  cam delete();
}

function function_112eb3afa848aa64(struct_name, time) {
  if(!isDefined(time)) {
    time = 2;
  }

  start_time = gettime();
  player_forward = anglesToForward(level.player getplayerangles());
  var_c27840c1f8beff05 = level.player getEye() + player_forward * 30;
  org = spawn("script_origin", var_c27840c1f8beff05);
  struct = function_7a18da6e48b71c35(struct_name);
  org moveTo(struct.origin, time);
  level.player freezecontrols(1);

  while(true) {
    if(gettime() > start_time + time * 1000) {
      break;
    }

    level.player setplayerangles(vectortoangles(org.origin - level.player getEye()));
    waitframe();
  }

  level.player freezecontrols(0);
  org delete();
}

function function_6f3fabd396506d70(pos, var_257b516e62ea1d2b, dur, max_dist, endon_flag) {
  line_limit = 40;
  var_bf8e408018c36808 = [];
  var_642668232f8b999d = var_257b516e62ea1d2b;

  while(var_642668232f8b999d.size > 0) {
    new_line = getsubstr(var_642668232f8b999d, 0, line_limit);

    if(var_642668232f8b999d.size > line_limit) {
      var_642668232f8b999d = getsubstr(var_642668232f8b999d, line_limit, var_642668232f8b999d.size);

      while(!is_equal(new_line[new_line.size - 1], " ")) {
        var_642668232f8b999d = new_line[new_line.size - 1] + var_642668232f8b999d;
        new_line = getsubstr(new_line, 0, new_line.size - 1);
      }
    } else {
      var_642668232f8b999d = "";
    }

    var_bf8e408018c36808[var_bf8e408018c36808.size] = new_line;
  }

  while(true) {
    waitframe();

    if(isDefined(endon_flag) && flag(endon_flag)) {
      break;
    }

    if(isDefined(max_dist)) {
      if(!isDefined(level.player)) {
        continue;
      }

      dist_from_player = distance(level.player.origin, pos);

      if(dist_from_player > max_dist) {
        continue;
      }
    }

    for(i = 0; i < var_bf8e408018c36808.size; i++) {
      var_b836d672dc79ed93 = (0, 0, -2 * i);

      print3d(pos + var_b836d672dc79ed93, var_bf8e408018c36808[i], (1, 1, 1), 1, 0.1, 1, 1);
    }
  }
}

function function_37d4e1a89bef5c44(struct_names, toggle_on) {
  endon_flag = "flag_world_text_disable_" + struct_names;

  if(istrue(toggle_on)) {
    text_array = getStructArray(struct_names, "targetname");

    foreach(text in text_array) {
      thread function_6f3fabd396506d70(text.origin, text.script_noteworthy, 1, 100, endon_flag);
    }

    return;
  }

  flag_set(endon_flag);
}

function function_fa35b59a26e5cc66(str_name) {
  model_array = function_60ff77d168418390(str_name);
  return model_array[0];
}

function function_60ff77d168418390(str_name) {
  model_structs = getStructArray(str_name, "targetname");
  model_array = [];

  foreach(struct in model_structs) {
    model_obj = spawn("script_model", struct.origin);

    if(!isDefined(struct.angles)) {
      struct.angles = (0, 0, 0);
    }

    model_obj.struct = struct;
    model_obj.angles = struct.angles;
    model_obj setModel(struct.script_noteworthy);

    if(isDefined(struct.target)) {
      model_obj.target = struct.target;
    }

    if(isDefined(struct.script_parameters)) {
      head_obj = spawn("script_model", (0, 0, 0));
      head_obj setModel(struct.script_parameters);
      head_obj linkTo(model_obj, "j_spine4", (0, 0, 0), (0, 0, 0));
      model_obj.headmodel = head_obj;

      if(is_equal(struct.script_parameters, "head_hero_price_nohat_lod")) {
        model_obj.hatmodel = "hat_hero_price_undercover_beanie";
        model_obj attach(model_obj.hatmodel);
      }
    }

    model_array[model_array.size] = model_obj;
  }

  return model_array;
}

function function_2778ccf84f201fd(time, next_pos) {
  if(isDefined(self.current_pos) && !isDefined(next_pos)) {
    if(!isDefined(self.current_pos.target)) {
      return;
    }

    next_pos = getStruct(self.current_pos.target, "targetname");
  } else if(!isDefined(next_pos)) {
    next_pos = getStruct(self.target, "targetname");
  }

  self moveTo(next_pos.origin, time);

  if(!isDefined(next_pos.angles)) {
    next_pos.angles = (0, 0, 0);
  }

  self rotateTo(next_pos.angles, time);
  self.current_pos = next_pos;
  wait time;
}

function function_ada99e3722b4ce7(struct_goal) {
  next_pos = getStruct(struct_goal, "targetname");
  self.origin = next_pos.origin;
  self.angles = next_pos.angles;
  self.current_pos = next_pos;
}

function function_eed6250e31a849f0() {
  if(!isDefined(self)) {
    return;
  }

  if(!isarray(self)) {
    if(isDefined(self.headmodel)) {
      self.headmodel delete();
    }

    self delete();
    return;
  }

  foreach(item in self) {
    if(isDefined(item.headmodel)) {
      item.headmodel delete();
    }

    if(isDefined(item.hatmodel)) {
      item.hatmodel delete();
    }

    item delete();
  }
}

function print3d_on_ent(var_257b516e62ea1d2b) {
  self endon("death");
  self notify("print3d");
  self endon("print3d");
  randomoffset = randomintrange(20, 80);

  if(isai(self)) {
    offset = (0, 0, 60);
  } else {
    offset = (0, 0, 0);
  }

  while(true) {
    print3d(self.origin + (0, 0, randomoffset), var_257b516e62ea1d2b, (1, 1, 1), 1, 0.35, 1, 1);

    waitframe();
  }
}

function function_ccc9189861847214(origin, text, color, scale, ender) {
  if(isent(self)) {
    self endon("<dev string:x1c>");
  }

  if(isDefined(ender)) {
    if(isDefined(self)) {
      self endon(ender);
    } else {
      level endon(ender);
    }
  }

  while(true) {
    print3d(origin, text, color, 1, scale);
    waitframe();
  }
}

function function_9e08608ba165709c() {}

function turbulence(scale, duration, slow_scale) {
  var_8e93e1ba5054c701 = 0.075 * scale;
  level.player earthquakeforplayer(var_8e93e1ba5054c701, duration, level.player.origin, 10000);
  level.player playRumbleOnEntity("damage_light");
  thread function_ce27b151bd7ba930(slow_scale);
}

function function_30a8198b3c0f3b1(scale, duration) {
  var_8e93e1ba5054c701 = 0.075 * scale;
  earthquake(var_8e93e1ba5054c701, duration, level.player.origin, 800);
  level.player playRumbleOnEntity("damage_light");
  thread function_ce27b151bd7ba930();
}

function function_f398c9cf637d3e18(time, shader, scale) {
  if(!isDefined(time)) {
    time = 0.3;
  }

  overlay = scripts\sp\hud_util::get_optional_overlay(shader);

  if(time > 0) {
    overlay fadeovertime(time);
  }

  overlay.alpha = 0.12 * scale;

  if(time > 0) {
    wait time;
  }
}

function function_ce27b151bd7ba930(slow_scale) {
  movespeedscale = level.player.movespeedscale;

  if(!isDefined(slow_scale)) {
    slow_scale = 0.35;
  }

  level.player scripts\engine\sp\utility::blend_movespeedscale(slow_scale, 0.25);
  wait 0.25;

  if(!isDefined(movespeedscale)) {
    movespeedscale = 0.5;
  }

  level.player scripts\engine\sp\utility::blend_movespeedscale(movespeedscale, 3);
}

function function_7cbb2723d14c566b(scale, flag_string) {
  var_8e93e1ba5054c701 = scale * 0.075;
  level.earthquake_active = 0;

  while(!flag(flag_string)) {
    if(level.earthquake_active) {
      wait 1;
      continue;
    }

    wait_time = randomintrange(15, 30);
    values = [randomfloatrange(0.25, 0.5), randomfloatrange(0.25, 0.5), randomfloatrange(0.25, 0.5), randomfloatrange(0.5, 2), randomfloatrange(0.5, 2), randomfloatrange(0.5, 1.5)];
    screenshake(level.player.origin, values[0], values[1], values[2], wait_time, 0, 0, 0, values[3], values[4], values[5]);
    wait wait_time / 2;
  }

  thread function_ce27b151bd7ba930();
}

function function_a3c560b7e0a3f584() {
  flag_wait("flag_trigger_turbulence_1");
  wait 1;
  var_e7b764034781cf94 = 1;
  thread function_365c95a5050985c9();
  level.player thread scripts\sp\maps\sp_jup_hijack\sp_jup_hijack_lighting::function_872ab8327e05cf14();
  wait 4;
  thread function_365c95a5050985c9(0);
  level.player thread scripts\sp\maps\sp_jup_hijack\sp_jup_hijack_lighting::function_872ab8327e05cf14();
  wait 4;
  thread function_365c95a5050985c9(1);
  level.player thread scripts\sp\maps\sp_jup_hijack\sp_jup_hijack_lighting::function_872ab8327e05cf14();
  flag_wait("flag_trigger_turbulence_2");

  while(!flag("flag_standoff_end")) {
    var_81568d4ee1187346 = [undefined, 0, 1];
    thread function_365c95a5050985c9(random(var_81568d4ee1187346));
    level.player thread scripts\sp\maps\sp_jup_hijack\sp_jup_hijack_lighting::function_872ab8327e05cf14();
    rand = randomfloatrange(4, 5);
    wait rand;
  }

  thread function_782e986772ce6fdb();
  flag_wait("lgt_mak_para_door_open");
  scale = 3.5;
  duration = 16;
  thread turbulence(scale, duration);
  flag_set("flag_show_o2_masks");
}

function function_365c95a5050985c9(big_shake) {
  scale = 2.5;
  duration = 3;
  level.earthquake_active = 1;
  thread namespace_2f067fefb7259496::turbulence(big_shake);

  if(isDefined(big_shake) && big_shake) {
    scale = 3;
    duration = 4;
  } else if(isDefined(big_shake) && !big_shake) {
    scale = 1.5;
    duration = 2;
  }

  thread turbulence(scale, duration);
  wait duration;
  level.earthquake_active = 0;
}

function function_42ad86cbdd2d532c(big_shake) {
  scale = 2.5;
  duration = 3;
  level.earthquake_active = 1;
  thread namespace_2f067fefb7259496::function_e587439a27a5c001(big_shake);

  if(isDefined(big_shake) && big_shake) {
    scale = 3;
    duration = 4;
  } else if(isDefined(big_shake) && !big_shake) {
    scale = 1.5;
    duration = 2;
  }

  thread turbulence(scale, duration);
  wait duration;
  level.earthquake_active = 0;
}

function function_782e986772ce6fdb() {
  scale = 1.5;
  duration = 5;
  rand = randomfloatrange(10, 13);
  wait rand;

  while(!flag("lgt_mak_para_door_open")) {
    level.earthquake_active = 1;
    thread turbulence(scale, duration);
    thread namespace_2f067fefb7259496::function_c0f0d9a29d612e95();
    wait duration;
    level.earthquake_active = 0;
    rand = randomfloatrange(5, 10);
    wait rand;
  }

  flag_wait("flag_trigger_turbulence_3");
  wait 8;
  scale = 2;
  duration = 5;

  while(true) {
    rand = randomfloatrange(5, 10);
    wait rand;
    level.earthquake_active = 1;
    thread turbulence(scale, duration);
    wait duration;
    level.earthquake_active = 0;
  }
}

function function_4c3e170c701819f9() {}

function function_8ea1fb185586cc5a() {
  level.var_cfc29cd454498f9e = [];
  level.var_cfc29cd454498f9e["man"] = 0;
  level.var_cfc29cd454498f9e["woman"] = 0;
  level.var_cfc29cd454498f9e["adult"] = 0;
  level.civspawners = [];
  level.civspawners["adult_spawners"] = getspawnerarray("adult_spawner");
  level.civspawners["man_spawners"] = [];
  level.civspawners["woman_spawners"] = [];

  foreach(spawner in level.civspawners["adult_spawners"]) {
    if(spawner.script_noteworthy == "man") {
      level.civspawners["man_spawners"][level.civspawners["man_spawners"].size] = spawner;
      continue;
    }

    level.civspawners["woman_spawners"][level.civspawners["woman_spawners"].size] = spawner;
  }

  level.var_e471ce013e2cc820 = [];
  level.var_ffd93feee6d8259b = [];

  if(getdvarint(@ "hash_3dcc1c3d7415db25", 0)) {
    return;
  }

  var_cfe2e30acba4c67e = level_spawner("man");
  var_5d61c5dd97f0ad03 = level_spawner("woman");
  var_3337184997f609bc = getStructArray("passenger_seat_animnode", "targetname");
  var_1b3fc8ff798f0a08 = getdvarint(@ "hash_40215944f9aa5045", 0);

  foreach(animnode in var_3337184997f609bc) {
    if(!istrue(var_1b3fc8ff798f0a08) && is_equal(animnode.script_noteworthy, "high_density_passenger")) {
      continue;
    }

    if(level.start_point == "standoff_recording" && is_equal(animnode.script_parameters, "delete_for_bink")) {
      continue;
    }

    start_time = randomfloatrange(0.1, 1);
    gender = getDvar(@ "hash_2d48b458366c7f5d", "default");

    if(gender == "men") {
      civ = function_aa07d9f9a1f53ec0(animnode, "civ", var_cfe2e30acba4c67e, undefined, "male");
      animnode thread delaythread(start_time, &anim_loop_solo, civ, animnode.animation);
    } else if(gender == "women") {
      civ = function_aa07d9f9a1f53ec0(animnode, "civ", var_5d61c5dd97f0ad03, undefined, "female");
      animnode thread delaythread(start_time, &anim_loop_solo, civ, animnode.animation);
    } else if(isDefined(animnode.script_noteworthy) && animnode.script_noteworthy == "man") {
      civ = function_aa07d9f9a1f53ec0(animnode, "civ", var_cfe2e30acba4c67e, undefined, "male");
      animnode thread delaythread(start_time, &anim_loop_solo, civ, animnode.animation);
    } else if(isDefined(animnode.script_noteworthy) && animnode.script_noteworthy == "woman") {
      civ = function_aa07d9f9a1f53ec0(animnode, "civ", var_5d61c5dd97f0ad03, undefined, "female");
      animnode thread delaythread(start_time, &anim_loop_solo, civ, animnode.animation);
    } else if(utility::cointoss()) {
      civ = function_aa07d9f9a1f53ec0(animnode, "civ", var_cfe2e30acba4c67e, undefined, "man");
      animnode thread delaythread(start_time, &anim_loop_solo, civ, animnode.animation);
    } else {
      civ = function_aa07d9f9a1f53ec0(animnode, "civ", var_5d61c5dd97f0ad03, undefined, "female");
      animnode thread delaythread(start_time, &anim_loop_solo, civ, animnode.animation);
    }

    civ.animnode = animnode;
    civ.curstate = 0;
    civ.script_noteworthy = animnode.script_noteworthy;
    civ.script_linkname = animnode.script_linkname;
    civ.target = animnode.target;
    animnode.civ = civ;

    if(isDefined(animnode.script_offhands) && animnode.script_offhands.size > 0) {
      var_bcd0896585faba23 = strtok(animnode.script_offhands, ",");
      model = var_bcd0896585faba23[0];
      lefthanded = 0;

      if(var_bcd0896585faba23.size > 1 && (var_bcd0896585faba23[1] == " left" || string_starts_with(var_bcd0896585faba23[1], "left"))) {
        lefthanded = 1;
      }

      civ thread function_f46b574e6bde386d(model, lefthanded);
      level.var_ffd93feee6d8259b[level.var_ffd93feee6d8259b.size] = civ;
    }

    level.var_e471ce013e2cc820[level.var_e471ce013e2cc820.size] = civ;
    level.var_8fdfe8e04db3db1f = level.var_e471ce013e2cc820;
  }

  wait 2.1;

  foreach(civ in level.var_8fdfe8e04db3db1f) {
    if(isDefined(civ.animnode.script_linkto)) {
      civ.paired_partner = getStruct(civ.animnode.script_linkto, "script_linkname");
      civ thread function_384d78dd0b8f21da(civ.paired_partner);
      civ.paired_partner = civ.paired_partner.civ;
      civ.paired_partner.paired_child = 1;
    }
  }

  flag_wait("passenger_transition_to_alert");
  level notify("kill_idle_managers");
  level.player thread function_e3449985ee5fe6f2();

  foreach(civ in level.var_8fdfe8e04db3db1f) {
    if(istrue(civ.paired_child)) {
      continue;
    }

    if(isDefined(civ.animnode.target)) {
      continue;
    }

    civ thread transition_to_alert(0);
  }
}

function function_53bfad63cce70ff3() {
  var_fce7542d277a7a39 = getStructArray("passenger_dead_animnode", "targetname");

  foreach(animnode in var_fce7542d277a7a39) {
    if(isDefined(animnode.animation)) {
      animnode scene::play(undefined, animnode.animation, "jup_hij_dead_bodies_staging");
    }
  }
}

function function_f46b574e6bde386d(phone_model, left_hand) {
  self endon("death");

  if(!isDefined(self.var_48491c1dd7d0a33d)) {
    model = spawn("script_model", (0, 0, 0));
    model setModel(phone_model);

    if(left_hand) {
      model linkTo(self, "tag_accessory_left", (0, 0, 0), (-90, 0, 180));
    } else {
      model linkTo(self, "tag_accessory_right", (0, 0, 0), (-90, 0, 180));
    }

    self.var_48491c1dd7d0a33d = model;
  }
}

function transition_to_alert(instant) {
  civ = self;
  wait_time = randomfloatrange(0, 1);

  if(!istrue(instant)) {
    wait wait_time;
  }

  if(isDefined(civ.paired_partner)) {
    thread transitiontostate(civ.paired_partner, 2);
  }

  transitiontostate(civ, 2);

  if(!istrue(instant)) {
    wait 1;
  }

  civ thread function_cf1311a027d39d1b("futile_defuse_black_out", civ.paired_partner);
}

function function_7abafeddc8d99f46(angle) {
  return within_fov(level.player getEye(), level.player getplayerangles(), self.origin, cos(angle));
}

function function_5d60dc2181ca061d() {
  animnode = self.animnode;
  starting_anim = self.animnode.animation;
  return isDefined(function_fbd76024d6a47870(starting_anim, 7));
}

function function_5619f5c41494dc0a(paired_partner, state) {
  if(isDefined(paired_partner)) {
    paired_partner stopanimScripted();
    paired_partner.animnode notify("stop_loop");
    thread transitiontostate(paired_partner, state);
  }

  self stopanimScripted();
  self.animnode notify("stop_loop");
  transitiontostate(self, state);
}

function function_cf1311a027d39d1b(flag_endon, paired_partner) {
  self endon("death");
  in_panic = 0;
  true_panic = 0;

  while(!flag(flag_endon)) {
    distancefromplayer = distance(level.player.origin, self.origin);
    isaimedat = level.player isads() && function_7abafeddc8d99f46(45);

    if(level.var_35dc8163678b4227) {
      if(!in_panic) {
        in_panic = 1;

        if(function_5d60dc2181ca061d()) {
          function_5619f5c41494dc0a(paired_partner, 7);
        } else {
          function_5619f5c41494dc0a(paired_partner, 4);
        }

        while(level.var_35dc8163678b4227) {
          wait 1;
        }
      }
    } else if(distancefromplayer < 200 && isaimedat) {
      if(!in_panic) {
        function_5619f5c41494dc0a(paired_partner, 4);
        in_panic = 1;
        wait 2;
      }
    } else if(in_panic) {
      function_5619f5c41494dc0a(paired_partner, 5);
      in_panic = 0;
      true_panic = 0;
    }

    waitframe();
  }
}

function function_8a39e2a8a63ec1ac(impactpos) {
  bullet_start = self getEye();
  bullet_end = impactpos;
  wait 0.1;

  foreach(guy in level.var_8fdfe8e04db3db1f) {
    if(is_dead_or_dying(guy)) {
      level.var_8fdfe8e04db3db1f = array_remove(level.var_8fdfe8e04db3db1f, guy);
      continue;
    }

    foreach(deathpos in level.recent_deaths) {
      var_e2cea03548e8d846 = distance(deathpos, guy.origin);

      if(var_e2cea03548e8d846 < 100) {
        guy.var_3038ff91bd42a629 = 1;
        break;
      }
    }

    if(!istrue(guy.var_ed6a778872306a90)) {
      var_9dc1de17618492d7 = function_6765f46c2f6e7249(bullet_start, bullet_end, guy.origin);

      if(var_9dc1de17618492d7 < 100) {
        guy.var_e26752ded17f72ec = 1;
      }
    }
  }
}

function function_e3449985ee5fe6f2() {
  self endon("death");

  if(!isDefined(level.recent_deaths)) {
    level.recent_deaths = [];
  }

  while(true) {
    self waittill("bullet_first_impact", _, _, _, _, _, _, _, impactpos, _);
    function_8a39e2a8a63ec1ac(impactpos);
  }
}

function function_6765f46c2f6e7249(p1, p2, pq) {
  l2 = distancesquared(p1, p2);

  if(l2 == 0) {
    return distance(p1, pq);
  }

  t = clamp(vectordot(pq - p1, p2 - p1) / l2, 0, 1);
  projection = p1 + t * (p2 - p1);
  return distance(pq, projection);
}

function function_e2ee6f531da3872c() {
  anim.callbacks["DoAnimation"] = &function_aabfd2fc04931c29;
}

function function_aabfd2fc04931c29(org, angles, animname, anime, anim_string, idleanim, scripted_node_ent) {
  animlength = scripts\sp\anim::do_animation(org, angles, animname, anime, anim_string, idleanim, scripted_node_ent);

  if(isDefined(level.var_70a7354d67759191[animname]) && isDefined(level.var_70a7354d67759191[animname][anime])) {
    var_1c8d96beb843e7b1 = undefined;
    var_792db042affa13d = [];

    foreach(index, animentry in level.var_70a7354d67759191[animname][anime]) {
      if(index == 0) {
        var_1c8d96beb843e7b1 = animentry;
        continue;
      }

      var_792db042affa13d[index - 1] = animentry;
    }

    assertex(isDefined(var_1c8d96beb843e7b1), "Index 0 of level.hijack_tracking_nodes[" + anime + "] doesn't contain a valid anim node");
    assertex(isDefined(var_792db042affa13d[0]), "level.hijack_tracking_nodes[" + animname + "][" + anime + "] doesn't contain any anim leaf nodes at index 1 or higher");

    if(isDefined(var_1c8d96beb843e7b1) && isDefined(var_792db042affa13d[0])) {
      self thread[[level.tracking_callbacks[anime]]](anime, var_1c8d96beb843e7b1, var_792db042affa13d);
    }
  }

  return animlength;
}

function transitiontostate(civ, state) {
  animnode = civ.animnode;
  starting_anim = civ.animnode.animation;
  animnode notify("stop_loop");
  civ stopanimScripted();

  if(is_equal(state, 2)) {
    civ.curstate = 1;
    transition_anim = function_fbd76024d6a47870(starting_anim, 1);
    animnode anim_single_solo(civ, transition_anim);
  } else if(is_equal(state, 4)) {
    civ.curstate = 3;
    transition_anim = function_fbd76024d6a47870(starting_anim, 3);
    animnode anim_single_solo(civ, transition_anim);
  } else if(is_equal(state, 7)) {
    civ.curstate = 6;
    transition_anim = function_fbd76024d6a47870(starting_anim, 6);

    if(isDefined(transition_anim)) {
      animnode anim_single_solo(civ, transition_anim);
    }
  } else if(utility::is_equal(state, 5)) {
    civ.curstate = 5;
    transition_anim = function_fbd76024d6a47870(starting_anim, 5);

    if(isDefined(transition_anim)) {
      animnode anim_single_solo(civ, transition_anim);
    }

    state = 2;
  }

  state_anim = function_fbd76024d6a47870(starting_anim, state);
  animnode thread anim_loop_solo(civ, state_anim);
  civ.curstate = state;
  waitframe();

  if(isai(civ) && isalive(civ)) {
    if(state <= 4) {
      civ enable_lookat();
      return;
    }

    civ stoplookat();
  }
}

function function_693d03525ad49ffc(targetentity) {
  function_602de23a88754761();
  level.tracking_targets = array_add(level.tracking_targets, targetentity);
}

function function_f9dcadb2db9f2781(targetentity) {
  function_602de23a88754761();
  level.tracking_targets = array_remove(level.tracking_targets, targetentity);
}

function function_733e573493a9ef16() {
  level.tracking_targets = undefined;
  function_602de23a88754761();
}

function function_25b67057c0f2b89b(targetarray) {
  closesttarget = targetarray[0];
  closestdistance = -1;

  foreach(target in targetarray) {
    if(isDefined(target)) {
      targetdistance = distancesquared(self.origin, target.origin);

      if(closestdistance < 0 || targetdistance < closestdistance) {
        closestdistance = targetdistance;
        closesttarget = target;
      }
    }
  }

  return closesttarget.origin;
}

function function_d41d018414fca105(targetarray) {
  if(!isDefined(level.var_fe2285eb3c953b79) || !isDefined(level.var_c459b6972f6c6380) || level.var_c459b6972f6c6380 <= 0) {
    assertmsg("Attempted to use get_closest_tracking_target_with_priority without setting level.tracking_priority_entity and/or level.tracking_priority_entity_radius ( with a value above 0 )");
    return level.player.origin;
  }

  var_4fe4da608dea7c5b = distancesquared(self.origin, level.var_fe2285eb3c953b79.origin);

  if(var_4fe4da608dea7c5b <= level.var_c459b6972f6c6380) {
    return level.var_fe2285eb3c953b79.origin;
  }

  return function_25b67057c0f2b89b(targetarray);
}

function function_c6f77bd43877c9c6(targetarray) {
  return level.player.origin;
}

function private function_602de23a88754761() {
  if(!isDefined(level.tracking_targets)) {
    level.tracking_targets = [];
    level.tracking_targets = array_add(level.tracking_targets, level.player);
  }
}

function private function_11461c82ae478f8a() {
  function_602de23a88754761();

  if(isDefined(self.var_87b3e310a36b0f7d)) {
    return self.var_87b3e310a36b0f7d.origin;
  }

  if(isDefined(self.var_47d42a0c7d19c938)) {
    return [[self.var_47d42a0c7d19c938]](level.tracking_targets);
  }

  if(isDefined(level.var_47d42a0c7d19c938)) {
    return [[level.var_47d42a0c7d19c938]](level.tracking_targets);
  }

  return level.player.origin;
}

function private function_d47d250d79b7975f(baseanim, var_1c8d96beb843e7b1, var_792db042affa13d) {
  function_aa40a6d42ee9dd39(baseanim, var_1c8d96beb843e7b1, var_792db042affa13d, 0);
}

function private function_e42447fbc054d453(baseanim, var_1c8d96beb843e7b1, var_792db042affa13d) {
  function_aa40a6d42ee9dd39(baseanim, var_1c8d96beb843e7b1, var_792db042affa13d, 360);
}

function private function_aa40a6d42ee9dd39(baseanim, var_1c8d96beb843e7b1, var_792db042affa13d, rotationoffset) {
  self.animnode endon("stop_loop");
  var_3057d921cdb189e8 = 0;
  var_aca99d6e23e8de95 = 0;
  var_4197014e580fc93c = gettime();
  var_71766f8f82b20561 = var_792db042affa13d[0];
  self setanimlimited(var_1c8d96beb843e7b1, 0);
  self setanimlimited(var_71766f8f82b20561, 1, 0, 0);

  if(!isDefined(self.var_f72317aa54b389c6)) {
    self.var_f72317aa54b389c6 = 0;
  }

  while(true) {
    dt = gettime() - var_4197014e580fc93c;
    var_d1ceb2434569f84e = dt / 1000;
    var_d94197c8ffe4e9bb = function_11461c82ae478f8a();
    var_1a9c293ad162288 = flat_origin(self.origin);
    var_965456bd5df29265 = flat_origin(var_d94197c8ffe4e9bb);
    dirtotarget = var_1a9c293ad162288 - var_965456bd5df29265;
    var_5189a13207464f7b = generateaxisanglesfromforwardvector(dirtotarget, (0, 0, 0));

    if(rotationoffset != 0) {
      angletotarget = rotationoffset - var_5189a13207464f7b[1];
    } else {
      angletotarget = var_5189a13207464f7b[1];
    }

    var_c1634c1b0c46570c = clamp(angletotarget, 15, 345);
    var_31625b97e5869e96 = (var_c1634c1b0c46570c - 15) / 330;
    angledifference = var_31625b97e5869e96 - self.var_f72317aa54b389c6;

    if(angledifference > 0.00277778 || angledifference < -0.00277778) {
      var_aca99d6e23e8de95 = self.var_f72317aa54b389c6 + angledifference * var_d1ceb2434569f84e * 0.6;
      self.var_f72317aa54b389c6 = var_aca99d6e23e8de95;
    }

    var_3057d921cdb189e8 += var_d1ceb2434569f84e * 0.25;
    var_3057d921cdb189e8 = clamp(var_3057d921cdb189e8, 0, 1);
    self setanimlimited(var_71766f8f82b20561, 1, 0, 0);
    self setanimlimited(var_1c8d96beb843e7b1, var_3057d921cdb189e8);
    self setanimtime(var_71766f8f82b20561, self.var_f72317aa54b389c6);
    var_4197014e580fc93c = gettime();
    waitframe();
  }
}

function function_fbd76024d6a47870(starting_anim, state) {
  if(!isDefined(level.var_a3ecd9469cde6f42)) {
    var_f509e1f67170bf4e = ["jup_hij_idle_01_civ_01", "jup_hij_idle_01_to_alert_01_civ_01", "jup_hij_alert_01_civ_01", "jup_hij_alert_to_recoil_right_civ01", "jup_hij_recoil_idle_right_civ01", "jup_hij_recoil_to_alert_right_civ01", "jup_hij_alert_01_to_panic_01_civ_01", "jup_hij_panic_01_civ_01"];
    var_f509e0f67170bd1b = ["jup_hij_idle_01_civ_02", "jup_hij_idle_01_to_alert_01_civ_02", "jup_hij_alert_01_civ_02", "jup_hij_alert_to_recoil_right_civ01", "jup_hij_recoil_idle_right_civ01", "jup_hij_recoil_to_alert_right_civ01", "jup_hij_alert_01_to_panic_01_civ_02", "jup_hij_panic_01_civ_02"];
    var_6320b1842f6bcfad = ["jup_hij_idle_02_civ01", "jup_hij_idle_to_alert_02_civ01", "jup_hij_alert_02_civ01", "jup_hij_alert_to_panic_02_civ01", "jup_hij_panic_02_civ01"];
    var_6320ae842f6bc914 = ["jup_hij_idle_02_civ02", "jup_hij_idle_to_alert_02_civ02", "jup_hij_alert_02_civ02", "jup_hij_alert_to_panic_02_civ02", "jup_hij_panic_02_civ02"];
    var_4475ff9173dcb3b4 = ["jup_hij_idle_03_handhold_civ_01", "jup_hij_idle_handhold_03_to_alert_03_civ_01", "jup_hij_alert_03_civ_01", "jup_hij_alert_03_to_panic_03_civ_01", "jup_hij_panic_03_civ_01"];
    var_4476029173dcba4d = ["jup_hij_idle_03_handhold_civ_02", "jup_hij_idle_handhold_03_to_alert_03_civ_02", "jup_hij_alert_03_civ_02", "jup_hij_alert_03_to_panic_03_civ_02", "jup_hij_panic_03_civ_02"];
    var_4476019173dcb81a = ["jup_hij_idle_03_civ_01", "jup_hij_idle_handhold_03_to_alert_03_civ_01", "jup_hij_alert_03_civ_01", "jup_hij_alert_03_to_panic_03_civ_01", "jup_hij_panic_03_civ_01"];
    var_4475fc9173dcad1b = ["jup_hij_idle_03_civ_02", "jup_hij_idle_handhold_03_to_alert_03_civ_02", "jup_hij_alert_03_civ_02", "jup_hij_alert_03_to_panic_03_civ_02", "jup_hij_panic_03_civ_02"];
    var_33da088527f0a68b = ["jup_hij_idle_04_civ_01", "jup_hij_idle_04_to_alert_04_civ_01", "jup_hij_alert_04_civ_01", "jup_hij_alert_04_to_panic_04_civ_01", "jup_hij_panic_04_civ_01"];
    var_33da098527f0a8be = ["jup_hij_idle_04_civ_02", "jup_hij_idle_04_to_alert_04_civ_02", "jup_hij_alert_04_civ_02", "jup_hij_alert_04_to_panic_04_civ_02", "jup_hij_panic_04_civ_02"];
    var_94f703d6bb8b14b2 = ["jup_hij_smartphone_02_idle_civ01", "jup_hij_smartphone_02_transition_civ01", "jup_hij_smartphone_02_recording_civ01", "jup_hij_alert_04_to_panic_04_civ_01", "jup_hij_panic_04_civ_01"];
    var_94f702d6bb8b127f = ["jup_hij_smartphone_02_idle_civ02", "jup_hij_smartphone_02_transition_civ02", "jup_hij_smartphone_02_recording_civ02", "jup_hij_smartphone_recording_to_recoil_civ01", "jup_hij_smartphone_recoil_idle_civ01", "jup_hij_smartphone_recoil_to_recording_civ01"];
    var_94f701d6bb8b104c = ["jup_hij_smartphone_02_idle_civ03", "jup_hij_smartphone_02_transition_civ03", "jup_hij_smartphone_02_recording_civ03", "jup_hij_smartphone_recording_to_recoil_civ01", "jup_hij_smartphone_recoil_idle_civ01", "jup_hij_smartphone_recoil_to_recording_civ01"];
    var_9b4121fcef1a94a1 = ["jup_hij_smartphone_03_idle_civ01", "jup_hij_smartphone_03_transition_civ01", "jup_hij_smartphone_03_record_civ01", "jup_hij_alert_04_to_panic_04_civ_02", "jup_hij_panic_04_civ_02"];
    var_9b411efcef1a8e08 = ["jup_hij_smartphone_03_idle_civ02", "jup_hij_smartphone_03_transition_civ02", "jup_hij_smartphone_03_record_civ02", "jup_hij_alert_04_to_panic_04_civ_02", "jup_hij_panic_04_civ_02"];
    var_9b411ffcef1a903b = ["jup_hij_smartphone_03_idle_civ03", "jup_hij_smartphone_03_transition_civ03", "jup_hij_smartphone_03_record_civ03", "jup_hij_alert_04_to_panic_04_civ_02", "jup_hij_panic_04_civ_02"];
    var_5f93f3e3d73dedc8 = ["jup_hij_smartphone_06_idle_civ01", "jup_hij_smartphone_06_transition_civ01", "jup_hij_smartphone_06_record_civ01", "jup_hij_alert_to_recoil_left_civ01", "jup_hij_recoil_left_idle_civ01", "jup_hij_recoil_to_alert_left_civ01"];
    var_5f93f6e3d73df461 = ["jup_hij_smartphone_06_idle_civ02", "jup_hij_smartphone_06_transition_civ02", "jup_hij_smartphone_06_record_civ02", "jup_hij_alert_to_recoil_left_civ01", "jup_hij_recoil_left_idle_civ01", "jup_hij_recoil_to_alert_left_civ01"];
    var_5f93f5e3d73df22e = ["jup_hij_smartphone_06_idle_civ03", "jup_hij_smartphone_06_transition_civ03", "jup_hij_smartphone_06_record_civ03", "jup_hij_alert_to_recoil_left_civ01", "jup_hij_recoil_left_idle_civ01", "jup_hij_recoil_to_alert_left_civ01"];
    var_bdfa74525c9c6b7f = ["jup_hij_smartphone_04_idle_civ01", "jup_hij_smartphone_04_transition_civ01", "jup_hij_smartphone_04_recording_civ01", "jup_hij_smartphone_recording_to_recoil_civ01", "jup_hij_smartphone_recoil_idle_civ01", "jup_hij_smartphone_recoil_to_recording_civ01", "jup_hij_alert_04_to_panic_04_civ_02", "jup_hij_panic_04_civ_02"];
    var_bdfa75525c9c6db2 = ["jup_hij_smartphone_04_idle_civ02", "jup_hij_smartphone_04_transition_civ02", "jup_hij_smartphone_04_recording_civ02", "jup_hij_smartphone_recording_to_recoil_civ01", "jup_hij_smartphone_recoil_idle_civ01", "jup_hij_smartphone_recoil_to_recording_civ01", "jup_hij_alert_04_to_panic_04_civ_02", "jup_hij_panic_04_civ_02"];
    var_bdfa76525c9c6fe5 = ["jup_hij_smartphone_04_idle_civ03", "jup_hij_smartphone_04_transition_civ03", "jup_hij_smartphone_04_recording_civ03", "jup_hij_alert_04_to_panic_04_civ_02", "jup_hij_panic_04_civ_02"];
    var_737b10d48b02bc56 = ["jup_hij_seated_large_left_idle_civ04", "jup_hij_seated_large_left_idle_to_react_civ04", "jup_hij_seated_large_left_react_loop_civ04", "jup_hij_alert_to_recoil_left_civ01", "jup_hij_recoil_left_idle_civ01", "jup_hij_recoil_to_alert_left_civ01"];
    var_737b0fd48b02ba23 = ["jup_hij_seated_large_left_idle_civ05", "jup_hij_seated_large_left_idle_to_react_civ05", "jup_hij_seated_large_left_react_loop_civ05", "jup_hij_alert_to_recoil_left_civ01", "jup_hij_recoil_left_idle_civ01", "jup_hij_recoil_to_alert_left_civ01"];
    var_53161fb9125eeb38 = ["jup_hij_idle_left_civ_01", "jup_hij_idle_to_alert_back_left_civ_01", "jup_hij_alert_idle_left_civ01", "jup_hij_alert_to_recoil_left_civ01", "jup_hij_recoil_idle_left_civ01", "jup_hij_recoil_to_alert_left_civ01"];
    var_3ce24d0c3cc11b3b = ["jup_hij_idle_left_civ_02", "jup_hij_idle_to_alert_back_left_civ_02", "jup_hij_alert_idle_left_civ02", "jup_hij_alert_to_recoil_left_civ02", "jup_hij_recoil_idle_left_civ02", "jup_hij_recoil_to_alert_left_civ02"];
    var_ae48d0082c8a5e9e = ["jup_hij_idle_right_civ_01", "jup_hij_idle_to_alert_back_right_civ_01", "jup_hij_alert_idle_right_civ01", "jup_hij_alert_to_recoil_right_civ01", "jup_hij_recoil_idle_right_civ01", "jup_hij_recoil_to_alert_right_civ01"];
    var_32df220966960631 = ["jup_hij_idle_right_civ_02", "jup_hij_idle_to_alert_back_right_civ_02", "jup_hij_alert_idle_right_civ02", "jup_hij_alert_to_recoil_right_civ02", "jup_hij_recoil_idle_right_civ02", "jup_hij_recoil_to_alert_right_civ02"];
    var_ee098fbd8d4a37b2 = ["jup_hij_idle_window_01_civ_02", "jup_hij_window_01_idle_to_alert_01_civ_02", "jup_hij_alert_01_civ_01", "jup_hij_alert_01_to_panic_01_civ_01", "jup_hij_panic_01_civ_01"];
    var_908a7836a4798c3e = ["jup_hij_overhead_compartment_idle_civ01", "jup_hij_idle_01_to_alert_01_civ_02", "jup_hij_alert_01_civ_02", "jup_hij_alert_to_recoil_left_civ01", "jup_hij_recoil_left_idle_civ01", "jup_hij_recoil_to_alert_left_civ01"];
    var_b84bf13fb3d75cf9 = ["jup_hij_overhead_compartment_idle_civ02", "jup_hij_idle_01_to_alert_01_civ_01", "jup_hij_alert_01_civ_01", "jup_hij_alert_01_to_panic_01_civ_01", "jup_hij_panic_01_civ_01"];
    var_a589e8432ec0bf1c = ["jup_hij_overhead_compartment_idle_civ03", "jup_hij_idle_to_alert_02_civ_01", "jup_hij_alert_02_civ_01", "jup_hij_alert_to_panic_02_civ_01", "jup_hij_panic_02_civ_01"];
    var_97a4736c9f71c598 = ["jup_hij_seated_large_left_idle_civ01", "jup_hij_idle_to_alert_back_left_civ_01", "jup_hij_alert_idle_left_civ01", "jup_hij_alert_to_recoil_left_civ01", "jup_hij_recoil_idle_left_civ01", "jup_hij_recoil_to_alert_left_civ01", "jup_hij_alert_01_to_panic_01_civ_01", "jup_hij_panic_01_civ_01"];
    var_2bb962347636aded = ["jup_hij_seated_large_right_idle_civ01", "jup_hij_idle_to_alert_back_right_civ_01", "jup_hij_alert_idle_right_civ01", "jup_hij_alert_to_recoil_right_civ01", "jup_hij_recoil_idle_right_civ01", "jup_hij_recoil_to_alert_right_civ01", "jup_hij_alert_01_to_panic_01_civ_02", "jup_hij_panic_01_civ_02"];
    var_97a4766c9f71cc31 = ["jup_hij_seated_large_left_idle_civ02", "jup_hij_idle_to_alert_back_left_civ_02", "jup_hij_alert_idle_left_civ02", "jup_hij_alert_to_recoil_left_civ02", "jup_hij_recoil_idle_left_civ02", "jup_hij_recoil_to_alert_left_civ02", "jup_hij_alert_to_panic_02_civ01", "jup_hij_panic_02_civ01"];
    var_2bb95f347636a754 = ["jup_hij_seated_large_right_idle_civ02", "jup_hij_idle_to_alert_back_right_civ_02", "jup_hij_alert_idle_right_civ02", "jup_hij_alert_to_recoil_right_civ02", "jup_hij_recoil_idle_right_civ02", "jup_hij_recoil_to_alert_right_civ02", "jup_hij_alert_to_panic_02_civ02", "jup_hij_panic_02_civ02"];
    var_97a4756c9f71c9fe = ["jup_hij_seated_large_left_idle_civ03", "jup_hij_idle_to_alert_back_left_civ_01", "jup_hij_alert_idle_left_civ01", "jup_hij_alert_to_recoil_left_civ01", "jup_hij_recoil_idle_left_civ01", "jup_hij_recoil_to_alert_left_civ01", "jup_hij_alert_01_to_panic_01_civ_01", "jup_hij_panic_01_civ_01"];
    var_2bb960347636a987 = ["jup_hij_seated_large_right_idle_civ03", "jup_hij_idle_to_alert_back_right_civ_01", "jup_hij_alert_idle_right_civ01", "jup_hij_alert_to_recoil_right_civ01", "jup_hij_recoil_idle_right_civ01", "jup_hij_recoil_to_alert_right_civ01", "jup_hij_alert_01_to_panic_01_civ_02", "jup_hij_panic_01_civ_02"];
    var_97a4786c9f71d097 = ["jup_hij_seated_large_left_idle_civ04", "jup_hij_idle_to_alert_back_left_civ_02", "jup_hij_alert_idle_left_civ02", "jup_hij_alert_to_recoil_left_civ02", "jup_hij_recoil_idle_left_civ02", "jup_hij_recoil_to_alert_left_civ02", "jup_hij_alert_to_panic_02_civ01", "jup_hij_panic_02_civ01"];
    var_2bb95d347636a2ee = ["jup_hij_seated_large_right_idle_civ04", "jup_hij_idle_to_alert_back_right_civ_02", "jup_hij_alert_idle_right_civ02", "jup_hij_alert_to_recoil_right_civ02", "jup_hij_recoil_idle_right_civ02", "jup_hij_recoil_to_alert_right_civ02", "jup_hij_alert_to_panic_02_civ02", "jup_hij_panic_02_civ02"];
    level.var_a3ecd9469cde6f42 = [var_f509e1f67170bf4e, var_f509e0f67170bd1b, var_6320b1842f6bcfad, var_6320ae842f6bc914, var_4475ff9173dcb3b4, var_4476029173dcba4d, var_4476019173dcb81a, var_4475fc9173dcad1b, var_33da088527f0a68b, var_33da098527f0a8be, var_ee098fbd8d4a37b2, var_94f703d6bb8b14b2, var_94f702d6bb8b127f, var_94f701d6bb8b104c, var_9b4121fcef1a94a1, var_9b411efcef1a8e08, var_9b411ffcef1a903b, var_5f93f3e3d73dedc8, var_5f93f6e3d73df461, var_5f93f5e3d73df22e, var_bdfa74525c9c6b7f, var_bdfa75525c9c6db2, var_bdfa76525c9c6fe5, var_737b10d48b02bc56, var_737b0fd48b02ba23, var_53161fb9125eeb38, var_3ce24d0c3cc11b3b, var_ae48d0082c8a5e9e, var_32df220966960631, var_97a4736c9f71c598, var_2bb962347636aded, var_97a4766c9f71cc31, var_2bb95f347636a754, var_97a4756c9f71c9fe, var_2bb960347636a987, var_97a4786c9f71d097, var_2bb95d347636a2ee, var_908a7836a4798c3e, var_b84bf13fb3d75cf9, var_a589e8432ec0bf1c];
    level.tracking_callbacks = [];
    level.tracking_callbacks["jup_hij_smartphone_02_recording_civ01"] = &function_d47d250d79b7975f;
    level.tracking_callbacks["jup_hij_smartphone_02_recording_civ02"] = &function_d47d250d79b7975f;
    level.tracking_callbacks["jup_hij_smartphone_02_recording_civ03"] = &function_d47d250d79b7975f;
    level.tracking_callbacks["jup_hij_smartphone_03_record_civ01"] = &function_e42447fbc054d453;
    level.tracking_callbacks["jup_hij_smartphone_03_record_civ02"] = &function_e42447fbc054d453;
    level.tracking_callbacks["jup_hij_smartphone_03_record_civ03"] = &function_e42447fbc054d453;
    level.tracking_callbacks["jup_hij_smartphone_04_recording_civ01"] = &function_d47d250d79b7975f;
    level.tracking_callbacks["jup_hij_smartphone_04_recording_civ02"] = &function_d47d250d79b7975f;
    level.tracking_callbacks["jup_hij_smartphone_04_recording_civ03"] = &function_d47d250d79b7975f;
    level.tracking_callbacks["jup_hij_smartphone_06_record_civ01"] = &function_e42447fbc054d453;
    level.tracking_callbacks["jup_hij_smartphone_06_record_civ02"] = &function_e42447fbc054d453;
    level.tracking_callbacks["jup_hij_smartphone_06_record_civ03"] = &function_e42447fbc054d453;
    level.tracking_callbacks["jup_hij_smartphone_recoil_idle_civ01"] = &function_d47d250d79b7975f;
  }

  foreach(var_369688ee361b5dff in level.var_a3ecd9469cde6f42) {
    if(is_equal(var_369688ee361b5dff[0], starting_anim)) {
      return var_369688ee361b5dff[state];
    }
  }

  return undefined;
}

function function_384d78dd0b8f21da(paired_partner) {
  if(is_equal("jup_hij_idle_03_civ_01", self.animnode.animation)) {
    start_time = randomfloatrange(20, 35);
    wait start_time;

    if(!flag("passenger_transition_to_alert")) {
      self.animnode notify("stop_loop");
      self stopanimScripted();
      paired_partner notify("stop_loop");
      paired_partner.civ stopanimScripted();
      self.animnode thread anim_single_solo(self, "jup_hij_idle_03_to_idle_handhold_03_civ_01");
      paired_partner anim_single_solo(paired_partner.civ, "jup_hij_idle_03_to_idle_handhold_03_civ_02");
      self.animnode thread anim_loop_solo(self, "jup_hij_idle_03_handhold_civ_01");
      paired_partner thread anim_loop_solo(paired_partner.civ, "jup_hij_idle_03_handhold_civ_02");
    }
  }
}

function level_spawner(gender) {
  spawner = level.civspawners[gender + "_spawners"][level.var_cfc29cd454498f9e[gender]];
  level.var_cfc29cd454498f9e[gender]++;

  if(level.var_cfc29cd454498f9e[gender] >= level.civspawners[gender + "_spawners"].size) {
    level.var_cfc29cd454498f9e[gender] = 0;
  }

  return spawner;
}

#using_animtree("generic_human");

function script_model_proc_node() {
  self setanim(%proc_node, 1, 0);
  self.anim_getrootfunc = &namespace_3123a12d1da4993::set_root;
}

function enable_lookat() {
  self function_f51ff412609193b9(1, "script");
  self function_c6a5eda5ddec35cc(1);
}

function function_aa07d9f9a1f53ec0(animnode, animname, spawner, index, gender) {
  if(!isDefined(level.var_24c48e6936b30519)) {
    level.var_24c48e6936b30519 = 0;
  }

  if(level.var_24c48e6936b30519 > 34 || isDefined(animnode.script_offhands) && animnode.script_offhands.size > 0) {
    civ = fakeactorspawn(spawner);

    if(isDefined(animnode.animation) && array_contains(level.var_4b008acd8d4972c5, animnode.animation)) {
      civ.var_2fdbdaf623328172 = 1;
    }
  } else {
    civ = spawner stalingradspawn(1, spawner.targetname, 1);
    level.var_24c48e6936b30519++;
    civ.ignoreall = 1;
    civ.ignoreme = 1;
    civ.dontevershoot = 1;
    civ.dontattackme = 1;
    civ.dontavoidplayer = 1;
    civ function_65502ee2f2b28d07();
    civ pausepath(0);
    civ function_e8971dd45d6d700c(0);
    civ function_b661b022700ba72f("script", 1);
    civ function_9e8aba535d998963();
    civ thread function_382c9c7dbf0a67e9();
  }

  civ endon("death");
  civ.spawner = spawner;
  civ.gender = spawner.script_noteworthy;
  civ.scriptednodebypass = 1;
  civ.fakeactor_face_anim = 1;

  if(isDefined(animname)) {
    civ.animname = animname;
  } else {
    civ.animname = "generic";
  }

  if(isDefined(animnode)) {
    civ.animnode = animnode;
  } else {
    civ.animnode = self;
  }

  return civ;
}

function function_90751bbbdd7f9aeb(body, head) {
  if(isDefined(body)) {
    self setModel(body);
  }

  if(isDefined(head)) {
    self detach(self.headmodel);
    self.headmodel = head;
    self attach(self.headmodel);
  }
}

function fakeactor_spawn(expendable) {
  expendable = default_to(expendable, 0);
  level notify("new_fakeactor");
  self.script_forcespawn = undefined;
  self.var_a328fea8cfacdcec = 1;
  self function_fc803f63f14ba95e(0);
  self hide();
  delaycall(0.05, &show);
  self setCanDamage(1);
  self.health = 1;
  thread function_10eab2a711b5c320();
}

function function_3da114b1569afef(location) {
  level.recent_deaths = array_add(level.recent_deaths, location);
  thread function_8702a3d357872ddf();
}

function function_8702a3d357872ddf() {
  wait 0.5;
  level.recent_deaths = array_remove_index(level.recent_deaths, 0);
}

function function_382c9c7dbf0a67e9(stoploop) {
  level endon("flashbang_done");
  flag_wait("flag_intro_complete");
  self.health = 1000;

  while(!istrue(level.player.gun_taken)) {
    wait 0.5;
  }

  while(isalive(self)) {
    self waittill("damage", amount, attacker, direction_vec, point, type);

    if(attacker == level.player) {
      scripts\sp\friendlyfire::missionfail(1);

      if(istrue(stoploop)) {
        animnode = self.animnode;
        animnode notify("stop_loop");
      }

      self notify("passenger_shot");
      self stoplookat();
      waitframe();
      function_3da114b1569afef(self.origin);
      self function_e8971dd45d6d700c(1);
      scripts\sp\anim::function_ce450b9957138bd5();
      wait 1;
      self kill();
    }
  }
}

function function_38497ef67aae58c8(actors) {
  foreach(actor in actors) {
    if(isDefined(actor.entity) && isalive(actor.entity)) {
      actor.entity.dropweapon = 0;
    }
  }
}

function function_10eab2a711b5c320() {
  self endon("entitydeleted");
  level endon("flashbang_done");
  flag_wait("flag_intro_complete");

  while(!istrue(level.player.gun_taken)) {
    wait 0.5;
  }

  while(isalive(self)) {
    self waittill("damage", amount, attacker, direction_vec, point, type);

    if(attacker == level.player) {
      scripts\sp\friendlyfire::missionfail(1);
      self.last_damage_type = type;
      self.lastattacker = attacker;

      if(isDefined(attacker) && isPlayer(attacker)) {
        attacker setclientomnvar("damage_feedback_notify", gettime());
      }

      self notify("passenger_shot");
      deatharray = ["jup_hij_death_pose_civ01", "jup_hij_death_pose_civ02", "jup_hij_death_pose_civ03", "jup_hij_death_pose_civ04", "jup_hij_death_pose_civ05", "jup_hij_death_pose_civ06", "jup_hij_death_pose_civ07", "jup_hij_death_pose_civ08", "jup_hij_death_pose_civ09"];
      randomdeath = random(deatharray);
      animnode = self.animnode;
      animnode notify("stop_loop");
      self stopanimScripted();
      waitframe();
      function_3da114b1569afef(self.origin);
      self notify("death");
      waitframe();
      animnode anim_single_solo(self, randomdeath);
      waitframe();
      scripts\sp\anim::function_ce450b9957138bd5();
    }
  }
}

function function_ae12c21bcfcdd83f() {
  level.player endon("death");

  while(true) {
    if(isDefined(level.player) && level.player istouching(self)) {
      return;
    }

    waitframe();
  }
}

function function_7d89f98164b6df3d(viewmodel, legmodel, shadowmodel) {
  if(isDefined(viewmodel)) {
    level.player setviewmodel(viewmodel);
  }

  if(isDefined(legmodel)) {
    level.player setlegsmodel(legmodel);
  }

  if(isDefined(shadowmodel)) {
    level.player setshadowmodel(shadowmodel);
  }
}

function function_587b8e0d4e4090f4(npc, animnode, animname) {
  if(!isDefined(npc)) {
    return;
  }

  animnode anim_single_solo(npc, animname);

  if(!isDefined(npc.animnode.script_linkname)) {
    npc thread transition_to_alert(1);
  }
}

function function_1734e4f3a27d192f() {
  level endon("flashbang_done");
  flags = ["stewardess_sees_gun", "neighbor_takedown"];
  waittill_any_in_array(flags);
  flag_set("passenger_transition_to_alert");
}

function function_2b76b679c7d68922() {
  level endon("flashbang_done");
  flags = ["standoff_canceled", "standoff_first_shot_fired"];
  waittill_any_in_array(flags);
  level.var_35dc8163678b4227 = 1;
  waitframe();
  flag_set("passenger_transition_to_alert");
}

function function_d7f8f6ca8e87874f() {}

function function_db7cf901994d45d0() {
  level endon("stewardess_death");
  flag_wait_either("design_flag_spawn_stewardess", "flag_spawn_civ_checkpoint");
  spawner = getspawner("civ_to_shoot", "targetname");
  level.stewardess = spawner spawn_ai(1);
  level.stewardess.health = 100000;
  level.stewardess.pushable = 0;
  level.stewardess.script_pushable = 0;
  level.stewardess.ignorerandombulletdamage = 1;
  thread function_2ea419e0536f6d12(level.stewardess);
  level.stewardess waittill("damage", amount, attacker, direction_vec, point, type);

  if(attacker == level.player) {
    scripts\sp\friendlyfire::missionfail(1);
  }
}

function stewardess_death() {
  node = spawnStruct();
  node.origin = self.origin;
  node.angles = self.angles;
  stewardess = get_object("civ_to_shoot");
  level waittill("stewardess_death");

  if(isDefined(stewardess)) {
    stewardess.functable["shotObjectStopAnim"] = undefined;
    stewardess.activeanimationtype = undefined;
  }

  node anim_single_solo(level.stewardess, "jup_hij_0200_standoff_stewardess_01_death");
  node anim_last_frame_solo(level.stewardess, "jup_hij_0200_standoff_stewardess_01_death");
}

function function_46a7af93f6a23ac3() {
  if(!isDefined(self) && is_dead_or_dying(self)) {
    return;
  }

  if(flag("stewardess_death")) {
    return;
  }

  self function_b661b022700ba72f("script", 1);
  self setcivstate("cower");
  self function_b661b022700ba72f("only_reactions", 1);
  self.health = 10;
}

function function_7d501d4bd01286f7() {}

function function_67758dee03bded8b() {
  self endon("death");
  level endon("neighbor_takedown");
  level endon("hijackers_end");
  level endon("flag_hero_rusher_start");
  level.player thread shove_spline("shove_spline");
  level.var_6d3b1ff57ed455b9 = -1;

  while(true) {
    if(function_b95cde2adc07d968(self, level.player, 50)) {
      if(getdvarint(@ "hash_7d45d3f1782561cf")) {
        notification = "<dev string:x22>";
        self notify(notification);
        thread draw_circle_until_notify(self.origin, 50, 0, 1, 0, self, notification);
      }

      selfforward = anglesToForward(self.angles);
      offset = selfforward * 50;
      var_518c88fe42a7c320 = self.origin + offset;
      angles = vectortoangles(level.player.origin - var_518c88fe42a7c320);
      forward = anglesToForward(angles);
      dot = vectordot(forward, selfforward);

      if(dot < 0) {
        result = function_469c45272a910658(var_518c88fe42a7c320);

        if(result) {
          flag_waitopen("hijack_shove_active");
        } else {
          flag_wait("hijack_shove_enabled");
        }
      }
    } else {
      if(getdvarint(@ "hash_7d45d3f1782561cf")) {
        notification = "<dev string:x22>";
        self notify(notification);
        thread draw_circle_until_notify(self.origin, 50, 1, 0, 0, self, notification);
      }
    }

    waitframe();
  }
}

function shove_spline(targetname) {
  self endon("death");
  level endon("hijackers_end");

  if(isDefined(self.var_ce8de5f635cfa2ab)) {
    return;
  }

  var_e47012497d2a870c = getStruct(targetname, "targetname");
  var_d10812c3cf2eedd5 = undefined;

  for(currentnode = var_e47012497d2a870c; isDefined(currentnode); currentnode = undefined) {
    if(isDefined(currentnode.target)) {
      nextnode = getStruct(currentnode.target, "targetname");
      currentnode.nextnode = nextnode;
      nextnode.prevnode = currentnode;

      if(getdvarint(@ "hash_7d45d3f1782561cf")) {
        if(isPlayer(self)) {
          r = 1;
          g = 1;
          b = 0;
        } else {
          r = 1;
          g = 0.25;
          b = 0;
        }

        thread draw_line_until_notify(currentnode.origin + (0, 0, 30), nextnode.origin + (0, 0, 30), r, g, b, level, "<dev string:x32>");
      }

      currentnode = nextnode;
      continue;
    }

    var_d10812c3cf2eedd5 = currentnode;
  }

  spline = spawnStruct();
  spline.currentnode = var_e47012497d2a870c;
  spline.nextnode = var_e47012497d2a870c.nextnode;
  spline.startnode = var_e47012497d2a870c;
  spline.endnode = var_d10812c3cf2eedd5;
  self.var_ce8de5f635cfa2ab = spline;

  var_2ac35ea45761aebb = undefined;
  starttime = gettime();

  while(true) {
    if(isPlayer(self) && self islinked()) {
      waitframe();
      continue;
    }

    currentnode = spline.currentnode;
    nextnode = spline.nextnode;

    if(!isDefined(nextnode)) {
      break;
    }

    var_42d0d4ffa62ce4ce = vectortoangles(currentnode.origin - nextnode.origin);

    if(getdvarint(@ "hash_7d45d3f1782561cf")) {
      thread draw_line_for_time(nextnode.origin + (0, 0, 30) + anglestoleft(var_42d0d4ffa62ce4ce) * 1000, nextnode.origin + (0, 0, 30) + anglestoright(var_42d0d4ffa62ce4ce) * 1000, 1, 1, 1, 0.05);
    }

    if(!within_fov(nextnode.origin, var_42d0d4ffa62ce4ce, self.origin, 0)) {
      if(getdvarint(@ "hash_7d45d3f1782561cf")) {
        normal = vectorNormalize(self.origin - nextnode.origin);
        forward = anglesToForward(var_42d0d4ffa62ce4ce);
        dot = vectordot(forward, normal);
        print3d(nextnode.origin + (0, 0, 30), dot, (1, 1, 1), 1, 0.3, 200);
        thread draw_line_for_time(nextnode.origin + (0, 0, 30), nextnode.origin + (0, 0, 30) + anglesToForward(var_42d0d4ffa62ce4ce) * 1000, 0, 1, 0, 10);
        thread draw_line_for_time(nextnode.origin + (0, 0, 30), self.origin + (0, 0, 30), 1, 0, 0, 10);
      }

      var_7c5c8d7b472bdcf4 = 0;

      if(isDefined(var_2ac35ea45761aebb) && within_fov(currentnode.origin, var_2ac35ea45761aebb, self.origin, 0)) {
        prevnode = currentnode.prevnode;

        if(isDefined(prevnode)) {
          spline.currentnode = prevnode;
          spline.nextnode = currentnode;
          var_42d0d4ffa62ce4ce = var_2ac35ea45761aebb;
          var_7c5c8d7b472bdcf4 = 1;
        }
      }

      if(!var_7c5c8d7b472bdcf4) {
        spline.currentnode = nextnode;

        while(true) {
          spline.nextnode = spline.currentnode.nextnode;
          break;
        }
      }

      var_2ac35ea45761aebb = var_42d0d4ffa62ce4ce;
      waitframe();
      continue;
    }

    waitframe();
  }
}

function function_469c45272a910658(var_518c88fe42a7c320) {
  level endon("hijackers_end");
  notification = "new_draw_shove";
  self notify(notification);

  if(!flag("hijack_shove_enabled")) {
    if(getdvarint(@ "hash_7d45d3f1782561cf")) {
      thread function_ccc9189861847214(self.origin + (0, 0, 75), "<dev string:x38>", (1, 0, 0), 1, notification);
    }

    return false;
  }

  if(flag("hijack_shove_active")) {
    if(getdvarint(@ "hash_7d45d3f1782561cf")) {
      thread function_ccc9189861847214(self.origin + (0, 0, 75), "<dev string:x41>", (1, 1, 0), 1, notification);
    }

    return false;
  }

  if(level.player islinked()) {
    if(getdvarint(@ "hash_7d45d3f1782561cf")) {
      thread function_ccc9189861847214(self.origin + (0, 0, 75), "<dev string:x48>", (1, 0, 0), 1, notification);
    }

    return false;
  }

  currentnode = level.player.var_ce8de5f635cfa2ab.currentnode;
  nextnode = level.player.var_ce8de5f635cfa2ab.nextnode;
  var_4dfdc410f588cefe = 50;
  var_d1ca53724c220d5d = vectorNormalize(nextnode.origin - currentnode.origin) * var_4dfdc410f588cefe;
  var_234ccb54fd00cf6a = -1 * vectorfromlinetopoint(currentnode.origin, nextnode.origin, level.player.origin);
  var_4ad2d8b076d17a8b = level.player.origin + var_234ccb54fd00cf6a + var_d1ca53724c220d5d;
  var_b4cb39e172d7bae = vectortoangles(nextnode.origin - currentnode.origin);

  while(true) {
    var_b4cb39e172d7bae = vectortoangles(nextnode.origin - currentnode.origin);
    var_42d0d4ffa62ce4ce = vectortoangles(currentnode.origin - nextnode.origin);

    if(within_fov(nextnode.origin, var_42d0d4ffa62ce4ce, var_4ad2d8b076d17a8b, 0)) {
      break;
    }

    currentnode = nextnode;
    nextnode = currentnode.nextnode;

    if(!isDefined(nextnode)) {
      break;
    }

    var_4ad2d8b076d17a8b -= vectorfromlinetopoint(currentnode.origin, nextnode.origin, var_4ad2d8b076d17a8b);
  }

  if(getdvarint(@ "hash_7d45d3f1782561cf")) {
    thread draw_line_for_time(level.player.origin + (0, 0, 30), level.player.origin + var_234ccb54fd00cf6a + (0, 0, 30), 0, 0, 1, 10);
    thread draw_line_for_time(level.player.origin + (0, 0, 30), var_4ad2d8b076d17a8b + (0, 0, 30), 1, 0, 1, 10);
  }

  thread function_7a9b07e72d8214e(var_518c88fe42a7c320, var_4ad2d8b076d17a8b, var_b4cb39e172d7bae);
  return true;
}

function function_7a9b07e72d8214e(var_518c88fe42a7c320, var_4ad2d8b076d17a8b, var_b4cb39e172d7bae) {
  level endon("hijackers_end");
  flag_set("hijack_shove_active");
  anime = "push_front";
  delaythread(0.3, &player_shoved, var_518c88fe42a7c320, var_4ad2d8b076d17a8b, var_b4cb39e172d7bae);
  level.player waittill("shove_done");
  flag_clear("hijack_shove_active");
}

function player_shoved(sourcepos, targetpos, targetangles, var_d0613ca1d9a8ae36) {
  level endon("hijackers_end");

  if(!isDefined(var_d0613ca1d9a8ae36)) {
    var_d0613ca1d9a8ae36 = 0.4;
  }

  mover = level.player spawn_script_origin();
  function_6c677bfd559ec633(sourcepos, var_d0613ca1d9a8ae36, 1);
  level.player playerlinktodelta(mover, undefined, var_d0613ca1d9a8ae36, 50, 70, 50, 50);
  level thread function_d0551eaf85c0e266(vectortoangles(targetpos - level.player.origin));
  level.player playerlinktodelta(mover, undefined, 0, 90, 90, 90, 90, 1);
  level.player lerpviewangleclamp(0.3, 0, 0.2, 5, 5, 10, 10);
  mover move_and_rotate_to(0.5, targetpos, targetangles, 1, 0.1, 0.3);

  if(!isDefined(level.player_rig)) {
    level.player unlink();
  }

  mover delete();
  level.player notify("shove_done");
}

function function_6c677bfd559ec633(sourcepos, var_d0613ca1d9a8ae36, var_b78ee32baaa3c23b) {
  level endon("hijackers_end");
  level.player scripts\sp\player::radial_distortion(0.05, 0.05, var_d0613ca1d9a8ae36);
  earthquake(0.5, 0.3, sourcepos, 100);

  if(istrue(var_b78ee32baaa3c23b)) {
    level.player viewkick(8, sourcepos, 0);
  }

  level.player playRumbleOnEntity("light_1s");
}

function function_d0551eaf85c0e266(angles) {
  level endon("hijackers_end");
  wait 0.25;

  if(function_f303bff968cdb8d8(angles)) {}
}

function function_f303bff968cdb8d8(angles) {
  level endon("hijackers_end");
  var_6d95dec01d52e89b = anglesToForward(angles) * (20 + length(level.player getvelocity()));

  if(level.player getnormalizedcameramovement()[1] > 0.2) {
    var_7c6826a6aa25007c = anglestoright(angles) * (20 + length(level.player getvelocity()));

    if(!ray_trace_passed(level.player.origin + (0, 0, 32), level.player.origin + (0, 0, 32) + var_7c6826a6aa25007c, level.player)) {
      return false;
    }
  } else if(level.player getnormalizedcameramovement()[1] < -0.2) {
    var_67feffd3d2c927b1 = anglestoleft(angles) * (20 + length(level.player getvelocity()));

    if(!ray_trace_passed(level.player.origin + (0, 0, 32), level.player.origin + (0, 0, 32) + var_67feffd3d2c927b1, level.player)) {
      return false;
    }
  }

  if(!ray_trace_passed(level.player.origin + (0, 0, 32), level.player.origin + (0, 0, 32) + var_6d95dec01d52e89b, level.player)) {
    return false;
  }

  return true;
}

function move_and_rotate_to(time, origin, angles, shouldwait, accel, decel) {
  level endon("hijackers_end");

  if(!isDefined(accel)) {
    accel = 0;
  }

  if(!isDefined(decel)) {
    decel = 0;
  }

  if(!isDefined(shouldwait)) {
    shouldwait = 1;
  }

  self moveTo(origin, time, accel, decel);

  if(isDefined(angles)) {
    self rotateTo(angles, time, accel, decel);
  }

  if(shouldwait) {
    wait time;
  }
}

function within_dist(start, end, dist) {
  level endon("hijackers_end");

  if(!isDefined(start) || !isDefined(end)) {
    return false;
  }

  return distancesquared(start, end) <= dist * dist;
}

function function_b95cde2adc07d968(ent1, ent2, dist) {
  level endon("hijackers_end");
  return within_dist(ent1.origin, ent2.origin, dist);
}

function function_f079872c1a36b31b() {}

function function_d90ecafe1cffe760() {
  blocker = getEnt("temp_am_blocker", "targetname");
  waitframe();
  flag_wait("flag_air_marshals_spawned");

  if(isDefined(blocker)) {
    blocker hide();
  }
}

function function_1f51580c2472a5c8() {
  business_class_blocker = getEnt("business_class_blocker", "targetname");

  if(isDefined(business_class_blocker)) {
    business_class_blocker hide();
  }

  flag_wait("flag_block_business_class");

  if(isDefined(business_class_blocker)) {
    business_class_blocker show();
  }
}

function function_3f41cb77e2785636(bool) {
  if(!bool) {
    val::set("earpiece_allow", "crouch", 0);
    val::set("earpiece_allow", "prone", 0);
    val::set("earpiece_allow", "offhand_weapons", 0);
    val::set("earpiece_allow", "allow_jump", 0);
    val::set("earpiece_allow", "sprint", 0);
    val::set("earpiece_allow", "weapon_switch", 0);
    val::set("earpiece_allow", "melee", 0);
    val::set("earpiece_allow", "mantle", 0);
    val::set("earpiece_allow", "reload", 0);

    if(!function_4a691d90212e9398()) {
      val::set("earpiece_allow", "fire", 0);
    }

    return;
  }

  val::reset_all("earpiece_allow");
}

function function_4a691d90212e9398() {
  return getdvarint(@ "hash_6016dbc223b1ee67", 0) == 1;
}

function function_ebd10619133e859c() {
  level.player notifyonplayercommand("fake_weapon_fire_attempted", "+attack");

  while(true) {
    level.player waittill("fake_weapon_fire_attempted");

    if(!function_4a691d90212e9398()) {
      continue;
    }

    if(!flag("flag_fake_pistol_enabled")) {
      continue;
    }

    player_org = level.player getEye();
    player_angles = level.player getplayerangles();
    var_c81f9e334cca7062 = anglesToForward(player_angles);
    bullet_start = player_org + var_c81f9e334cca7062 * 50;
    bullet_end = bullet_start + var_c81f9e334cca7062 * 2000;
    all_ai = getaiarray();
    var_56e6ae8d71d42a7b = array_add(all_ai, level.player);
    trace = scripts\engine\trace::ray_trace(bullet_start, bullet_end, var_56e6ae8d71d42a7b);
    magicbullet(make_weapon("iw9_pi_golf17_sp"), bullet_start, bullet_end);
    level.player notify("fake_weapon_fired");
  }
}

function function_5d1e8e5b4a31254e(dialogue) {
  if(!time_has_passed(level.var_c2bdd88f0b642617, 3.5)) {
    var_7b360e9ae09d91e4 = gettime() - level.var_c2bdd88f0b642617;
    var_e10f4271fbaa2b07 = 3.5 - var_7b360e9ae09d91e4 / 1000;
    wait var_e10f4271fbaa2b07;
  }

  say(dialogue);
}

function function_7a18da6e48b71c35(name) {
  if(!isDefined(name)) {
    return undefined;
  }

  return getStruct(name, "targetname");
}

function function_a7ed7711dc58e0b(toggle_open) {
  var_8697cf5f6210732e = getEntArray("pistol_bathroom_door", "targetname");

  if(toggle_open) {
    array_call(var_8697cf5f6210732e, &movex, 48, 0.75);
    return;
  }

  array_call(var_8697cf5f6210732e, &movex, -48, 0.75);
}

function function_7d2e287b72a27d32(position, time) {
  start_time = gettime();

  while(true) {
    if(function_cf0d23ab6a54057e(position)) {
      if(gettime() > start_time + time * 1000) {
        break;
      }
    } else {
      start_time = gettime();
    }

    waitframe();
  }
}

function function_c580a41a277e4291(position, time) {
  start_time = gettime();

  while(true) {
    if(function_e7c30095a6cdc3ef(position, 10, 0)) {
      if(gettime() > start_time + time * 1000) {
        break;
      }
    } else {
      start_time = gettime();
    }

    waitframe();
  }
}

function function_6783bbaabfd68cd1(position, time, flag_to_set) {
  function_c580a41a277e4291(position, time);
  flag_set(flag_to_set);
}

function function_cf0d23ab6a54057e(position) {
  if(!level.player isads()) {
    return 0;
  }

  return function_e7c30095a6cdc3ef(position, 15, 0);
}

function function_e7c30095a6cdc3ef(position, fov, occlude) {
  if(!isDefined(level.player)) {
    return false;
  }

  if(!isDefined(fov)) {
    fov = getdvarint(@ "cg_fov");
  }

  if(!isDefined(occlude)) {
    occlude = 0;
  }

  in_fov = within_fov(level.player getEye(), level.player getplayerangles(), position, cos(fov));

  if(!in_fov) {
    return false;
  }

  if(!occlude) {
    return true;
  }

  contents = physics_createcontents(["physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_ainosight"]);
  castresult = physics_raycast(level.player getEye(), position, contents, undefined, 0, "physicsquery_closest", 0);

  if(isDefined(castresult) && castresult.size > 0) {
    return false;
  }

  return true;
}

function player_moving_toward(point) {
  return within_fov(level.player.origin, level.player.angles, point, 0.642788) && istrue(level.player getnormalizedmovement()[0]);
}

function melee_tracker() {
  val::set("earpiece_allow", "melee", 1);
  context_melee_enable(0);
  flag_wait("flag_hijackers_end");
  val::set("earpiece_allow", "melee", 0);
}

function function_e3ef9d2f0513d055(position, fov, occlude) {
  while(true) {
    seen_by_player = function_e7c30095a6cdc3ef(position, fov, occlude);

    if(seen_by_player) {
      return "seen_by_player";
    }

    waitframe();
  }
}

function function_238801b2923279cf(position, timeout, fov, occlude) {
  start_time = gettime();
  timeout *= 1000;

  while(true) {
    seen_by_player = function_e7c30095a6cdc3ef(position, fov, occlude);

    if(seen_by_player) {
      return "seen_by_player";
    }

    if(timeout < gettime() - start_time) {
      return "timeout";
    }

    waitframe();
  }
}

function function_6342ec57ac648f0e(position, flag_name, fov, occlude) {
  while(true) {
    seen_by_player = function_e7c30095a6cdc3ef(position, fov, occlude);

    if(seen_by_player) {
      return "seen_by_player";
    }

    if(flag(flag_name)) {
      return "flag_hit";
    }

    waitframe();
  }
}

function function_3c72aef86fe48dab(struct_name, fov, occlude) {
  look_struct = getStruct(struct_name, "targetname");
  return function_e3ef9d2f0513d055(look_struct.origin, fov, occlude);
}

function function_777a76bee2b363ed(struct_name, timeout, fov, occlude) {
  look_struct = getStruct(struct_name, "targetname");
  return function_238801b2923279cf(look_struct.origin, timeout, fov, occlude);
}

function function_c8431cc67f0b0824(struct_name, flag_name, fov, occlude) {
  look_struct = getStruct(struct_name, "targetname");
  return function_6342ec57ac648f0e(look_struct.origin, flag_name, fov, occlude);
}

function function_e2ef62b3f4e104c(org, flag_to_set) {
  while(true) {
    level.player waittill("weapon_fired");

    if(function_e7c30095a6cdc3ef(org.origin, 10, 0)) {
      flag_set(flag_to_set);
    }
  }
}

function function_80a4a5e9830057a9(guy, var_8d9a61b271ef2344, endon_string, var_e1330ad3638c394f) {
  level endon(endon_string);

  while(true) {
    guy waittill("damage", damage, attacker, direction_vec, point, type, modelname, tagname, partname, idflags, objweapon);

    if(isPlayer(attacker)) {
      flag_set(var_8d9a61b271ef2344);
      return;
    }

    flag_set(var_e1330ad3638c394f);
    return;
  }
}

function function_4062dbbf7b62a4f8(flag_name) {
  level endon("flag_hero_rusher_start");
  flag_wait("hijackers_final_blocker_shot_once");

  while(true) {
    self waittill("damage", damage, attacker, direction_vec, point, type, modelname, tagname, partname, idflags, objweapon);

    if(isPlayer(attacker)) {
      flag_set(flag_name);
      break;
    }
  }
}

function function_38e061a78d470508() {
  level endon("flag_hero_rusher_start");
  self endon("death");

  switch (self.targetname) {
    case #"hash_8f9c7cf67782423":
      pain_anim = "jup_hij_0525_pain_enemy01";
      react_anim = "jup_hij_0525_react_enemy01";
      break;
    case #"hash_1dd4867f748523cf":
      pain_anim = "jup_hij_0525_pain_enemy02";
      react_anim = "jup_hij_0525_react_enemy02";
      break;
    case #"hash_7b31ab4a64c5a4ff":
      pain_anim = "jup_hij_0525_pain_enemy01";
      react_anim = "jup_hij_0525_react_enemy02";
      break;
    default:
      pain_anim = "jup_hij_0525_pain_enemy01";
      react_anim = "jup_hij_0525_react_enemy01";
      break;
  }

  set_dontmelee(1);
  flag_wait("flag_player_attacked_hijackers");

  if(isalive(self)) {
    anim_stopanimScripted();

    if(self.health < 100 && self != level.rear_hijacker) {
      anim_single_solo(self, pain_anim, undefined, 3.8);
    } else {
      magic_bullet_shield();
      random_time = randomfloatrange(0.1, 0.3);
      wait random_time;
    }

    self.favoriteenemy = level.player;
    self.maxfaceenemydist = 1000;
    self.goalradius = 100;
    self.accuracy = 1;
    self.disablereload = 1;
    self.ignoreall = 0;
  }
}

function function_319c2f097ede51e0(targetname, entities, shot, time_fraction) {
  animnode = getStruct(targetname, "targetname");
  animnode scene::play(entities, shot, undefined, time_fraction);
}

function function_57ac36ea7abb5af4(targetname, entities, shots, time_fraction) {
  if(isDefined(targetname)) {
    function_319c2f097ede51e0(targetname, entities, shots, time_fraction);
  } else {
    scene::play(entities, shots, undefined, time_fraction);
  }

  self notify("scene_complete");
}

function function_54376d79bb3d20f5(targetname, entities, shots, time_fraction) {
  if(isDefined(targetname)) {
    function_319c2f097ede51e0(targetname, entities, shots, time_fraction);
  } else {
    scene::play(entities, shots, undefined, time_fraction);
  }

  self notify("scene_secondary_complete");
}

function function_96cef8a436875213(targetname, entities) {
  if(isDefined(targetname)) {
    animnode = getStruct(targetname, "targetname");
  } else {
    animnode = self;
  }

  animnode function_57ac36ea7abb5af4(undefined, entities, "enter");
  animnode thread scene::play(entities, "loop");
}

function function_36bd1eff3569fcad() {
  level endon("kill_zoom");
  level.player notifyonplayercommand("safe_zoom_pressed", "+toggleads_throw");
  level.player notifyonplayercommand("safe_zoom_pressed", "+melee_zoom");
  level.player notifyonplayercommand("safe_zoom_pressed", "+speed_throw");
  level.player notifyonplayercommand("safe_zoom_released", "-toggleads_throw");
  level.player notifyonplayercommand("safe_zoom_released", "-melee_zoom");
  level.player notifyonplayercommand("safe_zoom_released", "-speed_throw");
  wait 1;

  if(!isDefined(level.player.animating)) {
    level.player.animating = 0;
  }

  while(!player_has_weapon(level.weap)) {
    level.player waittill("safe_zoom_pressed");

    if(!level.player.animating && !player_has_weapon(level.weap)) {
      level.player lerpfov(40, 0.5, 0.25, 0.25);
    }

    level.player waittill("safe_zoom_released");

    if(level.player.animating || player_has_weapon(level.weap)) {
      level.player lerpfov(50, 0.25, 0.05, 0.05);
      continue;
    }

    level.player lerpfov(50, 0.5, 0.25, 0.25);
  }
}

function zoom_disable() {
  level.player notify("safe_zoom_released");
  level.player.animating = 1;
}

function zoom_enable() {
  level.player.animating = 0;
}

function function_e804c126791f1d54() {
  animnode = self;
  flag_string = animnode.script_noteworthy;
  flag_wait("passenger_transition_to_alert");
  shots = ["idle_to_standing", "standing"];
  animnode thread scene::play(undefined, shots);
  guy = animnode scene::get_entity("civ");
  waittill_any_ents(level, flag_string, level, "aisle_father_dead", level.player, "attack_pressed");

  if(!flag(flag_string)) {
    shots = ["standing_to_recoil"];
    animnode scene::play(guy, shots);
    shots = ["recoil"];
    animnode thread scene::play(guy, shots);

    while(distance(level.player.origin, animnode.origin) > 400) {
      waitframe();
    }

    if(!flag(flag_string) && !flag("aisle_father_dead")) {
      waittill_any_ents_or_timeout_return(5, level, flag_string, level, "aisle_father_dead", level.player, "attack_pressed");
    }

    shots = ["recoil_to_standing"];
    animnode thread scene::set_anim_rate(3);
    animnode scene::play(guy, shots);
    shots = ["standing_to_panic"];
    animnode thread scene::set_anim_rate(1);
    animnode scene::play(guy, shots);
  } else {
    shots = ["standing_to_panic"];
    animnode scene::play(guy, shots);
  }

  shots = ["panic"];
  animnode thread scene::play(guy, shots);
}

function enter_economy_curtains() {
  var_36109f139cb57b7c = getEnt("first_class_curtain_entrance", "targetname");
  var_d7feeae39b9325e5 = getEnt("first_class_curtain_entrance_open", "targetname");
  waitframe();

  if(isDefined(var_36109f139cb57b7c) && isDefined(var_d7feeae39b9325e5)) {
    var_d7feeae39b9325e5 hide();
    flag_wait("flag_enter_economy_curtains");
    var_d7feeae39b9325e5 show();
    var_36109f139cb57b7c hide();
  }
}

function function_7070c8a674d0b8c9(actor) {
  cinematicingameloop("sp_jup_hijack_intro_phone", 1);
  flag_wait("flag_intro_complete");
  stopcinematicingame();
}

function function_d926ab4104653b4a(actor) {
  flag_wait("phone_countdown_start");
  cinematicingameloop("sp_jup_hijack_bomb_countdown", 1);
  flag_wait("phone_countdown_end");
  stopcinematicingame();
}

function function_d7c6627f65ecb8ac(actor) {
  flag_wait("makarov_phone_countdown_init");
  cinematicingame("sp_jup_hijack_bomb_countdown", 1);
  pausecinematicingame(1);
  flag_wait("makarov_phone_countdown_start");
  pausecinematicingame(0);
}

function temp_dialogue(speaker, text, duration, color_value) {
  level notify("temp_dialogue", speaker, text, duration);
  level endon("temp_dialogue");

  if(!isDefined(color_value)) {
    color_value = 2;
  }

  if(!isDefined(duration)) {
    duration = 4;
  }

  if(isDefined(level.tmp_subtitle)) {
    level.tmp_subtitle destroy();
    level.tmp_subtitle = undefined;
  }

  level.tmp_subtitle = newhudelem();
  level.tmp_subtitle.x = 0;
  level.tmp_subtitle.y = -64;
  level.tmp_subtitle settext("^" + color_value + speaker + ": ^7" + text);
  level.tmp_subtitle.fontscale = 1.46;
  level.tmp_subtitle.alignx = "center";
  level.tmp_subtitle.aligny = "middle";
  level.tmp_subtitle.horzalign = "center";
  level.tmp_subtitle.vertalign = "bottom";
  level.tmp_subtitle.sort = 1;
  wait duration;
  thread temp_dialogue_fade();
}

function temp_dialogue_fade() {
  level endon("temp_dialogue");
  alpha = 1;

  while(alpha > 0) {
    level.tmp_subtitle.alpha = alpha;
    wait 0.05;
    alpha -= 0.1;
  }

  level.tmp_subtitle destroy();
}

function function_8435dd9d3a6a867b(from_point) {
  if(!isDefined(from_point)) {
    return 0;
  }

  if(distance2d(level.player.origin, from_point.origin) < 75) {
    return 0;
  }

  return 1;
}

function function_4e77ad3c291b5056() {
  level.player thread scripts\sp\player::disable_player_weapon_info();

  if(!self isgestureplaying("jup_ges_hands_up") && function_3a0c2d9cf044a4d()) {
    self playgestureviewmodel("jup_ges_hands_up", undefined, 0, 0.5, 0, 1);
    thread function_476ec9d2a0a9fe9e();
    return;
  }

  if(self isgestureplaying("jup_ges_hands_up")) {
    self notify("hands_down");
    self stopgestureviewmodel("jup_ges_hands_up", 0.1, 0);
  }
}

function function_476ec9d2a0a9fe9e() {
  self endon("hands_down");

  while(!isads() || self attackButtonPressed()) {
    waitframe();
  }

  if(self isgestureplaying("jup_ges_hands_up")) {
    thread function_4e77ad3c291b5056();
  }
}

function function_3a0c2d9cf044a4d() {
  if(isnullweapon(level.player getcurrentweapon())) {
    return false;
  }

  if(level.player issprinting()) {
    return false;
  }

  if(level.player issupersprinting()) {
    return false;
  }

  if(!level.player isweaponsenabled()) {
    return false;
  }

  return true;
}

function function_4dd6bcfa285fa86e(node) {
  if(!isDefined(node) || !isDefined(self)) {
    return;
  }

  self.ignoreall = 1;
  self usecovernode(node, 1);
  self setgoalnode(node);

  while(true) {
    if(isDefined(self.pathgoalpos) && self pathdisttogoal() > 0) {
      break;
    }

    waitframe();
  }

  self.ignoreall = 0;
  self.var_3056d8c9bd11f1f2 = 1;
}

function function_2ea419e0536f6d12(stewardess) {
  level endon("standoff_canceled");
  flag_wait("stewardess_sees_gun");

  if(level.player.gun_taken == 1) {
    stewardess say("dx_sp_hjck_intr_fefl_shesgotagun");
  } else {
    stewardess say("dx_sp_hjck_intr_fefl_hesgotagun");
  }

  flag_wait("samara_reply_marshal");
  wait 3;
  level.player say("dx_sp_hjck_intr_sama_nononopleasethereare");
}

function function_c8583438e5aded0c() {
  spawner = getspawner("hijacker_v2_neighbour", "targetname");
  hijacker_v2_neighbour = spawner spawn_ai(1);
  hijacker_v2_neighbour.ignoreall = 1;
  hijacker_v2_neighbour.dontevershoot = 1;
  hijacker_v2_neighbour.goalradius = 16;
  hijacker_v2_neighbour.name = "Hijacker";
  hijacker_v2_neighbour.collide_with_ai = 0;
  hijacker_v2_neighbour enableavoidance(0, 0);
  hijacker_v2_neighbour.maxfaceenemydist = 1000;
  hijacker_v2_neighbour demeanor_override("casual");
  hijacker_v2_neighbour.fixednode = 1;
  namespace_bde1a0e87b86090::function_693d03525ad49ffc(hijacker_v2_neighbour);
  level.cleanup_crew = array_add(level.cleanup_crew, hijacker_v2_neighbour);
  level.neighbor = hijacker_v2_neighbour;
  struct = getStruct("neighbour_first_loc_shove", "targetname");
  first_loc = spawn_script_origin(struct.origin, struct.angles);

  if(isDefined(first_loc)) {
    hijacker_v2_neighbour forceteleport(first_loc.origin, first_loc.angles, 1000);
  }

  wait 2;
  flag_wait("flag_mexican_standoff_begin");
}

function function_ed04e541e65d1dce(animnode) {
  neighbor = animnode scene::get_entity("neighbor");
  neighbor.team = "neutral";
  level notify("visibilityTeamName", "neutral", [neighbor]);
  level waittill("neighborRevealGun");
  neighbor.team = "axis";
  level notify("visibilityTeamName", "axis", [neighbor]);
}

function function_4aa65d546609bfd8() {}

function function_32cb2a1de20d7e6() {
  level endon("neighbor_takedown");
  level endon("flag_mexican_standoff_end");
  infov = 0;
  level.var_9472023eb28270b2 = 0;
  messages = ["hij_player_remove_takedown", "hij_melee_button_pressed"];
  level waittill("enable_standoff_takedown");

  while(isalive(level.neighbor)) {
    infov = within_fov(level.player getEye(), level.player getplayerangles(), level.neighbor getEye(), cos(150));

    if(infov && !level.var_9472023eb28270b2) {
      level.var_9472023eb28270b2 = 1;
      level.player thread scripts\engine\sp\utility::display_hint_forced("hijack_disarm_hint", undefined, 0, level.player, messages);
    } else if(!infov && level.var_9472023eb28270b2) {
      level.player notify("hij_player_remove_takedown");
      level.var_9472023eb28270b2 = 0;
    }

    waitframe();
  }
}

function function_a733404fceca139f() {
  level endon("flag_mexican_standoff_end");
  flag_wait("player_melee_hit");
  thread function_d2ff41bc463d86e6();
}

function function_d2ff41bc463d86e6() {
  level.neighbor delete();
  animnode = getStruct("scene_hij_0150_second_takedown", "targetname");
  waitframe();
  level.player.gun_taken = 1;
  level.var_a613011527cdaa23.entity delete();
  animnode scene::play(undefined, "shot_010");
  level.player take_weapon(level.weap);
  level.weap = make_weapon("jup_cp24_pi_glima21_sp_3d");
  level.player give_weapon(level.weap);
  level.player switchtoweaponimmediate(level.weap);
  level.player setweaponammostock(level.weap, 0);
  level.player setweaponammoclip(level.weap, 15);
  level.player allowreload(0);
  level.player allowfire(1);
  level.player allowcrouch(1);
  level.player allowsprint(1);
  level.player setstance("stand", 1, 1, 0);
  level.player notify("hij_melee_button_pressed");
  waitframe();
  level.var_9472023eb28270b2 = !level.var_9472023eb28270b2;
  flag_set("neighbor_takedown");
}

function melee_listener() {
  level endon("flag_mexican_standoff_end");
  level endon("neighbor_takedown");
  self endon("death");
  self allowmelee(1);
  self allowfire(1);

  while(true) {
    if(level.player meleeButtonPressed()) {
      if(level.var_9472023eb28270b2) {
        flag_set("player_melee_hit");
        level.player notify("hij_player_remove_takedown");
        break;
      }
    }

    waitframe();
  }
}

function function_e47ba6fce6829dbd(targets) {
  level endon("flag_flashbang_done");
  self endon("death");

  while(!flag("flag_flashbang_done")) {
    var_e465d9f169f3da24 = 1;

    foreach(var_a03582deacadbd78 in targets) {
      if(!is_dead_or_dying(var_a03582deacadbd78)) {
        var_e465d9f169f3da24 = 0;
      }
    }

    if(var_e465d9f169f3da24) {
      level.player.ignoreme = 0;
      level.var_21fd20948641a30b = 1;
      set_favoriteenemy(level.player);
      break;
    }

    wait 0.5;
  }
}

function function_ad2aff0233216ab9(targets) {
  level endon("flag_flashbang_done");
  self endon("death");

  while(!flag("flag_flashbang_done")) {
    var_e465d9f169f3da24 = 1;

    foreach(var_a03582deacadbd78 in targets) {
      if(!is_dead_or_dying(var_a03582deacadbd78)) {
        var_e465d9f169f3da24 = 0;
      }
    }

    if(var_e465d9f169f3da24 && istrue(level.player.var_179ccec341f75747)) {
      level.player.ignoreme = 0;
      level.var_21fd20948641a30b = 1;
      set_favoriteenemy(level.player);
      break;
    }

    wait 0.5;
  }
}