/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\fakeactor.gsc
**************************************/

#using scripts\anim\face;
#using scripts\anim\notetracks;
#using scripts\anim\notetracks_sp;
#using scripts\anim\shared;
#using scripts\anim\utility;
#using scripts\common\ai;
#using scripts\common\anim;
#using scripts\engine\sp\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\sp\debug;
#using scripts\sp\fakeactor_node;
#using scripts\sp\friendlyfire;
#using scripts\sp\names;
#using scripts\sp\spawner;
#using scripts\sp\utility;
#namespace fakeactor;

function fakeactor_spawner_init(var_207688188378d7b1) {
  if(isDefined(level.var_4133bf82af26f173)) {
    return;
  }

  level.var_4133bf82af26f173 = 1;
  setdvarifuninitialized(@ "debug_fakeactor", 0);
  setdvarifuninitialized(@ "hash_ab259d9b09bad834", 0);

  if(!istrue(var_207688188378d7b1)) {
    level._effect["\xd4\xf6\x02|W\x1f\xb3+1W\xd7-[\xc7/A|\xca"] = loadfxasset(";\x99\x1e\xf5\x8d\xf6re\xf5m\xd5O\xd7\x85k\x86\xe6\xeb\x99\xc6\xc27\r\xfa\xbb\xce");
  }

  if(!isDefined(level.max_fakeactors)) {
    level.max_fakeactors = [];
  }

  if(!isDefined(level.max_fakeactors["O\x15\x1b\xad\x9ff"])) {
    level.max_fakeactors["O\x15\x1b\xad\x9ff"] = 9999;
  }

  if(!isDefined(level.max_fakeactors["?\xb1\xc0\x9a"])) {
    level.max_fakeactors["?\xb1\xc0\x9a"] = 9999;
  }

  if(!isDefined(level.max_fakeactors["\x8c\x1b\xab)\xd1"])) {
    level.max_fakeactors["\x8c\x1b\xab)\xd1"] = 9999;
  }

  if(!isDefined(level.max_fakeactors["\xba\xa5\x1f\xc9m\x80i"])) {
    level.max_fakeactors["\xba\xa5\x1f\xc9m\x80i"] = 9999;
  }

  if(!isDefined(level.fakeactors)) {
    level.fakeactors = [];
  }

  if(!isDefined(level.fakeactors["O\x15\x1b\xad\x9ff"])) {
    level.fakeactors["O\x15\x1b\xad\x9ff"] = utility_sp::struct_arrayspawn();
  }

  if(!isDefined(level.fakeactors["?\xb1\xc0\x9a"])) {
    level.fakeactors["?\xb1\xc0\x9a"] = utility_sp::struct_arrayspawn();
  }

  if(!isDefined(level.fakeactors["\x8c\x1b\xab)\xd1"])) {
    level.fakeactors["\x8c\x1b\xab)\xd1"] = utility_sp::struct_arrayspawn();
  }

  if(!isDefined(level.fakeactors["\xba\xa5\x1f\xc9m\x80i"])) {
    level.fakeactors["\xba\xa5\x1f\xc9m\x80i"] = utility_sp::struct_arrayspawn();
  }

  if(!isDefined(level.fa_state_machines)) {
    add_state("\x91\xca\xcc\v\xab\xd8:", ",U\xdf.", &play_anim_think, &play_anim_check, 30);
    add_state("\x91\xca\xcc\v\xab\xd8:", "\x80[\xb3\x9d", &move_think, &move_check, 10);
    add_state("\x91\xca\xcc\v\xab\xd8:", "\x0eq\x9e\b\xf4\xd9*Y", &traverse_think, &traverse_check, 20);
    add_state("\x91\xca\xcc\v\xab\xd8:", "\x91\x88\xc2*", &idle_think, &idle_check, 40);
  }

  level.fakeactor_spawn_func = &fakeactor_init;

  if(!isDefined(anim.fa_nodeyaws)) {
    yaws = [];
    yaws["g\x1fWv\xec\xec@P(o"] = 0;
    yaws["c\xb0\x14\xd5\xd9\xe4\xaf\x8d\x91}\xc2"] = -90;
    yaws["\xd2\xc8\xaf/\xf5\x1c\xdfs\xfes\x06\xce"] = -90;
    yaws["\xcalv\xe9\xf1\xb1\x89\x96\x9d^#"] = -90;
    yaws["\xc6\xbeqP\x9b\x14\x96\xfa\xfel\xf1\x98\xac\xfc"] = -90;
    anim.fa_nodeyaws = yaws;
    yaws = [];
    yaws["g\x1fWv\xec\xec@P(o"] = 180;
    yaws["X5hI3PHe\xbe\v\xeb\x19\xc1\x05\xcb\xfc\xaf"] = 0;
    yaws["c\xb0\x14\xd5\xd9\xe4\xaf\x8d\x91}\xc2"] = 180;
    yaws["\xd2\xc8\xaf/\xf5\x1c\xdfs\xfes\x06\xce"] = 180;
    yaws["\xcalv\xe9\xf1\xb1\x89\x96\x9d^#"] = 180;
    anim.fa_franticnodeyaws = yaws;
  }

  if(getDvar(@ "debug_fakeactor") == "<dev string:x24>") {
    if(!isDefined(level.var_d7b6bc05cba76fa6)) {
      level.var_d7b6bc05cba76fa6 = 1;
      level thread fakeactor_node::fakeactor_node_debug();
    }
  }

}

function spawndroneaitype(aitypename, spawnorigin, spawnangles, var_3ce06f90ee911540) {
  drone = function_e04b53b063e097a8(aitypename, spawnorigin, spawnangles);
  aitypestruct = drone function_81945ca9a451f1e8(aitypename);
  charactername = drone function_6c740f140d675101(aitypename, drone.script_char_index, drone.script_char_group, var_3ce06f90ee911540);
  fakeactorstruct = drone function_e3a632505a2118c3(charactername);
  aitypescriptbundle = getaitypescriptbundle(aitypename);
  function_5c8f65dd11ecf097(drone, aitypestruct, fakeactorstruct, charactername, aitypescriptbundle);
  drone rundronepostspawn();
  return drone;
}

function spawndrone() {
  drone = self spawndronecode();
  aitypestruct = self function_81945ca9a451f1e8();
  charactername = self function_6c740f140d675101(drone.classname, self.script_char_index, self.script_char_group, self.script_char_name);
  fakeactorstruct = self function_e3a632505a2118c3(charactername);
  aitypescriptbundle = getaitypescriptbundle(drone.classname);
  function_5c8f65dd11ecf097(drone, aitypestruct, fakeactorstruct, charactername, aitypescriptbundle);
  drone rundronepostspawn();
  return drone;
}

function function_5c8f65dd11ecf097(drone, aitypestruct, fakeactorstruct, charactername, aitypescriptbundle) {
  drone.team = aitypestruct.team;
  drone.unittype = aitypestruct.unittype;
  drone.animationarchetype = fakeactorstruct.animationarchetype;
  drone.animtree = fakeactorstruct.animtree;
  drone.voice = fakeactorstruct.voice;
  drone.fnasm_handlenotetrack = &notetracks_sp::handlenotetrack;

  if(isDefined(aitypescriptbundle.grenadeweapon) && aitypescriptbundle.grenadeweapon != "") {
    drone.grenadeweapon = makeweapon(aitypescriptbundle.grenadeweapon);
    drone.grenadeammo = aitypescriptbundle.grenadeammo;
  } else {
    drone.grenadeweapon = nullweapon();
    drone.grenadeammo = 0;
  }

  primaryweapons = [];

  foreach(weapon in aitypestruct.weaponlist) {
    if(weapon.weapontype == "\xe6\xaa6=\x93`Y") {
      primaryweapons[primaryweapons.size] = weapon;
      continue;
    }

    if(weapon.weapontype == "\x1f^\xe8UA\nY\xd7!") {
      drone.secondaryweapon = makeweapon(weapon.weaponname, isDefined(weapon.attachments) ? weapon.attachments : []);
      continue;
    }

    if(weapon.weapontype == "\xd64*\xa3I\x12\xef") {
      drone.sidearm = makeweapon(weapon.weaponname, isDefined(weapon.attachments) ? weapon.attachments : []);
    }
  }

  if(primaryweapons.size > 0) {
    if(primaryweapons.size == 1) {
      weapon = primaryweapons[0];
      drone.weapon = makeweapon(weapon.weaponname, isDefined(weapon.attachments) ? weapon.attachments : []);
    } else {
      weapon = primaryweapons[randomint(primaryweapons.size)];
      drone.weapon = makeweapon(weapon.weaponname, isDefined(weapon.attachments) ? weapon.attachments : []);
    }
  }

  drone function_97778f15700d1b8c(fakeactorstruct.animationarchetype);

  if(isDefined(fakeactorstruct.bodymodel)) {
    drone setModel(fakeactorstruct.bodymodel);
  } else if(isDefined(fakeactorstruct.bodyalias)) {
    drone function_95868c5d98d0e88f(fakeactorstruct.bodyalias, [[level.fncharacterxmodelalias[charactername]]](fakeactorstruct.bodyalias));
  }

  if(isDefined(fakeactorstruct.headmodel)) {
    drone attach(fakeactorstruct.headmodel, "", 1);
    drone.headmodel = fakeactorstruct.headmodel;
  } else if(isDefined(fakeactorstruct.headalias)) {
    drone.headmodel = drone function_8494407f6062cb5e(fakeactorstruct.headalias, [[level.fncharacterxmodelalias[charactername]]](fakeactorstruct.headalias));
  }

  if(isDefined(fakeactorstruct.hatmodel)) {
    drone.hatmodel = fakeactorstruct.hatmodel;
    drone attach(fakeactorstruct.hatmodel);
    return;
  }

  if(isDefined(fakeactorstruct.hatalias)) {
    drone.hatmodel = drone function_8494407f6062cb5e(fakeactorstruct.hatalias, [[level.fncharacterxmodelalias[charactername]]](fakeactorstruct.hatalias));
  }
}

function get_fakeactors(team) {
  return level.fakeactors[team].array;
}

function is_fakeactor() {
  return isDefined(self.script_fakeactor) && self.script_fakeactor;
}

function fakeactor_init(expendable = 0) {
  if(level.fakeactors[self.team].array.size >= level.max_fakeactors[self.team]) {
    assertmsg("<dev string:x29>" + 9999 + "<dev string:x5a>" + self.team + "<dev string:x68>");
    self delete();
    return;
  }

  thread array_handling(self);
  level notify("\xcb$W\xfb\x98XH{syw\xa2\xa3");
  self.script_forcespawn = undefined;
  self.flags = 0;
  self.upaimlimit = -89;
  self.downaimlimit = 45;
  self.rightaimlimit = -45;
  self.leftaimlimit = 45;
  self.baseaccuracy = 1;

  if(isDefined(self.var_557b3e36607952e0)) {
    self.look_ahead_value = self.var_557b3e36607952e0;
  } else {
    self.look_ahead_value = 200;
  }

  if(isDefined(self.var_40b38f8f06f77e41)) {
    self.loop_time = self.var_40b38f8f06f77e41;
  } else {
    self.loop_time = 0.5;
  }

  set_animsets(["\xff\xd5d'hTb"]);

  if(isDefined(self.script_demeanor)) {
    if(self.script_demeanor == "]\"\x81\x02y\xf7\xa4") {
      set_frantic(1);
    }

    self.script_demeanor = undefined;
  }

  if(isDefined(self.script_do_arrivals)) {
    set_do_arrivals(self.script_do_arrivals);
    self.script_do_arrivals = undefined;
  }

  if(isDefined(self.script_do_exits)) {
    set_do_exits(self.script_do_exits);
    self.script_do_exits = undefined;
  }

  if(isDefined(self.script_ignore_claimed)) {
    set_ignore_claimed(self.script_ignore_claimed);
    self.script_ignore_claimed = undefined;
  }

  if(isDefined(self.script_use_real_fire)) {
    set_real_fire(self.script_use_real_fire);
    self.script_use_real_fire = undefined;
  }

  if(isDefined(self.script_use_pain)) {
    set_use_pain(self.script_use_pain);
    self.script_use_pain = undefined;
  }

  if(isDefined(self.script_animname)) {
    self.animname = self.script_animname;
    self.script_animname = undefined;
  }

  if(istrue(level.var_c9386fa80eba881b)) {
    function_19ff13afbfa564cc();
  }

  function_fbc5fccc71a652b2();
  fakeactor_give_soul();
  self hide();
  utility::delaycall(0.05, &show);

  if(self.team == "?\xb1\xc0\x9a" && !isDefined(self.script_ignoreme)) {
    self enableaimassist();
  }

  if(!istrue(self.var_716ec2a6fb8e4d6d)) {
    self makeentitysentient(self.team, expendable);
  }

  thread fakeactor_thinks();
}

function function_9770699dda5e6226() {
  if(isDefined(self.health) && self.health > 0) {
    return;
  }

  set_animsets(["\xff\xd5d'hTb"]);
  fakeactor_give_soul();
  self.health = 1;
  self setCanDamage(0);
}

