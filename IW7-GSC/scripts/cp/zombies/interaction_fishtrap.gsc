/*******************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\cp\zombies\interaction_fishtrap.gsc
*******************************************************/

init_fishtrap() {
  var_0 = scripts\engine\utility::getStructArray("trap_electric", "script_noteworthy");
  foreach(var_2 in var_0) {
    level thread func_F956(var_2);
  }

  wait(10);
  scripts\engine\utility::exploder(30);
}

func_F956(var_0) {
  var_1 = getEntArray(var_0.target, "targetname");
  foreach(var_3 in var_1) {
    if(var_3.classname == "trigger_multiple") {
      var_0.dmg_trig = var_3;
    }
  }
}

use_fishtrap(var_0, var_1) {
  if(getweaponbasename(var_1 getcurrentweapon()) != "iw7_penetrationrail_mp") {
    var_1 setweaponammostock("iw7_feed_fish", 1);
    var_1 giveandfireoffhand("iw7_feed_fish");
  }

  scripts\cp\cp_interaction::disable_linked_interactions(var_0);
  thread fish_trap_splash_sfx_init(var_0);
  scripts\engine\utility::exploder(30);
  var_1 thread scripts\cp\cp_vo::try_to_play_vo("activate_trap_generic", "zmb_comment_vo", "low", 10, 0, 1, 0, 40);
  level thread fish_trap_damage(var_0, var_1);
  level thread fish_trap_timer(var_0);
}

fish_trap_splash_sfx_init(var_0) {
  var_1 = [];
  var_1[0] = (-3054, 2028, -155);
  var_1[1] = (-2585, 2070, -155);
  var_1[2] = (-2629, 2330, -155);
  var_1[3] = (-2437, 2443, -155);
  var_1[4] = (-2249, 2154, -155);
  var_1[5] = (-2396, 1924, -155);
  var_1[6] = (-2776, 1684, -155);
  foreach(var_3 in var_1) {
    thread fish_trap_splash_sfx_spawn(var_0, var_3);
  }
}

fish_trap_splash_sfx_spawn(var_0, var_1) {
  var_2 = scripts\engine\utility::play_loopsound_in_space("trap_piranha_splash_lp", var_1);
  var_0 waittill("trap_done");
  var_2 playSound("trap_piranha_splash_end");
  wait(0.5);
  var_2 stoploopsound();
  wait(4);
  var_2 delete();
}

fish_trap_timer(var_0) {
  var_1 = gettime() + 25000;
  while(gettime() < var_1) {
    wait(1);
  }

  var_0 notify("trap_done");
  scripts\cp\cp_interaction::enable_linked_interactions(var_0);
  scripts\cp\cp_interaction::interaction_cooldown(var_0, 45);
}

fish_trap_damage(var_0, var_1) {
  var_0 endon("trap_done");
  for(;;) {
    var_0.dmg_trig waittill("trigger", var_2);
    if(isPlayer(var_2) && isalive(var_2) && !scripts\cp\cp_laststand::player_in_laststand(var_2) && !isDefined(var_2.padding_damage)) {
      var_2.padding_damage = 1;
      var_2 dodamage(5, var_2.origin);
      var_2 thread remove_padding_damage();
      continue;
    }

    if(!isPlayer(var_2) && !isDefined(var_2.marked_for_death) && isagent(var_2) && isalive(var_2) && scripts\engine\utility::istrue(var_2.isactive)) {
      if(isDefined(var_2.agent_type) && var_2.agent_type == "zombie_sasquatch" || var_2.agent_type == "slasher") {
        continue;
      }

      if(isDefined(var_2.team) && var_2.team == "allies") {
        continue;
      }

      level thread fish_kill_zombie(var_2, var_1);
    }
  }
}

fish_kill_zombie(var_0, var_1) {
  var_0 endon("death");
  var_0.anchor = spawn("script_origin", var_0.origin);
  var_0.anchor.angles = var_0.angles;
  thread spawn_zombie_fish_fx(var_0);
  var_0 linkto(var_0.anchor);
  var_0.nocorpse = 1;
  var_0.marked_for_death = 1;
  var_0.customdeath = 1;
  var_0.scripted_mode = 1;
  if(scripts\engine\utility::istrue(var_0.dismember_crawl)) {
    var_0.anchor movez(-10, 2);
  } else {
    var_0.anchor movez(-60, 4);
  }

  var_0.anchor waittill("movedone");
  if(var_1 scripts\cp\utility::is_valid_player()) {
    var_2 = ["kill_trap_generic", "kill_trap_1", "kill_trap_2", "kill_trap_3", "kill_trap_4", "kill_trap_5", "kill_trap_6", "trap_kill_7"];
    var_1 thread scripts\cp\cp_vo::try_to_play_vo(scripts\engine\utility::random(var_2), "zmb_comment_vo", "highest", 10, 0, 0, 1, 25);
    var_0 dodamage(var_0.health + 100, var_0.origin, var_1, var_1, "MOD_UNKNOWN", "iw7_discotrap_zm");
    return;
  }

  var_0 dodamage(var_0.health + 100, var_0.origin, undefined, undefined, "MOD_UNKNOWN", "iw7_discotrap_zm");
}

remove_padding_damage() {
  self endon("disconnect");
  wait(1);
  self.padding_damage = undefined;
}

spawn_zombie_fish_fx(var_0) {
  playFX(level._effect["fish_trap_zombie"], (var_0.origin[0], var_0.origin[1], -165.5));
  scripts\engine\utility::waitframe();
  playFX(level._effect["fish_trap_zombie"], (var_0.origin[0], var_0.origin[1], -165.5));
  scripts\engine\utility::waitframe();
  playFX(level._effect["fish_trap_zombie"], (var_0.origin[0], var_0.origin[1], -165.5));
}