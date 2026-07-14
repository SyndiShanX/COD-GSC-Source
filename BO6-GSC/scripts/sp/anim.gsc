/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\anim.gsc
**************************************/

#using script_4dac3680f88a01c3;
#using scripts\aitypes\bt_util;
#using scripts\anim\animmode;
#using scripts\anim\death;
#using scripts\anim\face;
#using scripts\anim\first_frame;
#using scripts\anim\notetracks;
#using scripts\anim\notetracks_sp;
#using scripts\anim\pain;
#using scripts\anim\shared;
#using scripts\asm\asm;
#using scripts\asm\asm_sp;
#using scripts\asm\shared\sp\utility;
#using scripts\asm\shared\utility;
#using scripts\common\ai;
#using scripts\common\anim;
#using scripts\common\notetrack;
#using scripts\common\utility;
#using scripts\engine\sp\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\sp\anim_notetrack;
#using scripts\sp\debug;
#using scripts\sp\fakeactor;
#using scripts\sp\interaction;
#using scripts\sp\player;
#using scripts\sp\spawner;
#using scripts\stealth\enemy;
#namespace anim_sp;

function init() {
  setdvarifuninitialized(@ "hash_359daba9e2592b36", "\xfe");
  animation::initanim();
  notetracks_sp::registernotetracksifnot();
  anim_pain::initpainfx();
  anim_death::init_deathfx();
  anim.callbacks["\xef\xd8A\xd8\xcf\x9f\xd5\bPoA\xcfs\xa9\xe7\xb3\xed\x92j\x84\xa5"] = &play_sound_at_viewheight;
  anim.callbacks["\xdf\x02\xf2\x16|\xdf\xd0\x1e-\x036"] = &teleport_entity;
  anim.callbacks["7\xadXnx\x9a\xe5\xb7C\xeb\t9"] = &should_do_anim;
  anim.callbacks["\x86;\xbf>M\xc5\xc2\x04\x16\xba\x98"] = &do_animation;
  anim.callbacks["\xec\x9c\x8b \xaa\xb0\xd4\xcf\xa6\xad\xc0\xd8"] = &do_facial_anim;
  anim.callbacks["8F\x1c\xa8\xa9a\xb4P[\xc4\xf2\xa1a\x88\xf1\x05"] = &utility_sp::anim_stopanimscripted;
  anim.callbacks["j\xe6\xf7\xc5\xd5\xcf\x8f(\x16\xaf\xe1\xbd\x8f\v\xb8\xf3\xc7L~\x11\xec5(g1\x19\xffv\x03\xf5]\xe0\xabt\xf8\x1e\x0e"] = &function_cc200fe2e226ec45;
  anim.callbacks["\x8c\xcb\x0e\xd3\xca\x95>htQ\xb0\x93\x86\xafh\\\xed5\xbb\xdar\xfd\xd6\xc1\fp\xb03\xc6\x8f2`\xd3\xed\xa1"] = &function_1c92ab7bf5f98521;
  anim.callbacks["\xc5\xb6| \x8azTx\x17\xca\xaf\xc9\xb8x\x15,\xf8\xcc\xfc"] = &anim_notetrack::sp_anim_handle_notetrack;
  anim.callbacks["E7\xa3-G\x97Ha\xdc\x91\xb1+\xe4{\x1d\xca\xa3\xe4\xb0\x8dm"] = &anim_notetrack::entity_handle_notetrack;
  anim.callbacks["\xe1\xd3\xa3:\x1e\x83\x1e\x06,8\x8c\xbb\xe9\xbf\v\"L\a\xf7\xa0\xf4\xa0\x9b_\x19lOd"] = &notetracks::function_687d6da8dbe521c0;
  anim.callbacks["c\xf3\xf3<\xc6\xf4\x9bY]\xa4\x1e\xaf\x91\x80\xcf\x86"] = &ai_anim_first_frame;
  anim.callbacks["\xb1\xd0e\xbf\xaad|L\a\xca\x15\x17\x19\xa0\x15L\x1e#8"] = &function_6f858ddd0be86775;
  anim.callbacks["rn\xa3<\xb2\xd3\xff\x1d["] = &utility_sp::dialogue_print;
  anim.callbacks["\x88\x85\x1a\x17\xff\x1aX$"] = &play_xcam;
  utility::registersharedfunc(#"ai", #"Animscripted_SharedFunc", &utility::animscriptedactor);
  asm::asm_globalinit();
  bt_util::init();
  asm::setup_level_ents();

  if(getdvarint(@ "hash_2f8a3b3aa1e31fe5", 0) != 0) {
    thread asm::validatetraversenodes();
  }

  setdvarifuninitialized(@ "scr_debug_reach", 0);

  if(!isDefined(level.notetrackmissionfailedvo)) {
    level.notetrackmissionfailedvo = 1;
  }

  if(!isDefined(level.notetrackvo)) {
    level.notetrackvo = 1;
  }
}

function function_a0db8c2165a10110(anime) {
  names = utility_sp::function_99ee256322f70451(anime);
  assert(istrue(names.size), "<dev string:x24>" + anime);
  assert(names.size > 1, "<dev string:x45>" + anime);
  prevtime = undefined;
  time = undefined;
  identical = 1;
  prevtime = getanimlength(level.scr_anim[names[0]][anime]);

  for(i = 1; i < names.size; i++) {
    prefix = "";
    time = getanimlength(level.scr_anim[names[i]][anime]);

    if(prevtime != time) {
      identical = 0;
      prefix = "\xd6\xba\x84\xb1\xdc\xe4%\xe7w\xf9\x1d";
    }

    println(prefix + time + "<dev string:x71>" + names[i] + "<dev string:x7e>" + anime);
    prevtime = time;
  }

  return identical;
}

function function_e9fdd9cf0d5d479d(vo_alias) {
  assert(soundexists(vo_alias));
  self waittillmatch("\xb3\\\x97b@19[\x9e\xc1\xd7", "\xca!\xcf" + vo_alias);
  ms = lookupsoundlength(vo_alias);
  wait ms / 1000;
}

function igc_camera(bool) {
  registered = "y\x8ah";

  if(bool) {
    level.player player_sp::remove_damage_effects_instantly();
    level.player utility::function_7796cb25a4c0b81b(0);
  } else {
    level.player utility::function_7796cb25a4c0b81b(1);
  }

  level.player utility::igc_camera(bool);
}

function letterbox_enable(bool, time) {
  level.player utility::letterbox_enable(bool, time);
}

function play_xcam(xcamasset, origin, angles) {
  camnum = undefined;

  if(!isDefined(camnum)) {
    camnum = 0;
  }

  level.player playxcam(xcamasset, camnum, origin, angles);
  wait getxcamlength(xcamasset);
}

function die_frozen(attacker, inflictor, meansofdeath, weaponobj) {
  assert(isai(self), "<dev string:x83>");
  assert(isalive(self), "<dev string:xa7>");
  self.allowdeath = 1;
  self.deathanimmode = "(\xd4\xc9PE\xef\xc9`\xe8";
  self.disabledeathorient = 1;
  self.noragdoll = 1;
  self.skipdeathanim = 1;
  self.diequietly = 1;

  if(istrue(self.magic_bullet_shield)) {
    ai::stop_magic_bullet_shield();
  }

  if(!isDefined(attacker)) {
    attacker = undefined;
  }

  if(!isDefined(inflictor)) {
    inflictor = undefined;
  }

  if(!isDefined(meansofdeath)) {
    meansofdeath = undefined;
  }

  if(!isDefined(weaponobj)) {
    weaponobj = undefined;
  }

  self dodamage(self.health + 1, self.origin, attacker, inflictor, meansofdeath, undefined);
}

function anim_generic_gravity(guy, anime, tag) {
  pain = guy.allowpain;
  guy utility::disable_pain();
  anim_generic_custom_animmode(guy, "\x1b\x9e\x86\xecr\x97\xa2", anime, tag);

  if(pain) {
    guy utility::enable_pain();
  }
}

function anim_generic_reach(guy, anime, tag) {
  guys = [];
  guys[0] = guy;
  anim_reach(guys, anime, tag, "RF\x9e\xe1\xc4\x1f\xe7");
}

function anim_generic_reach_and_arrive(guy, anime, tag, arrival_type) {
  reach_and_arrive_internal(guy, anime, tag, arrival_type, "RF\x9e\xe1\xc4\x1f\xe7");
}

function anim_reach_and_arrive(guy, anime, tag, arrival_type) {
  reach_and_arrive_internal(guy, anime, tag, arrival_type, guy.animname);
}

function reach_and_arrive_internal(guy, anime, tag, arrival_type, anim_location) {
  if(interaction::is_interact_struct(self) || interaction::is_state_interact_struct(self)) {
    if(isDefined(self.script_reaction)) {
      guy.asm.customdata.interaction = self.script_reaction;
    } else {
      guy.asm.customdata.interaction = self.script_noteworthy;
    }

    interaction = interaction::get_interaction(guy.asm.customdata.interaction);

    if(!isDefined(interaction)) {
      interaction = interaction::get_state_interaction(guy.asm.customdata.interaction);
    }

    guy.asm.customdata.arrivalstate = undefined;

    if(isDefined(interaction)) {
      guy.asm.customdata.arrivalstate = guy interaction::get_arrivalstate_from_interaction(interaction);
    }

    if(isDefined(guy.asm.customdata.arrivalstate)) {
      animation::anim_reach_with_funcs([guy], anime, tag, anim_location, &reach_to_interact_begin, &reach_to_interact_end, arrival_type);
    } else {
      animation::anim_reach_with_funcs([guy], anime, tag, anim_location, &reach_with_arrivals_begin, &animation::reach_with_standard_adjustments_end, arrival_type);
    }

    return;
  }

  animation::anim_reach_with_funcs([guy], anime, tag, anim_location, &reach_with_arrivals_begin, &animation::reach_with_standard_adjustments_end, arrival_type);
}

function anim_reach_and_plant(guys, anime, tag) {
  animation::anim_reach_with_funcs(guys, anime, tag, undefined, &reach_with_planting, &animation::reach_with_standard_adjustments_end);
}

function anim_reach_and_plant_and_arrive(guys, anime, tag) {
  animation::anim_reach_with_funcs(guys, anime, tag, undefined, &reach_with_planting_and_arrivals, &animation::reach_with_standard_adjustments_end);
}

function anim_custom_animmode(guys, custom_animmode, anime, tag) {
  array = animation::get_anim_position(tag);
  org = array["\xb0$R\x8b\xc9\x17"];
  angles = array["\xc5\x94\x82H\x9a`"];
  aguy = undefined;

  foreach(guy in guys) {
    aguy = guy;
    assert(isDefined(guy.animname), "<dev string:xbe>");
    thread anim_custom_animmode_on_guy(guy, custom_animmode, anime, org, angles, guy.animname, 0);
  }

  assert(isDefined(aguy), "<dev string:xf5>");
  aguy wait_until_anim_finishes(anime);
  self notify(anime);
}

function anim_custom_animmode_loop(guys, custom_animmode, anime, tag) {
  array = animation::get_anim_position(tag);
  org = array["\xb0$R\x8b\xc9\x17"];
  angles = array["\xc5\x94\x82H\x9a`"];

  foreach(guy in guys) {
    thread anim_custom_animmode_on_guy(guy, custom_animmode, anime, org, angles, guy.animname, 1);
  }

  assert(isDefined(guys[0]), "<dev string:xf5>");
  guys[0] wait_until_anim_finishes(anime);
  self notify(anime);
}

function wait_until_anim_finishes(anime) {
  self endon("\xd7\xca\xae\xca\xff\xdb\xf1<\x8f1\xf97\xccqI\xb5fR\xe5%\xf9\xbdY\xe4" + anime);
  self waittill("\x1e\xfd\xd1\xa2\a");
}

function anim_generic_custom_animmode(guy, custom_animmode, anime, tag, thread_func, var_83264c7dd9405255) {
  array = animation::get_anim_position(tag);
  org = array["\xb0$R\x8b\xc9\x17"];
  angles = array["\xc5\x94\x82H\x9a`"];
  thread anim_custom_animmode_on_guy(guy, custom_animmode, anime, org, angles, "RF\x9e\xe1\xc4\x1f\xe7", 0, thread_func, var_83264c7dd9405255);
  guy wait_until_anim_finishes(anime);
  self notify(anime);
}

function anim_generic_custom_animmode_loop(guy, custom_animmode, anime, tag, thread_func, var_83264c7dd9405255) {
  array = animation::get_anim_position(tag);
  org = array["\xb0$R\x8b\xc9\x17"];
  angles = array["\xc5\x94\x82H\x9a`"];
  thread anim_custom_animmode_on_guy(guy, custom_animmode, anime, org, angles, "RF\x9e\xe1\xc4\x1f\xe7", 1, thread_func, var_83264c7dd9405255);
  guy wait_until_anim_finishes(anime);
  self notify(anime);
}

function anim_custom_animmode_solo(guy, custom_animmode, anime, tag) {
  guys = [];
  guys[0] = guy;
  anim_custom_animmode(guys, custom_animmode, anime, tag);
}

function anim_custom_animmode_loop_solo(guy, custom_animmode, anime, tag) {
  guys = [];
  guys[0] = guy;
  anim_custom_animmode_loop(guys, custom_animmode, anime, tag);
}

function anim_custom_animmode_on_guy(guy, custom_animmode, anime, org, angles, animname_override, loop, thread_func, var_83264c7dd9405255) {
  if(isai(guy) && guy utility::doinglongdeath()) {
    return;
  }

  animname = undefined;

  if(isDefined(animname_override)) {
    animname = animname_override;
  } else {
    animname = guy.animname;
  }

  guy animation::assert_existance_of_anim(anime, animname);

  assert(isai(guy), "<dev string:x12f>");

  if(!isDefined(var_83264c7dd9405255) || !var_83264c7dd9405255) {
    guy animation::set_start_pos(anime, org, angles, animname_override, loop);
  }

  guy._animmode = custom_animmode;
  guy._custom_anim = anime;
  guy._tag_entity = self;
  guy._anime = anime;
  guy._animname = animname;
  guy._custom_anim_loop = loop;
  guy._custom_anim_thread = thread_func;
  guy asm_sp::asm_animcustom(&animmode::main, &asm_sp::asm_stopanimcustom);
}

function anim_single_gravity(guys, anime, tag) {
  foreach(guy in guys) {
    guy utility::disable_pain();
  }

  anim_custom_animmode(guys, "\x1b\x9e\x86\xecr\x97\xa2", anime, tag);

  foreach(guy in guys) {
    if(isDefined(guy) && isalive(guy)) {
      guy utility::enable_pain();
    }
  }
}

function anim_single_run(guys, anime, tag, animname_override) {
  animation::anim_single_internal(guys, anime, tag, 0.25, animname_override);
}

function anim_reach_and_idle(guys, anime, anime_idle, ender, tag) {
  thread anim_reach(guys, anime, tag);
  ent = spawnStruct();
  ent.reachers = 0;

  foreach(guy in guys) {
    ent.reachers++;
    thread idle_on_reach(guy, anime_idle, ender, tag, ent);
  }

  for(;;) {
    ent waittill("m_\xa6\xe9\x11\xcb\xaf&:\xbf\xb2\x18SE\xfb\x80");

    if(ent.reachers <= 0) {
      return;
    }
  }
}

function wait_for_guy_to_die_or_get_in_position() {
  self endon("\x1e\xfd\xd1\xa2\a");
  self waittill("\xda\xe2\r!\xe3z\"^\xf3\xe3\xb8\xb3\x8af~t\xf4G~");
}

function idle_on_reach(guy, anime_idle, ender, tag, ent) {
  guy wait_for_guy_to_die_or_get_in_position();
  ent.reachers--;
  ent notify("m_\xa6\xe9\x11\xcb\xaf&:\xbf\xb2\x18SE\xfb\x80");

  if(isalive(guy)) {
    animation::anim_loop_solo(guy, anime_idle, ender, tag);
  }
}

function anim_reach_together(guys, anime, tag, animname_override) {
  guys_with_anims = [];

  foreach(guy in guys) {
    guys_with_anims[guys_with_anims.size] = [guy];
  }

  thread animation::anim_reach_speed_control(guys_with_anims);
  animation::anim_reach_with_funcs(guys, anime, tag, animname_override, &animation::reach_with_standard_adjustments_begin, &animation::reach_with_standard_adjustments_end);
}

function anim_reach_failsafe(var_dfc113f9133c3408, time) {
  if(isarray(var_dfc113f9133c3408)) {
    foreach(guy in var_dfc113f9133c3408) {
      thread anim_reach_failsafe(guy, time);
    }

    return;
  }

  guy = var_dfc113f9133c3408;
  guy endon("\xc2>\x97`k\x01.>\xf2\x0f\xc6\x908h");
  wait time;
  guy notify("\x83\xd6\xaf\x11");
}

function anim_reach(guys, anime, tag, animname_override) {
  if(interaction::is_interact_struct(self)) {
    foreach(guy in guys) {
      if(isDefined(self.script_reaction)) {
        guy.asm.customdata.interaction = self.script_reaction;
        continue;
      }

      guy.asm.customdata.interaction = self.script_noteworthy;
    }

    animation::anim_reach_with_funcs(guys, anime, tag, animname_override, &reach_to_interact_begin, &reach_to_interact_end);
    return;
  }

  animation::anim_reach_with_funcs(guys, anime, tag, animname_override, &function_cc200fe2e226ec45, &function_1c92ab7bf5f98521);
}

function anim_reach_cleanup_solo(guy) {
  if(!isalive(guy)) {
    return;
  }

  if(isDefined(guy.oldgoalradius)) {
    guy.goalradius = guy.oldgoalradius;
  }

  if(isDefined(guy.scriptedarrivalent)) {
    guy.scriptedarrivalent delete();
  }

  guy.disablearrivals = 0;
  guy.stopanimdistsq = 0;
}

function anim_spawner_teleport(guys, anime, tag) {
  pos = animation::get_anim_position(tag);
  org = pos["\xb0$R\x8b\xc9\x17"];
  angles = pos["\xc5\x94\x82H\x9a`"];
  ent = spawnStruct();

  foreach(guy in guys) {
    startorg = getstartorigin(org, angles, level.scr_anim[guy.animname][anime]);
    guy.origin = startorg;
  }
}

function reach_to_interact_begin(startorg, startangles) {
  self.oldgoalradius = self.goalradius;
  self.oldpathenemyfightdist = self.pathenemyfightdist;
  self.oldpathenemylookahead = self.pathenemylookahead;
  self.pathenemyfightdist = 128;
  self.pathenemylookahead = 128;
  utility_sp::disable_ai_color();
  anim_changes_pushplayer(1);
  self.nododgemove = 1;
  self.doavoidanceblocking = 0;
  self.fixednodewason = self.fixednode;
  self.fixednode = 0;
  self.var_c2ae25b51811f111 = self.cornercheckenabled;
  self.cornercheckenabled = 0;
  self.old_disablearrivals = self.disablearrivals;
  self.disablearrivals = 0;
  self.reach_goal_pos = undefined;
  assert(isDefined(self.asm.customdata.interaction));
  interaction = interaction::get_interaction(self.asm.customdata.interaction);

  if(!isDefined(interaction)) {
    interaction = interaction::get_state_interaction(self.asm.customdata.interaction);
  }

  self.customarrivalstate = interaction::get_arrivalstate_from_interaction(interaction);
  self.customarrivalangles = startangles;
  self.var_86770fad21f191a3 = interaction::get_idlestate_from_interaction(interaction);
  self.var_ae2790476708dfb3 = 1;

  if(isDefined(interaction.arrival_animmode)) {
    self.customarrivalanimmode = interaction.arrival_animmode;
  }

  return startorg;
}

function function_cc200fe2e226ec45(startorg, startangles) {
  self.oldgoalradius = self.goalradius;
  self.oldpathenemyfightdist = self.pathenemyfightdist;
  self.oldpathenemylookahead = self.pathenemylookahead;
  self.pathenemyfightdist = 0;
  self.pathenemylookahead = 128;
  utility_sp::disable_ai_color();
  anim_changes_pushplayer(1);
  self.nododgemove = 1;
  self.doavoidanceblocking = 0;
  self.fixednodewason = self.fixednode;
  self.fixednode = 0;
  self.var_c2ae25b51811f111 = self.cornercheckenabled;
  self.cornercheckenabled = 0;

  if(!isDefined(self.scriptedarrivalent)) {
    self.old_disablearrivals = self.disablearrivals;
    self.disablearrivals = 1;
  } else {
    self.scriptedarrivalent.angles = startangles;
    self.scriptedarrivalent.origin = startorg;
  }

  self.reach_goal_pos = undefined;
  return startorg;
}

function reach_to_interact_end() {
  anim_changes_pushplayer(0);
  self.nododgemove = 0;
  self.doavoidanceblocking = 1;
  self.fixednode = self.fixednodewason;
  self.fixednodewason = undefined;
  self.cornercheckenabled = self.var_c2ae25b51811f111;
  self.var_c2ae25b51811f111 = undefined;
  self.pathenemyfightdist = self.oldpathenemyfightdist;
  self.pathenemylookahead = self.oldpathenemylookahead;
  self.disablearrivals = self.old_disablearrivals;
  assert(isDefined(self.asm.customdata.interaction));
  interaction = interaction::get_interaction(self.asm.customdata.interaction);

  if(!isDefined(interaction)) {
    interaction = interaction::get_state_interaction(self.asm.customdata.interaction);
  }

  self.var_c9829cc678d083b1 = interaction::get_exitstate_from_interaction(interaction);
  self.asm.customdata.interaction = undefined;
  self.customarrivalstate = undefined;
  self.customarrivalangles = undefined;
}

function function_1c92ab7bf5f98521() {
  anim_changes_pushplayer(0);
  self.nododgemove = 0;
  self.doavoidanceblocking = 1;
  self.fixednode = self.fixednodewason;
  self.fixednodewason = undefined;
  self.cornercheckenabled = self.var_c2ae25b51811f111;
  self.var_c2ae25b51811f111 = undefined;
  self.pathenemyfightdist = self.oldpathenemyfightdist;
  self.pathenemylookahead = self.oldpathenemylookahead;

  if(isDefined(self.old_disablearrivals)) {
    self.disablearrivals = self.old_disablearrivals;
  }
}

function anim_changes_pushplayer(value) {
  if(isDefined(self.dontchangepushplayer)) {
    assert(self.dontchangepushplayer == 1);
    return;
  }

  self pushplayer(value);
}

function reach_with_arrivals_begin(startorg, startangles) {
  startorg = animation::reach_with_standard_adjustments_begin(startorg, startangles);
  self.disablearrivals = 0;
  return startorg;
}

function reach_with_planting(startorg, startangles) {
  neworigin = self getdroptofloorposition(startorg);
  assert(isDefined(neworigin));
  startorg = neworigin;
  startorg = animation::reach_with_standard_adjustments_begin(startorg, startangles);
  self.disablearrivals = 1;
  return startorg;
}

function reach_with_planting_and_arrivals(startorg, startangles) {
  neworigin = self getdroptofloorposition(startorg);
  assert(isDefined(neworigin));
  startorg = neworigin;
  startorg = animation::reach_with_standard_adjustments_begin(startorg, startangles);
  self.disablearrivals = 0;
  return startorg;
}

function anim_reach_and_idle_solo(guy, anime, anime_idle, ender, tag) {
  self endon("\x1e\xfd\xd1\xa2\a");
  newguy[0] = guy;
  anim_reach_and_idle(newguy, anime, anime_idle, ender, tag);
}

function anim_reach_solo(guy, anime, tag) {
  self endon("\x1e\xfd\xd1\xa2\a");
  newguy[0] = guy;
  anim_reach(newguy, anime, tag);
}

function anim_reach_and_approach_solo(guy, anime, tag, arrival_type) {
  self endon("\x1e\xfd\xd1\xa2\a");
  newguy[0] = guy;
  anim_reach_and_approach(newguy, anime, tag, arrival_type);
}

function anim_reach_and_approach_node_solo(guy, anime, tag, node_type, arrival_stance) {
  self endon("\x1e\xfd\xd1\xa2\a");
  newguy[0] = guy;
  array = animation::get_anim_position(tag);
  origin = array["\xb0$R\x8b\xc9\x17"];
  angles = array["\xc5\x94\x82H\x9a`"];
  animname = guy.animname;

  if(isDefined(level.scr_anim[animname][anime])) {
    if(isarray(level.scr_anim[animname][anime])) {
      animation = level.scr_anim[animname][anime][0];
    } else {
      animation = level.scr_anim[animname][anime];
    }

    origin = getstartorigin(origin, angles, animation);
    angles = getstartorigin(origin, angles, animation);
  }

  arrivalent = spawn("\xdcc9-p\xd1\xbe\xedr\xa5v-\xdc", origin);
  arrivalent.angles = angles;

  if(isDefined(node_type)) {
    arrivalent.type = node_type;
  } else {
    arrivalent.type = self.type;
  }

  if(isDefined(arrival_stance)) {
    arrivalent.arrivalstance = arrival_stance;
  } else {
    arrivalent.arrivalstance = self gethighestnodestance();
  }

  guy.scriptedarrivalent = arrivalent;
  anim_reach_and_approach(newguy, anime, tag);
  guy.scriptedarrivalent = undefined;
  arrivalent delete();

  while(guy.a.movement != "\x04M\xed\xab") {
    wait 0.05;
  }
}

function anim_reach_and_approach(guys, anime, tag, arrival_type) {
  self endon("\x1e\xfd\xd1\xa2\a");

  if(interaction::is_interact_struct(self)) {
    foreach(guy in guys) {
      if(isDefined(self.script_noteworthy)) {
        guy.asm.customdata.interaction = self.script_noteworthy;
        continue;
      }

      guy.asm.customdata.interaction = self.script_reaction;
    }

    animation::anim_reach_with_funcs(guys, anime, tag, undefined, &reach_to_interact_begin, &reach_to_interact_end, arrival_type);
    return;
  }

  if(!isDefined(arrival_type)) {
    arrival_type = "\xf7\xd5d'hTb";
  }

  animation::anim_reach_with_funcs(guys, anime, tag, undefined, &reach_with_arrivals_begin, &animation::reach_with_standard_adjustments_end, arrival_type);
}

function add_animation(animname, anime) {
  if(!isDefined(level.completedanims)) {
    level.completedanims[animname][0] = anime;
    return;
  }

  if(!isDefined(level.completedanims[animname])) {
    level.completedanims[animname][0] = anime;
    return;
  }

  for(i = 0; i < level.completedanims[animname].size; i++) {
    if(level.completedanims[animname][i] == anime) {
      return;
    }
  }

  level.completedanims[animname][level.completedanims[animname].size] = anime;
}

function anim_single_queue(guy, anime, tag, var_36e7c8da58046eb7) {
  if(!isDefined(var_36e7c8da58046eb7)) {
    var_36e7c8da58046eb7 = 0;
  }

  assert(isDefined(anime), "<dev string:x15a>");

  if(isDefined(guy.last_queue_time)) {
    utility_sp::wait_for_buffer_time_to_pass(guy.last_queue_time, 0.5);
  }

  utility_sp::function_stack(&animation::anim_single_solo, guy, anime, tag, var_36e7c8da58046eb7);

  if(isalive(guy)) {
    guy.last_queue_time = gettime();
  }
}

function anim_generic_queue(guy, anime, tag, var_36e7c8da58046eb7, timeout) {
  guy endon("\x1e\xfd\xd1\xa2\a");

  if(!isDefined(var_36e7c8da58046eb7)) {
    var_36e7c8da58046eb7 = 0;
  }

  assert(isDefined(anime), "<dev string:x15a>");

  if(isDefined(guy.last_queue_time)) {
    utility_sp::wait_for_buffer_time_to_pass(guy.last_queue_time, 0.5);
  }

  if(isDefined(timeout)) {
    utility_sp::function_stack_timeout(timeout, &animation::anim_single_solo, guy, anime, tag, var_36e7c8da58046eb7, "RF\x9e\xe1\xc4\x1f\xe7");
  } else {
    utility_sp::function_stack(&animation::anim_single_solo, guy, anime, tag, var_36e7c8da58046eb7, "RF\x9e\xe1\xc4\x1f\xe7");
  }

  if(isalive(guy)) {
    guy.last_queue_time = gettime();
  }
}

function anim_dontpushplayer(guys) {
  foreach(guy in guys) {
    guy pushplayer(0);
  }
}

function anim_pushplayer(guys) {
  foreach(guy in guys) {
    guy pushplayer(1);
  }
}

#using_animtree("*xmG4\x1e\x14\xb1\xc2u_!\xf5");

function function_d1c3a5869ce458b4() {
  if(isDefined(self.weapon)) {
    shared::dropaiweapon();
  }

  self setflaggedanim("Y\xe5\xb4\x9e\xf9\xb4\x06\xea\xd4\xb3\x06\x0e\t\x0f\x1e\xcd", %G2\xa60I\x800;\xb5s\xfd\xeb\xc9
  }\
  xa8\x18\x13g / \xf8, 1);
level thread notetrack::start_notetrack_wait(self, "Y\xe5\xb4\x9e\xf9\xb4\x06\xea\xd4\xb3\x06\x0e\t\x0f\x1e\xcd", undefined, undefined, %G2\xa60I\x800;\xb5s\xfd\xeb\xc9
}\
xa8\x18\x13g / \xf8);
level thread animscriptdonotetracksthread(self, "Y\xe5\xb4\x9e\xf9\xb4\x06\xea\xd4\xb3\x06\x0e\t\x0f\x1e\xcd");
return true;
}