function function_e9d03fd33df0b54a() {
  if(function_3aa73dfa57e3cdb()) {
    return;
  }

  fakeactor_give_soul();
  set_animsets(["\xff\xd5d'hTb"]);
  function_fbc5fccc71a652b2();
  self.flags = 4096;
  thread death_think();
}

function private function_fbc5fccc71a652b2() {
  self setCanDamage(1);
  self.health = 150;

  if(self.team == "\xba\xa5\x1f\xc9m\x80i") {
    self.team = "O\x15\x1b\xad\x9ff";
  }
}

function create_state_machine(machinename) {
  if(!isDefined(level.fa_state_machines)) {
    level.fa_state_machines = [];
  }

  level.fa_state_machines[machinename] = [];
}

function get_state_machine(machinename) {
  return level.fa_state_machines[machinename];
}

function add_state(machinename, statename, thinkfunc, changefunc, priority) {
  if(!isDefined(level.fa_state_machines)) {
    level.fa_state_machines = [];
  }

  if(!isDefined(level.fa_state_machines[machinename])) {
    create_state_machine(machinename);
  }

  index = level.fa_state_machines[machinename].size;
  level.fa_state_machines[machinename][index] = [];
  level.fa_state_machines[machinename][index]["\x90\b*\xd3q\xdc\xd4^"] = priority;
  level.fa_state_machines[machinename][index]["\xed\xd0\xf0\xc4\x1f\x86\xe5~\xfb"] = statename;
  level.fa_state_machines[machinename][index]["\xe3d;h\x02\xfc\xdf\xfb\x19"] = thinkfunc;
  level.fa_state_machines[machinename][index]["]Bz\x8e?wAB\x81O"] = changefunc;
  level.fa_state_machines[machinename] = utility::array_sort_with_func(level.fa_state_machines[machinename], &is_higher_priority);
}

function remove_state(machinename, statename) {
  if(!isDefined(level.fa_state_machines[machinename])) {
    return;
  }

  new_states = [];

  foreach(state in level.fa_state_machines[machinename]) {
    if(state["\xed\xd0\xf0\xc4\x1f\x86\xe5~\xfb"] != statename) {
      new_states[new_states.size] = state;
    }
  }

  level.fa_state_machines[machinename] = new_states;
}

function fakeactor_give_soul() {
  setup_animation();

  if(self.team == "O\x15\x1b\xad\x9ff" && isDefined(self.name)) {
    names::get_name();
    self setlookattext(self.name, &"");
  } else if(self.team == "?\xb1\xc0\x9a") {
    self setlookattext("\xba8C\xef\xc2", &"");
  }

  if(isDefined(self.script_moveplaybackrate)) {
    self.moveplaybackrate = self.script_moveplaybackrate;
  } else {
    self.moveplaybackrate = 1;
  }

  if(!isDefined(self.script_friendly_fire_disable) || !self.script_friendly_fire_disable) {
    level thread friendlyfire::friendly_fire_think(self);
  }

  self startusingheroonlylighting();

  if(isDefined(self.target)) {
    fakeactor_target = utility::getStructArray(self.target, "\"\xe4\xaapX\x9d\xbd\xe9\xab\xcc");
    fakeactor_target = utility::random(fakeactor_target);

    if(isDefined(fakeactor_target) && fakeactor_target fakeactor_node::is_fakeactor_node()) {
      set_current_node(fakeactor_target);
    }
  }
}

function fakeactor_thinks() {
  waittillframeend();
  thread update_state_machine();
  thread move_message_think();
  thread watch_aim_target_think();
  thread make_real_ai_think();
  thread death_think();

  if(getDvar(@ "debug_fakeactor") == "<dev string:x24>") {
    thread debug_draw();
  }
}

function make_real_ai_think() {
  self endon("\x1e\xfd\xd1\xa2\a");
  thread real_ai_distance_check();
  self waittill("!k\x85\xac\xe8P\xe5\x17\xb1\xf4m#");
  ai::stop_magic_bullet_shield();
  current_weapon = self.weapon;
  target_override = "";

  if(isDefined(self.current_node) && isDefined(self.current_node.target)) {
    target_override = self.current_node.target;
  }

  ai = spawner::spawner_makerealai(self, target_override);
  ai shared::placeweaponon(current_weapon, "o0\xee\xc1\x8c");

  if(isDefined(self)) {
    self delete();
  }
}

function function_19ff13afbfa564cc(radius) {
  fakeai = self;

  if(!isDefined(fakeai.nav_repulsor)) {
    repulsorname = "\x7fdw\x0e\x85sg\xba\xf2" + fakeai getentitynumber();
    fakeai.nav_repulsor = repulsorname;
    createnavrepulsor(repulsorname, -1, fakeai, radius, undefined, "O\x15\x1b\xad\x9ff", "\xba\xa5\x1f\xc9m\x80i", "?\xb1\xc0\x9a");
    fakeai thread function_59eb1e1b2abea84e();
  }
}

function function_1123949b442d9bd7() {
  fakeai = self;

  if(isDefined(fakeai.nav_repulsor)) {
    destroynavrepulsor(fakeai.nav_repulsor);
    fakeai.nav_repulsor = undefined;
    self notify("\ty4\x01\x0e\xc9e\xdf\xdb[\x01\xb96)Mb\x02C\xb1\xb8");
  }
}

function private function_59eb1e1b2abea84e() {
  self endon("\ty4\x01\x0e\xc9e\xdf\xdb[\x01\xb96)Mb\x02C\xb1\xb8");
  self waittill("\x1e\xfd\xd1\xa2\a");
  function_1123949b442d9bd7();
}

function watch_for_obstacles_think() {
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("\x83\xd6\xaf\x11");
  var_9b3e0f639d193349 = squared(128);

  while(true) {
    if(distancesquared(level.player getorigin(), self.origin) < var_9b3e0f639d193349) {
      obstacle_in_way(1);
    } else {
      obstacle_in_way(0);
    }

    wait 0.05;
  }
}

function real_ai_distance_check() {
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("!k\x85\xac\xe8P\xe5\x17\xb1\xf4m#");

  if(!isDefined(self.radius) || self.radius <= 0) {
    return;
  }

  while(true) {
    if(distancesquared(level.player getEye(), self.origin) < squared(self.radius)) {
      self notify("!k\x85\xac\xe8P\xe5\x17\xb1\xf4m#");
      return;
    }

    wait 0.05;
  }
}

function check_node_is_claimed() {
  if(is_ignore_claimed()) {
    return 0;
  }

  return self.current_node fakeactor_node::fakeactor_node_is_claimed_by(self);
}

function change_state(state) {
  self.previous_state = self.current_state;
  self notify("\xe1\xf4\xafo8\xdb\x15t\x7fQ)\xc1");
  cleanup_state_ents();
  self.current_state = state["\xed\xd0\xf0\xc4\x1f\x86\xe5~\xfb"];
  self thread[[state["\xe3d;h\x02\xfc\xdf\xfb\x19"]]]();
}

function add_state_ent(ent) {
  if(!isDefined(self.current_state_ents)) {
    self.current_state_ents = [];
  }

  self.current_state_ents[self.current_state_ents.size] = ent;
}

function cleanup_state_ents() {
  if(isDefined(self.current_state_ents)) {
    foreach(ent in self.current_state_ents) {
      if(isDefined(ent)) {
        ent delete();
      }
    }
  }
}

function update_state_machine() {
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("!k\x85\xac\xe8P\xe5\x17\xb1\xf4m#");
  self.previous_state = "";
  state_machine = "\x91\xca\xcc\v\xab\xd8:";

  if(isDefined(self.state_machine)) {
    state_machine = self.state_machine;
  }

  while(true) {
    wait 0.05;

    if(is_controlled()) {
      continue;
    }

    foreach(state in get_state_machine(state_machine)) {
      if(isDefined(self.current_state) && self.current_state == state["\xed\xd0\xf0\xc4\x1f\x86\xe5~\xfb"]) {
        continue;
      }

      if([[state["]Bz\x8e?wAB\x81O"]]]()) {
        change_state(state);
        break;
      }
    }
  }
}

function idle_check() {
  if(!isDefined(self.current_state)) {
    return true;
  }

  if(self.current_node fakeactor_node::fakeactor_node_is_claimed_by(self)) {
    return true;
  }

  return false;
}

function idle_think() {
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("\xe1\xf4\xafo8\xdb\x15t\x7fQ)\xc1");
  self endon("\xd8\xc2p\xd7\xdcG\v\xc9:");
  fakeactor_check_delete();
  self notify("\x83\xd6\xaf\x11");

  while(isDefined(self)) {
    if(isDefined(self.idle_anim_override)) {
      play_scripted_anim(get_idle_anim());
      continue;
    }

    if(isDefined(self.unittype) && self.unittype == "75\xffQ\x95\xfe`\x9a") {
      childthread civ_think();
      self waittill("}a\x7f\xca\xae\"a\x8a\xb7w'\xa8dN%\x1b");
      continue;
    }

    childthread fight_think();
    self waittill("}a\x7f\xca\xae\"a\x8a\xb7w'\xa8dN%\x1b");
  }
}

function fight_think() {
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("\xe1\xf4\xafo8\xdb\x15t\x7fQ)\xc1");
  self endon("\xd8\xc2p\xd7\xdcG\v\xc9:");

  if(!isDefined(self.ignoreall)) {
    if(isDefined(self.current_node)) {
      possible_targets = self.current_node utility::get_linked_ents();
      possible_targets = utility::array_combine(possible_targets, self.current_node utility::get_linked_structs());

      if(possible_targets.size) {
        target = utility::random(possible_targets);
        offset = (0, 0, 0);

        if(isDefined(target.radius)) {
          x_offset = randomfloatrange(target.radius * -1, target.radius);
          y_offset = randomfloatrange(target.radius * -1, target.radius);
          offset = (x_offset, y_offset, 0);
        }

        set_aim_target(target, offset);
      }
    }

    hide_to_aim_anim = get_hide_to_aim_anim();
    aim_to_hide_anim = get_aim_to_hide_anim();
    old_origin = self.origin;

    if(isDefined(hide_to_aim_anim) && isDefined(aim_to_hide_anim)) {
      play_scripted_anim(hide_to_aim_anim);
    }

    self notify("\x93{\xdf\xe6\x03#\v-\xc7");
    fire_weapon(get_shoot_anim());
    self notify("R\x80\xa7\xd0$#\x17");

    if(isDefined(hide_to_aim_anim) && isDefined(aim_to_hide_anim)) {
      play_scripted_anim(aim_to_hide_anim);
    }

    if(should_fire()) {
      reload_anim = get_reload_anim();

      if(isDefined(reload_anim)) {
        play_scripted_anim(reload_anim);
      }
    }

    if(utility::cointoss()) {
      prev_animset = self.animset;
      pick_random_animset();

      if(self.animset != prev_animset) {
        play_scripted_anim(get_stance_change_anim());
      }
    }
  }

  play_scripted_anim(get_idle_anim());
  set_wants_to_move(1);
  self notify("}a\x7f\xca\xae\"a\x8a\xb7w'\xa8dN%\x1b");
}

function civ_think() {
  play_scripted_anim(get_idle_anim());
  self notify("}a\x7f\xca\xae\"a\x8a\xb7w'\xa8dN%\x1b");
}

function traverse_check() {
  if(isDefined(self.current_node) && self.current_node fakeactor_node::fakeactor_node_is_claimed_by(self) && self.current_node fakeactor_node::fakeactor_node_is_traverse()) {
    return true;
  }

  return false;
}

function traverse_think() {
  self endon("\x1e\xfd\xd1\xa2\a");
  set_controlled(1);
  animation = do_traverse_anim(self.current_node.traverse_animscript);
  set_controlled(0);
  set_wants_to_move(1);
}

function turn_check() {
  if(self.current_node fakeactor_node::fakeactor_node_is_claimed_by(self) && self.current_node fakeactor_node::fakeactor_node_is_turn()) {
    return true;
  }

  return false;
}

function turn_think() {
  self endon("\x1e\xfd\xd1\xa2\a");
  set_controlled(1);
  next_node = self.current_node fakeactor_node::fakeactor_node_get_next();
  play_scripted_anim(get_turn_anim(self.angles, self.origin, next_node.origin));
  set_controlled(0);
  set_wants_to_move(1);
}

function play_anim_check() {
  if(isDefined(self.current_node) && self.current_node fakeactor_node::fakeactor_node_is_claimed_by(self) && self.current_node fakeactor_node::fakeactor_node_is_animation()) {
    if(!isDefined(self.current_node.last_actor) || self.current_node.last_actor != self) {
      return true;
    }
  }

  return false;
}

function play_anim_think() {
  self endon("\x1e\xfd\xd1\xa2\a");
  set_controlled(1);
  self.current_node.anim_node animation::anim_generic_run(self, self.current_node.animation);
  self.current_node.last_actor = self;
  set_controlled(0);
  set_wants_to_move(1);
  self notify("i\xa0.\f\xeb6b\xa2d\xae\xe2");
}

function do_traverse_anim(traverse_animscript) {
  traverse_animation = get_traverse_anim(traverse_animscript);

  if(!isDefined(traverse_animation)) {
    assertmsg("<dev string:x9e>");
  }

  play_scripted_anim(traverse_animation, undefined, &handletraversenotetracks, "\xf9\xb2O\x89C\xcc\xae~G=\xb2A", self.current_node);
}

