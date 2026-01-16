/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\mo_tools.gsc
********************************/

wait_timeout(var_0, var_1) {
  self endon("wait timed out");
  thread wait_timeout2(var_0, var_1);
  self waittill("msg");
}

wait_timeout2(var_0, var_1) {
  self endon("msg");
  wait(var_1);
  self notify("wait timed out");
}

get_ai(var_0, var_1, var_2) {
  if(!isdefined(var_1))
    var_1 = "allies";

  if(!isdefined(var_2))
    var_2 = "targetname";

  var_3 = getaiarray(var_1);
  var_4 = [];

  for (var_5 = 0; var_5 < var_3.size; var_5++) {
    switch (var_2) {
      case "targetname":
        if(isdefined(var_3[var_5].targetname) && var_3[var_5].targetname == var_0)
          var_4[var_4.size] = var_3[var_5];

        break;
      case "script_noteworthy":
        if(isdefined(var_3[var_5].script_noteworthy) && var_3[var_5].script_noteworthy == var_0)
          var_4[var_4.size] = var_3[var_5];

        break;
      case "script_forcecolor":
        if(var_3[var_5] maps\_utility::check_force_color(var_0))
          var_4[var_4.size] = var_3[var_5];

        break;
    }
  }

  return var_4;
}

get_closest(var_0, var_1, var_2) {
  if(var_1.size < 1) {
    return;
  }
  var_3 = distancesquared(var_1[0].origin, var_0);
  var_4 = var_1[0];

  for (var_5 = 0; var_5 < var_1.size; var_5++) {
    var_6 = distancesquared(var_1[var_5].origin, var_0);

    if(var_6 >= var_3) {
      continue;
    }
    var_3 = var_6;
    var_4 = var_1[var_5];
  }

  if(isdefined(var_2) && distance(var_0, var_4.origin) > var_2)
    var_4 = undefined;

  return var_4;
}

get_closest_fx(var_0, var_1, var_2) {}

get_closest_ent(var_0, var_1, var_2) {
  if(var_1.size < 1) {
    return;
  }
  var_3 = distancesquared(var_1[0] getorigin(), var_0);
  var_4 = var_1[0];

  for (var_5 = 0; var_5 < var_1.size; var_5++) {
    var_6 = distancesquared(var_1[var_5] getorigin(), var_0);

    if(var_6 >= var_3) {
      continue;
    }
    var_3 = var_6;
    var_4 = var_1[var_5];
  }

  if(isdefined(var_2) && distance(var_0, var_4 getorigin()) > var_2)
    var_4 = undefined;

  return var_4;
}

get_ents_within_dist(var_0, var_1, var_2) {
  if(var_1.size < 1) {
    return;
  }
  var_3 = [];

  for (var_4 = 0; var_4 < var_1.size; var_4++) {
    var_5 = distance(var_1[var_4] getorigin(), var_0);

    if(var_5 > var_2) {
      continue;
    }
    var_3[var_3.size] = var_1[var_4];
  }

  return var_3;
}

door_breach(var_0, var_1, var_2, var_3) {
  var_1.ignoreme = 1;
  var_1.oldradius = var_1.goalradius;
  var_1.goalradius = 16;
  var_4 = 0;
  var_5 = 0;

  if(isdefined(var_1.set_forcedgoal))
    var_4 = 1;

  if(isdefined(var_1.magic_bullet_shield))
    var_5 = 1;

  if(!var_4)
    var_1 maps\_utility::set_forcegoal();

  if(!var_5)
    var_1 thread maps\_utility::magic_bullet_shield();

  if(var_3 == "kick") {
    var_6 = anglestoforward(var_0.angles);
    var_6 = maps\_utility::vector_multiply(var_6, 20);
    var_7 = spawn("script_origin", var_0.origin + var_6);
    var_7.angles = var_0.angles;
    var_0 = var_7;
  }

  var_1.oldanimname = var_1.animname;
  var_1.animname = "guy";

  if(var_3 == "kick")
    var_0 maps\_anim::anim_reach_solo(var_1, var_3);
  else {
    var_1 setgoalnode(var_0);
    var_1 waittill("goal");
  }

  var_0 thread maps\_anim::anim_single_solo(var_1, var_3);
  var_1 waittillmatch("single anim", "kick");
  common_scripts\utility::array_thread(var_2, ::door_breach_door);

  if(var_3 == "kick") {
    wait 0.2;
    var_1 stopanimscripted();
  } else
    var_1 waittillmatch("single anim", "end");

  var_1.animname = var_1.oldanimname;
  var_1.goalradius = var_1.oldradius;
  var_1.ignoreme = 0;

  if(!var_4)
    var_1 maps\_utility::unset_forcegoal();

  if(!var_5)
    var_1 maps\_utility::stop_magic_bullet_shield();
}