function anim_facialanim(guy, anime, faceanim) {
  guy endon("\x1e\xfd\xd1\xa2\a");
  self endon(anime);
  changetime = 0.05;
  guy notify("\xb9\x95\xddb\xdb\xb7\xb6EX\x9c\xd9e\xa3");
  guy notify("\xc5\xe1\xb5\\HL\x10\xe7\x02\x8a\x1e5\x9d");
  utility::disabledefaultfacialanims();
  waittillframeend();

  if(!isDefined(self.scriptedtalkingknob)) {
    self.scriptedtalkingknob = asm::asm_getxanim("?\xd3b\x8e/", asm::asm_lookupanimfromalias("?\xd3b\x8e/", "F\x83\x1c\x9d\x19\xc5\xca\x1b\xe35DN\xb8\xf4?\x8c"));
  }

  animflag = "6i\xb5\xf6\xa0\xf6k9\xafwP\x88E_" + anime;
  guy setanim(self.scriptedtalkingknob, 1, 0.2);
  guy setflaggedanimknobrestart(animflag, faceanim, 1, 0, 1);
  thread facial_notetrack_handler(guy, animflag, anime);
  thread clearfaceanimonanimdone(guy, animflag, anime);
}

function facial_notetrack_handler(guy, animflag, anime) {
  self endon(anime);
  guy endon("\x1e\xfd\xd1\xa2\a");
  guy endon("b\xf6+H\xa9\xcc\x10\x940");
  guy endon("|\xf9Sv\x06#)d\xbe\xa5\xa8';&]\xf9x\xb6");
  guy endon("\xc5\xe1\xb5\\HL\x10\xe7\x02\x8a\x1e5\x9d");

  while(true) {
    self waittill(animflag, notetracks);

    foreach(note in notetracks) {
      prefix = getsubstr(note, 0, 3);

      if(prefix == "\xca!\xcf") {
        alias = getsubstr(note, 3);

        if(!issentient(self)) {
          thread utility_sp::play_sound_on_tag(alias, "\xa6\xeb\x1ae\x85#", 1, alias);
        } else {
          play_sound_at_viewheight(alias, "'*C\x01\xa38\x82q\f\xf1\x92\xb5`0", 1);
        }

        continue;
      }

      if(prefix == "4\xebd") {
        alias = getsubstr(note, 4);
        thread utility_sp::smart_player_dialogue(alias);
      }
    }
  }
}