function move_message_think() {
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("!k\x85\xac\xe8P\xe5\x17\xb1\xf4m#");

  while(true) {
    self waittill("\x80[\xb3\x9d");
    set_wants_to_move(1);
  }
}

function move_check() {
  if(isDefined(self.forced_node_path)) {
    self.node_path = self.forced_node_path;
    self.forced_node_path = undefined;
    return true;
  }

  if(!isDefined(self.current_node)) {
    return false;
  }

  wants_to_move = does_want_to_move();
  node_path = undefined;

  if(!isDefined(self.current_state) && isDefined(self.current_node)) {
    node_path = fakeactor_node::fakeactor_node_get_path(self.current_node, self.origin, is_frantic(), wants_to_move);
  }

  if(self.current_node fakeactor_node::fakeactor_node_is_claimed_by(self) && !self.current_node fakeactor_node::fakeactor_node_is_end_path(wants_to_move)) {
    next_node = self.current_node fakeactor_node::fakeactor_node_get_next();
    node_path = fakeactor_node::fakeactor_node_get_path(next_node, self.origin, is_frantic(), wants_to_move);
  }

  if(isDefined(node_path)) {
    foreach(node in node_path) {
      if(node["_ts\xfc"] > 0) {
        self.node_path = node_path;
        return true;
      }
    }
  }

  return false;
}

function play_running_anim() {
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("\xe1\xf4\xafo8\xdb\x15t\x7fQ)\xc1");
  self endon("\xd8\xc2p\xd7\xdcG\v\xc9:");
  self notify("\x942\xd0=69e\x90i\xe2\xfdd\x90\x93\x18\xc8.");
  self endon("\x942\xd0=69e\x90i\xe2\xfdd\x90\x93\x18\xc8.");
  run_rate = 1;

  if(isDefined(self.run_rate_min) && isDefined(self.run_rate_max)) {
    run_rate = randomfloatrange(self.run_rate_min, self.run_rate_max);
  }

  while(true) {
    run_anim = get_movement_anim();
    var_964062aa1507bf1a = get_anim_data(run_anim);
    run_speed = var_964062aa1507bf1a.run_speed;
    anim_relative = var_964062aa1507bf1a.anim_relative;
    play_running_anim_internal(run_anim, run_rate);
    wait getanimlength(run_anim);
  }
}

function move_think() {
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("\xe1\xf4\xafo8\xdb\x15t\x7fQ)\xc1");
  self endon("\xd8\xc2p\xd7\xdcG\v\xc9:");
  self notify("\xce\xfd\x02\xc2\xb0\xeco\x8e\xc1");
  start_pos = self.origin;
  wants_to_move = does_want_to_move();

  if(self.node_path.size == 0) {
    assertmsg("<dev string:x105>");
  }

  if(isDefined(self.current_node)) {
    self.current_node fakeactor_node::fakeactor_node_remove_claimed(self);
  }

  run_anim = get_movement_anim();
  var_964062aa1507bf1a = get_anim_data(run_anim);
  run_speed = var_964062aa1507bf1a.run_speed;
  anim_relative = var_964062aa1507bf1a.anim_relative;

  if(!anim_relative) {
    childthread lock_to_ground(run_speed);
  }

  last_node = self.node_path[self.node_path.size - 1];

  if(self.node_path[0]["\xd7\xdbDs[\xc9\xa1J\xc1\xdc"] < 64) {
    thread play_scripted_anim(get_idle_anim());
    mover = utility::spawn_script_origin(self.origin, self.angles);
    add_state_ent(mover);
    self linkTo(mover);
    time = 0.2;
    mover moveTo(last_node["\xb0$R\x8b\xc9\x17"], time);
    mover rotateTo(last_node["\xc5\x94\x82H\x9a`"], time);
    utility::waittill_notify_or_timeout("\x1e\xfd\xd1\xa2\a", time);
    self unlink();
    mover delete();

    if(self.current_node != last_node["H\x86\n\x01"]) {
      self.current_node = last_node["H\x86\n\x01"];
    }

    self.current_node fakeactor_node::fakeactor_node_set_claimed(self);
    fakeactor_check_node(self.current_node);
    set_wants_to_move(0);
    self notify(")\x99\xe6\x88g\x16\xa0\x04\x03\xef\r");
    return;
  }

  var_369fddaea7ef9058 = 0;
  exit_pos = undefined;

  if(should_do_exits()) {
    next_node = 0;

    foreach(node in self.node_path) {
      if(next_node) {
        exit_pos = node["\xb0$R\x8b\xc9\x17"];
        break;
      }

      if(node["_ts\xfc"] > 0) {
        next_node = 1;
      }
    }

    if(isDefined(exit_pos)) {
      exit_anim = get_exit_anim(exit_pos);
      play_scripted_anim(exit_anim);
    }
  }

  arrival_anim = undefined;
  arrival_cover = utility::random(last_node["H\x86\n\x01"] fakeactor_node::fakeactor_node_get_cover_list());

  if(should_do_arrivals() && !last_node["H\x86\n\x01"] fakeactor_node::fakeactor_node_is_traverse() && !last_node["H\x86\n\x01"] fakeactor_node::fakeactor_node_is_turn() && last_node["H\x86\n\x01"] fakeactor_node::fakeactor_node_allow_arrivals()) {
    start_node = self;

    if(isDefined(self.node_path[self.node_path.size - 2]["H\x86\n\x01"])) {
      start_node = self.node_path[self.node_path.size - 2]["H\x86\n\x01"];
    }

    arrival_anim = get_arrival_anim(last_node["H\x86\n\x01"], start_node, arrival_cover);

    if(isDefined(arrival_anim)) {
      move_delta = getmovedelta(arrival_anim, 0, 1);
      angles_delta = getangledelta3d(arrival_anim, 0, 1);
      var_f09654c1f92aac70 = invertangles(angles_delta);
      new_angles = combineangles(last_node["\xc5\x94\x82H\x9a`"], var_f09654c1f92aac70);
      new_origin = last_node["\xb0$R\x8b\xc9\x17"] - rotatevector(move_delta, new_angles);
      last_node["\xa8\xfb\xb5\x9d\n\"(\v\x15"] = utility::spawn_script_origin(new_origin, new_angles);
      add_state_ent(last_node["\xa8\xfb\xb5\x9d\n\"(\v\x15"]);
      last_node["\xb0$R\x8b\xc9\x17"] = new_origin;
      last_node["\xc5\x94\x82H\x9a`"] = new_angles;
    }
  }

  thread play_running_anim();
  thread watch_for_obstacles_think();
  self.current_node = self.node_path[var_369fddaea7ef9058 + 1]["H\x86\n\x01"];
  move_scale = 1;

  if(isDefined(self.move_scale)) {
    move_scale = self.move_scale;
  }

  while(true) {
    var_a634709a3524bb25 = self.node_path[var_369fddaea7ef9058][":\xbd\xd7\xe6\x95\x87t_\xe6o\x91\xac"];
    var_a77e5ba5c786feaf = self.origin - self.node_path[var_369fddaea7ef9058]["\xb0$R\x8b\xc9\x17"];
    var_17e79b56a507cb38 = vectordot(var_a634709a3524bb25, var_a77e5ba5c786feaf);

    if(var_369fddaea7ef9058 == self.node_path.size) {
      break;
    }

    var_ac8fb9bb240ffa = var_17e79b56a507cb38 + self.look_ahead_value;

    while(var_ac8fb9bb240ffa > self.node_path[var_369fddaea7ef9058]["_ts\xfc"]) {
      var_ac8fb9bb240ffa -= self.node_path[var_369fddaea7ef9058]["_ts\xfc"];
      var_369fddaea7ef9058++;

      if(var_369fddaea7ef9058 == self.node_path.size) {
        if(self.current_node != last_node["H\x86\n\x01"]) {
          self.current_node = last_node["H\x86\n\x01"];
        }

        time = 0;
        desired_forward = (0, 0, 0);
        current_up = (0, 0, 0);
        new_right = (0, 0, 0);
        var_ebd0187f46e4da5f = last_node["\xb0$R\x8b\xc9\x17"] - self.origin;
        desired_forward = vectortoangles(var_ebd0187f46e4da5f);
        dist = length(var_ebd0187f46e4da5f);
        time = dist / run_speed * move_scale;

        if(time > 0) {
          if(anim_relative) {
            self moveTo(last_node["\xb0$R\x8b\xc9\x17"], time);
            self rotateTo(desired_forward, time * 0.25);
            wait time;
          } else {
            mover = utility::spawn_script_origin(self.origin, self.angles);
            add_state_ent(mover);
            self linkTo(mover);
            mover moveTo(last_node["\xb0$R\x8b\xc9\x17"], time);
            mover rotateTo(desired_forward, time * 0.25);
            utility::waittill_notify_or_timeout("\x1e\xfd\xd1\xa2\a", time);
            self unlink();
            mover delete();
          }
        }

        if(isDefined(arrival_anim)) {
          self notify("\x942\xd0=69e\x90i\xe2\xfdd\x90\x93\x18\xc8.");
          play_scripted_anim(arrival_anim, undefined, undefined, undefined, last_node["\xa8\xfb\xb5\x9d\n\"(\v\x15"], 0);
          last_node["\xa8\xfb\xb5\x9d\n\"(\v\x15"] delete();
          set_animsets([arrival_cover]);
        } else {
          self.angles = last_node["\xc5\x94\x82H\x9a`"];
          set_animsets(self.current_node fakeactor_node::fakeactor_node_get_cover_list());
        }

        if(isDefined(self.node_path[var_369fddaea7ef9058 - 1]["\x94\x17\xae~\x1c\x9f\xe5"])) {
          var_369fddaea7ef9058 = 1;
          self.current_node = self.node_path[var_369fddaea7ef9058 + 1]["H\x86\n\x01"];
          break;
        } else {
          self.current_node fakeactor_node::fakeactor_node_set_claimed(self);
          fakeactor_check_node(self.current_node);
          self notify("\x942\xd0=69e\x90i\xe2\xfdd\x90\x93\x18\xc8.");
          set_wants_to_move(0);
          self notify(")\x99\xe6\x88g\x16\xa0\x04\x03\xef\r");
          self notify("\x05[\xf8\x84\x04\x06\x01:p\x01\xde\x10\xcc\xb3\xb0\xf8");
          self notify("\x83\xd6\xaf\x11");
          return;
        }

        continue;
      }

      if(self.current_node != self.node_path[var_369fddaea7ef9058]["H\x86\n\x01"]) {
        self.current_node = self.node_path[var_369fddaea7ef9058]["H\x86\n\x01"];
        set_animsets(self.current_node fakeactor_node::fakeactor_node_get_cover_list());
        fakeactor_check_node(self.current_node);
      }
    }

    desired_pos = self.node_path[var_369fddaea7ef9058][":\xbd\xd7\xe6\x95\x87t_\xe6o\x91\xac"] * var_ac8fb9bb240ffa;
    desired_pos += self.node_path[var_369fddaea7ef9058]["\xb0$R\x8b\xc9\x17"];
    var_1524f53466b7678 = desired_pos;

    if(!anim_relative) {
      self.look_ahead_point = var_1524f53466b7678;
    }

    new_angles = vectortoangles(var_1524f53466b7678 - self.origin);
    childthread fakeactor_rotate_to(new_angles, self.loop_time);

    if(anim_relative) {
      var_8efe509ef4c6b530 = run_speed * self.loop_time * move_scale;
      move_vec = vectorNormalize(var_1524f53466b7678 - self.origin);
      desired_pos = move_vec * var_8efe509ef4c6b530;
      desired_pos += self.origin;
      self moveTo(desired_pos, self.loop_time);
    }

    if(getDvar(@ "debug_fakeactor") == "<dev string:x24>") {
      sphere(var_1524f53466b7678, 5, (0, 1, 1), 1, int(self.loop_time * 30) - 1);
      print3d(var_1524f53466b7678, var_ac8fb9bb240ffa + "<dev string:x13e>" + self.node_path[var_369fddaea7ef9058]["<dev string:x143>"] + "<dev string:x14b>" + var_369fddaea7ef9058 + "<dev string:x168>", (1, 1, 1), 1, 0.5, int(self.loop_time * 30) - 1);
    }

    wait self.loop_time;
  }

  self.node_path = undefined;
  set_wants_to_move(0);
  self notify(")\x99\xe6\x88g\x16\xa0\x04\x03\xef\r");
  self notify("\x05[\xf8\x84\x04\x06\x01:p\x01\xde\x10\xcc\xb3\xb0\xf8");
  self notify("\x83\xd6\xaf\x11");
}

function fakeactor_rotate_to(target_angles, time) {
  start_forward = anglesToForward(self.angles);
  target_forward = anglesToForward(target_angles);
  progress = 0;
  inv_time = 1 / time;

  while(true) {
    t = progress * inv_time;
    new_forward = vectorlerp(start_forward, target_forward, t);
    self.angles = vectortoangles(new_forward);
    progress += 0.05;
    wait 0.05;

    if(progress >= time) {
      break;
    }
  }

  self.angles = target_angles;
}

