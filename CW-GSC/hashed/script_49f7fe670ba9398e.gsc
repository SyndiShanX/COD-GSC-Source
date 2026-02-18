/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_49f7fe670ba9398e.gsc
***********************************************/

#using script_17dcb1172e441bf6;
#using script_1b0b07ff57d1dde3;
#using script_1ee011cd0961afd7;
#using script_2a5bf5b4a00cee0d;
#using script_47851dbeea22fe66;
#using script_634ae70c663d1cc9;
#using script_774302f762d76254;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\spawning_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace namespace_a7c12078;

function init() {}

function main() {
  level.doa.var_ea40471b = [];
}

function function_c6453062() {
  self notify("2f25b26e22f30a5c");
  self endon("2f25b26e22f30a5c");
  self thread namespace_268747c0::function_978c05b5();
  result = self waittill(#"destroy_hazard");

  if(is_true(self.var_7c56394) && is_true(result.var_760a0807)) {
    arrayremovevalue(level.doa.var_ea40471b, self);
    namespace_1e25ad94::debugmsg("Deleting LogDrop trap permenently at:" + self.origin);
  }

  util::wait_network_frame();

  if(isDefined(self.trigger)) {
    self.trigger namespace_268747c0::function_54f185a();
    self.trigger = undefined;
  }

  if(isDefined(self.script_model)) {
    self.script_model delete();
  }
}

function function_cb1b5203(trap, var_7c56394 = 0) {
  hazard = namespace_ec06fe4a::spawnmodel(trap.origin, "p8_fxanim_zm_towers_trap_blade_01_mod");

  if(isDefined(hazard)) {
    hazard.targetname = "hazard";
    hazard.var_fd5301f9 = "logdrop";
    hazard.angles = trap.angles;
    hazard enablelinkto();
  }

  trap.script_model = hazard;
  trap.var_7c56394 = var_7c56394;

  if(isDefined(trap.trigger)) {
    trap.trigger namespace_268747c0::function_54f185a();
    trap.trigger = undefined;
  }

  trap thread function_62ba9be4();
  return trap;
}

function function_7f3d5e5d(trap, page = 0) {
  if(!namespace_ec06fe4a::function_a8975c67()) {
    return;
  }

  if(page) {
    if(!isDefined(level.doa.var_ea40471b)) {
      level.doa.var_ea40471b = [];
    } else if(!isarray(level.doa.var_ea40471b)) {
      level.doa.var_ea40471b = array(level.doa.var_ea40471b);
    }

    level.doa.var_ea40471b[level.doa.var_ea40471b.size] = trap;
    return;
  }

  function_cb1b5203(trap);
}

function function_d4a86caf() {
  self notify("599e6beca01ea7e4");
  self endon("599e6beca01ea7e4");
  level endon(#"game_over", #"hash_15db1223146bc923");

  while(true) {
    wait 0.5;
    state = namespace_4dae815d::function_59a9cf1d();

    if(state == 0) {
      continue;
    }

    foreach(trap in level.doa.var_ea40471b) {
      time = gettime();

      if(isDefined(trap.var_eb9d64bb) && time < trap.var_eb9d64bb) {
        continue;
      }

      trap.var_eb9d64bb = time + 2000 + randomint(600);

      if(!isDefined(trap.script_model)) {
        activate = 0;

        if(isDefined(trap.var_f8660931)) {
          distsq = distancesquared(trap.origin, trap.var_f8660931.origin);

          if(distsq < sqr(3200)) {
            activate = 1;
          }
        }

        if(!activate) {
          trap.var_f8660931 = namespace_ec06fe4a::function_6eacecf5(trap.origin, 3200);

          if(isDefined(trap.var_f8660931)) {
            activate = 1;
          } else {
            trap.var_f8660931 = namespace_ec06fe4a::function_bd3709ce(trap.origin, 1200);

            if(isDefined(trap.var_f8660931)) {
              activate = 1;
            }
          }
        }

        if(activate) {
          function_cb1b5203(trap, 1);
          trap.var_eb9d64bb += 5000;
          namespace_1e25ad94::debugmsg("Paging IN logdrop trap at:" + trap.origin);
        }

        continue;
      }

      trap.var_f8660931 = namespace_ec06fe4a::function_f3eab80e(trap.origin, 3600);

      if(!isDefined(trap.var_f8660931)) {
        trap notify(#"destroy_hazard", {
          #var_760a0807: 0
        });
        namespace_1e25ad94::debugmsg("Paging out logdrop trap at:" + trap.origin);
      }
    }
  }
}

function function_237de89e() {
  level.doa.var_ea40471b = [];
  level thread function_d4a86caf();

  if(isDefined(level.doa.var_a77e6349)) {
    traps = [[level.doa.var_a77e6349]] - > function_87f950c1("logdrop");
    page = 1;
  } else {
    traps = [[level.doa.var_39e3fa99]] - > function_242886d5("logdrop");
  }

  foreach(trap in traps) {
    function_7f3d5e5d(trap, page);
  }
}

function function_b31750de(lifetime) {
  self endon(#"destroy_hazard");
  self notify("31632961de933827");
  self endon("31632961de933827");

  while(isDefined(self) && self.state === 1) {
    if(!isDefined(self.trigger)) {
      self.trigger = namespace_268747c0::function_5bfa98c9("logdrop", self.origin);

      if(isDefined(self.trigger)) {
        up = anglestoup(self.angles);
        offset = up * 80;
        self.trigger.origin = self.origin + offset;
        self.trigger.angles = self.angles;

        level thread namespace_1e25ad94::function_b57a9d84(self.trigger.origin, self.trigger.angles[1], self.trigger.length, self.trigger.width, self.trigger.height, lifetime);
      }
    }

    if(isDefined(self.trigger)) {
      result = self.trigger waittilltimeout(0.25, #"trigger");
      guy = result.activator;

      if(isDefined(guy) && isalive(guy)) {
        if(is_true(guy.var_47267079) || is_true(guy.boss)) {
          continue;
        }

        if(isvehicle(guy)) {
          continue;
        }

        if(isPlayer(guy) && isDefined(guy.doa.vehicle)) {
          continue;
        }

        if(!isDefined(guy.var_ef6bca09)) {
          guy.var_ef6bca09 = 0;
        }

        if(guy.var_ef6bca09 < gettime()) {
          guy namespace_83eb6304::function_3ecfde67("pungi_damage");
          guy.var_ef6bca09 = gettime() + 1000;
        }

        if(isPlayer(guy)) {
          guy dodamage(guy.health + 100, guy.origin);
        } else {
          guy thread namespace_ed80aead::function_586ef822();
        }
      }

      continue;
    }

    wait 0.25;
  }

  if(isDefined(self.trigger)) {
    self.trigger namespace_268747c0::function_54f185a();
    self.trigger = undefined;
  }
}

function function_62ba9be4() {
  self notify("453fade6619d7141");
  self endon("453fade6619d7141");
  level endon(#"game_over");
  self endon(#"destroy_hazard");
  self thread function_c6453062();

  if(!isDefined(self.script_model)) {
    self notify(#"destroy_hazard");
  }

  self.state = 0;
  self.script_model useanimtree("generic");
  self.script_model solid();
  var_ba28dc68 = getanimlength(#"p8_fxanim_zm_towers_trap_blade_01_start_anim");
  var_fb7d52cb = getanimlength(#"p8_fxanim_zm_towers_trap_blade_01_loop_anim");
  var_3493b9e = getanimlength(#"p8_fxanim_zm_towers_trap_blade_01_end_anim");

  while(true) {
    self.script_model stopanimscripted();
    self.state = 0;
    wait 8 + randomint(5);
    self.script_model namespace_268747c0::play_anim(#"p8_fxanim_zm_towers_trap_blade_01_start_anim", 1);
    self.script_model waittilltimeout(var_ba28dc68, #"end", #"scriptedanim", #"new_scripted_anim");
    self.state = 1;
    loops = randomintrange(5, 15);
    self thread function_b31750de(loops * var_fb7d52cb);

    while(loops) {
      self.script_model namespace_268747c0::play_anim(#"p8_fxanim_zm_towers_trap_blade_01_loop_anim", 1);
      self.script_model namespace_e32bb68::function_3a59ec34("zmb_traps_blade_lp");
      self.script_model waittilltimeout(var_fb7d52cb, #"end", #"scriptedanim", #"new_scripted_anim");
      loops--;
    }

    self.state = 0;
    self.script_model namespace_e32bb68::function_ae271c0b("zmb_traps_blade_lp");
    self.script_model namespace_268747c0::play_anim(#"p8_fxanim_zm_towers_trap_blade_01_end_anim", 1);
    self.script_model waittilltimeout(var_3493b9e, #"end", #"scriptedanim", #"new_scripted_anim");
  }
}