function function_d7a72f1908a6c561(guy, animflag, anime, faceanim) {
  guy endon("<dev string:x1a0>");
  guy endon("<dev string:x1a9>");
  self endon(anime);
  wait 0.2;

  for(;;) {
    animweight = guy getanimweight(faceanim);

    if(animweight <= 0) {
      assertmsg("<dev string:x1b6>");
      return;
    }

    if(self.facialstate != "<dev string:x202>") {
      assertmsg("<dev string:x212>");
      return;
    }

    waitframe();
  }
}

function anim_facialfiller(msg, looktarget, force, msg_ent, intensity = "\at") {
  self endon("\x1e\xfd\xd1\xa2\a");
  self notify("\xc5\xe1\xb5\\HL\x10\xe7\x02\x8a\x1e5\x9d");

  if(!isDefined(msg_ent)) {
    msg_ent = self;
  }

  if(isai(self) && !isalive(self)) {
    return;
  }

  if(!isai(self)) {
    if(!isDefined(self.fakeactor_face_anim)) {
      return;
    } else if(!self.fakeactor_face_anim || !isalive(self)) {
      return;
    }
  }

  if(istrue(self.nofacialfiller)) {
    return;
  }

  if(!istrue(force) && !utility::isfacialstateallowed("\x88H\xcbq\x8f\xdd")) {
    return;
  }

  if(isDefined(self.unittype) && (self.unittype == "\xdf~" || self.unittype == "YB" || self.unittype == "\x11\xabV")) {
    return;
  }

  changetime = 0.05;
  self notify("\xb9\x95\xddb\xdb\xb7\xb6EX\x9c\xd9e\xa3");
  self endon("\xb9\x95\xddb\xdb\xb7\xb6EX\x9c\xd9e\xa3");
  waittillframeend();

  if(!isDefined(looktarget) && isDefined(self.bc_looktarget)) {
    looktarget = self.bc_looktarget;
  }

  archetype = utility::function_bc2028f16daab4cc();
  talkanim = self.defaulttalk;
  headknob = self.scriptedtalkingknob;
  assert(isalive(self));
  utility::setfacialstate("\x88H\xcbq\x8f\xdd");

  if(archetype != "") {
    if(isai(self)) {
      self setfacialindex("~\xe3'\x90\xa9" + intensity);
    } else if(istrue(self.var_22bbe270fbb36c94)) {
      utility::function_ffcc9a389593ff8c("~\xe3'\x90\xa9" + intensity);
    } else {
      utility::setfacialindexfornonai("~\xe3'\x90\xa9" + intensity);
    }
  } else {
    self setanimknoblimitedrestart(talkanim, 1, 0, 1);
    self setanim(headknob, 5, 0.267);
  }

  msg_ent waittill(msg);

  if(archetype != "" && isai(self)) {
    self setfacialindex("\r+x5");
  } else if(istrue(self.var_22bbe270fbb36c94) && isDefined(self.capanimset)) {
    utility::function_ffcc9a389593ff8c("\r+x5");
  }

  utility::clearfacialstate("\x88H\xcbq\x8f\xdd");
}