function fakeactor_check_delete() {
  if(!isDefined(self)) {
    return;
  }

  if(!isDefined(self.script_noteworthy)) {
    return;
  }

  switch (self.script_noteworthy) {
    case #"hash_2c3612c489888b90":
      if(isDefined(self.magic_bullet_shield)) {
        ai::stop_magic_bullet_shield();
      }

      self delete();
      break;
    case #"hash_1b3e853d9bd4735f":
      self kill();
      break;
  }
}

function fakeactor_check_node(node) {
  if(isDefined(node.script_noteworthy)) {
    switch (node.script_noteworthy) {
      case #"hash_2c3612c489888b90":
        if(isDefined(self.magic_bullet_shield)) {
          ai::stop_magic_bullet_shield();
        }

        self delete();
        break;
      case #"hash_1b3e853d9bd4735f":
        self kill();
        break;
    }
  }

  if(isDefined(node.script_flag_set)) {
    utility::flag_set(node.script_flag_set);
  }

  if(isDefined(node.script_flag_clear)) {
    utility::flag_clear(node.script_flag_clear);
  }

  if(isDefined(node.script_ent_flag_set)) {
    utility::ent_flag_set(node.script_ent_flag_set);
  }

  if(isDefined(self.script_ent_flag_clear)) {
    utility::ent_flag_set(node.script_ent_flag_clear);
  }

  if(isDefined(node.script_demeanor)) {
    if(node.script_demeanor == "]\"\x81\x02y\xf7\xa4") {
      set_frantic(1);
    }
  }

  if(isDefined(node.script_do_arrival)) {
    set_do_arrivals(node.script_do_arrival);
  }

  if(isDefined(node.script_do_exits)) {
    set_do_exits(node.script_do_exits);
  }

  if(isDefined(node.script_use_real_fire)) {
    set_real_fire(node.script_use_real_fire);
  }

  if(isDefined(node.script_use_pain)) {
    set_use_pain(node.script_use_pain);
  }
}

function lock_to_ground(run_speed) {
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("\xe1\xf4\xafo8\xdb\x15t\x7fQ)\xc1");
  self endon("\xd8\xc2p\xd7\xdcG\v\xc9:");
  self notify("29{7+\xf5[\xb7;\xac\xfa\xd3");
  self endon("29{7+\xf5[\xb7;\xac\xfa\xd3");
  var_6927ac6d7b5ba1f2 = 0.05;

  for(;;) {
    if(isDefined(self.look_ahead_point) && run_speed > 0) {
      z_delta = self.look_ahead_point[2] - self.origin[2];
      xy_delta = distance2d(self.look_ahead_point, self.origin);
      time_left = xy_delta / run_speed;

      if(time_left > 0 && z_delta != 0) {
        var_f2e5a898f7314f7d = abs(z_delta) / time_left;
        var_e884e05726582259 = var_f2e5a898f7314f7d * var_6927ac6d7b5ba1f2;

        if(z_delta >= var_f2e5a898f7314f7d) {
          self.origin = (self.origin[0], self.origin[1], self.origin[2] + var_e884e05726582259);
        } else if(z_delta <= var_f2e5a898f7314f7d * -1) {
          self.origin = (self.origin[0], self.origin[1], self.origin[2] - var_e884e05726582259);
        }
      }
    }

    wait var_6927ac6d7b5ba1f2;
  }
}

function set_current_node(target_node) {
  if(isDefined(self.current_node)) {
    self.current_node fakeactor_node::fakeactor_node_remove_claimed(self);
  }

  self.forced_node_path = undefined;
  self.current_node = target_node;
  set_animsets(self.current_node fakeactor_node::fakeactor_node_get_cover_list());
}

function teleport_to_node(target_node) {
  set_current_node(target_node);
  self.current_node fakeactor_node::fakeactor_node_set_claimed(self);
  fakeactor_check_node(self.current_node);
  self dontinterpolate();
  self.origin = self.current_node.origin;
  self.angles = self.current_node fakeactor_node::fakeactor_node_get_angles(is_frantic());
}

function clear_node_path() {
  if(isDefined(self.node_path)) {
    foreach(object in self.node_path) {
      if(isDefined(object["H\x86\n\x01"])) {
        object["H\x86\n\x01"] fakeactor_node::fakeactor_node_remove_claimed(self);
      }
    }
  }
}

function should_fire() {
  if(self.animset == "\xff\xd5d'hTb") {
    return 0;
  }

  if(isDefined(self.aim_target)) {
    return is_target_in_view();
  }

  return 1;
}

function fire_weapon(fire_anim) {
  self endon("\x1e\xfd\xd1\xa2\a");
  childthread aim_think();
  wait 0.25;
  var_f1fc9ca3898ce911 = weaponclipsize(self.weapon);
  weapon_fire_time = weaponfiretime(self.weapon);
  var_e76b647e4a68461 = weaponburstcount(self.weapon);
  weapon_class = weaponclass(self.weapon);
  weapon_ammo = var_f1fc9ca3898ce911;

  if(weapon_class == "\xff\x12\x9a\xbe.a") {
    weapon_ammo = 5;
  } else if(var_e76b647e4a68461 > 0) {
    weapon_ammo = var_e76b647e4a68461;
  }

  while(weapon_ammo > 0) {
    if(should_fire()) {
      flash_origin = self gettagorigin("\xfd\xef\xc3\r\xb4\xad\x84p\x84");
      flash_angles = self gettagangles("\xfd\xef\xc3\r\xb4\xad\x84p\x84");
      shoot_dir = anglesToForward(flash_angles);
      end_pos = flash_origin + shoot_dir * 1000;

      if(isDefined(self.aim_target)) {
        trace = trace::ray_trace(flash_origin, end_pos, self);

        if(getDvar(@ "debug_fakeactor") == "<dev string:x24>") {
          trace::draw_trace(trace, (0, 1, 1), 1, int(weapon_fire_time * 30));
        }

        if(isDefined(trace["\x1f\xa8\x10WP\xa9"]) && trace["\x1f\xa8\x10WP\xa9"] == self.aim_target) {
          accuracy = get_accuracy();

          if(randomfloat(1) > accuracy) {
            target_coll = self.aim_target physics_getcharactercollisioncapsule();
            target_up = anglestoup(self.aim_target.angles);
            up_miss = randomfloatrange(0, target_coll["\xf1\xa1\xdd%\xa2\x1e\xc3\xe1\x9cLq"] * 2);
            target_right = anglestoright(self.aim_target.angles);
            right_miss = target_coll["\x04\x1f\xf9.\xdbw"] * randomfloatrange(1, 2);

            if(utility::cointoss()) {
              right_miss *= -1;
            }

            var_5b6ac1bffb82c208 = self.aim_target.origin + target_up * up_miss + target_right * right_miss;
            shoot_dir = vectorNormalize(var_5b6ac1bffb82c208 - flash_origin);
            end_pos = flash_origin + shoot_dir * 1000;
          }
        }
      }

      if(should_real_fire()) {
        magicbullet(self.weapon, flash_origin, end_pos);
      } else {
        fake_bullet(self.weapon, flash_origin, end_pos, self.no_weapon_sound);
      }

      self setanimknobrestart(fire_anim, 1, 0.2, 1);
      utility::delaycall(0.15, &clearanim, fire_anim, 0);
    }

    weapon_ammo--;
    wait max(weapon_fire_time, 0.1);
  }
}

function get_accuracy(debug) {
  self_acc = self.baseaccuracy;
  target_acc = 1;

  if(isDefined(self.aim_target) && isDefined(self.aim_target.attackeraccuracy)) {
    target_acc = self.aim_target.attackeraccuracy;
  }

  dist_to_target = distance(self.origin, self.aim_target.origin);
  weapon_acc = getaccuracyfraction(self.weapon, dist_to_target, isPlayer(self.aim_target));
  pose = "\x8b\x90\xb5\xc4W";

  if(isPlayer(self.aim_target)) {
    pose = self.aim_target getstance();
  } else if(isai(self.aim_target)) {
    pose = self.aim_target.currentpose;
  }

  stance_acc = 1;

  if(pose == "1x\xc5\xb4\xabx") {
    stance_acc = 0.75;
  } else if(pose == "GX\xa9]\x82") {
    stance_acc = 0.5;
  }

  movement_acc = 1;

  if(isPlayer(self.aim_target)) {
    movement = level.player getnormalizedmovement();
    movement_acc = 1 - length(movement) * 0.3;
  } else if(isai(self.aim_target)) {}

  sight_acc = 0.75;
  total_acc = self_acc * target_acc * weapon_acc * stance_acc * movement_acc * sight_acc;

  if(isDefined(debug) && debug) {
    text_scale = 0.5;
    new_line = 11 * text_scale;
    cam_angles = level.player getplayerangles();
    cam_up = anglestoup(cam_angles);
    text_pos = self.origin;
    print3d(text_pos - cam_up * new_line * 0, "<dev string:x16d>" + self_acc, (1, 1, 1), 1, text_scale);
    print3d(text_pos - cam_up * new_line * 1, "<dev string:x17b>" + target_acc, (1, 1, 1), 1, text_scale);
    print3d(text_pos - cam_up * new_line * 2, "<dev string:x189>" + weapon_acc, (1, 1, 1), 1, text_scale);
    print3d(text_pos - cam_up * new_line * 3, "<dev string:x197>" + stance_acc, (1, 1, 1), 1, text_scale);
    print3d(text_pos - cam_up * new_line * 4, "<dev string:x1a5>" + movement_acc, (1, 1, 1), 1, text_scale);
    print3d(text_pos - cam_up * new_line * 5, "<dev string:x1b3>" + sight_acc, (1, 1, 1), 1, text_scale);
    print3d(text_pos - cam_up * new_line * 6, "<dev string:x1c1>" + total_acc, (1, 0, 0), 1, text_scale);
  }

  return total_acc;
}

function fake_bullet(weapon, start, end, no_sound) {
  bullettracer(start, end, weapon);
  playFXOnTag(utility::getfx("\xd4\xf6\x02|W\x1f\xb3+1W\xd7-[\xc7/A|\xca"), self, "\xfd\xef\xc3\r\xb4\xad\x84p\x84");

  if(!isDefined(no_sound) || !no_sound) {}
}

function get_target_point(ent) {
  if(isPlayer(ent)) {
    if(is_human()) {
      aim_height = 50;
    } else {
      aim_height = 50;
    }

    player_angles = ent getplayerangles();
    target_point = ent getorigin() + anglestoup(player_angles) * aim_height;
    return target_point;
  }

  if(isai(ent)) {
    return ent gettagorigin("\xb8y\xa4\x8fk\x05b\x02(U\xe7\xf3");
  }

  target_point = ent.origin;

  if(isDefined(self.aim_target_offset)) {
    target_point += self.aim_target_offset;
  }

  return target_point;
}

function aim_think() {
  self endon("R\x80\xa7\xd0$#\x17");
  transtime = 0.2;
  var_b32941ab529f126f = get_aim_anim("tc:G\xb5");

  if(isDefined(var_b32941ab529f126f)) {
    self setanimknoball(var_b32941ab529f126f, self.anim_branch["\xb7\x1bs\xf8"], 1, transtime);
  }

  self setanimlimited(get_aim_anim("\xa8E\xcd\xc5\x8c"), 1, transtime);
  self setanimlimited(get_aim_anim("=T\x8e\xf3\xa1"), 1, transtime);
  self setanimlimited(get_aim_anim("P\xee&_\x8d"), 1, transtime);
  self setanimlimited(get_aim_anim("?d\xad\x90x"), 1, transtime);
  var_c9aa15715084ae90 = 10;
  prevyawdelta = 0;
  prevpitchdelta = 0;
  firstframe = 1;

  while(isDefined(self.aim_target)) {
    my_eye = self gettagorigin("\xfd\xef\xc3\r\xb4\xad\x84p\x84");
    target_eye = get_target_point(self.aim_target);
    adjusted_aim = utility_sp::worldtolocalcoords(target_eye) - utility_sp::worldtolocalcoords(my_eye);
    shoot_angles = vectortoangles(adjusted_aim);
    pitchdelta = angleclamp180(shoot_angles[0]);
    yawdelta = angleclamp180(shoot_angles[1]);

    if(pitchdelta < self.upaimlimit || pitchdelta > self.downaimlimit || yawdelta < self.rightaimlimit || yawdelta > self.leftaimlimit) {
      set_target_in_view(0);
      pitchdelta = 0;
      yawdelta = 0;
    } else {
      set_target_in_view(1);
    }

    if(getDvar(@ "debug_fakeactor") == "<dev string:x24>") {
      base_angles = self gettagangles("<dev string:x1cf>");
      utility::draw_angles(base_angles, self gettagorigin("<dev string:x1cf>"));
      line(my_eye, target_eye, (1, 0, 1));
    }

    if(!firstframe) {
      yawdeltachange = yawdelta - prevyawdelta;

      if(abs(yawdeltachange) > var_c9aa15715084ae90) {
        yawdelta = prevyawdelta + clamp(yawdeltachange, -1 * var_c9aa15715084ae90, var_c9aa15715084ae90);
      }

      pitchdeltachange = pitchdelta - prevpitchdelta;

      if(abs(pitchdeltachange) > var_c9aa15715084ae90) {
        pitchdelta = prevpitchdelta + clamp(pitchdeltachange, -1 * var_c9aa15715084ae90, var_c9aa15715084ae90);
      }
    }

    pitchdelta = clamp(pitchdelta, self.upaimlimit, self.downaimlimit);
    yawdelta = clamp(yawdelta, self.rightaimlimit, self.leftaimlimit);
    firstframe = 0;
    prevyawdelta = yawdelta;
    prevpitchdelta = pitchdelta;
    aim_weights(self.anim_branch["\xa8E\xcd\xc5\x8c"], self.anim_branch["=T\x8e\xf3\xa1"], self.anim_branch["P\xee&_\x8d"], self.anim_branch["?d\xad\x90x"], pitchdelta, yawdelta);
    wait 0.05;
  }
}

