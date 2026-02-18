/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_226eec8e867ca977.gsc
***********************************************/

#using script_17dcb1172e441bf6;
#using script_1b0b07ff57d1dde3;
#using script_1ee011cd0961afd7;
#using script_2a5bf5b4a00cee0d;
#using script_47851dbeea22fe66;
#using script_634ae70c663d1cc9;
#using script_774302f762d76254;
#using scripts\core_common\animation_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\spawning_shared;
#using scripts\core_common\status_effects\status_effect_util;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace namespace_85f9e33a;

function init() {}

function main() {
  level.doa.var_18f8e489 = [];
}

function function_81853592() {
  self notify("64d873247a66697a");
  self endon("64d873247a66697a");
  self thread namespace_268747c0::function_978c05b5();
  result = self waittill(#"destroy_hazard");

  if(is_true(self.var_7c56394) && is_true(result.var_760a0807)) {
    arrayremovevalue(level.doa.var_18f8e489, self);
    namespace_1e25ad94::debugmsg("Deleting Flogger trap permenently at:" + self.origin);
  }

  if(isDefined(self.trigger)) {
    triggers = arraycopy(self.trigger);

    foreach(trigger in triggers) {
      trigger namespace_268747c0::function_54f185a();
    }

    self.trigger = [];
  }

  if(isDefined(self.script_model)) {
    self.script_model delete();
  }

  self.var_13c99cf7 = gettime() + 1000;
}

function function_ecfc6c75(trap, var_7c56394 = 0) {
  hazard = namespace_ec06fe4a::spawnmodel(trap.origin, "p8_fxanim_mp_zmuseum_flogger_trap_mod");

  if(isDefined(hazard)) {
    hazard.targetname = "hazard";
    hazard.var_fd5301f9 = "flogger";
    hazard.angles = trap.angles;
    hazard enablelinkto();
  }

  trap.script_model = hazard;
  trap.var_7c56394 = var_7c56394;
  trap.trigger = [];
  trap.spinrate = 1;
  trap.minwait = 3;
  trap.maxwait = 5;
  trap.maxloops = 3;

  if(isDefined(trap.script_parameters)) {
    args = strtok(trap.script_parameters, ";");

    if(args.size > 0) {
      trap.spinrate = float(args[0]);
    }

    if(args.size > 1) {
      trap.minwait = float(args[1]);
    }

    if(args.size > 2) {
      trap.maxwait = float(args[2]);
    }

    if(args.size > 3) {
      trap.maxloops = float(args[3]);
    }
  }

  trap.spinrate = 1;
  trap thread function_80eed528();
  return trap;
}

function function_7fb58446(trap, page = 0) {
  if(page) {
    if(!isDefined(level.doa.var_18f8e489)) {
      level.doa.var_18f8e489 = [];
    } else if(!isarray(level.doa.var_18f8e489)) {
      level.doa.var_18f8e489 = array(level.doa.var_18f8e489);
    }

    level.doa.var_18f8e489[level.doa.var_18f8e489.size] = trap;
    return;
  }

  function_ecfc6c75(trap);
}

function function_9d10940b() {
  self notify("56bc794308d648b4");
  self endon("56bc794308d648b4");
  level endon(#"game_over");

  while(true) {
    wait 0.5;

    if(namespace_4dae815d::function_59a9cf1d() == 0) {
      continue;
    }

    foreach(trap in level.doa.var_18f8e489) {
      time = gettime();

      if(isDefined(trap.var_13c99cf7) && time < trap.var_13c99cf7) {
        continue;
      }

      if(isDefined(trap.var_eb9d64bb) && time < trap.var_eb9d64bb) {
        continue;
      }

      trap.var_eb9d64bb = time + 1500 + randomint(600);

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
          function_ecfc6c75(trap, 1);
          trap.var_eb9d64bb += 5000;
          namespace_1e25ad94::debugmsg("Paging IN flogger trap at:" + trap.origin);
        }

        continue;
      }

      trap.var_f8660931 = namespace_ec06fe4a::function_f3eab80e(trap.origin, 3600);

      if(!isDefined(trap.var_f8660931)) {
        namespace_1e25ad94::debugmsg("Paging out flogger trap at:" + trap.origin);
        trap notify(#"destroy_hazard", {
          #var_760a0807: 0
        });
      }
    }
  }
}

function function_a76494d5() {
  level.doa.var_18f8e489 = [];
  level thread function_9d10940b();

  if(isDefined(level.doa.var_a77e6349)) {
    traps = [[level.doa.var_a77e6349]] - > function_87f950c1("flogger");
    page = 1;
  } else {
    traps = [[level.doa.var_39e3fa99]] - > function_242886d5("flogger");
  }

  foreach(trap in traps) {
    trap.var_13c99cf7 = 0;
    function_7fb58446(trap, page);
  }
}

