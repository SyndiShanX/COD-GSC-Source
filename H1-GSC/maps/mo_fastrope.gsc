/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\mo_fastrope.gsc
********************************/

main() {
  level.fastrope_globals = spawnstruct();
  level.fastrope_globals.helicopters = [];
  level.fastrope_globals.animload = [];
  level.fastrope_globals.animload["blackhawk"] = 0;
  level.fastrope_globals.heli_inflight = 0;
  level.fastrope_globals.basename = "fastrope_vehicle";
  var_0 = getspawnerarray();
  fastrope_precache();
  common_scripts\utility::array_thread(var_0, ::fastrope_setup);
}

fastrope_override(var_0, var_1, var_2, var_3) {
  var_4 = fastrope_animname(self.type, var_0);
  level.scr_anim[var_4]["custom_all" + self.targetname] = var_1;
  level.scr_anim[var_4]["custom_ride" + self.targetname] = var_2;
  level.scr_anim[var_4]["custom_unload" + self.targetname] = var_3;
  maps\_anim::addnotetrack_customfunction(var_4, "start", ::play_fastrope_start_sfx, "custom_unload" + self.targetname);
  maps\_anim::addnotetrack_customfunction(var_4, "fastrope_end_sfx", ::play_fastrope_end_sfx, "custom_unload" + self.targetname);
  maps\_anim::addnotetrack_customfunction(var_4, "custom_land", ::play_fastrope_land_sfx, "custom_unload" + self.targetname);
}

fastrope_override_vehicle(var_0, var_1) {
  level.scr_anim[self.animname]["pathanim"] = var_0;
  self.pathnode = var_1;
}

play_fastrope_start_sfx(var_0) {
  var_0 thread maps\_utility::play_sound_on_entity("fastrope_start_npc");
  var_0 thread common_scripts\utility::play_loop_sound_on_entity("fastrope_loop_npc");
}

play_fastrope_end_sfx(var_0) {
  var_0 notify("stop soundfastrope_loop_npc");
  var_0 thread maps\_utility::play_sound_on_entity("fastrope_end_npc");
}

play_fastrope_land_sfx(var_0) {
  var_0 thread maps\_utility::play_sound_on_entity("step_land_hv_concrete_wet");
}

fastrope_spawner_think() {
  self endon("death");

  if(isdefined(self.script_parameters)) {
    var_0 = strtok(self.script_parameters, ":;, ");

    for (var_1 = 0; var_1 < var_0.size; var_1++) {
      if(tolower(var_0[var_1]) == "fastrope_seat") {
        var_1++;
        self.fastrope_seat = int(var_0[var_1]);
      }

      if(tolower(var_0[var_1]) == "nounload")
        self.nounload = 1;
    }
  }

  for (;;) {
    self waittill("spawned", var_2);

    if(maps\_utility::spawn_failed(var_2)) {
      continue;
    }
    var_2.spawner = self;
    var_2 thread fastrope_ai_think(self);
  }
}

fastrope_ai_think_hack(var_0, var_1) {
  if(!isdefined(var_1))
    var_1 = 0.2;

  wait(var_0 - var_1);
  self stopanimscripted();
  self notify("single_anim_done");
}

fastrope_ai_think(var_0) {
  self endon("death");
  self endon("overtakenow");
  var_1 = spawn("script_origin", self.origin);
  var_1.angles = self.angles;
  self linkto(var_1);
  var_1.ai = self;
  var_1.ai hide();
  var_0 fastrope_wait_que(var_1);

  if(isdefined(var_0.nounload) && var_0.nounload == 1) {
    if(var_1.ai.seat_pos < 9) {
      var_0 fastrope_post_unload(var_1);
      var_0.heli waittill("unload_rest");
      var_0.heli.que[var_0.heli.que.size] = var_0;
    } else {
      var_0 fastrope_post_unload(var_1);

      if(var_1.ai.seat_pos == 10) {
        common_scripts\utility::flag_wait("heli_shoot_deck_windows");
        self.spawner.heli.model notify("stop_" + var_1.ai.seat_index);
        self.spawner.heli.model thread maps\_anim::anim_loop_solo(self, "minigun", "tag_detach");
      }

      var_0.heli.vehicle waittill("reached_end_node");
      var_1 delete();
      self delete();
      return;
    }
  }

  var_0.heli notify("unload_" + var_1.ai.side);
  var_0 fastrope_pre_unload(var_1);
  var_2 = "custom_unload" + var_0.heli.targetname;
  var_3 = "custom_all" + var_0.heli.targetname;

  if(isdefined(level.scr_anim[var_1.ai.animname][var_3])) {
    self waittillmatch("single anim", "start");
    thread maps\_utility::play_sound_on_entity("fastrope_start_npc");
    var_1 thread common_scripts\utility::play_loop_sound_on_entity("fastrope_loop_npc");
    fastrope_calc(var_1);
    var_0 thread fastrope_post_unload(var_1);
    self waittillmatch("single_anim_done");
    var_1 notify("stop soundfastrope_loop_npc");
    thread maps\_utility::play_sound_on_entity("fastrope_end_npc");
    self unlink();
  } else if(isdefined(level.scr_anim[var_1.ai.animname][var_2])) {
    thread fastrope_ai_think_hack(getanimlength(level.scr_anim[var_1.ai.animname][var_2]));
    var_0.heli.model thread maps\_anim::anim_single_solo(self, var_2, "tag_detach");
    self waittillmatch("single anim", "start");
    fastrope_calc(var_1);
    var_0 thread fastrope_post_unload(var_1);
    self waittillmatch("single_anim_done");
    self unlink();
  } else {
    var_4 = 45 * var_1.ai.index + 90;
    var_5 = 360 * var_1.ai.spin;

    if(var_1.ai.side == "right")
      var_4 = var_4 + 180;

    self unlink();
    var_1.origin = self.origin;
    var_1.angles = self.angles;
    var_1 linkto(self);
    var_0.heli thread fastrope_ropethink(self);
    var_0.heli.model thread maps\_anim::anim_single_solo(self, "grab", "tag_detach");
    wait 2.5;
    fastrope_calc(var_1);
    self waittillmatch("single anim", "end");
    var_1 unlink();
    self linkto(var_1);
    fastrope_calc(var_1);
    var_0 thread fastrope_post_unload(var_1);
    var_1 thread maps\_anim::anim_loop_solo(self, "loop", undefined, "stopanimscripted");
    thread maps\_utility::play_sound_on_entity("fastrope_start_npc");
    var_1 thread common_scripts\utility::play_loop_sound_on_entity("fastrope_loop_npc");
    var_1 movez(var_1.range * -1, var_1.time);
    var_6 = var_4 - var_5;
    var_1 rotateyaw(var_6, var_1.time);
    wait(var_1.time);
    var_1 notify("stopanimscripted");
    var_1.angles = self.angles;
    var_1 maps\_anim::anim_single_solo(self, "land");
    var_1 notify("stop soundfastrope_loop_npc");
    thread maps\_utility::play_sound_on_entity("fastrope_end_npc");
    self unlink();
  }

  var_1 delete();
  wait 3;
  self pushplayer(0);
}