door_breach_door() {
  self notsolid();

  if(self.spawnflags & 1)
    self connectpaths();

  var_0 = 0;
  var_1 = 0;
  var_2 = 0;

  switch (self.script_parameters) {
    case "left":
      var_1 = randomfloatrange(88, 92);
      break;
    case "right":
      var_1 = -1 * randomfloatrange(88, 92);
      break;
    case "xleft":
      var_2 = 90;
      break;
    case "xright":
      var_2 = -90;
      break;
    case "yleft":
      var_0 = 90;
      break;
    case "yright":
      var_0 = -90;
      break;
  }

  var_3 = 0.4;
  var_4 = self.angles + (var_0, var_1, var_2);
  self rotateto(var_4, var_3, 0.05, 0.05);
  wait(var_3);
  self solid();
  self disconnectpaths();
}

floodspawner_switch(var_0, var_1) {
  var_2 = var_0.size;

  if(var_0.size > var_1.size)
    var_2 = var_1.size;

  for (var_3 = 0; var_3 < var_2; var_3++)
    var_0[var_3] thread spawner_switch_think(var_1[var_3]);

  if(var_3 < var_1.size) {
    for (var_4 = var_3; var_4 < var_1.size; var_4++)
      var_1[var_4] thread spawner_switch_think2();
  }
}

spawner_switch_think(var_0) {
  var_0 endon("death");
  var_0.floodspawncount--;
  self waittill("death");
  var_0 thread spawner_switch_think2();
}

spawner_switch_think2() {
  self endon("death");
  self.count = 1;

  if(!maps\_utility::script_wait())
    wait(randomfloatrange(2, 4));

  for (;;) {
    var_0 = self dospawn();

    if(!maps\_utility::spawn_failed(var_0)) {
      break;
    }

    wait 0.2;
  }
}

#using_animtree("fastrope");