function talk_for_time(timer) {
  self endon("\x1e\xfd\xd1\xa2\a");
  talkanim = self.defaulttalk;
  self setanimknoblimitedrestart(talkanim, 1, 0, 1);
  self setanim(self.scriptedtalkingknob, 5, 0.4);
  utility::disabledefaultfacialanims();
  wait timer;
  changetime = 0.3;
  self clearanim(self.scriptedtalkingknob, 0.2);
  utility::disabledefaultfacialanims(0);
}

function anim_reach_idle(guys, anime, idle) {
  ent = spawnStruct();
  ent.count = guys.size;

  foreach(guy in guys) {
    thread reachidle(guy, anime, idle, ent);
  }

  while(ent.count) {
    ent waittill("\xaf7\xee\xff\x12\x0f\x8c\xf3\x90\xf2\xf8B");
  }

  self notify("j\r\x9f\xe9X\xd4\x99\xaa\xba\x89\x94N\x86");
}

function reachidle(guy, anime, idle, ent) {
  anim_reach_solo(guy, anime);
  ent.count--;
  ent notify("\xaf7\xee\xff\x12\x0f\x8c\xf3\x90\xf2\xf8B");

  if(ent.count > 0) {
    animation::anim_loop_solo(guy, idle, "j\r\x9f\xe9X\xd4\x99\xaa\xba\x89\x94N\x86");
  }
}