fastrope_wait_que(var_0) {
  var_0.ai endon("death");
  fastrope_waiton_helicopter(var_0);

  if(isdefined(level.scr_anim[var_0.ai.animname]["custom_unload" + self.heli.targetname])) {
    return;
  }
  if(isdefined(level.scr_anim[var_0.ai.animname]["custom_all" + self.heli.targetname])) {
    return;
  }
  if(var_0.ai.side == "left")
    wait 0.5;
}

#using_animtree("generic_human");

fastrope_ropethink(var_0) {
  var_1 = var_0.side;
  var_2 = "ropeidle" + var_1;
  var_3 = "ropeall" + var_1;

  if(!isdefined(level.scr_anim[self.targetname])) {
    return;
  }
  if(!(isdefined(level.scr_anim[self.targetname][var_2]) || isdefined(level.scr_anim[self.targetname][var_3]))) {
    return;
  }
  if(isdefined(self.rope_dropped[var_1]) && self.rope_dropped[var_1] == 1) {
    return;
  }
  self.rope_dropped[var_1] = 1;
  var_4 = undefined;

  switch (self.type) {
    case "blackhawk":
      switch (var_1) {
        case "left":
          var_4 = "TAG_FastRope_LE";
          break;
        case "right":
          var_4 = "TAG_FastRope_RI";
          break;
      }

      break;
  }

  var_5 = spawn("script_model", self.model gettagorigin(var_4));
  var_5.angles = self.model gettagangles(var_4);
  var_5 setmodel(level.models["heli"]["rope"][var_1]);
  var_5.animname = self.animname;
  var_5 useanimtree(#animtree);
  var_5 linkto(self.model, var_4);

  if(isdefined(level.scr_anim[self.targetname][var_3])) {
    var_6 = getanimlength(level.scr_anim[self.targetname][var_3]);
    self.model thread maps\_anim::anim_single_solo(var_5, var_3, var_4);
    wait(var_6 - 1.5);
  } else {
    self.model thread maps\_anim::anim_loop_solo(var_5, var_2, var_4, "stop_" + var_2);
    self waittill("unload_" + var_1);
    self.model notify("stop_" + var_2);
    var_2 = "ropedrop" + var_1;
    self.model thread maps\_anim::anim_single_solo(var_5, var_2, var_4);

    while (self.que.size)
      self waittill("check_fastrope_que");

    wait(self.lasttime);
  }

  var_5 unlink();
  self waittill("returnflight");
  self.rope_dropped[var_1] = 0;
}

fastrope_pre_unload(var_0) {
  fastrope_free_seat(var_0);
}

fastrope_post_unload(var_0) {
  self.heli.lasttime = var_0.time;
  wait 0.1;
  self.heli.que = common_scripts\utility::array_remove(self.heli.que, self);
  self.heli thread fastrope_que_check();
}

fastrope_que_check() {
  wait(self.unloadwait);
  self notify("check_fastrope_que");
}

fastrope_waiton_helicopter(var_0) {
  var_0.ai endon("death");
  thread fastrope_attach_helicopter(var_0);

  if(!self.heli.inflight)
    self.heli thread fastrope_heli_fly();

  self.heli endon("overtakenow");

  if(!self.heli.ready)
    self.heli waittill("ready");
}

fastrope_attach_helicopter(var_0) {
  var_0.ai endon("death");
  var_0.ai endon("overtakenow");

  for (;;) {
    if(!self.heli.inflight)
      self.heli waittill("inflight");

    fastrope_find_seat(var_0.ai);

    if(!isdefined(var_0.ai.seat_index)) {
      self.heli waittill("seat_open");
      continue;
    } else
      break;
  }

  self.heli.model endon("death");
  var_1 = var_0.ai.seat_index;
  var_0.ai.animname = self.heli.seats[var_1].animname;
  var_0.ai.index = self.heli.seats[var_1].index;
  var_0.ai.side = self.heli.seats[var_1].side;
  var_0.ai.spin = self.heli.seats[var_1].spin;
  self.heli.que[self.heli.que.size] = self;
  var_0 moveto(self.heli.model gettagorigin("tag_detach"), 0.05);
  wait 0.1;
  var_0.angles = self.heli.model gettagangles("tag_detach");
  var_0 linkto(self.heli.model, "tag_detach");
  var_0.ai show();
  var_0.ai linkto(self.heli.model, "tag_detach");
  self.heli thread fastrope_ropethink(var_0.ai);
  self.heli.model endon("stop_" + var_1);

  if(isdefined(level.scr_anim[var_0.ai.animname]["custom_all" + self.heli.targetname])) {
    var_0.ai linkto(self.heli.model, "tag_detach");
    var_0.ai pushplayer(1);
    var_0 linkto(var_0.ai);
    self.heli.model thread maps\_anim::anim_single_solo(var_0.ai, "custom_all" + self.heli.targetname, "tag_detach");
    var_0 notify("custom_all");
    var_0.ai thread fastrope_ai_think_hack(getanimlength(level.scr_anim[var_0.ai.animname]["custom_all" + self.heli.targetname]), 0.25);
    return;
  }

  if(isdefined(level.scr_anim[var_0.ai.animname]["custom_ride" + self.heli.targetname])) {
    var_0.ai linkto(self.heli.model, "tag_detach");
    var_0.ai pushplayer(1);
    var_0 linkto(var_0.ai);
    self.heli.model maps\_anim::anim_single_solo(var_0.ai, "custom_ride" + self.heli.targetname, "tag_detach");

    if(self.heli.ready)
      return;
  }

  self.heli.model thread maps\_anim::anim_loop_solo(var_0.ai, "idle", "tag_detach", "stop_" + var_1);
}

fastrope_free_seat(var_0) {
  if(!isdefined(level.scr_anim[var_0.ai.animname]["custom_all" + self.heli.targetname])) {
    self.heli.model notify("stop_" + var_0.ai.seat_index);
    var_0.ai stopanimscripted();
    var_0.origin = var_0.ai.origin;
    var_0.angles = var_0.ai.angles;
  }

  self.heli.seats[var_0.ai.seat_index].taken = undefined;
  self.heli notify("seat_open");
}

fastrope_find_seat(var_0) {
  var_0.seat_index = undefined;

  if(isdefined(self.fastrope_seat)) {
    for (var_1 = 0; var_1 < self.heli.seats.size; var_1++) {
      if(self.heli.seats[var_1].pos != self.fastrope_seat) {
        continue;
      }
      if(isdefined(self.heli.seats[var_1].taken))
        self.heli.seats[var_1].taken.spawner fastrope_find_seat(self.heli.seats[var_1].taken);

      self.heli.seats[var_1].taken = var_0;
      var_0.seat_index = var_1;
      var_0.seat_pos = self.heli.seats[var_1].pos;
      return;
    }
  }

  for (var_1 = 0; var_1 < self.heli.seats.size; var_1++) {
    if(isdefined(self.heli.seats[var_1].taken)) {
      continue;
    }
    self.heli.seats[var_1].taken = var_0;
    var_0.seat_index = var_1;
    var_0.seat_pos = self.heli.seats[var_1].pos;
    break;
  }
}

fastrope_player_think() {
  maps\mo_tools::playerweapontake();
  var_0 = fastrope_player_attach();
  level.player.cgocamera = var_0;
  self.model thread fastrope_player_quake();
  self endon("overtakenow");
  wait 0.1;
  var_1 = 0;

  for (var_2 = 0; var_2 < self.seats.size; var_2++) {
    if(isdefined(self.seats[var_2].taken)) {
      if(self.seats[var_2].taken != level.player) {
        var_1++;
        continue;
      }

      break;
    }
  }

  self.que = common_scripts\utility::array_insert(self.que, level.player, var_1);
  wait 2;
  level.player setplayerangles((15, 70, 0));
  self.vehicle waittill("reached_wait_node");
  wait 2.5;

  if(getdvar("fastropeunlock") == "")
    setdvar("fastropeunlock", "0");

  if(!isdefined(getdvar("fastropeunlock")))
    setdvar("fastropeunlock", "0");

  fastrope_player_viewshift();
  fastrope_player_unload();
}

play_fast_rope_fx() {
  var_0 = spawn("script_model", level.player.origin);
  var_0 setmodel("tag_origin");
  var_0 linkto(level.player);
  playfxontag(level._effect["rain_drops_fastrope"], var_0, "tag_origin");
  wait 3;
  var_0 delete();
}

fastrope_player_viewshift() {
  var_0 = int(getdvar("fastropeunlock"));

  if(!var_0)
    fastrope_player_viewshift_lock();
  else
    fastrope_player_viewshift_nolock();
}

fastrope_player_unload() {
  var_0 = int(getdvar("fastropeunlock"));

  if(!var_0)
    fastrope_player_unload_lock();
  else
    fastrope_player_unload_nolock();
}

fastrope_player_viewshift_nolock() {
  var_0 = level.player.cgocamera;
  wait 1;
  level.player playerlinktodelta(var_0, "tag_player", 1, 100, 100, 30, 80);
  var_0 waittillmatch("single anim", "end");
}

fastrope_player_unload_nolock() {
  var_0 = level.player.cgocamera;
  var_1 = spawn("script_origin", var_0.origin);
  var_1.angles = var_0.angles;
  var_0 linkto(var_1);
  var_2 = 1;
  var_3 = anglestoforward((0, 233, 0));
  var_3 = maps\_utility::vector_multiply(var_3, 30);
  self.que = common_scripts\utility::array_remove(self.que, level.player);
  thread fastrope_que_check();
  fastrope_calc(level.player);
  level.player.time = level.player.time + 1;
  self.lasttime = level.player.time;
  var_4 = (level.player.range + 100) * -1;
  var_1 moveto((3220, 255, 435), level.player.time);
  var_1 thread maps\_anim::anim_loop_solo(var_0, "loop", undefined, "stopanimscripted");
  var_0 thread maps\_utility::play_sound_on_entity("fastrope_start_plr");
  var_0 thread common_scripts\utility::play_loop_sound_on_entity("fastrope_loop_plr");
  wait(level.player.time);
  var_0 notify("stop soundfastrope_loop_plr");
  var_0 thread maps\_utility::play_sound_on_entity("fastrope_end_plr");
  var_1 notify("stopanimscripted");
  maps\mo_tools::playerweapongive();
  setsaveddvar("compass", 1);
  setsaveddvar("ammoCounterHide", "0");
  setsaveddvar("hud_showStance", 1);
  setsaveddvar("hud_drawhud", "1");
  level.player unlink();
  level.player allowlean(1);
  level.player allowcrouch(1);
  level.player allowprone(1);
  var_1 delete();
  var_0 delete();
}

fastrope_player_viewshift_nolock2() {
  var_0 = level.player.cgocamera;
  wait 1;
  level.player playerlinktodelta(var_0, "tag_player", 1, 100, 100, 30, 80);
  var_0 waittillmatch("single anim", "end");
}

fastrope_player_unload_nolock2() {
  var_0 = level.player.cgocamera;
  var_1 = spawn("script_origin", var_0.origin);
  var_1.angles = var_0.angles;
  var_0 linkto(var_1);
  var_2 = 1;
  var_3 = anglestoforward((0, 233, 0));
  var_3 = maps\_utility::vector_multiply(var_3, 30);
  self.que = common_scripts\utility::array_remove(self.que, level.player);
  thread fastrope_que_check();
  fastrope_calc(level.player);
  level.player.time = level.player.time + 1;
  self.lasttime = level.player.time;
  var_4 = (level.player.range + 100) * -1;
  var_1 moveto((3220, 300, 400), level.player.time);
  var_1 thread maps\_anim::anim_loop_solo(var_0, "loop", undefined, "stopanimscripted");
  var_0 thread maps\_utility::play_sound_on_entity("fastrope_start_plr");
  var_0 thread common_scripts\utility::play_loop_sound_on_entity("fastrope_loop_plr");
  var_5 = 0.5;
  wait(level.player.time - var_5);
  var_1 rotateto((-60, 225, 0), var_5, var_5 * 0.5, var_5 * 0.5);
  wait(var_5);
  var_0 notify("stop soundfastrope_loop_plr");
  var_0 thread maps\_utility::play_sound_on_entity("fastrope_end_plr");
  var_1 notify("stopanimscripted");
  maps\mo_tools::playerweapongive();
  setsaveddvar("compass", 1);
  setsaveddvar("ammoCounterHide", "0");
  setsaveddvar("hud_showStance", 1);
  setsaveddvar("hud_drawhud", "1");
  level.player unlink();
  level.player allowlean(1);
  level.player allowcrouch(1);
  level.player allowprone(1);
  var_1 delete();
  var_0 delete();
}

fastrope_player_viewshift_lock() {
  var_0 = level.player.cgocamera;

  if(isdefined(level.player.ropecamera)) {
    level.player lerpviewangleclamp(1, 0.1, 0.1, 0, 0, 0, 0);
    wait 1;
    level.player playerlinktodelta(level.player.ropecamera, "tag_player", 1, 0, 0, 0, 0, 1);
    wait 0.1;
  } else {
    var_1 = spawn("script_origin", var_0.origin);
    var_1.angles = level.player getplayerangles();
    var_2 = 1;
    var_3 = var_0 gettagangles("tag_player");
    var_1 rotateto(var_3, var_2, var_2 * 0.5, var_2 * 0.5);
    var_4 = int(var_2 * 20);
    var_5 = var_4;
    level.player freezecontrols(1);

    while (var_4) {
      var_4--;
      level.player setplayerangles((var_1.angles[0], var_1.angles[1], level.player getplayerangles()[2]));
      wait 0.05;

      if(var_4 > var_5 * 0.5) {
        continue;
      }
      if(var_4 % 2) {
        continue;
      }
      if(!var_4) {
        break;
      }

      var_3 = var_0 gettagangles("tag_player");
      var_1 rotateto(var_3, var_2 * (var_4 / var_5));
    }

    level.player setplayerangles((var_1.angles[0], var_1.angles[1], level.player getplayerangles()[2]));
    level.player playerlinktodelta(var_0, "tag_player", 1, 15, 15, 5, 5);
    wait 0.1;
    level.player freezecontrols(0);
    var_1 delete();
  }

  var_0 waittillmatch("single anim", "end");
}

fastrope_player_unload_lock() {
  var_0 = level.player.cgocamera;
  var_1 = spawn("script_origin", var_0.origin);
  var_1.angles = var_0.angles;
  var_0 linkto(var_1);
  var_2 = 1;
  var_3 = anglestoforward((0, 233, 0));
  var_3 = maps\_utility::vector_multiply(var_3, -50);
  self.que = common_scripts\utility::array_remove(self.que, level.player);
  thread fastrope_que_check();
  fastrope_calc(level.player);
  level.player.time = level.player.time + 0.5;
  self.lasttime = level.player.time;
  var_4 = (level.player.range + 100) * -1;
  var_5 = var_2 / (level.player.time + 0.5);
  var_6 = var_4 * var_5;
  var_7 = var_1.origin + var_3 + (0, 0, var_6);
  var_1 rotateto((80, 233, 0), var_2, var_2 * 0.5, var_2 * 0.5);
  var_1 moveto(var_7, var_2);
  var_1 thread maps\_anim::anim_loop_solo(var_0, "loop", undefined, "stopanimscripted");
  var_0 thread maps\_utility::play_sound_on_entity("fastrope_start_plr");
  var_0 thread common_scripts\utility::play_loop_sound_on_entity("fastrope_loop_plr");
  thread play_fast_rope_fx();
  wait(var_2);
  var_8 = 0.5;
  var_9 = level.player.time - var_2 + 0.5 - var_8;
  var_6 = var_4 - var_6;
  var_5 = (level.player.time + 0.5) * (var_6 / var_4);
  var_3 = maps\_utility::vector_multiply(var_3, -1);
  var_7 = var_1.origin + var_3 + (0, 0, var_6);
  var_1 moveto(var_7, level.player.time + 0.5 - var_2);
  wait(var_9);
  var_1 rotateto((10, 233, 0), var_8, var_8 * 0.5, var_8 * 0.5);
  wait(var_8 - 0.25);
  var_0 notify("stop soundfastrope_loop_plr");
  var_0 thread maps\_utility::play_sound_on_entity("fastrope_end_plr");
  var_1 moveto((3200, 225, 337), 0.5);
  var_1 notify("stopanimscripted");
  maps\mo_tools::playerweapongive();
  setsaveddvar("compass", 1);
  setsaveddvar("ammoCounterHide", "0");
  setsaveddvar("hud_showStance", 1);
  setsaveddvar("hud_drawhud", "1");
  wait 0.4;
  level.player unlink();
  level.player allowlean(1);
  level.player allowcrouch(1);
  level.player allowprone(1);
  var_1 delete();
  var_0 delete();

  if(isdefined(level.player.ropecamera)) {
    level.player.ropecamera delete();
    level.player.ropecamera = undefined;
  }
}

#using_animtree("fastrope");

fastrope_player_attach() {
  var_0 = spawn("script_model", self.model gettagorigin("tag_detach"));
  var_0 setmodel(level.models["player"]["fastrope"]);
  var_0 linkto(self.model, "tag_detach", (0, 0, 0), (0, 0, 0));
  var_0.animname = fastrope_animname(self.type, "player");
  var_0 useanimtree(#animtree);
  var_0 hide();
  level.player playerlinktodelta(var_0, "tag_player", 1, 100, 100, 30, 60);
  self.model thread maps\_anim::anim_single_solo(var_0, "ride", "tag_detach", self.model);
  level.player allowlean(0);
  level.player allowcrouch(0);
  level.player allowprone(0);

  if(isdefined(level.scr_model["fastrope_intro"])) {
    var_1 = maps\_utility::spawn_anim_model("fastrope_intro");
    var_1 linkto(self.model, "tag_detach");
    self.model thread maps\_anim::anim_single_solo(var_1, "opening", "tag_detach", self.model);
    level.player playerlinktodelta(var_1, "tag_player", 1, 65, 74, 30, 35, 1);
    level.player.ropecamera = var_1;

    if(isdefined(level.scr_gun["fastrope_intro"]))
      var_1 attach(level.scr_gun["fastrope_intro"], "tag_weapon");
  }

  return var_0;
}

fastrope_player_quake() {
  self endon("death");
  self endon("stopquake");

  for (;;) {
    wait 0.1;
    earthquake(0.2, 0.1, self.origin, 256);
  }
}

#using_animtree("vehicles");

fastrope_heli_fly() {
  self.inflight = 1;

  if(self.ready) {
    return;
  }
  if(self.returnflight)
    self waittill("returnflight");

  if(isdefined(self.pathnode)) {
    var_0 = getstartorigin(self.pathnode.origin, self.pathnode.angles, level.scr_anim[self.animname]["pathanim"]);
    var_1 = getstartangles(self.pathnode.origin, self.pathnode.angles, level.scr_anim[self.animname]["pathanim"]);
    self.vehicle = spawn("script_model", var_0);
    self.vehicle.angles = var_1;
  } else if(isdefined(self.startnode))
    self.vehicle = spawnvehicle(self.modelname, self.targetname, self.type, self.startnode.origin, self.startnode.angles);
  else
    return;

  self.vehicle setmodel(self.modelname);
  self.model = self.vehicle;

  if(isdefined(level._sea_org)) {
    self.model = spawn("script_model", self.vehicle.origin);
    self.model setmodel(self.modelname);
    self.model.angles = self.vehicle.angles;
    self.model thread fastrope_heli_fly_sea(self.vehicle);
    self.vehicle hide();
    self.vehicle setcontents(0);
  }

  self.model linkto(self.vehicle, "tag_detach");
  self.model useanimtree(#animtree);
  self.model setanim(level.scr_anim[fastrope_animname(self.type, "heli")]["loop"][0]);
  self.model.vehicletype = self.type;
  self.model thread maps\_vehicle_code::aircraft_wash_thread();
  self notify("inflight");

  if(self.player)
    thread fastrope_player_think();

  self endon("overtakenow");
  wait 0.1;
  level.fastrope_globals.heli_inflight = 1;
  fastrope_heli_waittill_unload();
  self.vehicle notify("reached_wait_node");
  self.inflight = 0;
  level.fastrope_globals.heli_inflight = 0;
  self.returnflight = 1;
  self.ready = 1;
  self notify("ready");
  self.ready = 0;

  while (self.que.size)
    self waittill("check_fastrope_que");

  wait(self.lasttime);
  self.vehicle notify("going_home");

  if(isdefined(self.overtake)) {
    self notify("overtake");
    return;
  }

  if(isdefined(self.pathnode)) {
    self.vehicle waittillmatch("single anim", "end");
    self.vehicle notify("reached_end_node");
  } else {
    self.vehicle resumespeed(10);
    self.vehicle waittill("reached_end_node");
  }

  fastrope_heli_cleanup();
}

fastrope_heli_waittill_unload() {
  if(isdefined(self.pathnode)) {
    self.vehicle endon("fake_wait_node");
    wait 0.1;
    self.model thread common_scripts\utility::play_loop_sound_on_entity(self.enginesnd);
    self.vehicle.animname = self.animname;
    self.vehicle useanimtree(#animtree);
    wait 1.15;
    self.pathnode thread maps\_anim::anim_single_solo(self.vehicle, "pathanim");
    self.vehicle waittillmatch("single anim", "stop");
  } else {
    self.vehicle attachpath(self.startnode);
    self.vehicle startpath();
    wait 0.1;
    self.model thread common_scripts\utility::play_loop_sound_on_entity(self.enginesnd);
    self.vehicle setwaitnode(self.stopnode);
    self.vehicle waittill("reached_wait_node");
    self notify("almost_ready");
    self.vehicle vehicle_setspeed(0, 25);

    while (self.vehicle vehicle_getspeed() > 0)
      wait 0.1;
  }
}

fastrope_heli_cleanup() {
  self.model notify("stop_anim_loop");
  self.model notify("stop sound" + self.enginesnd);
  self.vehicle delete();
  self.vehicle = undefined;

  if(isdefined(self.model)) {
    self.model delete();
    self.model = undefined;
  }

  self.returnflight = 0;
  self notify("returnflight");
}

fastrope_heli_overtake() {
  self.overtake = 1;
  self waittill("overtake");
  self.model notify("overtake");
  var_0 = self.model.angles;
  var_1 = self.vehicle.origin;
  self.vehicle delete();
  self.vehicle = undefined;
  self.vehicle = spawnvehicle(self.modelname, self.targetname, self.type, var_1, var_0);
  self.vehicle.vehicletype = "blackhawk";
  self.vehicle.health = 100000;
  self.vehicle hide();
  self.vehicle setcontents(0);
  self.model linkto(self.vehicle, "tag_detach");
  self.model thread fastrope_heli_fly_sea(self.vehicle);
}

fastrope_heli_overtake_now() {
  self.overtake = 1;
  self notify("overtakenow");
  self.model notify("overtake");
  var_0 = self.vehicle.angles;
  var_1 = self.vehicle.origin;
  self.vehicle delete();
  self.vehicle = undefined;
  self.vehicle = spawnvehicle(self.modelname, self.targetname, self.type, var_1, var_0);
  self.vehicle.vehicletype = "blackhawk";
  self.vehicle.health = 100000;
  self.vehicle hide();
  self.vehicle setcontents(0);
  self.model thread fastrope_heli_fly_sea(self.vehicle);
}

fastrope_heli_playexteriorlightfx() {
  playfxontag(level._effect["aircraft_light_wingtip_red"], self, "tag_light_L_wing");
  playfxontag(level._effect["aircraft_light_wingtip_green"], self, "tag_light_R_wing");
  playfxontag(level._effect["aircraft_light_white_blink"], self, "tag_light_belly");
  wait 0.25;
  playfxontag(level._effect["aircraft_light_white_blink"], self, "tag_light_tail");
}

fastrope_heli_playinteriorlightfx() {
  playfxontag(level._effect["aircraft_light_cockpit_blue"], self, "tag_light_cockpit01");
}

fastrope_heli_playinteriorlightfx2() {
  playfxontag(level._effect["aircraft_light_cockpit_red"], self, "tag_light_cargo01");
}

fastrope_heli_playinteriorlightgreenfx(var_0) {
  var_1 = common_scripts\utility::spawn_tag_origin();
  var_1 linkto(self, "tag_light_cargo01", (0, 0, 0), (0, -90, 0));

  if(var_0 == 1)
    playfxontag(level._effect["aircraft_light_cockpit_green"], var_1, "tag_origin");
}

fastrope_heli_fly_sea(var_0) {
  self endon("death");
  self endon("overtake");

  for (;;) {
    var_1 = level._sea_link localtoworldcoords(var_0.origin);
    var_2 = combineangles(level._sea_link.angles, var_0 gettagangles("tag_detach"));
    self moveto(var_1 + level._sea_link.offset, 0.1);
    self rotateto(var_2, 0.1);
    wait 0.1;
  }
}

fastrope_calc(var_0) {
  var_1 = var_0.origin;
  var_2 = physicstrace(var_1, var_1 + (0, 0, -10000));
  var_3 = distance(var_1, var_2) + 1;
  var_4 = 400;
  var_5 = int(var_3 - 128);
  var_6 = int(var_5 / var_4);
  var_7 = var_5 - var_4 * var_6;
  var_8 = var_7 / var_4;
  var_9 = (var_6 + var_8) * 1.6;
  var_10 = var_8 * -360;
  var_11 = var_0.angles + (0, var_10, 0);
  var_0.range = var_5;
  var_0.time = var_9;
  var_0.startangle = var_11;
}

fastrope_setup() {
  if(!(isdefined(self.script_noteworthy) && self.script_noteworthy == "fastrope_friendlies")) {
    return;
  }
  self.heli = fastrope_heli_setup(self.targetname);
  fastrope_animload(self.heli);
  thread fastrope_spawner_think();
}

fastrope_heli_setup(var_0) {
  var_1 = undefined;
  var_1 = level.fastrope_globals.helicopters[fastrope_heliname(var_0)];

  if(isdefined(var_1))
    return var_1;

  var_2 = common_scripts\utility::getstruct(var_0, "target");
  var_1 = spawnstruct();
  var_1.vehicle = undefined;
  var_1.targetname = fastrope_heliname(var_0);
  var_1.animname = var_1.targetname;
  var_1.startnode = getvehiclenode(var_0, "targetname");
  var_1.stopnode = undefined;
  var_1.lasttime = undefined;
  var_1.ready = 0;
  var_1.inflight = 0;
  var_1.returnflight = 0;
  var_1.que = [];
  var_1.rope_dropped = [];
  var_1.modelname = "vehicle_blackhawk_hero_sas_night";
  var_1.type = "blackhawk";
  var_1.enginesnd = "blackhawk_engine_high";
  var_1.player = 0;
  var_1.unload = "both";
  var_1.unloadwait = 1;

  if(isdefined(var_2.script_parameters)) {
    var_3 = strtok(var_2.script_parameters, ":;,= ");

    for (var_4 = 0; var_4 < var_3.size; var_4++) {
      if(tolower(var_3[var_4]) == "model") {
        var_4++;

        switch (var_3[var_4]) {
          case "blackhawk":
            var_1.modelname = "vehicle_blackhawk_hero_sas_night";
            var_1.type = "blackhawk";
            var_1.enginesnd = "blackhawk_engine_high";
            break;
        }

        continue;
      }

      if(tolower(var_3[var_4]) == "player") {
        var_4++;

        if(tolower(var_3[var_4]) == "true")
          var_1.player = 1;

        continue;
      }

      if(tolower(var_3[var_4]) == "unload") {
        var_4++;

        if(var_3[var_4] == "both" || var_3[var_4] == "left" || var_3[var_4] == "right")
          var_1.unload = var_3[var_4];
      }
    }
  }

  fastrope_heli_setup_seats(var_1);

  if(isdefined(var_1.startnode)) {
    var_5 = var_1.startnode;

    while (isdefined(var_5.target)) {
      var_5 = getvehiclenode(var_5.target, "targetname");

      if(isdefined(var_5.script_noteworthy) && var_5.script_noteworthy == "stop") {
        var_1.stopnode = var_5;
        break;
      }
    }

    if(!isdefined(var_1.stopnode)) {

    }
  }

  level.fastrope_globals.helicopters[var_1.targetname] = var_1;
  return var_1;
}

fastrope_heli_setup_seats(var_0) {
  var_0.seats = [];

  switch (var_0.type) {
    case "blackhawk":
      switch (var_0.unload) {
        case "both":
          var_0.seats[0] = fastrope_createseat(var_0.type, 1);
          var_0.seats[1] = fastrope_createseat(var_0.type, 2);
          var_0.seats[2] = fastrope_createseat(var_0.type, 5);
          var_0.seats[3] = fastrope_createseat(var_0.type, 4);
          var_0.seats[4] = fastrope_createseat(var_0.type, 8);
          var_0.seats[5] = fastrope_createseat(var_0.type, 6);
          var_0.seats[6] = fastrope_createseat(var_0.type, 7);
          var_0.seats[7] = fastrope_createseat(var_0.type, 3);
          var_0.seats[8] = fastrope_createseat(var_0.type, 9);
          var_0.seats[9] = fastrope_createseat(var_0.type, 10);

          if(var_0.player) {
            level.player.side = "right";
            var_0.seats[4].taken = level.player;
          }

          break;
        case "right":
          var_0.seats[0] = fastrope_createseat(var_0.type, 1);
          var_0.seats[1] = fastrope_createseat(var_0.type, 2);
          var_0.seats[2] = fastrope_createseat(var_0.type, 8);
          var_0.seats[3] = fastrope_createseat(var_0.type, 7);
          var_0.seats[4] = fastrope_createseat(var_0.type, 9);
          var_0.seats[5] = fastrope_createseat(var_0.type, 10);

          if(var_0.player) {
            level.player.side = "right";
            var_0.seats[2].taken = level.player;
          }

          break;
        case "left":
          var_0.seats[0] = fastrope_createseat(var_0.type, 5);
          var_0.seats[1] = fastrope_createseat(var_0.type, 4);
          var_0.seats[2] = fastrope_createseat(var_0.type, 6);
          var_0.seats[3] = fastrope_createseat(var_0.type, 3);
          var_0.seats[4] = fastrope_createseat(var_0.type, 9);
          var_0.seats[5] = fastrope_createseat(var_0.type, 10);

          if(var_0.player)
            level.player.side = "right";

          break;
      }

      break;
  }
}

fastrope_precache() {
  level.models["player"]["fastrope"] = "fastrope_arms";
  level.models["heli"]["rope"]["right"] = "rope_test_ri";
  level.models["heli"]["rope"]["left"] = "rope_test";
  precachemodel(level.models["player"]["fastrope"]);
  precachemodel(level.models["heli"]["rope"]["right"]);
  precachemodel(level.models["heli"]["rope"]["left"]);
}

fastrope_ropeanimload(var_0, var_1, var_2, var_3) {
  level.scr_anim[self.targetname]["ropeall" + var_2] = var_3;
  level.scr_anim[self.targetname]["ropeidle" + var_2][0] = var_0;
  level.scr_anim[self.targetname]["ropedrop" + var_2] = var_1;
}

#using_animtree("generic_human");

fastrope_animload(var_0) {
  var_1 = var_0.type;

  if(level.fastrope_globals.animload[var_1]) {
    return;
  }
  level.fastrope_globals.animload[var_1] = 1;
  fastrope_animload_heli(var_1);
  fastrope_animload_player(var_1);

  switch (var_1) {
    case "blackhawk":
      var_2 = fastrope_animname(var_1, 1);
      level.scr_anim[var_2]["idle"][0] = % bh_1_idle;
      level.scr_anim[var_2]["grab"] = % bh_1_begining;
      level.scr_anim[var_2]["loop"][0] = % bh_fastrope_loop;
      level.scr_anim[var_2]["land"] = % bh_fastrope_land;
      var_2 = fastrope_animname(var_1, 2);
      level.scr_anim[var_2]["idle"][0] = % bh_2_idle;
      level.scr_anim[var_2]["grab"] = % bh_2_begining;
      level.scr_anim[var_2]["loop"][0] = % bh_fastrope_loop;
      level.scr_anim[var_2]["land"] = % bh_fastrope_land;
      var_2 = fastrope_animname(var_1, 3);
      level.scr_anim[var_2]["idle"][0] = % bh_2_idle;
      level.scr_anim[var_2]["grab"] = % bh_2_begining;
      level.scr_anim[var_2]["loop"][0] = % bh_fastrope_loop;
      level.scr_anim[var_2]["land"] = % bh_fastrope_land;
      var_2 = fastrope_animname(var_1, 4);
      level.scr_anim[var_2]["idle"][0] = % bh_4_idle;
      level.scr_anim[var_2]["grab"] = % bh_4_begining;
      level.scr_anim[var_2]["loop"][0] = % bh_fastrope_loop;
      level.scr_anim[var_2]["land"] = % bh_fastrope_land;
      var_2 = fastrope_animname(var_1, 5);
      level.scr_anim[var_2]["idle"][0] = % bh_5_idle;
      level.scr_anim[var_2]["grab"] = % bh_5_begining;
      level.scr_anim[var_2]["loop"][0] = % bh_fastrope_loop;
      level.scr_anim[var_2]["land"] = % bh_fastrope_land;
      var_2 = fastrope_animname(var_1, 6);
      level.scr_anim[var_2]["idle"][0] = % bh_6_idle;
      level.scr_anim[var_2]["grab"] = % bh_6_begining;
      level.scr_anim[var_2]["loop"][0] = % bh_fastrope_loop;
      level.scr_anim[var_2]["land"] = % bh_fastrope_land;
      var_2 = fastrope_animname(var_1, 7);
      level.scr_anim[var_2]["idle"][0] = % bh_2_idle;
      level.scr_anim[var_2]["grab"] = % bh_2_begining;
      level.scr_anim[var_2]["loop"][0] = % bh_fastrope_loop;
      level.scr_anim[var_2]["land"] = % bh_fastrope_land;
      var_2 = fastrope_animname(var_1, 8);
      level.scr_anim[var_2]["idle"][0] = % bh_2_idle;
      level.scr_anim[var_2]["grab"] = % bh_2_begining;
      level.scr_anim[var_2]["loop"][0] = % bh_fastrope_loop;
      level.scr_anim[var_2]["land"] = % bh_fastrope_land;
      var_2 = fastrope_animname(var_1, 9);
      level.scr_anim[var_2]["idle"][0] = % bh_pilot_idle;
      var_2 = fastrope_animname(var_1, 10);
      level.scr_anim[var_2]["idle"][0] = % bh_copilot_idle;
      level.scr_anim[var_2]["minigun"][0] = % h1_cargoship_blackhawk_copilote_minigun;
      break;
  }
}

fastrope_createseat(var_0, var_1) {
  var_2 = spawnstruct();
  var_2.taken = undefined;
  var_2.animname = fastrope_animname(var_0, var_1);
  var_2.side = fastrope_getside(var_0, var_1);
  var_2.index = fastrope_getindex(var_0, var_1);
  var_2.spin = fastrope_getspin(var_0, var_1);
  var_2.pos = var_1;
  return var_2;
}

fastrope_heliname(var_0) {
  return level.fastrope_globals.basename + var_0;
}

fastrope_animname(var_0, var_1) {
  return "fastrope_" + var_0 + "_" + var_1;
}

fastrope_get_heli(var_0) {
  return level.fastrope_globals.helicopters[level.fastrope_globals.basename + var_0];
}

fastrope_getspin(var_0, var_1) {
  var_2 = [];

  switch (var_0) {
    case "blackhawk":
      var_2[1] = 0;
      var_2[2] = 0;
      var_2[8] = 0;
      var_2[7] = 0;
      var_2[5] = 0;
      var_2[4] = 1;
      var_2[6] = 1;
      var_2[3] = 1;
      var_2[9] = undefined;
      var_2[10] = undefined;
  }

  return var_2[var_1];
}

fastrope_getindex(var_0, var_1) {
  var_2 = [];

  switch (var_0) {
    case "blackhawk":
      var_2[1] = 0;
      var_2[2] = 0.25;
      var_2[8] = -1.5;
      var_2[7] = 1;
      var_2[5] = 0;
      var_2[4] = 0.25;
      var_2[6] = -1.5;
      var_2[3] = 1;
      var_2[9] = undefined;
      var_2[10] = undefined;
  }

  return var_2[var_1];
}

fastrope_getside(var_0, var_1) {
  var_2 = [];

  switch (var_0) {
    case "blackhawk":
      var_2[1] = "right";
      var_2[2] = "right";
      var_2[3] = "left";
      var_2[4] = "left";
      var_2[5] = "left";
      var_2[6] = "left";
      var_2[7] = "right";
      var_2[8] = "right";
      var_2[9] = "right";
      var_2[10] = "right";
  }

  return var_2[var_1];
}

#using_animtree("fastrope");

fastrope_animload_player(var_0) {
  switch (var_0) {
    case "blackhawk":
      var_1 = fastrope_animname(var_0, "player");
      level.scr_anim[var_1]["idle"][0] = % cs_bh_player_idle;
      level.scr_anim[var_1]["ride"] = % bh_player_rope_start;
      level.scr_anim[var_1]["loop"][0] = % bh_player_rope_middle;
      level.scr_anim[var_1]["land"] = % bh_player_rope_end;
      break;
  }
}

#using_animtree("vehicles");

fastrope_animload_heli(var_0) {
  switch (var_0) {
    case "blackhawk":
      var_1 = fastrope_animname(var_0, "heli");
      level.scr_anim[var_1]["loop"][0] = % bh_rotors;
      break;
  }
}