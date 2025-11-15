/*******************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\cp\zombies\interaction_fishtrap.gsc
*******************************************************/

init_fishtrap() {
  var_00 = scripts\engine\utility::getstructarray("trap_electric", "script_noteworthy");
  foreach(var_02 in var_00) {
    level thread func_F956(var_02);
  }

  wait(10);
  scripts\engine\utility::exploder(30);
}

func_F956(param_00) {
  var_01 = getEntArray(param_00.target, "targetname");
  foreach(var_03 in var_01) {
    if(var_03.classname == "trigger_multiple") {
      param_00.dmg_trig = var_03;
    }
  }
}

use_fishtrap(param_00, param_01) {
  if(getweaponbasename(param_01 getcurrentweapon()) != "iw7_penetrationrail_mp") {
    param_01 setweaponammostock("iw7_feed_fish", 1);
    param_01 giveandfireoffhand("iw7_feed_fish");
  }

  scripts\cp\cp_interaction::disable_linked_interactions(param_00);
  thread fish_trap_splash_sfx_init(param_00);
  scripts\engine\utility::exploder(30);
  param_01 thread scripts\cp\cp_vo::try_to_play_vo("activate_trap_generic", "zmb_comment_vo", "low", 10, 0, 1, 0, 40);
  level thread fish_trap_damage(param_00, param_01);
  level thread fish_trap_timer(param_00);
}

fish_trap_splash_sfx_init(param_00) {
  var_01 = [];
  var_01[0] = (-3054, 2028, -155);
  var_01[1] = (-2585, 2070, -155);
  var_01[2] = (-2629, 2330, -155);
  var_01[3] = (-2437, 2443, -155);
  var_01[4] = (-2249, 2154, -155);
  var_01[5] = (-2396, 1924, -155);
  var_01[6] = (-2776, 1684, -155);
  foreach(var_03 in var_01) {
    thread fish_trap_splash_sfx_spawn(param_00, var_03);
  }
}

fish_trap_splash_sfx_spawn(param_00, param_01) {
  var_02 = scripts\engine\utility::play_loopsound_in_space("trap_piranha_splash_lp", param_01);
  param_00 waittill("trap_done");
  var_02 playSound("trap_piranha_splash_end");
  wait(0.5);
  var_02 stoploopsound();
  wait(4);
  var_02 delete();
}

fish_trap_timer(param_00) {
  var_01 = gettime() + 25000;
  while(gettime() < var_01) {
    wait(1);
  }

  param_00 notify("trap_done");
  scripts\cp\cp_interaction::enable_linked_interactions(param_00);
  scripts\cp\cp_interaction::interaction_cooldown(param_00, 45);
}

fish_trap_damage(param_00, param_01) {
  param_00 endon("trap_done");
  for(;;) {
    param_00.dmg_trig waittill("trigger", var_02);
    if(isplayer(var_02) && isalive(var_02) && !scripts\cp\cp_laststand::player_in_laststand(var_02) && !isDefined(var_02.padding_damage)) {
      var_02.padding_damage = 1;
      var_02 dodamage(5, var_02.origin);
      var_02 thread remove_padding_damage();
      continue;
    }

    if(!isplayer(var_02) && !isDefined(var_02.marked_for_death) && isagent(var_02) && isalive(var_02) && scripts\engine\utility::istrue(var_02.isactive)) {
      if(isDefined(var_02.agent_type) && var_02.agent_type == "zombie_sasquatch" || var_02.agent_type == "slasher") {
        continue;
      }

      if(isDefined(var_02.team) && var_02.team == "allies") {
        continue;
      }

      level thread fish_kill_zombie(var_02, param_01);
    }
  }
}

fish_kill_zombie(param_00, param_01) {
  param_00 endon("death");
  param_00.anchor = spawn("script_origin", param_00.origin);
  param_00.anchor.angles = param_00.angles;
  thread spawn_zombie_fish_fx(param_00);
  param_00 linkto(param_00.anchor);
  param_00.nocorpse = 1;
  param_00.marked_for_death = 1;
  param_00.customdeath = 1;
  param_00.scripted_mode = 1;
  if(scripts\engine\utility::istrue(param_00.dismember_crawl)) {
    param_00.anchor movez(-10, 2);
  } else {
    param_00.anchor movez(-60, 4);
  }

  param_00.anchor waittill("movedone");
  if(param_01 scripts\cp\utility::is_valid_player()) {
    var_02 = ["kill_trap_generic", "kill_trap_1", "kill_trap_2", "kill_trap_3", "kill_trap_4", "kill_trap_5", "kill_trap_6", "trap_kill_7"];
    param_01 thread scripts\cp\cp_vo::try_to_play_vo(scripts\engine\utility::random(var_02), "zmb_comment_vo", "highest", 10, 0, 0, 1, 25);
    param_00 dodamage(param_00.health + 100, param_00.origin, param_01, param_01, "MOD_UNKNOWN", "iw7_discotrap_zm");
    return;
  }

  param_00 dodamage(param_00.health + 100, param_00.origin, undefined, undefined, "MOD_UNKNOWN", "iw7_discotrap_zm");
}

remove_padding_damage() {
  self endon("disconnect");
  wait(1);
  self.padding_damage = undefined;
}

spawn_zombie_fish_fx(param_00) {
  playFX(level._effect["fish_trap_zombie"], (param_00.origin[0], param_00.origin[1], -165.5));
  scripts\engine\utility::waitframe();
  playFX(level._effect["fish_trap_zombie"], (param_00.origin[0], param_00.origin[1], -165.5));
  scripts\engine\utility::waitframe();
  playFX(level._effect["fish_trap_zombie"], (param_00.origin[0], param_00.origin[1], -165.5));
}