function get_animation_from_alias(archetype, statename, alias, frantic) {
  assert(isDefined(archetype), "<dev string:x1dd>");
  aliasdata = archetypegetalias(archetype, statename, alias, frantic);

  if(isDefined(aliasdata)) {
    if(isarray(aliasdata.anims)) {
      if(isDefined(aliasdata.weights)) {
        totalweights = 0;

        foreach(weight in aliasdata.weights) {
          totalweights += weight;
        }

        assert(aliasdata.anims.size == aliasdata.weights.size, "<dev string:x1fa>" + archetype + "<dev string:x240>" + statename + "<dev string:x24b>" + alias);
        randnum = randomfloat(totalweights);
        accum = 0;

        for(ianim = 0; ianim < aliasdata.anims.size; ianim++) {
          accum += aliasdata.weights[ianim];

          if(accum > randnum) {
            return aliasdata.anims[ianim];
          }
        }

        assertmsg("<dev string:x256>" + archetype + "<dev string:x283>" + statename + "<dev string:x283>" + alias);
      } else {
        randnum = randomint(aliasdata.anims.size);
        return aliasdata.anims[randnum];
      }
    } else {
      return aliasdata.anims;
    }

    return;
  }

  assertmsg("<dev string:x28a>" + alias + "<dev string:x2c0>" + statename + "<dev string:x2ce>" + archetype);
}

function get_animation(statename, alias) {
  animation = get_animation_from_alias(self.animationarchetype, statename, alias, is_frantic());

  if(isarray(animation)) {
    animation = utility::random(animation);
  }

  self.last_anim = statename + "<dev string:x2e1>" + alias;

  return animation;
}

function get_idle_anim() {
  if(isDefined(self.idle_anim_override)) {
    return self.idle_anim_override;
  }

  if(self.unittype != "75\xffQ\x95\xfe`\x9a") {
    if(utility::cointoss()) {
      if(self.animset == "\xff\xd5d'hTb") {
        return get_animation("\x9bT\x03DAr8\xc8jG\xcb\xbc\xd9vL\xc4\x83\x04\x19`", "\x9bT\x03DAr8\xc8jG\xcb\xbc\xd9vL\xc4\x83\x04\x19`");
      } else {
        return get_animation(self.animset, "o\xc6\xaa\xa8^\x9e\x06\x01\x7f");
      }
    } else {
      switch (self.animset) {
        case #"hash_175771022bc5e75d":
        case #"hash_4ddb655e251e06c8":
        case #"hash_9d76c99eddd14433":
        case #"hash_e7aface284179b3b":
          return get_animation(self.animset + "\xc6G`\xf1\x1c", "\x91\xca\xcc\v\xab\xd8:");
        case #"hash_f1676baca0ae608b":
          return get_animation(self.animset + "\xc6G`\xf1\x1c", "~\x9e\x95,");
        case #"hash_c475427a998ee26c":
          return get_animation(self.animset, "o\xc6\xaa\xa8^\x9e\x06\x01\x7f");
        case #"hash_d44cb989edc40ab3":
          return get_animation("\x9bT\x03DAr8\xc8jG\xcb\xbc\xd9vL\xc4\x83\x04\x19`", "\xc1[\xe4O@\x89~\xdf\x96f\x9cmG\x85\xa6eN\xc6DG\xd8\x1fu\x1b\xd6\xfa\x1f");
      }
    }

    return;
  }

  switch (self.animset) {
    case #"hash_d44cb989edc40ab3":
      return get_animation("\x91\x88\xc2*", "\x91\xca\xcc\v\xab\xd8:");
  }
}

function get_movement_anim() {
  if(isDefined(self.run_anim_override)) {
    return self.run_anim_override;
  }

  alias = "\x91\xca\xcc\v\xab\xd8:";

  if(isDefined(self.run_anim_alias)) {
    alias = self.run_anim_alias;
  }

  return get_animation("\x0f\x18~g\x8d#\x14t\xa4:R\xd6Yl", alias);
}

function get_turn_anim(viewerangles, viewerorigin, targetorigin) {
  anglestopoint = vectortoangles(targetorigin - viewerorigin);
  angle = viewerangles[1] - anglestopoint[1];
  angle += 360;
  angle = int(angle) % 360;
  direction = "";

  if(angle > 315 || angle < 45) {
    return undefined;
  } else if(angle >= 150 && angle <= 210) {
    direction = "\x19";
  } else if(angle < 90) {
    direction = "i";
  } else if(angle > 270) {
    direction = "{";
  } else if(angle < 135) {
    direction = "\xbb";
  } else if(angle > 225) {
    direction = "P";
  } else if(angle < 150) {
    direction = "?";
  } else if(angle > 210) {
    direction = "\x87";
  }

  return get_animation("\xc9W\x9b\xfa:u\xe4\xdc", "=\xff0b" + direction);
}

function get_shoot_anim() {
  switch (self.animset) {
    case #"hash_9d76c99eddd14433":
    case #"hash_c475427a998ee26c":
    case #"hash_e7aface284179b3b":
      return get_animation("& 47\xf5\xf4\x0e\\@\x80jN\xce\xe0!\xd2\xde^", "\xcciN\xca");
    case #"hash_175771022bc5e75d":
    case #"hash_4ddb655e251e06c8":
    case #"hash_f1676baca0ae608b":
      return get_animation(">\t\xd1lL\xa5,\xc5\x14/", "\xcciN\xca");
    case #"hash_d44cb989edc40ab3":
      return get_animation(">\t\xd1lL\xa5,\xc5\x14/", "\xcciN\xca");
  }
}

function get_aim_anim(aim) {
  switch (self.animset) {
    case #"hash_9d76c99eddd14433":
      return get_animation("-\xb8!\xf1\f\x96\xe3kn\x95n\x15\xa3\"\x18$", "[\xcf\xf2\x89\x03\x18" + aim);
    case #"hash_e7aface284179b3b":
      if(aim == "tc:G\xb5") {
        return undefined;
      }

      return get_animation("\xb4\x1aS\x853g\x8f|f\xc0\x96\xf0\x8fN\x9e@R\xcd\x01\xeb\x92I\xbc\xb4V", "[\xcf\xf2\x89\x03\x18" + aim);
    case #"hash_c475427a998ee26c":
      if(aim == "tc:G\xb5") {
        return undefined;
      }

      return get_animation("\x8b\xe2+ \xf0;\x7f\xbb?\xf9&\xd6\xc8\xa3\x89n\t\xa6\xb6\x1f\b\x8c\xef\xff\x99\xce", "[\xcf\xf2\x89\x03\x18" + aim);
    case #"hash_f1676baca0ae608b":
      return get_animation("\x84p\xb8\xc8\xaf\xc0\xf12\xd4|\xfeC1\x96\xd8/1\xaf\x8d", "[\xcf\xf2\x89\x03\x18" + aim);
    case #"hash_4ddb655e251e06c8":
      if(aim == "tc:G\xb5") {
        return undefined;
      }

      return get_animation("Pk_8\x92zB\x1d\xf6S\x19-\x88:\xd3\x10\xa1>c\xee", "[\xcf\xf2\x89\x03\x18" + aim);
    case #"hash_175771022bc5e75d":
      if(aim == "tc:G\xb5") {
        return undefined;
      }

      return get_animation("N\xf8\t\xbd\xda\x98\xee3\xf0\xefD\x11\xb6\xab\x7fINzl:V", "[\xcf\xf2\x89\x03\x18" + aim);
    case #"hash_d44cb989edc40ab3":
      return get_animation("{\xa1H8_\xf2\xea<\f\x8a\xad}", "[\xcf\xf2\x89\x03\x18" + aim);
  }
}

function get_hide_to_aim_anim() {
  switch (self.animset) {
    case #"hash_9d76c99eddd14433":
      return get_animation("u\x18c\x87z1\xa4U\xad\x80\xb0V\x8ahVMF\xb8#\x8e\xcd\xfe\xa0\xad", "\x1aiFe\xeb\x1d\xdb}\vK\xb5");
    case #"hash_f1676baca0ae608b":
      return get_animation("x\xf5CU\xb9\x95\x15\xde\xc9\xa2\x935\xd9\xbf\xf3\x95F\xb8\x18\xf2\xda\xa1\x94\xc3\x91\x99\xed", "\xa1-\x8cV\xf5\x1d\xed\xf5\xacx\x83{\x9b\x95d");
    case #"hash_4ddb655e251e06c8":
      return get_animation("1py\xfc\x02\xa8\xec\xc1\xbdi\x93\xa6ue\xcf\xb7\xf0\xcexa", "\xa1-\x8cV\xf5\x1d\xed\xf5\xacx\x83{\x9b\x95d");
    case #"hash_175771022bc5e75d":
      return get_animation("\xcext\xc1W#\xc8\xe2\n\x88[\xf3\x97\xe3\x12[\xfdd\xe1\xe0\x91", "\xa1-\x8cV\xf5\x1d\xed\xf5\xacx\x83{\x9b\x95d");
    case #"hash_e7aface284179b3b":
      return get_animation("\xb6l\xef\x81\x16|\xedYax\xd4\xf7Y\x9bx\x9e\x88:>\f\xca\xfbi9\xc5F\x86", "I,\x03\xe4\xc8\xf4/\t\xf6");
    case #"hash_c475427a998ee26c":
      return get_animation("\xe3\xaa\xbe\x86\xf2\xfd\xec\x1c\x82x\xc2j\xc3&\xfe[\xd6;\x88@H3\x1c\x18\x06\xfb\xed\xd5", "I,\x03\xe4\xc8\xf4/\t\xf6");
  }

  return undefined;
}

function get_aim_to_hide_anim() {
  switch (self.animset) {
    case #"hash_9d76c99eddd14433":
      return get_animation("n~C4\x13\xafw\xf7\xb7s$\xb9\xf0\xb7\xf8\xfdQ%W\xf09\xf4r3", "T\xfd\xec\x9d\xe9\xd9\xee\x8e\xae\x89\xd8");
    case #"hash_f1676baca0ae608b":
      return get_animation("X\x93x\xba\xdfR\fHI\x18j\xf6\xcb,1\tqu\xaeO'\xaf\x9e>\xe3\xeeF", "\x06\xab\xa8\xbb\x13E[_p\x9f\xabR\xdc\xd0l");
    case #"hash_4ddb655e251e06c8":
      return get_animation("c\xb0tE\xa2X\f~\x17.gN\x93C\ac\x1bfE\xf5", "\x06\xab\xa8\xbb\x13E[_p\x9f\xabR\xdc\xd0l");
    case #"hash_175771022bc5e75d":
      return get_animation("l\xbdg\x95\x9c\xd7\x9c\xd2\xce\x86t\xbe\x90\xd7\x1d\xdb\xaf\r-\x91\x95", "\x06\xab\xa8\xbb\x13E[_p\x9f\xabR\xdc\xd0l");
    case #"hash_e7aface284179b3b":
      return get_animation("\xd1\xe9\r\xa0\x1a\"\xe2+\xf9\xb7J\xbb\xf5\xfb\xbe\x06A'P{\xe4_\x84\xd7\xdc\xb7\x16", "x\x03\xddS\xb8H\x14\a\xe5");
    case #"hash_c475427a998ee26c":
      return get_animation("\xea\xc0\x8b\xa8\x04R\xee\x19#\xb0\x80\xb7\xf3\xea\xc9\x97\xc8\xc4\x9f\vC\xaa\xcd\xe5\xe8\xb1\xb0\xfc", "x\x03\xddS\xb8H\x14\a\xe5");
  }

  return undefined;
}

function get_arrival_anim(arrival_node, start_node, animset) {
  if(!isDefined(animset)) {
    animset = self.animset;
  }

  if(!isDefined(start_node)) {
    start_node = self;
  }

  state_name = animset + "\xfd&\xa56~\xe6\xa2\xe2";
  dir_val = utility_sp::get_direction_value(arrival_node.angles, arrival_node.origin, start_node.origin);

  switch (animset) {
    case #"hash_9d76c99eddd14433":
      if(dir_val == "i") {
        dir_val = "\xbb";
      } else if(dir_val == "{" || dir_val == "\f") {
        dir_val = "P";
      }

      break;
    case #"hash_f1676baca0ae608b":
      if(dir_val == "i") {
        dir_val = "\xbb";
      } else if(dir_val == "{" || dir_val == "\f") {
        dir_val = "P";
      }

      break;
    case #"hash_4ddb655e251e06c8":
      if(dir_val == "i") {
        dir_val = "\f";
      }

      break;
    case #"hash_175771022bc5e75d":
      if(dir_val == "{") {
        dir_val = "\f";
      }

      break;
    case #"hash_e7aface284179b3b":
      if(dir_val == "i") {
        dir_val = "\f";
      }

      break;
    case #"hash_c475427a998ee26c":
      if(dir_val == "{") {
        dir_val = "\f";
      }

      break;
    case #"hash_d44cb989edc40ab3":
      break;
    default:
      return undefined;
  }

  if(is_human()) {
    alias = "=\xff0b" + dir_val;
  } else {
    alias = dir_val;
  }

  return get_animation(state_name, alias);
}