function clearfaceanimonanimdone(guy, animflag, anime) {
  guy endon("\x1e\xfd\xd1\xa2\a");
  guy endon("\xc5\xe1\xb5\\HL\x10\xe7\x02\x8a\x1e5\x9d");
  guy waittillmatch(animflag, "8\xdb\x90");
  guy notify("|\xf9Sv\x06#)d\xbe\xa5\xa8';&]\xf9x\xb6");
  changetime = 0.3;
  guy clearanim(self.scriptedtalkingknob, 0.2);
  utility::disabledefaultfacialanims(0);
}

function anim_set_rate_single(guy, anime, rate) {
  guy thread anim_set_rate_internal(anime, rate);
}

function anim_set_rate(guys, anime, rate) {
  utility::array_thread(guys, &anim_set_rate_internal, anime, rate);
}

function anim_set_rate_internal(anime, rate, animname_override) {
  animname = undefined;

  if(isDefined(animname_override)) {
    animname = animname_override;
  } else {
    animname = self.animname;
  }

  self setflaggedanim("\xb3\\\x97b@19[\x9e\xc1\xd7", utility::getanim_from_animname(anime, animname), 1, 0, rate);
}

function create_anim_scene(animtree, anim_sequence, anim_asset, animname, model) {
  if(!isDefined(animname)) {
    animname = "RF\x9e\xe1\xc4\x1f\xe7";
  } else {
    level.scr_animtree[animname] = animtree;
  }

  scene = spawnStruct();
  scene.animtree = animtree;
  scene.model = model;

  if(isDefined(model)) {
    level.scr_model[animname] = model;
  }

  if(isDefined(anim_asset)) {
    level.scr_anim[animname][anim_sequence] = anim_asset;
  }

  scene.animname = animname;
  scene.anim_sequence = anim_sequence;
  level.current_anim_data_scene = scene;
}

function blended_loop_solo(guy, lookat, anim_array, ender) {
  guy.anim_array = anim_array;
  guy.ender = ender;
  guy.gesture_lookat = lookat;
  guy.animnode = self;
  guy asm_sp::asm_animcustom(&namespace_6ecc19f3ac5deab::blended_loop_anim, &namespace_6ecc19f3ac5deab::blended_loop_cleanup);
}

function blended_anim_solo(guy, lookat, anim_array) {
  while(isDefined(guy.anim_array)) {
    wait 0.05;
  }

  guy.anim_array = anim_array;
  guy.gesture_lookat = lookat;
  guy.animnode = self;
  guy asm_sp::asm_animcustom(&namespace_6ecc19f3ac5deab::blended_anim);
}

function anim_block_in_single(guys, anime, lerp_speed) {
  foreach(guy in guys) {
    thread anim_block_in_internal(guy, anime, lerp_speed);
  }
}

function anim_block_in_solo(guy, anime, lerp_speed) {
  thread anim_block_in_internal(guy, anime, lerp_speed);
}

function anim_block_in_internal(newguy, anime, lerp_speed) {
  newguy endon("\x1e\xfd\xd1\xa2\a");
  newguy endon("\xb5BW;\x9f?Iwq:\xba\a");
  animname = newguy.animname;
  newguy animation::assert_existance_of_anim(anime, animname);

  if(isDefined(level.scr_blockin[animname]) && isDefined(level.scr_blockin[animname][anime])) {
    start = utility::getStruct(level.scr_blockin[animname][anime], "\"\xe4\xaapX\x9d\xbd\xe9\xab\xcc");
  } else {
    return;
  }

  if(!isDefined(lerp_speed)) {
    lerp_speed = 50;
  }

  mover_org = spawn("7l\x9ci\xc1\xa3}\xda\xf6\x19\xca6", newguy.origin);
  mover_org.angles = newguy.angles;
  mover_org setModel("\xec\xbfK|\au\xcd\xc2\x19<");
  og_ignoreall = newguy.ignoreall;
  og_ignoreme = newguy.ignoreme;
  newguy thread anim_block_in_cleanup_internal(mover_org, og_ignoreall, og_ignoreme);
  dist = distance(newguy.origin, start.origin);
  var_cd9373a81c02dc29 = dist / lerp_speed;

  if(isPlayer(newguy)) {
    newguy playerlinktoabsolute(mover_org);
  } else if(isai(newguy)) {
    newguy animcustom(&t_poser);
    newguy linkTo(mover_org, "\xec\xbfK|\au\xcd\xc2\x19<", (0, 0, 0), (0, 0, 0));
    newguy.ignoreall = 1;
  } else {
    newguy linkTo(mover_org, "\xec\xbfK|\au\xcd\xc2\x19<", (0, 0, 0), (0, 0, 0));
    newguy.ignoreall = 1;
  }

  newguy.ignoreme = 1;
  var_cd9373a81c02dc29 = var_cd9373a81c02dc29 == 0 ? 0.05 : var_cd9373a81c02dc29;
  instant_lerp = 0.05;
  mover_org moveTo(start.origin, instant_lerp);
  mover_org rotateTo(start.angles, instant_lerp);

  if(isai(newguy)) {
    if(!isDefined(start.angles)) {
      newguy orientmode("\xfc\x9f\\\x9e\x16\xbc\xbe\xca\xed\x12", start.origin);
    } else {
      newguy orientmode("u\x9fP\x1a\xbe4oa\xd5\xd9", start.angles[1]);
    }
  }

  mover_org waittill("\xd4E\xa7\xc7\x1e\xf9\x87%");
  start utility::script_wait();

  while(isDefined(start.target)) {
    next = utility::getStruct(start.target, "\"\xe4\xaapX\x9d\xbd\xe9\xab\xcc");

    if(isDefined(start.script_speed)) {
      lerp_speed = start.script_speed;
    }

    start utility::script_delay();
    start = next;
    dist = distance(newguy.origin, start.origin);
    var_cd9373a81c02dc29 = dist / lerp_speed;
    mover_org moveTo(start.origin, var_cd9373a81c02dc29);

    if(isDefined(start.angles)) {
      mover_org rotateTo(start.angles, var_cd9373a81c02dc29);

      if(isai(newguy)) {
        newguy orientmode("u\x9fP\x1a\xbe4oa\xd5\xd9", start.angles[1]);
      }
    } else {
      mover_org rotateTo(vectortoangles(next.origin - mover_org.origin), var_cd9373a81c02dc29);

      if(isai(newguy)) {
        newguy orientmode("\xfc\x9f\\\x9e\x16\xbc\xbe\xca\xed\x12", next.origin);
      }
    }

    mover_org waittill("\xd4E\xa7\xc7\x1e\xf9\x87%");
    start utility::script_wait();
  }

  newguy notify("\xf0\xcd\x0e\xe2\x9a]X<\xa1\xf54");
}

function t_poser() {
  self animmode("b\xf21\xbc\xeb{");
  utility::waittill_any("\xf0\xcd\x0e\xe2\x9a]X<\xa1\xf54", "\xb5BW;\x9f?Iwq:\xba\a");
}

function anim_block_in_cleanup_internal(mover_org, og_ignoreall, og_ignoreme) {
  utility::waittill_any("\xf0\xcd\x0e\xe2\x9a]X<\xa1\xf54", "\xb5BW;\x9f?Iwq:\xba\a", "\x1e\xfd\xd1\xa2\a");
  self unlink();

  if(isai(self)) {
    self.ignoreall = og_ignoreall;
  }

  self.ignoreme = og_ignoreme;
  mover_org delete();
}

function should_do_anim() {
  return !isai(self) || !utility::doinglongdeath();
}

function teleport_entity(origin, angles) {
  if(isai(self)) {
    if(isDefined(self.anim_start_at_groundpos)) {
      origin = utility::drop_to_ground(origin);
    }

    self forceteleport(origin, angles, 9999);
    return;
  }

  if(isDefined(self.vehicletype)) {
    self vehicle_teleport(origin, angles);
    self dontinterpolate();
    return;
  }

  self.origin = origin;
  self.angles = angles;
  self dontinterpolate();
}