function function_80eed528() {
  self notify("220693f3dc4b6553");
  self endon("220693f3dc4b6553");
  level endon(#"game_over");
  self endon(#"destroy_hazard");
  self thread function_81853592();

  if(!isDefined(self.script_model)) {
    self notify(#"destroy_hazard");
  }

  self.script_model useanimtree("generic");
  self.script_model solid();
  length = getanimlength(#"p8_fxanim_mp_museum_flogger_trap_anim");
  assert(self.trigger.size == 0, "<dev string:x38>");
  triggers = arraycopy(self.trigger);

  foreach(trigger in triggers) {
    trigger namespace_268747c0::function_54f185a();
  }

  self.trigger = [];

  while(self.trigger.size < 2) {
    self.trigger[self.trigger.size] = self namespace_268747c0::function_678eaf60("flogger", self.origin, 512, 1, 256);
  }

  self.trigger[0] unlink();
  self.trigger[1] unlink();
  self.trigger[0] linkto(self.script_model, "flogger_trap_rod_jnt", (-100, 0, 0));
  self.trigger[1] linkto(self.script_model, "flogger_trap_rod_jnt", (100, 0, 0));
  self.trigger[0] triggerenable(0);
  self.trigger[1] triggerenable(0);

  if(!isDefined(self.spinrate)) {
    self.spinrate = 1;
  }

  animationrate = self.spinrate;
  length /= animationrate;
  self.script_model namespace_e32bb68::function_3a59ec34("evt_doa_hazard_flogger_eng_start");
  wait 1;

  foreach(trigger in self.trigger) {
    trigger triggerenable(1);
    trigger thread function_ab141bd8(self.script_model, self);
  }

  self.script_model namespace_e32bb68::function_3a59ec34("evt_doa_hazard_flogger_eng_start");
  self.script_model namespace_e32bb68::function_3a59ec34("evt_doa_hazard_flogger_eng_loop");
  self.script_model thread function_b98fe7eb();
  self.script_model animscripted("spin_end", self.origin, self.angles, #"p8_fxanim_mp_museum_flogger_trap_anim", "server script", undefined, animationrate);
  wait length;
  self.script_model stopanimscripted(0, 1);
  self.script_model namespace_e32bb68::function_ae271c0b("evt_doa_hazard_flogger_eng_loop");
  self.script_model namespace_e32bb68::function_3a59ec34("evt_doa_hazard_flogger_eng_stop");
  triggers = arraycopy(self.trigger);

  foreach(trigger in triggers) {
    trigger namespace_268747c0::function_54f185a();
  }

  self.trigger = [];
  wait randomfloatrange(self.minwait, self.maxwait);
  self thread function_80eed528();
}

function function_b98fe7eb() {
  self notify("7897d0aa40ce1f82");
  self endon("7897d0aa40ce1f82");
  self endon(#"death");

  for(log = 0; true; log = !log) {
    self waittill(#"hash_4460cb197033d052");
    self namespace_e32bb68::function_3a59ec34("evt_doa_hazard_flogger_whoosh_" + log);
  }
}

function function_ab141bd8(model, trap) {
  self notify("22fa8b414c5486fc");
  self endon("22fa8b414c5486fc");
  self endon(#"death", #"hash_5dc5b7f198cd1bec");
  fling_force = 190;

  while(isDefined(self)) {
    result = self waittill(#"trigger");
    guy = result.activator;

    if(isDefined(guy)) {
      if(!isDefined(guy.var_62abb118)) {
        guy.var_62abb118 = 0;
      }

      if(guy.var_62abb118 < gettime()) {
        guy.var_62abb118 = gettime() + 500;
        guy namespace_83eb6304::function_3ecfde67("pungi_damage");
        model namespace_e32bb68::function_3a59ec34("evt_doa_hazard_flogger_impact");
      }

      if(is_true(guy.var_47267079) || is_true(guy.boss)) {
        continue;
      }

      if(isPlayer(guy)) {
        guy dodamage(isDefined(trap.damage) ? trap.damage : guy.health + 100, guy.origin);
        guy playrumbleonentity("damage_heavy");

        if(isDefined(trap.var_2e485cc) && guy.birthtime != gettime()) {
          guy thread status_effect::status_effect_apply(trap.var_2e485cc, guy.currentweapon, self, 1);
        }

        continue;
      }

      if(!is_true(guy.var_e66cd6fb)) {
        v_centroid = guy getcentroid();
        v_away_from_source = vectornormalize(self.origin - v_centroid);
        v_away_from_source *= 128;
        v_away_from_source = (v_away_from_source[0], v_away_from_source[1], randomintrange(128, 200));
        guy thread namespace_ec06fe4a::function_b4ff2191(v_away_from_source, fling_force);
        continue;
      }

      guy thread namespace_ed80aead::function_586ef822();
    }
  }
}