function get_exit_anim(target_pos, start_pos, start_angles, animset) {
  if(!isDefined(start_pos)) {
    start_pos = self.origin;
  }

  if(!isDefined(start_angles)) {
    start_angles = self.angles;
  }

  if(!isDefined(animset)) {
    animset = self.animset;
  }

  state_name = animset + "!z\x84{\x8e";
  alias = utility_sp::get_direction_value(start_angles, start_pos, target_pos);

  switch (animset) {
    case #"hash_9d76c99eddd14433":
      if(alias == "i") {
        alias = "\xbb";
      } else if(alias == "{" || alias == "\f") {
        alias = "P";
      }

      return get_animation(state_name, alias);
    case #"hash_f1676baca0ae608b":
      if(alias == "i") {
        alias = "\xbb";
      } else if(alias == "{" || alias == "\f") {
        alias = "P";
      }

      return get_animation(state_name, alias);
    case #"hash_4ddb655e251e06c8":
      if(alias == "i") {
        alias = "\f";
      }

      return get_animation(state_name, alias);
    case #"hash_175771022bc5e75d":
      if(alias == "{") {
        alias = "\f";
      }

      return get_animation(state_name, alias);
    case #"hash_e7aface284179b3b":
      if(alias == "i") {
        alias = "\f";
      }

      return get_animation(state_name, alias);
    case #"hash_c475427a998ee26c":
      if(alias == "{") {
        alias = "\f";
      }

      return get_animation(state_name, alias);
    case #"hash_d44cb989edc40ab3":
      return get_animation(state_name, alias);
    default:
      return undefined;
  }
}

function get_reload_anim() {
  if(self.animset == "\xff\xd5d'hTb") {
    return get_animation("\xa8\x878\xde\xcde\x19\xaf\xa4e\xc6{,\x19", "\x93\xa536Y");
  }

  archetype = self.animset + "\x02\xa1\xf0\xa8]4\xbd";
  return get_animation(archetype, "\xc9\xca\x1boX\x8c");
}

function get_stance_change_anim() {
  switch (self.animset) {
    case #"hash_9d76c99eddd14433":
      return get_animation("P{Cx\xc0\x90\xb1{\xb9\b\x8e\xfc\xcd\x06Q\xf9\xb4\xbc\r\x84\xc0(\xb0", "s\x1d\v\xcd2_G\xb7\xf5\x1b\x9c\xdbu\xd8h");
    case #"hash_f1676baca0ae608b":
      return get_animation("SVD\xedl\xf9L\x90\x86\xb0NQ\xd5\x1c#Y\xe9\xf6\x06\xdd&T\xdd", "\xcd\t\xa8\x99n\\\xdb\xc0\f?o\xc4\xd4&\xb7");
    case #"hash_4ddb655e251e06c8":
      return get_animation("G[\xe8L\xce\x90y\xdd\x9f\xf3\x8a\xe6\xce\x05.{\xce[HB\xd8\x9c\xf4\x1f\xecy", "\xcd\t\xa8\x99n\\\xdb\xc0\f?o\xc4\xd4&\xb7");
    case #"hash_e7aface284179b3b":
      return get_animation("\xea\xc0\x8b\xa8\x04R\x1e)'\x88\xd6\xa1x\xf9I\xb5\xd6\xc3\xaf\x16\xc4\xca\xcd\xcf\xe3\xb3", "s\x1d\v\xcd2_G\xb7\xf5\x1b\x9c\xdbu\xd8h");
    case #"hash_175771022bc5e75d":
      return get_animation("\xce\tw\x87\x8c\xe2a\x12\xbe\xe4\x1d\x8e\xf4\xd1n:Ca\xb1\x82X\xce>\x88\x90\xf0A", "\xcd\t\xa8\x99n\\\xdb\xc0\f?o\xc4\xd4&\xb7");
    case #"hash_c475427a998ee26c":
      return get_animation("\x9d\xd0\x8f\xf7]\x80Kq?o'\xf26\xdb\xeb\t\xe0\xeb\x8d\x1bO\x8e\xb9\t\xe0\xf5\x0f", "s\x1d\v\xcd2_G\xb7\xf5\x1b\x9c\xdbu\xd8h");
  }

  return undefined;
}

function get_pain_anim() {
  if(is_moving()) {
    anim_type = utility::cointoss() ? "\xf4\xba8\xd4\x17" : "w=&\x15\xbd\xae";
    return get_animation("8\x85Z\xe6}'un\xf5d\x95\xccX\xd5l\x8e", anim_type);
  }

  switch (self.animset) {
    case #"hash_9d76c99eddd14433":
      return get_animation("\x15\x88\x11g\xc7\xedwvC\rg{p\xf8yd\xd4\xd1Kn1\xe9", "\xe9\xe5\bv\xbe\xc7U\\:\xe5");
    case #"hash_f1676baca0ae608b":
      return get_animation("&\x8c\xebAv\xfa\x96\r\xbd\xb7+\xf0S\xc7\xd7\x93\xfd\xc6{f\xd8", "\xe9\xe5\bv\xbe\xc7U\\:\xe5");
    case #"hash_4ddb655e251e06c8":
      return get_animation("\xac\xf0a\x85\x91+\xbey\xa9Kj\xf6\xd3\xe8\xe3o\xadv\x0e\x9dRS\xb4", "\x8b\x90\xb5\xc4W");
    case #"hash_175771022bc5e75d":
      return get_animation("Y\xde\xd8ov\x06\x8e\xe7p\xf3\xbd\xa3x7\xb9]+\xaf\xf4\xef/\x0f\xa8\xf1", "\x8b\x90\xb5\xc4W");
    case #"hash_e7aface284179b3b":
      return get_animation("\xac\xf0a\x85\x91+\xbey\xa9Kj\xf6\xd3\xe8\xe3o\xadv\x0e\x9dRS\xb4", "1x\xc5\xb4\xabx");
    case #"hash_c475427a998ee26c":
      return get_animation("Y\xde\xd8ov\x06\x8e\xe7p\xf3\xbd\xa3x7\xb9]+\xaf\xf4\xef/\x0f\xa8\xf1", "1x\xc5\xb4\xabx");
    default:
      return get_animation("\xe0\v-s\xf5\xb2\xc3\a\xf5\xdc\xd1\v\xb92", "\xe9\xe5\bv\xbe\xc7U\\:\xe5");
  }
}

function get_death_anim() {
  if(self.unittype != "75\xffQ\x95\xfe`\x9a") {
    if(isDefined(self.last_damage_type) && self.last_damage_type == "\xa2rl\xdaDn\x17b\xd9I\xc9=N") {
      random_anim = utility::random(["\xaa\x12V\xc0\x97\xa8MX\b\xf0x", "+\xe1\x836\xdb7K\xb3+\xaf\xd8", "~\xf9\xe7a\xde`6s\xbf6\x01"]);

      if(is_moving()) {
        return get_animation("\xfb\xa5O\xc9Yx){\x8a\xfcsD\x81ci\x11~U\x13\x8b\xc3n", random_anim);
      } else {
        return get_animation("\\\xcdJq$\x99\xa9\x84\xe2U\x19\b+\x02g", random_anim);
      }
    } else if(is_moving()) {
      if(utility::cointoss()) {
        random_part = utility::random(["\x83\xe2\x11D", "<\b\xcf\xa2\xb5\rB$\xce%7", "\xf2\xb7\xc9yG5\x0e\x8f\xc0\bU", "\x9e\x8bjjn\x9d\x8e"]);
        random_severity = "\x127\x99\xbe";
        random_dir = utility::random(["\x19", "P", "\xbb", "\f"]);
        random_anim = random_part + random_severity + random_dir;
        return get_animation("e\x16V'\x809.\xd9\xf1\xc62\x01qu\"", random_anim);
      } else {
        random_dir = utility::random(["K>\xf0@\xe6Xb\xed\xbb\xcd\xdcP\xc5\x11\xf4\x8b\xea", "\x17z5\xf8l\xdb\x9f\xb0t\x97\x1ej#\xb4d\xa1\b", "L\xaa\xe6:\xdf\xb6$p\a\xae\x95\xc7\n\x9d\xb3\xc1\x97", "\x05\xcf\xbc\xcb\xbaDsU2\x1dQs\x7fk\x02\xed\xb0"]);
        return get_animation("\v@w\xf4\xd8SY$\x88\x9b\xcc\x17\xe5ud\x04\x8bD\xf1p", random_dir);
      }
    } else {
      switch (self.animset) {
        case #"hash_9d76c99eddd14433":
          return get_animation("K\xff\xdb\b\x0f\xfe\xe5\x03\a\xad/\x8f\xac}F\x94\xbf\x1el", "\xdf\xc3\xef\xedS\a\a=\x7f\f.\x1d+\xb4");
        case #"hash_f1676baca0ae608b":
          return get_animation("K\xff\xdb\b\x0f\xfe\xe5\x03\a\xad/\x8f\xac}F\x94\xbf\x1el", "\x8b\x90\xb5\xc4W");
        case #"hash_4ddb655e251e06c8":
          return get_animation("K\xff\xdb\b\x0f\xfe\xe5\x03\a\xad/\x8f\xac}F\x94\xbf\x1el", "\xfa63zn\x15\xe8w\xf7\xfb");
        case #"hash_175771022bc5e75d":
          return get_animation("K\xff\xdb\b\x0f\xfe\xe5\x03\a\xad/\x8f\xac}F\x94\xbf\x1el", "\xd9~\xd7\xad\xc04GW\x95\xf9\xf5");
        case #"hash_e7aface284179b3b":
          return get_animation("K\xff\xdb\b\x0f\xfe\xe5\x03\a\xad/\x8f\xac}F\x94\xbf\x1el", "1\x84)\xdb\xcbTW_\xed\xb8b");
        case #"hash_c475427a998ee26c":
          return get_animation("K\xff\xdb\b\x0f\xfe\xe5\x03\a\xad/\x8f\xac}F\x94\xbf\x1el", "\xacZdCyU\xf4X\xad\x95i\x9f\x82\xa6\xda\xcc\xe0{\xacD");
        default:
          random_part = utility::random(["\x83\xe2\x11D", "\xb8R\x8b}N\x19\xd6\xe0\xff", "\x9e\x8bjjn\x9d\x8e"]);

          if(random_part == "\xb8R\x8b}N\x19\xd6\xe0\xff") {
            random_severity = utility::cointoss() ? "<\xb3\xa7do\x10" : "T\x85\xfa\xbe\xc7\xa5";
          } else {
            random_severity = "\x127\x99\xbe";
          }

          random_dir = utility::random(["\x19", "P", "\xbb", "\f"]);
          random_anim = random_part + random_severity + random_dir;
          return get_animation("e\x16V'\x809.\xd9\xf1\xc62\x01qu\"", random_anim);
      }
    }

    return;
  }

  return get_animation("{_\xa6,\x11\xbf\x9fa\x06\xef\xa2\x18\x0f", "\x82\xba\x89X\xddN\xe75\xf1\xd0\x83!N \x1dN\xf6");
}

function get_traverse_anim(animscript) {
  if(issubstr(animscript, "&\xa5\"\x9f9\xf1E\xe3")) {
    return get_animation(animscript, "&\xa5\"\x9f9\xf1E\xe3");
  }

  if(issubstr(animscript, "\xa7\x9c\x1c7\xf8\xd8'\v")) {
    return get_animation(animscript, "\xa7\x9c\x1c7\xf8\xd8'\v");
  }

  if(issubstr(animscript, ":\xcdh& 5\x1c")) {
    return get_animation(animscript, ":\xcdh& 5\x1c");
  }

  return get_animation(animscript, animscript);
}

function death_think() {
  self notify("I\xd7\xce\x1c\xf9\x80\xf5\xcb\xb0\x0f\xda");
  self endon("I\xd7\xce\x1c\xf9\x80\xf5\xcb\xb0\x0f\xda");
  self endon("\xd3\xad\x11\xca%\xf7@\xabk_L\xff\x19");
  damage_think();

  if(!isDefined(self)) {
    return;
  }

  clear_node_path();

  if(isDefined(self.deathfunction)) {
    result = self[[self.deathfunction]]();

    if(!isDefined(result) || result) {
      return;
    }
  }

  death_anim = self.deathanim;

  if(!isDefined(death_anim)) {
    death_anim = get_death_anim();
  }

  self notify("\x1e\xfd\xd1\xa2\a");
  cleanup_state_ents();
  drop_weapon();
  face::saygenericdialogue("\x1e\xfd\xd1\xa2\a");

  if(isDefined(self.noragdoll) && self.noragdoll) {
    if(!isDefined(self.skipdeathanim) || !self.skipdeathanim) {
      play_scripted_anim(death_anim, "\x12\x9cG\x91\xbct\x16N\x8bn");
    }
  }

  if(!(isDefined(self.skipdeathanim) && self.skipdeathanim)) {
    play_scripted_anim(death_anim, "\x12\x9cG\x91\xbct\x16N\x8bn");
  }

  self freeentitysentient();
  self startragdoll();
  self notsolid();

  if(isDefined(self) && isDefined(self.nocorpsedelete)) {
    return;
  }

  wait 10;

  while(isDefined(self)) {
    self delete();
    wait 5;
  }
}