function play_sound_at_viewheight(aliasname, notification_string, var_f0e999956b095703) {
  if(!soundexists(aliasname)) {
    iprintln("<dev string:x262>" + aliasname);

    if(isstring(notification_string)) {
      waitframe();
      self notify(notification_string);
      self notify("\xcam$[\x8b\xc4 \x1b\x9dm\x8e\x8e \x89\x86");
    }

    return;
  }

  if(isDefined(notification_string) && isDefined(var_f0e999956b095703)) {
    self playsoundatviewheight(aliasname, notification_string, var_f0e999956b095703);
  } else if(isDefined(notification_string)) {
    self playsoundatviewheight(aliasname, notification_string);
  } else {
    self playsoundatviewheight(aliasname);
  }

  if(isDefined(notification_string)) {
    self.scripteddialoguenotify = gettime();
  } else {
    self.scripteddialoguenonotify = gettime();
  }

  thread bcs_scripted_dialog_clear(aliasname, notification_string);
}

function bcs_scripted_dialog_clear(aliasname, notification_string) {
  self endon("\x1e\xfd\xd1\xa2\a");

  if(isDefined(notification_string)) {
    self waittill(notification_string);
    self.scripteddialoguenotify = undefined;
    return;
  }

  length = lookupsoundlength(aliasname) * 0.001;
  wait length;
  self.scripteddialoguenonotify = undefined;
}

function do_facial_anim(dofacialanim, dodialogue, doanimation, anime, animname, dialogue, looping) {
  if(dofacialanim && looping) {
    println("<dev string:x282>");
  }

  if(dofacialanim && !looping) {
    if(dodialogue) {
      thread face::sayspecificdialogue(dialogue);
    }

    assert(!doanimation, "<dev string:x2c2>" + anime);
    thread anim_facialanim(self, anime, level.scr_face[animname][anime]);
    return true;
  } else if(isai(self) || isDefined(self.fakeactor_face_anim) && self.fakeactor_face_anim) {
    if(doanimation) {
      face::sayspecificdialogue(dialogue);
    } else {
      if(!looping) {
        thread anim_facialfiller("\xcam$[\x8b\xc4 \x1b\x9dm\x8e\x8e \x89\x86");
      }

      face::sayspecificdialogue(dialogue, "\xcam$[\x8b\xc4 \x1b\x9dm\x8e\x8e \x89\x86");
    }
  } else {
    thread utility_sp::play_sound_on_entity(dialogue, "\xcam$[\x8b\xc4 \x1b\x9dm\x8e\x8e \x89\x86");
  }

  return false;
}

#using_animtree("[ \xf19\xbc\xb1@]\xebu\xe6#Wcvb+\xf7(u\xdcAq\xad5Y\xed\x8c\x8d");