player_fastrope_go(var_0) {
  var_1 = spawn("script_model", var_0.origin);
  var_1 setmodel("fastrope_arms");
  var_1.angles = var_0.angles;
  var_2 = spawn("script_origin", var_0.origin);
  var_2.angles = level.player.angles;
  var_1 linkto(var_2);
  var_1.animname = "playerfastrope";
  var_1 useanimtree(#animtree);
  level.player allowlean(0);
  level.player freezecontrols(1);
  level.player playerlinktoabsolute(var_1, "tag_player");
  playerweapontake();
  var_2 maps\_anim::anim_single_solo(var_1, "fastrope_on");
  var_2 movez((var_0.range + 96) * -1, var_0.time + 0.5);
  var_2 thread maps\_anim::anim_loop_solo(var_1, "fastrope_loop", undefined, "stopanimscripted");
  wait(var_0.time);
  var_2 notify("stopanimscripted");
  level.player maps\_anim::anim_single_solo(var_1, "fastrope_off");
  playerweapongive();
  level.player unlink();
  level.player freezecontrols(0);
  level.player allowlean(1);
  var_2 delete();
  var_1 delete();
}

ai_clear_dialog(var_0, var_1, var_2, var_3, var_4) {
  if(!isdefined(level.ai_clear_dialog_last))
    level.ai_clear_dialog_last = 0;

  var_5 = getaiarray("axis");
  ai_clear_dialog_logic(var_5, var_0, var_1, var_2, var_3, var_4);
}

ai_clear_dialog_logic_guy(var_0) {
  self waittill("death");
  var_0.count--;
  var_0 notify("ai_death");
}

ai_clear_dialog_logic_check() {
  self endon("death");
  self.ready = 0;

  while (self.count)
    self waittill("ai_death");

  self.ready = 1;
  self notify("ready");
}

ai_clear_dialog_logic(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(isdefined(var_2))
    var_2 endon(var_3);

  var_6 = spawnstruct();
  var_6.ready = 1;

  if(isdefined(var_1)) {
    var_6.count = var_1.size;
    var_6 thread ai_clear_dialog_logic_check();
    common_scripts\utility::array_thread(var_1, maps\_utility::add_spawn_function, ::ai_clear_dialog_logic_guy, var_6);
  }

  maps\_utility::waittill_dead(var_0);

  if(!var_6.ready)
    var_6 waittill("ready");

  var_6 notify("death");

  if(isdefined(var_4)) {
    wait 0.5;

    if(var_4 == level.player)
      thread radio_msg_stack(var_5);
    else
      var_4 thread maps\_utility::play_sound_on_entity(var_5);
  } else {
    var_7 = getaiarray("allies");
    var_8 = [];
    var_9 = maps\_utility::get_closest_living(level.player.origin, var_7, 1024);

    if(!isdefined(var_9)) {
      level notify("ai_clear_dialog_done");
      return;
    }

    var_10 = 2;

    for (var_11 = level.ai_clear_dialog_last; var_11 == level.ai_clear_dialog_last; var_11 = randomint(var_10)) {

    }

    level.ai_clear_dialog_last = var_11;
    wait 0.5;

    switch (var_11) {
      case 0:
        var_9 thread maps\_utility::play_sound_on_entity(level.level_name + "_gm2_clear");
        break;
      case 1:
        var_9 thread maps\_utility::play_sound_on_entity(level.level_name + "_gm3_clear");
        break;
    }
  }

  level notify("ai_clear_dialog_done");
}

playerweapongive() {
  level.player notify("restore_player_weapons");
}

playerweapontake() {
  thread playerweapontakelogic();
}

playerweapontakelogic() {
  if(isdefined(level.player.weaponstaken)) {
    return;
  }
  level.player.weaponstaken = 1;
  level.player disableweapons();
  level.player waittill("restore_player_weapons");
  level.player enableweapons();
  level.player.weaponstaken = undefined;
}

anim_single_stack(var_0, var_1) {
  var_2 = spawnstruct();
  var_2 thread anim_single_stack_proc(var_0, var_1);
  var_2 waittill("anim_single_done");
}

anim_single_stack_proc(var_0, var_1) {
  if(!isdefined(level.anim_stack))
    level.anim_stack = [];

  var_2 = "" + var_0.ai_number + var_1;
  level.anim_stack[level.anim_stack.size] = var_2;

  while (level.anim_stack[0] != var_2)
    level waittill("level_anim_stack_ready");

  maps\_anim::anim_single_solo(var_0, var_1);
  level.anim_stack = common_scripts\utility::array_remove(level.anim_stack, var_2);
  level notify("level_anim_stack_ready");
  self notify("anim_single_done");
}

radio_msg_stack(var_0) {
  var_1 = spawnstruct();
  var_1 thread radio_msg_stack_proc(var_0);
  var_1 waittill("radio_dialogue_done");
}

radio_msg_stack_proc(var_0) {
  if(!isdefined(level.radio_stack))
    level.radio_stack = [];

  level.radio_stack[level.radio_stack.size] = var_0;

  while (level.radio_stack[0] != var_0)
    level waittill("level_radio_stack_ready");

  maps\_utility::radio_dialogue(var_0);
  level.radio_stack = common_scripts\utility::array_remove(level.radio_stack, var_0);
  level notify("level_radio_stack_ready");
  self notify("radio_dialogue_done");
}

disable_cqbwalk_ign_demo_wrapper() {
  maps\_utility::disable_cqbwalk();

  if(!isdefined(self.a.cqbchangedontmodifyinterval) || !self.a.cqbchangedontmodifyinterval)
    self.interval = 96;
}

enable_cqbwalk_ign_demo_wrapper() {
  maps\_utility::enable_cqbwalk();

  if(!isdefined(self.a.cqbchangedontmodifyinterval) || !self.a.cqbchangedontmodifyinterval)
    self.interval = 50;
}