function drop_weapon(limit) {
  if(!isDefined(limit)) {
    limit = 1;
  }

  if(istrue(self.nodrop)) {
    return;
  }

  if(isDefined(self.weapon)) {
    weapon = self.weapon;
    weapon_model = getweaponmodel(weapon);
  }

  if(isDefined(self.weapon_object) && (!isDefined(weapon_model) || weapon_model == "")) {
    weapon = self.weapon_object;
    weapon_model = getweaponmodel(weapon);
  }

  if(isDefined(weapon_model) && weapon_model != "") {
    ai::gun_remove();

    if(!isDefined(self.nodrop)) {
      attachments = getweapondefaultattachments(weapon.basename);
      attachmentstring = "";

      foreach(attachment in attachments) {
        attachmentstring = attachmentstring + "H" + attachment;
      }

      gun = spawn("r\x15U\xae\x95\xae\xc3" + getcompleteweaponname(weapon) + attachmentstring, self gettagorigin("\n\xa2iWa\xf6d\xab$x\xb8\x11b\xd9l\f"));
      gun.angles = self gettagangles("\n\xa2iWa\xf6d\xab$x\xb8\x11b\xd9l\f");

      if(istrue(limit)) {
        limit_dropped_weapons(gun);
      }
    }
  }
}

function limit_dropped_weapons(newweapon) {
  if(!isDefined(level.fakeactor_droppedweapons)) {
    level.fakeactor_droppedweapons = [];
  }

  weaponarray = utility::array_removeundefined(level.fakeactor_droppedweapons);
  num = weaponarray.size;

  if(weaponarray.size >= 4) {
    weaponarray = sortbydistance(weaponarray, level.player.origin);
    num -= 1;
    weaponarray[num] delete();
  }

  weaponarray[num] = newweapon;
  level.fakeactor_droppedweapons = weaponarray;
}

function damage_think() {
  self endon("\xd3\xad\x11\xca%\xf7@\xabk_L\xff\x19");

  while(true) {
    self waittill("\fU`\xc0y\x95", amount, attacker, direction_vec, point, type);
    self.last_damage_type = type;
    self.lastattacker = attacker;

    if(isDefined(attacker) && isPlayer(attacker)) {
      attacker setclientomnvar("F\xb0\xd6,\x9d+\xbe\x99e\x95F1\v\xb1\xad_\xcd\xb7tK\xcc\xe5", gettime());
    }

    if(isDefined(self.damageshield) && self.damageshield) {
      self.health = 100000;
      continue;
    }

    if(self.health <= 0) {
      break;
    }

    face::saygenericdialogue("\x80\xb5\xc7J");

    if(!was_recent_pain() && should_do_pain_anim()) {
      thread do_pain();
    }
  }
}

function do_pain() {
  self notify("\xe1\xf4\xafo8\xdb\x15t\x7fQ)\xc1");
  self notify("1\xc5\x0e\"\xa0q\xda\xb8\xaf\xfc4=\x8c\xac\x05\xda\xc6\x0fQ\x1b\xb4");
  self endon("1\xc5\x0e\"\xa0q\xda\xb8\xaf\xfc4=\x8c\xac\x05\xda\xc6\x0fQ\x1b\xb4");
  self endon("\x1e\xfd\xd1\xa2\a");
  set_recent_pain(1);
  utility::delaythread(1.5, &set_recent_pain, 0);
  clear_node_path();
  play_scripted_anim(get_pain_anim());
  self.current_state = "";
  self.forced_node_path = fakeactor_node::fakeactor_node_get_path(self.current_node, self.origin, is_frantic(), 1);
}

function debug_draw() {
  self endon("<dev string:x2e6>");

  while(true) {
    if(getDvar(@ "debug_fakeactor") == "<dev string:x24>") {
      color = (1, 0, 0);

      if(should_real_fire()) {
        color = (0, 1, 0);
      }

      utility::draw_character_capsule(color, 1);
      utility::draw_ent_axis();
      text_scale = 0.5;
      new_line = 11 * text_scale;
      cam_angles = level.player getplayerangles();
      cam_up = anglestoup(cam_angles);
      text_pos = self.origin;

      if(getDvar(@ "hash_ab259d9b09bad834") == "<dev string:x24>") {
        if(isDefined(self.aim_target)) {
          get_accuracy(1);
        }
      } else {
        if(isDefined(self.current_state)) {
          print3d(text_pos - cam_up * new_line * -1, self.current_state, (1, 1, 1), 1, text_scale);
        }

        if(isDefined(self.current_node)) {
          debug::draw_node(self.current_node.origin, self.current_node.angles, (1, 1, 0), 48);
        }

        if(isDefined(self.animset)) {
          text = self.animset;

          if(isDefined(self.last_anim)) {
            text += "<dev string:x2ef>" + self.last_anim;
          }

          print3d(text_pos - cam_up * new_line * 0, text, (1, 1, 1), 1, text_scale);
        }

        if(does_want_to_move()) {
          print3d(text_pos - cam_up * new_line * 1, "<dev string:x2f5>", (0, 1, 0), 1, text_scale);
        } else {
          print3d(text_pos - cam_up * new_line * 1, "<dev string:x309>", (1, 0, 0), 1, text_scale);
        }

        if(should_do_arrivals()) {
          print3d(text_pos - cam_up * new_line * 3, "<dev string:x31d>", (0, 1, 0), 1, text_scale);
        } else {
          print3d(text_pos - cam_up * new_line * 3, "<dev string:x32f>", (1, 0, 0), 1, text_scale);
        }

        if(should_do_exits()) {
          print3d(text_pos - cam_up * new_line * 4, "<dev string:x341>", (0, 1, 0), 1, text_scale);
        } else {
          print3d(text_pos - cam_up * new_line * 4, "<dev string:x350>", (1, 0, 0), 1, text_scale);
        }

        if(should_real_fire()) {
          print3d(text_pos - cam_up * new_line * 5, "<dev string:x35f>", (0, 1, 0), 1, text_scale);
        } else {
          print3d(text_pos - cam_up * new_line * 5, "<dev string:x36f>", (1, 0, 0), 1, text_scale);
        }
      }
    }

    wait 0.05;
  }
}

function array_handling(fakeactor) {
  team = fakeactor.team;
  utility_sp::structarray_add(level.fakeactors[team], fakeactor);
  fakeactor waittill("\x1e\xfd\xd1\xa2\a");
  fakeactor cleanup_state_ents();

  if(isDefined(fakeactor) && isDefined(fakeactor.struct_array_index)) {
    utility_sp::structarray_remove_index(level.fakeactors[team], fakeactor.struct_array_index);
    return;
  }

  utility_sp::structarray_remove_undefined(level.fakeactors[team]);
}

function play_running_anim_internal(animation, rate) {
  if(!isDefined(rate)) {
    rate = randomfloatrange(0.85, 1.2);
  }

  if(isDefined(self.fakeactor_loop_override)) {
    self[[self.fakeactor_loop_override]](animation, rate);
    return;
  }

  self clearanim(self.anim_branch["\xb7\x1bs\xf8"], 0.2);
  self setflaggedanim("\xe0\xb0Y\xaa\x9a\"K\xe0B\x13\x8b\xce\xae\x05", animation, 1, 0.2, rate);
}

function play_scripted_anim(script_anim, deathplant, notetrackfunction, flagname, node, var_36e7c8da58046eb7) {
  if(isDefined(self.fakeactor_scripted_override)) {
    self[[self.fakeactor_scripted_override]](script_anim, deathplant);
    return;
  }

  self clearanim(self.anim_branch["\xb7\x1bs\xf8"], 0.2);
  self stopanimScripted();
  mode = "+0a<s,";

  if(isDefined(deathplant)) {
    mode = "\x12\x9cG\x91\xbct\x16N\x8bn";
  }

  org = self.origin;
  ang = self.angles;

  if(isDefined(node)) {
    org = node.origin;
    ang = node.angles;
  } else if(isDefined(self.var_5ba1031aba1f9a6b)) {
    org = self.var_5ba1031aba1f9a6b.origin;
    ang = self.var_5ba1031aba1f9a6b.angles;
  }

  if(!isDefined(var_36e7c8da58046eb7)) {
    var_36e7c8da58046eb7 = 0.2;
  }

  self animScripted("\xe0\xb0Y\xaa\x9a\"K\xe0B\x13\x8b\xce\xae\x05", org, ang, script_anim, mode);

  if(isDefined(notetrackfunction)) {
    thread notetracks::donotetracks(flagname, notetrackfunction);
  }

  endmarker = "8\xdb\x90";

  if(animhasnotetrack(script_anim, "\xd7\xca\xae\xca\xff\xdb")) {
    endmarker = "\xd7\xca\xae\xca\xff\xdb";
  } else if(animhasnotetrack(script_anim, "7t\xf6\a\x80anik")) {
    endmarker = "7t\xf6\a\x80anik";
  }

  anim_len = getanimlength(script_anim) - var_36e7c8da58046eb7;

  if(var_36e7c8da58046eb7 > 0 && anim_len > 0) {
    utility::waittill_match_or_timeout("\xe0\xb0Y\xaa\x9a\"K\xe0B\x13\x8b\xce\xae\x05", endmarker, anim_len);
    return;
  }

  self waittillmatch("\xe0\xb0Y\xaa\x9a\"K\xe0B\x13\x8b\xce\xae\x05", endmarker);
}

function get_anim_data(this_anim) {
  anim_struct = spawnStruct();
  anim_struct.anim_time = getanimlength(this_anim);
  anim_delta = getmovedelta(this_anim, 0, 1);
  anim_dist = length(anim_delta);

  if(anim_struct.anim_time > 0 && anim_dist > 0) {
    anim_struct.run_speed = anim_dist / anim_struct.anim_time;
    anim_struct.anim_relative = 0;
  } else {
    anim_struct.run_speed = 170;
    anim_struct.anim_relative = 1;
  }

  return anim_struct;
}

function set_aim_target(aim_target, offset) {
  self.aim_target = aim_target;
  self.aim_target_offset = offset;
}

function get_aim_target() {
  return self.aim_target;
}

function watch_aim_target_think() {
  self endon("\x1e\xfd\xd1\xa2\a");

  while(true) {
    if(isai(self.aim_target) && !isalive(self.aim_target)) {
      set_aim_target(undefined);
    }

    wait 0.05;
  }
}

function is_human() {
  return self.unittype == "\x11\xf6\xc2" || self.unittype == "\xb9\xdb6d-\xb2\xc9" || self.unittype == "75\xffQ\x95\xfe`\x9a" || self.unittype == "\xab\xbf\xbe\xe2\xcdvJ\x14/c" || self.unittype == "\xce\xe4\x15\xda\x967&F\xc34\xff5N";
}

function setup_animation() {
  utility_sp::assign_animtree_based_on_unittype();

  switch (self.unittype) {
    case #"hash_44aaeb0edd152195":
    case #"hash_e87767df2e5c3a68":
      setup_generic_human();
      break;
    default:
      assertmsg("<dev string:x37f>" + self.unittype + "<dev string:x39a>");
      break;
  }
}

#using_animtree("*xmG4\x1e\x14\xb1\xc2u_!\xf5");

function setup_generic_human() {
  self.anim_branch["\x11\x9ag\xc4"] = % \x11\x9ag\xc4;
  self.anim_branch["\xb7\x1bs\xf8"] = % \xb7\x1bs\xf8;
  self.anim_branch["\xa8E\xcd\xc5\x8c"] = % \xa8E\xcd\xc5\x8c;
  self.anim_branch["=T\x8e\xf3\xa1"] = %= T\x8e\xf3\xa1;
  self.anim_branch["P\xee&_\x8d"] = % P\xee &_\x8d;
  self.anim_branch["?d\xad\x90x"] = % ? d\xad\x90x;
}

function aim_weights(aim_2, aim_4, aim_6, aim_8, pitchdelta, yawdelta) {
  var_f93af707d2e710b = 0.1;
  anim_weight = 1;

  if(yawdelta < 0) {
    weight = yawdelta / self.rightaimlimit * anim_weight;
    self setanimlimited(aim_4, 0, var_f93af707d2e710b, 1, 1);
    self setanimlimited(aim_6, weight, var_f93af707d2e710b, 1, 1);
  } else if(yawdelta > 0) {
    weight = yawdelta / self.leftaimlimit * anim_weight;
    self setanimlimited(aim_4, weight, var_f93af707d2e710b, 1, 1);
    self setanimlimited(aim_6, 0, var_f93af707d2e710b, 1, 1);
  }

  if(pitchdelta < 0) {
    weight = pitchdelta / self.upaimlimit * anim_weight;
    self setanimlimited(aim_2, 0, var_f93af707d2e710b, 1, 1);
    self setanimlimited(aim_8, weight, var_f93af707d2e710b, 1, 1);
    return;
  }

  if(pitchdelta > 0) {
    weight = pitchdelta / self.downaimlimit * anim_weight;
    self setanimlimited(aim_2, weight, var_f93af707d2e710b, 1, 1);
    self setanimlimited(aim_8, 0, var_f93af707d2e710b, 1, 1);
  }
}