function do_animation(org, angles, animname, anime, anim_string, idleanim, scripted_node_ent) {
  if(isDefined(level.scr_xcam[anime])) {
    if(isPlayer(self)) {
      assertmsg("<dev string:x34a>");
    }
  }

  animation = undefined;

  if(animation::function_25f089b18d2ffbe7(anime)) {
    animation = animation::function_75a88057a7fff0bb(anime, org, angles, animname);
  } else if(isDefined(idleanim)) {
    animation = level.scr_anim[animname][anime][idleanim];
  } else {
    animation = level.scr_anim[animname][anime];
  }

  goaltime = animation::anim_get_goal_time(animname, anime);
  animation::last_anim_time_check();

  if(!isDefined(idleanim)) {
    self._lastanime = anime;
  }

  if(self.code_classname == "?\x96%o2\x88V\xd4\x98\a\xdc" && !isDefined(idleanim)) {
    self setflaggedanim(anim_string, animation, 1, goaltime);
  } else {
    root = undefined;

    if(isai(self) || fakeactor::is_fakeactor()) {
      root = asm::asm_getbodyknob();
    } else if(isDefined(self.anim_getrootfunc)) {
      root = [[self.anim_getrootfunc]]();
    }

    if(isDefined(self.asm) && !isai(self)) {
      asm_sp::asm_animScripted();
    }

    var_d2e92bcec8174510 = [-90, 90, -60, 60];
    var_be8573f247d1d3f8 = % \x12vD\xd9)(\xca\xdbBy\x8a(b\xdb\xf4\f\xa4\xc3G\x84 < != !\"\xf0Tx;

      if(isDefined(level.scr_lookat[animname]) && isDefined(level.scr_lookat) && isDefined(level.scr_lookat[animname][anime])) {
        if(!isDefined(level.scr_lookat[animname][anime].ranges)) {
          assertmsg("<dev string:x396>" + animname + "<dev string:x3d3>" + anime);
        }

        if(level.scr_lookat[animname][anime].ranges.size != 4) {
          assertmsg("<dev string:x3da>" + animname + "<dev string:x3d3>" + anime);
        }

        if(!isDefined(level.scr_lookat[animname][anime].atr_node)) {
          assertmsg("<dev string:x430>" + animname + "<dev string:x3d3>" + anime);
        }

        var_d2e92bcec8174510 = level.scr_lookat[animname][anime].ranges;
        var_be8573f247d1d3f8 = level.scr_lookat[animname][anime].atr_node;
      }

      self animScripted(anim_string, org, angles, animation, undefined, root, goaltime, 1, var_d2e92bcec8174510[0], var_d2e92bcec8174510[1], var_d2e92bcec8174510[2], var_d2e92bcec8174510[3], var_be8573f247d1d3f8, scripted_node_ent);
    }

    thread notetrack::start_notetrack_wait(self, anim_string, anime, animname, animation); thread animscriptdonotetracksthread(self, anim_string, anime);
    return getanimlength(animation);
  }

  function animscriptdonotetracksthread(guy, animstring, anime) {
    if(isDefined(guy.dontdonotetracks) && guy.dontdonotetracks) {
      return;
    }

    guy endon("\xfe\x8eC\x0f\xfe-c\x8e\xb2\xaa\x89\xaf[Q\xe1\xf9W\x14r\xe3(\x0eV\xf7_\xf7");
    guy endon("\x1e\xfd\xd1\xa2\a");
    guy notetracks::donotetracks(animstring);
  }

  function ai_anim_first_frame(animation, animname) {
    self._first_frame_anim = animation;
    self._animname = animname;
    asm_sp::asm_animcustom(&first_frame::main);
  }

  function anim_react_new(guys, node, anime) {
    data = spawnStruct();

    if(!isarray(guys)) {
      guys = [guys];
    }

    data.guys = guys;
    data.node = node;
    data.anime = anime;
    return data;
  }

  function anim_react(guys, anime, reactfunc, gotocombatonly) {
    data = anim_react_new(guys, self, anime);
    data.fnreact = reactfunc;
    data.gotocombatonly = gotocombatonly;
    anim_react_data(data);
  }

  function anim_react_data(data) {
    utility::array_thread(data.guys, &anim_react_thread, data);
    anime = data.anime;

    foreach(guy in data.guys) {
      death_anime = anime + "\xb8\xe1\x94\x04\xc9v";

      if(isDefined(level.scr_anim[guy.animname][death_anime])) {
        guy ai::set_deathanim(death_anime);
      }

      if(isDefined(guy.animents)) {
        foreach(animent in guy.animents) {
          if(isDefined(level.scr_anim[animent.animname][death_anime])) {
            animent.deathanime = death_anime;
          }
        }
      }

      level thread anim_react_death(data.node, guy, data.fnreact);
    }

    intro_anime = anime + "DA\xaf%8\xc9";

    if(isDefined(level.scr_anim[data.guys[0].animname][intro_anime])) {
      data.node anim_single_with_props(data.guys, intro_anime);
    }

    loop_anime = anime + "\x9e\x14c\xab\x9d";
    outro_anime = anime + "\a\x9d\xb7\xc5\xec\xd1";

    foreach(guy in data.guys) {
      if(!isalive(guy)) {
        continue;
      }

      if(guy utility::ent_flag(".\x1cq\xfa\xd2\x8a\x8a\xb7\xdc\v\x18\x94")) {
        continue;
      }

      if(isDefined(level.scr_anim[guy.animname][loop_anime])) {
        data.node thread anim_loop_with_props(guy, loop_anime, "7z\x18\xe8H1\xcd00\x85]\x89\x95 \x13" + guy.animname);
        continue;
      }

      if(isDefined(level.scr_anim[guy.animname][outro_anime])) {
        data.node thread anim_single_with_props(guy, outro_anime);
        guy thread utility::waittillmatch_notify("\xb3\\\x97b@19[\x9e\xc1\xd7", "8\xdb\x90", "\xc7\xf8\xa0\xba:;\xa3mc\xbb:.\xe2\xb0");
        guy utility::thread_on_notify("\xc7\xf8\xa0\xba:;\xa3mc\xbb:.\xe2\xb0", &utility::send_notify, "\x9fP0\"H\x870*S\xc2n&!!\x8f", undefined, undefined, guy, ",\xdcZm\xeb\x93e\x85l\x1d");
        continue;
      }

      guy notify("\x9fP0\"H\x870*S\xc2n&!!\x8f");
      guy notify("\xaa\x8dY\xf5k\x9e\xce\x85\x89WWn\xfcSM\x9cA%Rv\xcc");
    }
  }

  function anim_react_thread(data) {
    self endon("\x1e\xfd\xd1\xa2\a");
    self notify("\x9fP0\"H\x870*S\xc2n&!!\x8f");
    self endon("\x9fP0\"H\x870*S\xc2n&!!\x8f");
    type = anim_react_wait_thread();
    anim_react_alertgroup_msg("y\xf1G(\xf4kE", type);
    self notify(",\xdcZm\xeb\x93e\x85l\x1d");
    data.node notify(",\xdcZm\xeb\x93e\x85l\x1d");

    if(!istrue(self.anim_react_skip_stopanimscripted)) {
      data.node notify("7z\x18\xe8H1\xcd00\x85]\x89\x95 \x13" + self.animname);
      utility_sp::anim_stopanimScripted();
    }

    skipreaction = 0;

    if(isDefined(data.fnreact)) {
      result = self[[data.fnreact]](type);

      if(isDefined(result)) {
        if(result == "`\x81\x1dp\x94u\xd7m\x80\x82\xa7\x94\xd9") {
          skipreaction = 1;
        } else {
          type = result;
        }
      }
    }

    if(!skipreaction) {
      react_type = get_react_type(type);
      anime = data.anime;
      reactanime = undefined;

      if(isDefined(data.fnreactanime)) {
        reactanime = [[data.fnreactanime]](type);
      }

      function_859ff067fa720c91("<dev string:x46d>" + react_type);

      if(type == "\x80\xb5\xc7J") {
        reactanime = anime + "\xbc\x8e\\}u\x14V\t\x8fLn";

        if(isDefined(level.scr_anim[self.animname][reactanime])) {
          self.allowdeath = 1;

          if(!isDefined(self.animreactrelative)) {
            data.node anim_single_with_props(self, reactanime);
          } else {
            anim_single_with_props(self, reactanime);
          }
        } else if(isDefined(self.script_stealthgroup)) {
          enemy::bt_set_stealth_state("\xe3\xd0\xc3e\x85h");
        }
      } else {
        level thread detach_linkedaniments(self);

        if(!isDefined(reactanime)) {
          reactanime = anime + "c\xc9\xd48\x88\xe4\xd5" + react_type;
        }

        if(!isDefined(level.scr_anim[self.animname][reactanime])) {
          reactanime = anime + ".>\a\"\td";
        }

        if(isDefined(level.scr_anim[self.animname][reactanime])) {
          self.allowdeath = 1;

          if(!isDefined(self.animreactrelative)) {
            data.node anim_single_with_props(self, reactanime);
          } else {
            anim_single_with_props(self, reactanime);
          }
        }

        var_ab782baa5893b2a3 = reactanime + "\x9e\x14c\xab\x9d";

        if(isDefined(level.scr_anim[self.animname][var_ab782baa5893b2a3])) {
          if(!isDefined(self.animreactrelative)) {
            data.node anim_loop_with_props(self, var_ab782baa5893b2a3);
          } else {
            anim_loop_with_props(self, var_ab782baa5893b2a3);
          }
        }

        if(isDefined(self.script_stealthgroup) && istrue(data.gotocombatonly)) {
          enemy::bt_set_stealth_state("\xe3\xd0\xc3e\x85h");
        }
      }
    } else {
      function_859ff067fa720c91("<dev string:x48c>");
    }

    self notify("v{&m^r\xb7`P\xd3\xc6uN\x02\xb5");

    if(isDefined(self.target)) {
      spawner::go_to_node();
    }

    if(!isDefined(self.script_forcegoal)) {
      self.goalradius = level.default_goalradius;
    }
  }

  function get_react_type(type) {
    switch (type) {
      case #"hash_b330931dd2da97d1":
        return "4\xa9\xc7";
      default:
        return ":\xbfa^";
    }
  }

  function anim_react_wait_thread() {
    self endon("\x1e\xfd\xd1\xa2\a");
    self endon("\x9fP0\"H\x870*S\xc2n&!!\x8f");

    if(!utility::ent_flag_exist(".\x1cq\xfa\xd2\x8a\x8a\xb7\xdc\v\x18\x94")) {
      utility::ent_flag_init(".\x1cq\xfa\xd2\x8a\x8a\xb7\xdc\v\x18\x94");
    }

    utility::ent_flag_clear(".\x1cq\xfa\xd2\x8a\x8a\xb7\xdc\v\x18\x94");
    childthread anim_react_damage();
    childthread anim_react_waittill("\xfe\xde\x92Xt");
    childthread anim_react_waittill("\xab\xe9\b\x93\x8f\xab\xcdgF`\xaf!\xa2");
    childthread anim_react_waittill("H[\x90\x80SZ\x80%\x95");
    childthread anim_react_waittill("\x15C\xf9\x0e\xb6\xb7&\x14\x03\xb0\x0f");
    childthread anim_react_waittill("\bv\x1foU0\xa9\xb2V\xddM\xc9:8");
    childthread anim_react_waittill("\x83Atz\x01\xcbDu\xb7\xf21%V");
    childthread anim_react_ai_events();
    childthread anim_react_radius();
    self waittill("\x12\x1b\xab8!4\xc6P\x13\v\x11KSL\x1f\x86I", type, event);

    if(isDefined(event)) {
      self.anim_react_event = event;
    }

    utility::ent_flag_set(".\x1cq\xfa\xd2\x8a\x8a\xb7\xdc\v\x18\x94");

    function_859ff067fa720c91("<dev string:x4b5>" + type);

    if(type == "\x15C\xf9\x0e\xb6\xb7&\x14\x03\xb0\x0f" || type == "\x83Atz\x01\xcbDu\xb7\xf21%V") {
      wait randomfloatrange(0.2, 0.4);
    }

    return type;
  }

  function anim_react_damage() {
    self waittill("\fU`\xc0y\x95", dmg, attacker, dir, point, meansofdamage, model, tag, part, idflag, objweapon);

    if(meansofdamage != "9\xe6R?Wcx5\xf2F%Q3W\x06z\xfe\a" && isDefined(objweapon) && objweapon.basename != "\xef\xd8\x94\x8d\xba") {
      self notify("\x12\x1b\xab8!4\xc6P\x13\v\x11KSL\x1f\x86I", "\x80\xb5\xc7J");
    }
  }

  function anim_react_waittill(msg) {
    self waittill(msg, extra);
    self notify("\x12\x1b\xab8!4\xc6P\x13\v\x11KSL\x1f\x86I", msg, extra);
  }

  function anim_react_radius() {
    self endon(".\x1cq\xfa\xd2\x8a\x8a\xb7\xdc\v\x18\x94");

    if(!isDefined(self.radius)) {
      self.radius = 72;
    }

    trigger = undefined;

    if(isDefined(self.target)) {
      ent = getEnt(self.target, #targetname);

      if(isDefined(ent)) {
        if(ent.code_classname == "E\x03\xae\xad\x7f\xcc\xa9\x17\xda\xb0K\xa4s\xeb\xfb\xf7") {
          trigger = ent;
        }
      }
    }

    while(true) {
      waitframe();

      if(distancesquared(level.player.origin, self.origin) < squared(self.radius)) {
        break;
      }

      if(!isDefined(trigger)) {
        continue;
      }

      if(level.player istouching(trigger)) {
        break;
      }
    }

    self notify("H[\x90\x80SZ\x80%\x95");
  }

  function force_high_reaction() {
    self aieventlistenerevent("\x8e\x86U\b\xe9s\xa7\xb1\x87\x99\xb9", self, self.origin);
  }

  function force_low_reaction() {
    self aieventlistenerevent("\xc2\x99.K\xdd\x9fBw>]\x8e", self, self.origin);
  }

  function anim_react_ai_events() {
    self endon("\x1e\xfd\xd1\xa2\a");
    self endon(".\x1cq\xfa\xd2\x8a\x8a\xb7\xdc\v\x18\x94");

    while(true) {
      level waittill("\xdc\xe8+,\x8d\xa3\x1a_\xb2\xece\xdc:", event, receiver);

      if(receiver != self) {
        continue;
      }

      thread function_6468b33e707765c2([event]);

      switch (event.type) {
        case #"hash_f796130a9b9cec5":
        case #"hash_9e02cd4a0f3ca981":
          self notify("\x12\x1b\xab8!4\xc6P\x13\v\x11KSL\x1f\x86I", "\xef\x19\x1ev\xacNb\x14Zh\xe7\xf7\xb0", event);
          return;
        case #"hash_e21b072df2b47f94":
          self notify("\x12\x1b\xab8!4\xc6P\x13\v\x11KSL\x1f\x86I", "}\x18P\xdf\xb5\x87\xbf\x9a\xbf=\xd1\xb7", event);
          return;
      }
    }
  }

  function function_6468b33e707765c2(eventarray) {
    prefix = "<dev string:x4cd>";
    types = "<dev string:x4db>";

    for(i = 0; i < eventarray.size; i++) {
      if(i < eventarray.size - 1) {
        types += "<dev string:x7e>" + eventarray[i].type + "<dev string:x4df>";
      } else {
        types += "<dev string:x7e>" + eventarray[i].type;
      }

      function_859ff067fa720c91("<dev string:x4e4>" + eventarray[i].type);
    }

    if(getdvarint(@ "hash_f2e0c1a7174051b7") > 0) {
      msg = prefix + types;
      thread debug::function_7d08b29d5c99f310(msg, (0, 0, 60));
    }
  }

  function function_859ff067fa720c91(msg) {
    if(getdvarint(@ "hash_359daba9e2592b36") > 0) {
      println(self getentitynumber() + "<dev string:x4f3>" + msg);
    }
  }

  function anim_react_alertgroup_msg(suffix, type) {
    if(!isDefined(self.alertgroupnames)) {
      return;
    }

    event = undefined;

    if(isDefined(self.anim_react_event)) {
      event = self.anim_react_event;
    }

    if(type == "\x80\xb5\xc7J") {
      suffix = "\xdcV\xf0\x879(";
    } else if(type == "\x1e\xfd\xd1\xa2\a") {
      suffix = "\xce\xb6\xfe\xf8";
    }

    foreach(groupname in self.alertgroupnames) {
      level.alertgroup[groupname] = utility::array_removeundefined(level.alertgroup[groupname]);

      foreach(ai in level.alertgroup[groupname]) {
        ai notify("d\rI\x05\xd3/\xd0" + suffix, event);
      }
    }
  }

  function anim_react_add_to_alertgroup(groupname) {
    if(!isDefined(level.alertgroup)) {
      level.alertgroup = [];
    }

    if(!isDefined(level.alertgroup[groupname])) {
      level.alertgroup[groupname] = [];
    }

    level.alertgroup[groupname][level.alertgroup[groupname].size] = self;

    if(!isDefined(self.alertgroupnames)) {
      self.alertgroupnames = [];
    }

    self.alertgroupnames[self.alertgroupnames.size] = groupname;
  }

  function add_animents(array, anime) {
    newarray = array;

    foreach(ent in array) {
      if(!isDefined(ent.animents)) {
        continue;
      }

      foreach(animent in ent.animents) {
        if(!isDefined(level.scr_anim[animent.animname])) {
          continue;
        }

        if(!isDefined(level.scr_anim[animent.animname][anime])) {
          continue;
        }

        newarray[newarray.size] = animent;
      }
    }

    return newarray;
  }

  function anim_single_with_props(ents, anime, tag, var_36e7c8da58046eb7, animname_override) {
    if(!isarray(ents)) {
      ents = [ents];
    }

    ents = add_animents(ents, anime);
    animation::anim_single(ents, anime, tag, var_36e7c8da58046eb7, animname_override);
  }

  function anim_loop_with_props(ents, anime, ender, tag, var_ddc747038998657, animname_override) {
    if(!isarray(ents)) {
      ents = [ents];
    }

    ents = add_animents(ents, anime);
    animation::anim_loop(ents, anime, ender, tag, var_ddc747038998657, animname_override);
  }

  function anim_react_death(node, guy, reactfunc) {
    guy endon("\xd3\xad\x11\xca%\xf7@\xabk_L\xff\x19");
    guy endon("v{&m^r\xb7`P\xd3\xc6uN\x02\xb5");
    guy endon("\xaa\x8dY\xf5k\x9e\xce\x85\x89WWn\xfcSM\x9cA%Rv\xcc");
    guy waittill("\x1e\xfd\xd1\xa2\a");

    guy function_859ff067fa720c91("<dev string:x4f9>");

    if(isDefined(reactfunc)) {
      guy thread[[reactfunc]]("\x1e\xfd\xd1\xa2\a");
    }

    if(isDefined(guy.animents)) {
      foreach(ent in guy.animents) {
        ent thread prop_deathanim(node);
      }
    }

    level thread detach_linkedaniments(guy);
  }

  function prop_deathanim(node) {
    self endon("\x1e\xfd\xd1\xa2\a");

    if(!isDefined(self.deathanime)) {
      return;
    }

    if(!isDefined(level.scr_anim[self.animname][self.deathanime])) {
      return;
    }

    node animation::anim_single_solo(self, self.deathanime);
  }

  function detach_linkedaniments(guy) {
    if(!isDefined(guy.linkedaniments)) {
      return;
    }

    foreach(ent in guy.linkedaniments) {
      ent thread detach_linkedaniment(guy);
    }

    guy.linkedaniments = undefined;
  }

  function detach_linkedaniment(guy) {
    prevpos = guy gettagorigin(self.parenttag);
    waitframe();

    if(!isDefined(guy)) {
      newpos = prevpos + (0, 0, 10);
    } else {
      newpos = guy gettagorigin(self.parenttag);
    }

    forward = vectorNormalize(newpos - prevpos);
    velocity = forward * randomfloatrange(1, 2);
    self unlink();

    if(isDefined(self.nophysics)) {
      pos = utility::drop_to_ground(self.origin, 16, -500);
      dist = distance(pos, self.origin);
      time = dist / 120;
      time = max(time, 0.05);
      self moveTo(pos, time, 0, time - 0.05);
      return;
    }

    if(isDefined(self.children)) {
      foreach(child in self.children) {
        child unlink();
        upvelocity = (0, 0, 1) * randomfloatrange(25, 60) + velocity;
        child physicslaunchclient(child.origin + (0, 0, 1), upvelocity);
      }
    }

    if(isDefined(self.overridevelocity)) {
      velocity = self.overridevelocity;
    }

    self physicslaunchclient(newpos, velocity);
  }

  function primaryweapon_leave_behind(tagname, suspend) {
    origin = self gettagorigin(tagname);
    angles = self gettagangles(tagname);
    primaryweapon_leave_behind_internal(origin, angles, suspend);
  }

  function primaryweapon_leave_behind_internal(origin, angles, spawnflags) {
    if(isDefined(self.gun_on_ground)) {
      return;
    }

    if(!isDefined(spawnflags)) {
      spawnflags = 0;
    }

    gun = spawn("r\x15U\xae\x95\xae\xc3" + getcompleteweaponname(self.weapon), origin, spawnflags);
    gun.angles = angles;
    self.gun_on_ground = gun;
    shared::placeweaponon(self.weapon, "\r+x5");
    self.dropweapon = 0;
  }

  #using_animtree("K_p\x84a\x01");

  function function_6f858ddd0be86775(animname) {
    if(isDefined(level.scr_animtree[animname]) && level.scr_animtree[animname] == #animtree) {
      return true;
    }

    return false;
  }

  function function_82ecf17b8bd03eff(rootorigin, rootangles, xanim, tags, ignoreentities, collision_radius = 5, content_override = undefined, var_6a65c1941177b623 = "\x9c\xad\xad6p\xa2\xb3\xe3&\xafu\x93j") {
    body_model = self;
    assert(isDefined(rootorigin));
    assert(isDefined(rootangles));
    assert(isDefined(xanim));
    assert(isDefined(tags) && tags.size > 0);

    setdvarifuninitialized(@ "hash_d8e70b2a85adf339", 0);

    debuglevel = getdvarint(@ "hash_d8e70b2a85adf339", 0);

    var_9ce2b6b45f4f2af2 = 1;
    startragdollnotetracks = getnotetracktimes(xanim, var_6a65c1941177b623);

    if(startragdollnotetracks.size > 0) {
      var_9ce2b6b45f4f2af2 = startragdollnotetracks[0];
    }

    foreach(bonetag in tags) {
      start_origin = body_model gettagorigin(bonetag);
      result_end = body_model animation::function_3cf2092e487b2640(xanim, bonetag, var_9ce2b6b45f4f2af2, rootorigin, rootangles);

      if(!(isDefined(start_origin) && isDefined(result_end))) {
        return false;
      }

      trace = trace::sphere_trace(start_origin, result_end["\xb0$R\x8b\xc9\x17"], collision_radius, ignoreentities, content_override);

      if(trace["\xda\x16\x81\aw}^i"] < 1) {
        if(istrue(debuglevel)) {
          trace::draw_trace(trace, (1, 0, 0), debuglevel > 1, 500);
          iprintln("<dev string:x502>" + trace["<dev string:x51e>"]);
        }

        body_model startragdoll();
        return false;
      }

      if(trace["<dev string:x51e>"] >= 1 && istrue(debuglevel)) {
        trace::draw_trace(trace, (1, 1, 1), debuglevel > 1, 500);
      }
    }

    if(istrue(debuglevel)) {
      iprintln("<dev string:x52a>");
    }

    return true;
  }