function set_animsets(animsets) {
  self.animsets = animsets;
  pick_random_animset();
}

function pick_random_animset() {
  random_cover = randomint(self.animsets.size);
  self.animset = self.animsets[random_cover];
}

function set_run_anim_override(run_anim) {
  self.run_anim_override = run_anim;
}

function clear_run_anim_override() {
  self.run_anim_override = undefined;
}

function set_idle_anim_override(idle_anim) {
  self.idle_anim_override = idle_anim;
}

function clear_idle_anim_override() {
  self.idle_anim_override = undefined;
}

function is_idle() {
  return self.current_state == "\x91\x88\xc2*";
}

function is_moving() {
  return isDefined(self.current_state) && self.current_state == "\x80[\xb3\x9d";
}

function is_controlled() {
  return self.flags & 256 || istrue(self.scriptmodelcap);
}

function set_controlled(controlled) {
  if(controlled) {
    self.flags |= 256;
    return;
  }

  self.flags &= -257;
}

function take_control() {
  self notify("\xe1\xf4\xafo8\xdb\x15t\x7fQ)\xc1");
  self.prev_node = self.current_node;
  clear_node_path();
  self.node_path = undefined;
  set_controlled(1);
}

function release_control(next_node) {
  set_controlled(0);
  var_13f5c771f756e73c = undefined;

  if(isDefined(next_node)) {
    var_13f5c771f756e73c = next_node;
  } else if(isDefined(self.prev_node)) {
    var_13f5c771f756e73c = self.prev_node;
    self.prev_node = undefined;
  } else if(isDefined(self.target)) {
    fakeactor_target = utility::getStructArray(self.target, "\"\xe4\xaapX\x9d\xbd\xe9\xab\xcc");
    fakeactor_target = utility::random(fakeactor_target);

    if(isDefined(fakeactor_target) && fakeactor_target fakeactor_node::is_fakeactor_node()) {
      var_13f5c771f756e73c = fakeactor_target;
    }
  }

  if(isDefined(var_13f5c771f756e73c)) {
    set_current_node(var_13f5c771f756e73c);
    set_wants_to_move(1);
  }

  self.current_state = undefined;
}

function set_do_arrivals(do_arrivals) {
  if(do_arrivals) {
    self.flags |= 8;
    return;
  }

  self.flags &= -9;
}

function should_do_arrivals() {
  return self.flags & 8;
}

function set_do_exits(do_exits) {
  if(do_exits) {
    self.flags |= 16;
    return;
  }

  self.flags &= -17;
}

function should_do_exits() {
  if(isDefined(self.previous_state)) {
    if(self.previous_state == "\x0eq\x9e\b\xf4\xd9*Y" || self.previous_state == "\x03\x9c\xb4\xa2") {
      return 0;
    }
  }

  return self.flags & 16;
}

function set_wants_to_move(wants_to_move) {
  if(wants_to_move) {
    self.flags |= 2;
    return;
  }

  self.flags &= -3;
}

function does_want_to_move() {
  return self.flags & 2;
}

function set_target_in_view(in_view) {
  if(in_view) {
    self.flags |= 1;
    return;
  }

  self.flags &= -2;
}

function is_target_in_view() {
  return self.flags & 1;
}

function set_real_fire(real_fire) {
  if(real_fire) {
    self.flags |= 32;
    return;
  }

  self.flags &= -33;
}

function should_real_fire() {
  return self.flags & 32;
}

function set_ignore_claimed(ignore) {
  if(ignore) {
    self.flags |= 64;
    return;
  }

  self.flags &= -65;
}

function is_ignore_claimed() {
  return self.flags & 64;
}

function obstacle_in_way(in_way) {
  if(in_way) {
    self.flags |= 128;
    return;
  }

  self.flags &= -129;
}

function is_obstacle_in_way() {
  return self.flags & 128;
}

function should_do_pain_anim() {
  return self.flags & 512;
}

function set_use_pain(use_pain) {
  if(use_pain) {
    self.flags |= 512;
    return;
  }

  self.flags &= -513;
}

function was_recent_pain() {
  return self.flags & 2048;
}

function set_recent_pain(recent_pain) {
  if(recent_pain) {
    self.flags |= 2048;
    return;
  }

  self.flags &= -2049;
}

function is_frantic() {
  return self.flags & 1024;
}

function set_frantic(frantic) {
  if(frantic) {
    self.flags |= 1024;
    return;
  }

  self.flags &= -1025;
}

function function_3aa73dfa57e3cdb() {
  return isDefined(self.flags) && (self.flags & 4096) != 0;
}

function trigger_fakeactor_move(trigger) {
  if(!isDefined(self.targetname)) {
    return;
  }

  fakeactor = getEnt("\x7fw*%A\xff", self.targetname);

  while(true) {
    trigger waittill("\x91`\xb1\xe7T\x97>", other);
    fakeactor set_wants_to_move(1);
  }
}

function trigger_fakeactor_node_disable(trigger) {
  if(!isDefined(trigger.targetname)) {
    return;
  }

  var_c7613e6077048fbc = utility::getStructArray(trigger.targetname, "\x7fw*%A\xff");

  if(var_c7613e6077048fbc.size == 0) {
    return;
  }

  while(true) {
    trigger waittill("\x91`\xb1\xe7T\x97>", other);

    foreach(struct in var_c7613e6077048fbc) {
      struct fakeactor_node::fakeactor_node_set_disabled(1);
    }
  }
}

function trigger_fakeactor_node_enable(trigger) {
  if(!isDefined(trigger.targetname)) {
    return;
  }

  var_c7613e6077048fbc = utility::getStructArray(trigger.targetname, "\x7fw*%A\xff");

  if(var_c7613e6077048fbc.size == 0) {
    return;
  }

  while(true) {
    trigger waittill("\x91`\xb1\xe7T\x97>", other);

    foreach(struct in var_c7613e6077048fbc) {
      struct fakeactor_node::fakeactor_node_set_disabled(0);
    }
  }
}

function trigger_fakeactor_node_enablegroup(trigger) {
  if(!isDefined(trigger.script_parameters)) {
    return;
  }

  while(true) {
    trigger waittill("\x91`\xb1\xe7T\x97>", other);
    fakeactor_node::fakeactor_node_group_set_disabled(trigger.script_parameters, 0);
  }
}

function trigger_fakeactor_node_disablegroup(trigger) {
  if(!isDefined(trigger.script_parameters)) {
    return;
  }

  while(true) {
    trigger waittill("\x91`\xb1\xe7T\x97>", other);
    fakeactor_node::fakeactor_node_group_set_disabled(trigger.script_parameters, 1);
  }
}

function trigger_fakeactor_node_passthrough(trigger) {
  if(!isDefined(trigger.targetname)) {
    return;
  }

  var_c7613e6077048fbc = utility::getStructArray(trigger.targetname, "\x7fw*%A\xff");

  if(var_c7613e6077048fbc.size == 0) {
    return;
  }

  while(true) {
    trigger waittill("\x91`\xb1\xe7T\x97>", other);

    foreach(struct in var_c7613e6077048fbc) {
      struct fakeactor_node::fakeactor_node_set_passthrough();
    }
  }
}

function trigger_fakeactor_node_lock(trigger) {
  if(!isDefined(trigger.targetname)) {
    return;
  }

  var_c7613e6077048fbc = utility::getStructArray(trigger.targetname, "\x7fw*%A\xff");

  if(var_c7613e6077048fbc.size == 0) {
    return;
  }

  while(true) {
    trigger waittill("\x91`\xb1\xe7T\x97>", other);

    foreach(struct in var_c7613e6077048fbc) {
      struct fakeactor_node::fakeactor_node_set_locked();
    }
  }
}

function is_higher_priority(item, key) {
  return item["\x90\b*\xd3q\xdc\xd4^"] < key["\x90\b*\xd3q\xdc\xd4^"];
}

function teleportthread(verticaloffset) {
  self endon("\xbb\x91a^\xe9\x1dr\x1e\x1cks\xf5y@");
  self notify("\xcan\x91T\xca\x8dYp\xb7\xe4\x1dTCr\xca\x162");
  self endon("\xcan\x91T\xca\x8dYp\xb7\xe4\x1dTCr\xca\x162");
  reps = 5;
  offset = (0, 0, verticaloffset / reps);

  for(i = 0; i < reps; i++) {
    self forceteleport(self.origin + offset);
    wait 0.05;
  }
}

function teleportthreadex(verticaloffset, delay, frames, animrate) {
  self endon("\xbb\x91a^\xe9\x1dr\x1e\x1cks\xf5y@");
  self notify("\xcan\x91T\xca\x8dYp\xb7\xe4\x1dTCr\xca\x162");
  self endon("\xcan\x91T\xca\x8dYp\xb7\xe4\x1dTCr\xca\x162");

  if(verticaloffset == 0 || frames <= 0) {
    return;
  }

  if(delay > 0) {
    wait delay;
  }

  offset = (0, 0, verticaloffset / frames);

  if(isDefined(animrate) && animrate < 1) {
    self setflaggedanimknoball("\xf9\xb2O\x89C\xcc\xae~G=\xb2A", self.traverseanim, self.traverseanimroot, 1, 0.2, animrate);
  }

  for(i = 0; i < frames; i++) {
    self forceteleport(self.origin + offset);
    wait 0.05;
  }

  if(isDefined(animrate) && animrate < 1) {
    self setflaggedanimknoball("\xf9\xb2O\x89C\xcc\xae~G=\xb2A", self.traverseanim, self.traverseanimroot, 1, 0.2, 1);
  }
}

function finishtraversedrop(finalz) {
  self endon("\xbb\x91a^\xe9\x1dr\x1e\x1cks\xf5y@");
  finalz += 4;

  while(true) {
    if(self.origin[2] < finalz) {
      self animmode("\x1b\x9e\x86\xecr\x97\xa2");
      break;
    }

    wait 0.05;
  }
}

function handletraversenotetracks(note) {
  if(note == "C\x13P.\x02v\xaf\xd7G\xf9\x95\nd@") {
    return handletraversedeathnotetrack();
  }

  if(note == "\x05\xae\xd7r\"\xf3\x95\xfe\x91\"\\\x1d\x10\xd0") {
    return handletraversealignment();
  }

  if(note == "\x81\x86\x8fa\x1c\xee\xb0n\x05\xd3\x9a\x90\x8a") {
    return handletraversedrop();
  }
}

function handletraversedeathnotetrack() {
  if(isDefined(self.traversedeathanim)) {
    deathanimarray = self.traversedeathanim[self.traversedeathindex];
    ai::set_deathanim(deathanimarray[randomint(deathanimarray.size)]);
    self.traversedeathindex++;
  }
}

function handletraversealignment() {
  self animmode("b\xf21\xbc\xeb{");
  targettraverseheight = undefined;

  if(self.var_8ac1c0c5d59943e0 == "\xe5\xdau\xfb\xb3\x8d\xa5\x85" || self.var_8ac1c0c5d59943e0 == "\x06g\x84\xeee<\xcf\x85") {
    targettraverseheight = self.var_a8031492d1ad720d.traverse_height;
  } else {
    targettraverseheight = self.traversestartnode.traverse_height;
  }

  if(isDefined(self.traverseheight) && isDefined(targettraverseheight)) {
    currentheight = targettraverseheight - self.traversestartz;
    thread teleportthread(currentheight - self.traverseheight);
  }
}

function handletraversedrop() {
  startpos = self.origin + (0, 0, 32);
  endpos = physicstrace(startpos, self.origin + (0, 0, -512));
  dist = distance(startpos, endpos);
  realdropheight = dist - 32 - 0.5;
  traverseanimpos = self getanimtime(self.traverseanim);
  traverseanimdelta = getmovedelta(self.traverseanim, traverseanimpos, 1);
  traverseanimlength = getanimlength(self.traverseanim);
  animdropheight = 0 - traverseanimdelta[2];
  assert(animdropheight >= 0, animdropheight);
  dropoffset = animdropheight - realdropheight;

  if(getdvarint(@ "scr_traverse_debug")) {
    thread utility::debugline(startpos, endpos, (1, 1, 1), 40);
    thread utility::drawstringtime("<dev string:x3d4>" + dropoffset, endpos, (1, 1, 1), 2);
  }

  if(animdropheight < realdropheight) {
    animrate = animdropheight / realdropheight;
  } else {
    animrate = 1;
  }

  teleportlength = (traverseanimlength - traverseanimpos) / 3;
  numframes = ceil(teleportlength * 20);
  thread teleportthreadex(dropoffset, 0, numframes, animrate);
  thread finishtraversedrop(endpos[2]);
}