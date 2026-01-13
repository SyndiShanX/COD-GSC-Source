/***************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\asm\dlc4_boss\dlc4_boss_asm.gsc
***************************************************/

asminit(var_0, var_1, var_2, var_3) {
  scripts\asm\zombie\zombie::func_13F9A(var_0, var_1, var_2, var_3);
  self.fnactionvalidator = ::isvalidaction;
  if(!isDefined(level.dlc4_boss_arrival_data)) {
    analyzemovementanims();
  }

  var_4 = self getsafecircleorigin("move_arrival", 4);
  self._blackboard.movearrivaldist = length(getmovedelta(var_4, 0, 1));
  var_4 = self getsafecircleorigin("move_back_arrival", 0);
  self._blackboard.movebackarrivaldist = length(getmovedelta(var_4, 0, 1));
  var_4 = self getsafecircleorigin("drop_move_arrival", 0);
  self._blackboard.dropmovearrivaldist = length(getmovedelta(var_4, 0, 1));
}

analyzemovementanims() {
  level.dlc4_boss_arrival_data = [];
  level.dlc4_boss_move_data = [];
  for(var_0 = 1; var_0 <= 9; var_0++) {
    if(var_0 == 5) {
      continue;
    }

    var_1 = var_0;
    var_2 = scripts\asm\asm::asm_lookupanimfromalias("move_arrival", var_1);
    var_3 = self getsafecircleorigin("move_arrival", var_2);
    var_4 = getmovedelta(var_3, 0, 1);
    level.dlc4_boss_arrival_data[var_0] = var_4;
    level.dlc4_boss_arrival_time[var_0] = getanimlength(var_3);
    var_1 = var_0;
    var_2 = scripts\asm\asm::asm_lookupanimfromalias("move_loop", var_1);
    var_3 = self getsafecircleorigin("move_loop", var_2);
    var_4 = getmovedelta(var_3, 0, 1);
    level.dlc4_boss_move_data[var_0] = var_4;
    level.dlc4_boss_move_time[var_0] = getanimlength(var_3);
    var_2 = scripts\asm\asm::asm_lookupanimfromalias("move_exit", var_1);
    var_3 = self getsafecircleorigin("move_exit", var_2);
    var_4 = getmovedelta(var_3, 0, 1);
    level.dlc4_boss_exit_data[var_0] = var_4;
    level.dlc4_boss_exit_time[var_0] = getanimlength(var_3);
  }
}

isvalidaction(var_0) {
  switch (var_0) {
    case "drop_move":
    case "black_hole":
    case "ground_vul":
    case "air_pound":
    case "move":
    case "teleport":
    case "ground_pound":
    case "turn":
    case "death":
    case "eclipse":
    case "temp_idle":
    case "throw":
    case "tornado":
    case "summon":
    case "clap":
    case "fireball":
    case "taunt":
    case "fly_over":
      return 1;
  }

  return 0;
}

shouldplayentranceanim(var_0, var_1, var_2, var_3) {
  thread introfx();
  return 1;
}

introfx() {
  var_0 = scripts\asm\dlc4\dlc4_asm::gettunedata();
  self.vo_ent = spawn("script_origin", self gettagorigin("tag_origin"));
  self.vo_ent linkto(self);
  playFX(var_0.air_pound_rise_fx, self.arenacenter);
  wait(0.1);
  playsoundatpos(self.arenacenter, "zmb_ground_spawn_dirt");
  self.vo_ent playSound("final_meph_intro");
  var_1 = gettime() + 4400;
  while(gettime() < var_1) {
    earthquake(0.35, 3, self.arenacenter, 750);
    scripts\engine\utility::waitframe();
    playrumbleonposition("artillery_rumble", self.arenacenter);
    wait(0.2);
  }

  wait(2.1);
  earthquake(0.4, 1, self.arenacenter, 750);
  scripts\engine\utility::waitframe();
  playrumbleonposition("artillery_rumble", self.arenacenter);
  wait(1.1);
  earthquake(0.4, 1, self.arenacenter, 750);
  scripts\engine\utility::waitframe();
  playrumbleonposition("artillery_rumble", self.arenacenter);
}

playmoveexit(var_0, var_1, var_2, var_3) {
  self orientmode("face angle abs", self.angles);
  var_4 = self._blackboard;
  var_4.desireddir = vectornormalize(var_4.nodes[var_4.desirednode].origin - self.origin);
  var_5 = scripts\asm\asm_mp::asm_getanim(var_0, var_1);
  var_6 = self getsafecircleorigin(var_1, var_5);
  if(self._blackboard.smoothmotion) {
    thread adjustlookahead(var_1);
  }

  thread applyallmotiontowardsdesireddir(var_1, var_6, getdvarfloat("dlc4_boss_in_out_scale", 1), 0);
  if(self._blackboard.facecenter) {
    thread staylookingatcenter(var_1);
  }

  scripts\asm\asm_mp::func_2364(var_0, var_1, var_2, var_3);
}

loopbossmoveanim(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  var_4 = scripts\asm\asm_mp::asm_getanim(var_0, var_1);
  var_5 = self getsafecircleorigin(var_1, var_4);
  if(self._blackboard.smoothmotion) {
    thread adjustlookahead(var_1);
  }

  thread applyallmotiontowardsdesireddir(var_1, var_5, 1, 1);
  if(self._blackboard.facecenter) {
    thread staylookingatcenter(var_1);
  }

  lib_0F3C::func_B050(var_0, var_1, var_2, var_3);
}

playmovearrival(var_0, var_1, var_2, var_3) {
  var_4 = scripts\asm\asm_mp::asm_getanim(var_0, var_1);
  var_5 = self getsafecircleorigin(var_1, var_4);
  if(self._blackboard.smoothmotion) {
    thread adjustlookahead(var_1);
  }

  thread applyallmotiontowardsdesireddir(var_1, var_5, getdvarfloat("dlc4_boss_in_out_scale", 1), 0);
  if(self._blackboard.facecenter) {
    thread staylookingatcenter(var_1);
  }

  scripts\asm\asm_mp::func_2364(var_0, var_1, var_2, var_3);
}

choosebossmoveanim(var_0, var_1, var_2) {
  var_3 = self._blackboard.currentmovedirindex;
  return scripts\asm\asm::asm_lookupanimfromalias(var_1, var_3);
}

choosebossarrivalanim(var_0, var_1, var_2) {
  var_3 = self._blackboard.currentmovedirindex;
  return scripts\asm\asm::asm_lookupanimfromalias(var_1, var_3);
}

applyallmotiontowardsdesireddir(var_0, var_1, var_2, var_3) {
  self endon(var_0 + "_finished");
  var_2 = var_2 * getdvarfloat("dlc4_boss_strafe_speed", 1);
  var_4 = 0;
  var_5 = getanimlength(var_1);
  while(var_4 < var_5) {
    var_6 = self._blackboard;
    var_7 = var_6.nodes[var_6.desirednode].origin;
    var_8 = var_4 / var_5;
    var_9 = var_4 + 0.05 / var_5;
    var_0A = 0;
    if(var_9 > 1) {
      if(var_3) {
        var_0A = length2d(getmovedelta(var_1, var_8, 1)) * var_2;
        var_4 = 0;
        var_8 = 0;
        var_9 = var_9 - 1;
      } else {
        var_9 = 1;
      }
    }

    var_0B = getmovedelta(var_1, var_8, var_9);
    var_0A = var_0A + length2d(var_0B) * var_2;
    var_0C = self.origin + self._blackboard.desireddir * var_0A;
    self setorigin(var_0C - (0, 0, 1), 0);
    wait(0.05);
    var_4 = var_4 + 0.05;
  }
}

adjustlookahead(var_0) {
  self endon(var_0 + "_finished");
  var_1 = self._blackboard;
  var_2 = scripts\asm\dlc4\dlc4_asm::gettunedata().look_ahead_radius;
  var_3 = scripts\asm\dlc4\dlc4_asm::gettunedata().look_ahead_speed;
  var_4 = var_1.nodes.size;
  var_5 = var_1.lookaheadnextnode - var_1.lookaheadcurrnode;
  for(;;) {
    var_6 = distance2dsquared(self.origin, var_1.lookaheadorigin);
    if(var_6 < var_2 * var_2) {
      for(var_7 = var_3; var_7 > 0; var_7 = 0) {
        var_8 = distance2d(var_1.lookaheadorigin, var_1.nodes[var_1.lookaheadnextnode].origin);
        if(var_8 < var_7) {
          var_7 = var_7 - var_8;
          var_1.lookaheadorigin = var_1.nodes[var_1.lookaheadnextnode].origin;
          var_1.lookaheadcurrnode = var_1.lookaheadnextnode;
          var_1.lookaheadnextnode = var_1.lookaheadcurrnode + var_5 + var_4 % var_4;
          continue;
        }

        var_9 = vectornormalize(var_1.nodes[var_1.lookaheadnextnode].origin - var_1.nodes[var_1.lookaheadcurrnode].origin);
        var_1.lookaheadorigin = var_1.lookaheadorigin + var_9 * var_7;
      }
    }

    self._blackboard.desireddir = vectornormalize(var_1.lookaheadorigin - self.origin * (1, 1, 0));
    wait(0.05);
  }
}

staylookingatcenter(var_0) {
  self endon(var_0 + "_finished");
  for(;;) {
    facearenacenter();
    wait(0.05);
  }
}

playstrafefireball(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  var_4 = scripts\asm\asm_mp::asm_getanim(var_0, var_1);
  var_5 = self getsafecircleorigin(var_1, var_4);
  if(self._blackboard.smoothmotion) {
    thread adjustlookahead(var_1);
  }

  thread applyallmotiontowardsdesireddir(var_1, var_5, 1, 0);
  if(self._blackboard.facecenter) {
    thread staylookingatcenter(var_1);
  }

  lib_0F3C::func_CEA8(var_0, var_1, var_2, var_3);
}

choosestrafefireballanim(var_0, var_1, var_2) {
  var_3 = self._blackboard.currentmovedirindex;
  return scripts\asm\asm::asm_lookupanimfromalias(var_1, var_3);
}

strafefireballnotehandler(var_0, var_1, var_2, var_3) {
  var_4 = getspecialenemy();
  var_5 = self.arenacenter;
  if(isDefined(var_4)) {
    var_5 = var_4.origin;
  }

  if(var_0 == "fireleft") {
    thread strafefireballburst("j_mid_le_3", var_5, var_1);
    return;
  }

  if(var_0 == "fireright") {
    thread strafefireballburst("j_mid_ri_3", var_5, var_1);
    return;
  }

  if(var_0 == "fireboth") {
    thread strafefireballburst("j_thumb_ri_3", var_5, var_1);
    return;
  }
}

strafefireballburst(var_0, var_1, var_2) {
  self endon(var_2 + "_finished");
  var_3 = scripts\asm\dlc4\dlc4_asm::gettunedata();
  var_4 = randomintrange(var_3.min_burst_count, var_3.max_burst_count);
  for(var_5 = 0; var_5 < var_4; var_5++) {
    var_6 = self gettagorigin(var_0);
    var_7 = (randomfloatrange(var_3.sawblade_min_offset, var_3.sawblade_max_offset), randomfloatrange(var_3.sawblade_min_offset, var_3.sawblade_max_offset), 0);
    var_8 = magicbullet(var_3.sawblade_weapon, var_6, var_1 + var_7, self);
    var_8 thread fireballimpactfx();
    wait(var_3.sawblade_burst_interval);
  }
}

playfireball(var_0, var_1, var_2, var_3) {
  if(!isDefined(self.fireballtargetpos)) {
    self.fireballtargetpos = self.arenacenter;
  }

  faceposition(self.fireballtargetpos);
  lib_0F3C::func_CEA8(var_0, var_1, var_2, var_3);
}

choosefireballanim(var_0, var_1, var_2) {
  var_3 = randomfloat(1);
  if(var_3 < 0.33) {
    return scripts\asm\asm::asm_lookupanimfromalias(var_1, "left");
  }

  if(var_3 < 0.66) {
    return scripts\asm\asm::asm_lookupanimfromalias(var_1, "right");
  }

  return scripts\asm\asm::asm_lookupanimfromalias(var_1, "both");
}

fireball_note_handler(var_0, var_1, var_2, var_3) {
  var_4 = self.fireballtargetpos;
  if(var_0 == "fireleft") {
    var_5 = self gettagorigin("j_mid_le_3");
    fireballburst(var_1, var_5, var_4);
    return;
  }

  if(var_0 == "fireright") {
    var_5 = self gettagorigin("j_mid_ri_3");
    fireballburst(var_1, var_5, var_4);
    return;
  }

  if(var_0 == "fireboth") {
    var_5 = self gettagorigin("j_thumb_ri_3");
    fireballburst(var_1, var_5, var_4);
    return;
  }
}

fireballburst(var_0, var_1, var_2) {
  self endon(var_0 + "_finished");
  var_3 = scripts\asm\dlc4\dlc4_asm::gettunedata();
  var_4 = randomintrange(var_3.min_burst_count, var_3.max_burst_count);
  for(var_5 = 0; var_5 < var_4; var_5++) {
    var_6 = (randomfloatrange(var_3.sawblade_min_offset, var_3.sawblade_max_offset), randomfloatrange(var_3.sawblade_min_offset, var_3.sawblade_max_offset), 0);
    var_7 = magicbullet(var_3.sawblade_weapon, var_1, var_2 + var_6, self);
    var_7 thread fireballimpactfx();
    wait(var_3.sawblade_burst_interval);
  }
}

fireballimpactfx() {
  self waittill("death");
  if(!isDefined(self) || !isDefined(self.origin)) {
    return;
  }

  earthquake(0.3, 1, self.origin, 128);
  playrumbleonposition("grenade_rumble", self.origin);
}

clap_note_handler(var_0, var_1, var_2, var_3) {
  if(var_0 == "fire") {
    thread handleclapprojectile();
  }
}

doclapdamage() {
  level endon("rockwall_end");
  var_0 = getent("rockwall_trig", "targetname");
  for(;;) {
    var_0 waittill("trigger", var_1);
    if(!var_1 scripts\cp\utility::is_valid_player()) {
      continue;
    }

    if(!isDefined(var_1.padding_damage)) {
      playfxontagforclients(level._effect["vfx_dlc4_player_burn_flames"], var_1, "tag_eye", var_1);
      var_1.padding_damage = 1;
      var_1 dodamage(15, var_0.origin, level.dlc4_boss, level.dlc4_boss, "MOD_UNKNOWN", "iw7_electrictrap_zm");
      var_1 thread scripts\cp\maps\cp_final\cp_final_final_boss::remove_padding_damage();
      continue;
    }
  }
}

handleclapprojectile() {
  self.claponarena = 1;
  var_0 = scripts\asm\dlc4\dlc4_asm::gettunedata();
  var_1 = anglesToForward(self.angles);
  var_2 = var_0.staff_projectile_range / var_0.staff_projectile_speed;
  var_3 = var_0.staff_projectile_speed * var_0.staff_projectile_interval;
  var_4 = var_3 / 2;
  var_5 = self.origin + var_1 * var_4;
  var_6 = gettime() + var_2 * 1650;
  var_7 = spawn("script_model", var_5);
  var_7 setModel(var_0.ratking_staff_projectile_model);
  var_7 show();
  var_7.angles = var_1 + (0, 90, 0);
  var_8 = getent("rockwall_clip", "targetname");
  var_8.angles = var_1 + (0, 90, 0);
  var_8.origin = var_5;
  var_8 linkto(var_7);
  var_8 thread doclapdamage();
  var_7 playsoundonmovingent("cp_final_meph_rock_spires");
  level.rockwall_forming = 1;
  while(gettime() < var_6) {
    doclaplethaldamage(var_5, var_4, var_0.staff_projectile_z_delta, var_0.staff_projectile_damage);
    var_7 moveto(var_5, var_0.staff_projectile_interval);
    earthquake(0.35, 1, var_5, 256);
    wait(var_0.staff_projectile_interval);
    var_5 = var_5 + var_1 * var_3;
    var_7.angles = vectortoangles(var_5 - var_7.origin);
    var_9 = anglesToForward(var_7.angles);
    playFX(level._effect["vfx_clap_wall_raise"], var_5, anglesToForward(var_7.angles), anglestoup(var_7.angles));
    playrumbleonposition("grenade_rumble", var_5);
  }

  level.rockwall_forming = undefined;
  var_0A = createnavobstaclebybounds(var_8.origin, (2000, 64, 200), var_7.angles);
  wait(0.15);
  var_7 delete();
  wait(10);
  destroynavobstacle(var_0A);
  var_8 unlink();
  var_8.origin = var_8.origin + (0, 0, -200);
  self.claponarena = 0;
  level notify("rockwall_end");
}

doclaplethaldamage(var_0, var_1, var_2, var_3) {
  var_1 = var_1 + 64;
  var_4 = var_1 * var_1;
  var_5 = scripts\common\trace::create_default_contents(1);
  var_6 = scripts\common\trace::ray_trace(var_0 + (0, 0, var_2), var_0 - (0, 0, var_2), self, var_5);
  var_0 = getgroundposition(var_0, 8);
  foreach(var_8 in level.players) {
    if(!isalive(var_8)) {
      continue;
    }

    var_9 = distance2dsquared(var_0, var_8.origin);
    if(var_9 > var_4) {
      continue;
    }

    if(abs(var_0[2] - var_8.origin[2]) > var_2) {
      continue;
    }

    if(!scripts\cp\cp_laststand::player_in_laststand(var_8) && scripts\mp\agents\zombie\zombie_util::shouldignoreent(var_8)) {
      continue;
    }

    var_8 thread warp_to_closest();
    var_8 dodamage(var_3, var_0, self, self, "MOD_IMPACT");
  }
}

warp_to_closest() {
  self endon("disconnect");
  while(scripts\engine\utility::istrue(level.rockwall_forming)) {
    wait(0.05);
  }

  self setorigin(getclosestpointonnavmesh(self.origin));
}

unlink_from_anchor() {
  wait(0.5);
  self unlink(1);
}

playsummonanim(var_0, var_1, var_2, var_3) {
  self playSound("final_meph_eclipse");
  var_4 = scripts\asm\asm_mp::asm_getanim(var_0, var_1);
  scripts\asm\asm_mp::func_2365(var_0, var_1, var_2, var_4, self.var_C081);
}

summon_note_handler(var_0, var_1, var_2, var_3) {
  if(var_0 == "hit") {
    summonskeletons();
  }
}

summonskeletons() {
  var_0 = scripts\asm\dlc4\dlc4_asm::gettunedata();
  foreach(var_2 in var_0.spawnpoints) {
    spawnzombie(var_0.summon_agent_type, var_2);
  }
}

setup_summoned_zombie(var_0) {
  self endon("death");
  wait(2);
  if(!isalive(self)) {
    return;
  }

  if(var_0 == "skeleton") {
    self setscriptablepartstate("eyes", "red_eyes");
    self setscriptablepartstate("burning", "active");
    return;
  }

  if(var_0 == "generic_zombie") {
    self setscriptablepartstate("eyes", "yellow_eyes");
  }
}

tornado_note_handler(var_0, var_1, var_2, var_3) {
  if(var_0 == "tornado_start") {
    level thread firetornado(self);
  }
}

firetornado(var_0) {
  var_1 = spawnfx(level._effect["vfx_fire_tornado_lg"], var_0.arenacenter + (0, 0, 5));
  wait(0.2);
  var_0 playSound("final_meph_throw_big");
  triggerfx(var_1);
  wait(0.05);
  var_2 = spawn("trigger_radius", var_0.arenacenter, 0, 156, 96);
  var_2 thread firetornadodamage();
  playsoundatpos(var_0.arenacenter + (0, 0, 5), "cp_final_meph_tornado_big_spawn");
  wait(3);
  var_3 = scripts\engine\utility::getstructarray("tornado_start", "targetname");
  foreach(var_5 in var_3) {
    level thread createfiretornado(var_5);
    wait(0.05);
  }

  var_7 = scripts\engine\utility::random(var_3);
  var_8 = scripts\engine\utility::random(var_3);
  wait(1);
  level thread createfiretornado(var_7);
  level thread createfiretornado(var_8);
  wait(2);
  var_2 delete();
  wait(1);
  var_1 delete();
}

createfiretornado(var_0) {
  var_1 = spawn("trigger_radius", var_0.origin, 0, 96, 96);
  var_2 = spawn("script_model", var_0.origin);
  wait(0.05);
  var_2 setModel("tag_origin_fire_tornado");
  var_1 enablelinkto();
  var_1 linkto(var_2);
  var_1 thread firetornadodamage();
  wait(0.05);
  var_2 playLoopSound("cp_final_meph_tornado_small_lp");
  var_2 moveto(scripts\engine\utility::random(scripts\engine\utility::getstructarray(var_0.target, "targetname")).origin, 3);
  var_2 waittill("movedone");
  var_2 stoploopsound();
  playsoundatpos(var_2.origin, "cp_final_meph_tornado_small_end");
  var_1 delete();
  wait(1);
  var_2 delete();
}

firetornadodamage() {
  self endon("death");
  for(;;) {
    self waittill("trigger", var_0);
    if(!var_0 scripts\cp\utility::is_valid_player()) {
      continue;
    }

    if(!isDefined(var_0.padding_damage)) {
      playfxontagforclients(level._effect["vfx_dlc4_player_burn_flames"], var_0, "tag_eye", var_0);
      var_0.padding_damage = 1;
      var_0 dodamage(40, self.origin, self, self, "MOD_UNKNOWN", "iw7_electrictrap_zm");
      var_0 thread scripts\cp\maps\cp_final\cp_final_final_boss::remove_padding_damage();
      continue;
    }
  }
}

ground_pound_start_note_handler(var_0, var_1, var_2, var_3) {
  if(var_0 == "fire") {
    thread doteleporttocenter(var_1);
  }
}

ground_pound_pound_note_handler(var_0, var_1, var_2, var_3) {
  if(var_0 == "fire") {
    var_4 = scripts\asm\dlc4\dlc4_asm::gettunedata();
    self radiusdamage(self.origin, var_4.ss_groundpound_radius, var_4.ss_groundpound_max_damage, var_4.ss_groundpound_min_damage, self, "MOD_IMPACT");
  }
}

groundpoundexit(var_0, var_1, var_2, var_3) {
  thread doteleporttodesirednode(var_1);
}

throw_note_handler(var_0, var_1, var_2, var_3) {
  var_4 = undefined;
  var_5 = undefined;
  var_6 = getspecialenemy();
  var_5 = self.arenacenter;
  if(isDefined(var_6)) {
    var_5 = var_6.origin;
  }

  if(var_0 == "fireleft") {
    var_4 = self gettagorigin("j_mid_le_3");
    throwmeteor(var_1, "LEFT", var_5);
    return;
  }

  if(var_0 == "fireright") {
    var_4 = self gettagorigin("j_mid_ri_3");
    throwmeteor(var_1, "RIGHT", var_5);
    return;
  }

  if(var_0 == "fireboth") {
    var_4 = self gettagorigin("j_thumb_ri_3");
    throwmeteor(var_1, "CENTER", var_5);
    return;
  }
}

throwmeteor(var_0, var_1, var_2) {
  self playSound("final_meph_throw_quick");
  self endon(var_0 + "_finished");
  var_3 = scripts\asm\dlc4\dlc4_asm::gettunedata();
  if(distance2dsquared(self.origin, var_2) < distance2dsquared(self.origin, self.arenacenter)) {
    var_2 = self.arenacenter;
  }

  var_4 = vectortoangles(self.origin - var_2 * (1, 1, 0));
  var_5 = undefined;
  var_4 = (0 - var_3.throw_starting_pitch, var_4[1], var_4[2]);
  if(var_1 == "LEFT") {
    var_4 = (var_4[0], var_4[1] - var_3.throw_side_yaw, var_4[2]);
  } else if(var_1 == "RIGHT") {
    var_4 = (var_4[0], var_4[1] + var_3.throw_side_yaw, var_4[2]);
  }

  var_6 = scripts\common\trace::create_contents(1, 0, 0, 0, 1, 0, 0);
  var_7 = [];
  foreach(var_9 in scripts\mp\mp_agent::getactiveagentsofspecies("zombie")) {
    if(var_9.agent_type != "dlc4_boss") {
      var_7[var_7.size] = var_9;
    }
  }

  foreach(var_0C in level.players) {
    var_7[var_7.size] = var_0C;
  }

  while(var_4[0] > -40) {
    var_4 = (var_4[0] - var_3.throw_fidelity, var_4[1], var_4[2]);
    var_5 = anglesToForward(var_4) * var_3.throw_distance;
    if(scripts\common\trace::sphere_trace_passed(var_2 + var_5, var_2, var_3.throw_meteor_radius, var_7, var_6)) {
      break;
    }
  }

  var_0E = magicbullet(var_3.throw_weapon, var_2 + var_5, var_2, self);
  var_0E playLoopSound("cp_final_meph_asteroid_lp_01");
  level thread play_asteroid_tellsfx(var_2);
  var_0E waittill("death");
  playsoundatpos(var_0E.origin, "cp_final_meph_asteroid_explo");
  earthquake(0.55, 1, var_0E.origin, 1200);
  playrumbleonposition("artillery_rumble", var_0E.origin);
}

play_asteroid_tellsfx(var_0) {
  wait(2);
  playsoundatpos(var_0, "cp_final_meph_asteroid_incoming");
}

choosethrowanim(var_0, var_1, var_2) {
  var_3 = randomfloat(1);
  if(var_3 < 0.33) {
    return scripts\asm\asm::asm_lookupanimfromalias(var_1, "left");
  }

  if(var_3 < 0.66) {
    return scripts\asm\asm::asm_lookupanimfromalias(var_1, "right");
  }

  return scripts\asm\asm::asm_lookupanimfromalias(var_1, "both");
}

air_pound_rise_play(var_0, var_1, var_2, var_3) {
  createnavrepulsor("dlc4_boss_repulsor", -1, self.arenacenter, 150, 1);
  self.var_BE6F = createnavobstaclebybounds(self.arenacenter, (100, 100, 100), (0, 0, 0));
  self playSound("final_meph_intro");
  thread airpoundrisefx();
  lib_0F3C::func_CEA8(var_0, var_1, var_2, var_3);
}

air_pound_attack_note_handler(var_0, var_1, var_2, var_3) {
  if(var_0 == "hit") {
    var_4 = scripts\asm\dlc4\dlc4_asm::gettunedata();
    playFX(var_4.air_pound_pound_fx, self.arenacenter);
    earthquake(var_4.air_pound_pound_rumble_scale, var_4.air_pound_pound_rumble_duration, self.arenacenter, var_4.air_pound_pound_rumble_radius);
    playrumbleonposition("artillery_rumble", self.arenacenter);
    playsoundatpos(self.arenacenter, var_4.air_pound_pound_sfx);
    self radiusdamage(self.arenacenter, var_4.ss_groundpound_radius, var_4.ss_groundpound_max_damage, var_4.ss_groundpound_min_damage, self, "MOD_IMPACT");
  }
}

airpoundrisefx() {
  var_0 = scripts\asm\dlc4\dlc4_asm::gettunedata();
  playFX(var_0.air_pound_rise_fx, self.arenacenter);
  var_1 = gettime() + 4000;
  playsoundatpos(self.arenacenter, "zmb_ground_spawn_dirt");
  while(gettime() < var_1) {
    earthquake(var_0.air_pound_rise_rumble_scale, var_0.air_pound_rise_rumble_duration, self.arenacenter, var_0.air_pound_rise_rumble_radius);
    scripts\engine\utility::waitframe();
    playrumbleonposition("artillery_rumble", self.arenacenter);
    wait(0.2);
  }
}

playgroundvulidle(var_0, var_1, var_2, var_3) {
  self.groundvultimer = scripts\asm\dlc4\dlc4_asm::gettunedata().ground_vul_time;
  thread playgroundvulidlehelper(var_1);
  lib_0F3C::func_B050(var_0, var_1, var_2, var_3);
}

playgroundvulidlehelper(var_0) {
  self endon(var_0 + "_finished");
  while(self.groundvultimer > 0) {
    self.groundvultimer = self.groundvultimer - 50;
    wait(0.05);
  }
}

groundvulteleportintransition(var_0, var_1, var_2, var_3) {
  if(scripts\asm\asm::func_232B(var_1, "teleport_finished")) {
    self.teleportedin = 1;
  }

  return self.teleportedin && !self.claponarena;
}

playgroundvulland(var_0, var_1, var_2, var_3) {
  var_4 = scripts\asm\dlc4\dlc4_asm::gettunedata();
  createnavrepulsor("dlc4_boss_repulsor", -1, self.arenacenter, 150, 1);
  self.var_BE6F = createnavobstaclebybounds(self.arenacenter, (100, 100, 100), (0, 0, 0));
  if(level.fbd.bossstate == "LAST_STAND") {
    lib_0F3C::func_CEA8(var_0, var_1, var_2, var_3);
    self.cantakedamage = 1;
    return;
  }

  var_5 = scripts\mp\mp_agent::getactiveagentsoftype(var_4.summon_agent_type);
  var_6 = var_4.summon_max_total["" + level.players.size];
  var_7 = min(level.players.size * var_4.zombies_per_person, var_6 - var_5.size);
  for(var_8 = 0; var_8 < var_7; var_8++) {
    var_9 = 1 * var_8 * 360 / var_7;
    var_0A = self.arenacenter[0] + cos(var_9) * var_4.zombies_summon_radius;
    var_0B = self.arenacenter[1] + sin(var_9) * var_4.zombies_summon_radius;
    var_0C = (var_0A, var_0B, self.arenacenter[2]);
    spawnzombie("skeleton", var_0C);
  }

  lib_0F3C::func_CEA8(var_0, var_1, var_2, var_3);
}

playgroundvullaunch(var_0, var_1, var_2, var_3) {
  self.groundvultimer = undefined;
  scripts\cp\maps\cp_final\cp_final_final_boss::cleanupweakspot(level.fbd.activecircle);
  level notify("FINAL_BOSS_STAGE_FAILED");
  playanimandteleport(var_0, var_1, var_2, var_3);
}

groundvulidletransition(var_0, var_1, var_2, var_3) {
  if(!isDefined(self.groundvultimer) || self.groundvultimer > 0) {
    return 0;
  }

  return 1;
}

groundvulidleterminate(var_0, var_1, var_2) {
  self.vulnerable = 0;
}

groundvulhurttransition(var_0, var_1, var_2, var_3) {
  return isDefined(level.fbd.sectioncomplete) && level.fbd.sectioncomplete;
}

groundvuldeathtransition(var_0, var_1, var_2, var_3) {
  return isDefined(level.fbd.sectioncomplete) && level.fbd.sectioncomplete && level.fbd.victory;
}

choosegroundvulhurtanim(var_0, var_1, var_2) {
  if(level.fbd.bossstate == "FRENZIED") {
    return scripts\asm\asm::asm_lookupanimfromalias(var_1, "frenzied_hurt");
  }

  return scripts\asm\asm::asm_lookupanimfromalias(var_1, "ground_vul_hurt");
}

groundvullaunchnotehandler(var_0, var_1, var_2, var_3) {
  if(var_0 == "flames_on") {
    self setscriptablepartstate("flames", "on");
    self setscriptablepartstate("circle_" + level.fbd.activecircle.index, "off");
  }

  teleportnotehandler(var_0, var_1, var_2, var_3);
}

groundvulhurtnotehandler(var_0, var_1, var_2, var_3) {
  if(var_0 == "hit") {
    var_4 = scripts\asm\dlc4\dlc4_asm::gettunedata();
    playFX(var_4.air_pound_pound_fx, self.arenacenter);
    earthquake(var_4.air_pound_pound_rumble_scale, var_4.air_pound_pound_rumble_duration, self.arenacenter, var_4.air_pound_pound_rumble_radius);
    playrumbleonposition("artillery_rumble", self.arenacenter);
    playsoundatpos(self.arenacenter, var_4.air_pound_pound_sfx);
    self radiusdamage(self.origin, var_4.ground_pound_radius, var_4.ground_pound_max_damage, var_4.ground_pound_min_damage, self, "MOD_IMPACT");
    var_5 = scripts\mp\mp_agent::getactiveagentsofspecies("zombie");
    foreach(var_7 in var_5) {
      if(var_7.agent_type != "dlc4_boss") {
        var_7 dodamage(var_7.health * 10, self.arenacenter);
      }
    }
  } else if(var_0 == "flames_on") {
    self setscriptablepartstate("flames", "on");
  }

  teleportnotehandler(var_0, var_1, var_2, var_3);
}

loopdropmovedown(var_0, var_1, var_2, var_3) {
  self.dropdowntimer = scripts\asm\dlc4\dlc4_asm::gettunedata().drop_down_time;
  thread playdropmovedownhelper(var_1);
  lib_0F3C::func_B050(var_0, var_1, var_2, var_3);
}

playdropmovedownhelper(var_0) {
  self endon(var_0 + "_finished");
  while(self.dropdowntimer > 0) {
    self.dropdowntimer = self.dropdowntimer - 50;
    wait(0.05);
  }

  thread doteleporttodesirednode(var_0, 1);
}

dropmovedowntransition(var_0, var_1, var_2, var_3) {
  if(!isDefined(self.dropdowntimer) || self.dropdowntimer > 0) {
    return 0;
  }

  self playSound("final_meph_ground_swipe");
  self setscriptablepartstate("flame_trail", "off");
  self.dropdowntimer = undefined;
  return 1;
}

dropmoveuptransition(var_0, var_1, var_2, var_3) {
  var_4 = self._blackboard.nodes[self._blackboard.var_4BF7].origin;
  var_5 = self._blackboard.dropmovearrivaldist * self._blackboard.dropmovearrivaldist;
  return distancesquared(self.origin, var_4) <= var_5;
}

playflyoverexit(var_0, var_1, var_2, var_3) {
  self scragentsetanimscale(scripts\asm\dlc4\dlc4_asm::gettunedata().fly_over_speed, 1);
  scripts\asm\asm_mp::func_2364(var_0, var_1, var_2, var_3);
}

flyoverlooptransition(var_0, var_1, var_2, var_3) {
  var_4 = self._blackboard;
  var_5 = var_4.nodes[var_4.desirednode].origin;
  var_6 = distance2dsquared(var_5, self.origin);
  var_7 = var_4.flyoverarrivaldist * var_4.flyoverarrivaldist;
  if(var_6 <= var_7) {
    self._blackboard.flyoverarrivaldist = undefined;
    return 1;
  }

  return 0;
}

terminateflyoverarrival(var_0, var_1, var_2) {
  self scragentsetanimscale(1, 1);
}

flyoverloopnotehandler(var_0, var_1, var_2, var_3) {}

black_hole_start_note_handler(var_0, var_1, var_2, var_3) {
  if(var_0 == "start_blackhole") {
    thread createmephblackhole();
  }
}

playblackholeloop(var_0, var_1, var_2, var_3) {
  self.blackholetimer = scripts\asm\dlc4\dlc4_asm::gettunedata().black_hole_duration;
  thread playblackholeloophelper(var_1);
  lib_0F3C::func_B050(var_0, var_1, var_2, var_3);
}

playblackholeloophelper(var_0) {
  self endon(var_0 + "_finished");
  while(self.blackholetimer > 0) {
    self.blackholetimer = self.blackholetimer - 50;
    wait(0.05);
  }
}

blackholelooptransition(var_0, var_1, var_2, var_3) {
  if(!isDefined(self.blackholetimer) || self.blackholetimer > 0) {
    return 0;
  }

  return 1;
}

black_hole_end_note_handler(var_0, var_1, var_2, var_3) {
  if(var_0 == "blackhole_end") {
    self notify("stop_blackhole");
  }
}

eclipse_note_handler(var_0, var_1, var_2, var_3) {
  if(var_0 == "start_eclipse") {
    thread create_eclipse();
    return;
  }

  if(var_0 == "start_wave") {
    thread doeclipsespecialwave();
    thread eclipsespecialwavetimer();
  }
}

doeclipsespecialwave() {
  self endon("death");
  level endon("ECLIPSE_SPAWN_COMPLETE");
  var_0 = scripts\asm\dlc4\dlc4_asm::gettunedata();
  self.eclipseactive = 1;
  var_1 = self.unlockedactions.size;
  var_2 = var_0.base_spawn_interval;
  var_3 = var_0.specialwavesdata["BASIC_" + var_1];
  var_4 = var_0.specialwavesdata["PHANTOM_" + var_1];
  var_5 = var_3 + var_4;
  var_6 = [];
  for(var_7 = 0; var_7 < var_3; var_7++) {
    if(randomfloat(1) > 0.5) {
      var_6[var_6.size] = "generic_zombie";
      continue;
    }

    var_6[var_6.size] = "alien_goon";
  }

  for(var_7 = 0; var_7 < var_4; var_7++) {
    var_6[var_6.size] = "alien_phantom";
  }

  var_6 = scripts\engine\utility::array_randomize(var_6);
  for(var_7 = 0; var_7 < var_5; var_7++) {
    while(scripts\mp\mp_agent::getactiveagentsoftype("all").size >= 24) {
      scripts\engine\utility::waitframe();
    }

    scripts\aitypes\dlc4_boss\behaviors::computespawnpoints(1, scripts\mp\mp_agent::getactiveagentsofspecies("zombie"));
    if(isDefined(var_0.spawnpoints[0])) {
      spawnzombie(var_6[var_7], var_0.spawnpoints[0]);
    }

    wait(var_2);
    var_2 = var_2 * var_0.spawn_interval_decay;
  }

  var_8 = var_0.specialwavesdata["SPECIAL_" + var_1];
  while(scripts\mp\mp_agent::getactiveagentsofspecies("zombie").size + var_8.size > 24) {
    wait(1);
  }

  scripts\aitypes\dlc4_boss\behaviors::computespawnpoints(var_8.size, scripts\mp\mp_agent::getactiveagentsofspecies("zombie"));
  for(var_7 = 0; var_7 < var_8.size; var_7++) {
    if(isDefined(var_0.spawnpoints[var_7])) {
      spawnzombie(var_8[var_7], var_0.spawnpoints[var_7]);
    }
  }

  while(scripts\mp\mp_agent::getactiveagentsofspecies("zombie").size > 1) {
    wait(1);
  }

  wait(1);
  level notify("ECLIPSE_SPAWN_COMPLETE");
}

eclipsespecialwavetimer() {
  level endon("ECLIPSE_SPAWN_COMPLETE");
  var_0 = gettime();
  var_1 = scripts\asm\dlc4\dlc4_asm::gettunedata().eclipse_duration;
  while(gettime() < var_0 + var_1) {
    wait(1);
  }

  level notify("ECLIPSE_SPAWN_COMPLETE");
}

create_eclipse() {
  var_0 = getent("eclipse_blocker", "targetname");
  if(!isDefined(var_0.og_origin)) {
    var_0.og_origin = var_0.origin;
  }

  var_1 = spawnfx(level._effect["vfx_boss_sun_blocker"], (-17910.3, 966.038, 5116), anglesToForward((43.4021, 347.643, -7.50797)), anglestoup((43.4021, 347.643, -7.50797)));
  triggerfx(var_1);
  playsoundatpos((-17910.3, 966.038, 5116), "cp_final_meph_eclipse_rock_forming");
  wait(1);
  var_0 moveto((-17391.3, 400, 3900), 1.25);
  level.current_vision_set = "cp_final_meph_eclipse";
  visionsetnaked("cp_final_meph_eclipse", 1);
  level waittill("ECLIPSE_SPAWN_COMPLETE");
  var_2 = spawnfx(level._effect["vfx_sun_blocker_end"], (-17910.3, 966.038, 5116), anglesToForward((43.4021, 347.643, -7.50797)), anglestoup((43.4021, 347.643, -7.50797)));
  triggerfx(var_2);
  var_1 delete();
  visionsetnaked("cp_final_meph", 1);
  level.current_vision_set = "cp_final_meph";
  var_0 moveto(var_0.og_origin, 1.25);
  thread createarmageddon();
}

createarmageddon() {
  var_0 = scripts\asm\dlc4\dlc4_asm::gettunedata();
  var_1 = var_0.safe_zone_radius * var_0.safe_zone_radius;
  wait(0.5);
  var_2 = gettime() + var_0.armageddon_duration;
  var_3 = self.unlockedactions.size;
  var_4 = pow(var_0.meteor_period_stage_decay, var_3);
  var_5 = var_0.meteor_min_period * var_4;
  var_6 = var_0.meteor_max_period * var_4;
  while(gettime() < var_2) {
    var_7 = sqrt(randomfloat(1)) * var_0.meteor_target_radius;
    var_8 = randomfloat(360);
    var_9 = self.arenacenter[0] + var_7 * cos(var_8);
    var_0A = self.arenacenter[1] + var_7 * sin(var_8);
    var_0B = (var_9, var_0A, self.arenacenter[2]);
    var_0C = distance2dsquared(var_0B, (-13165, 74, -46));
    var_0D = distance2dsquared(var_0B, (-13263, -767, -46));
    if(var_0C > var_1 && var_0D > var_1) {
      magicbullet("iw7_dlc4eclipse_mp", (-17910.3, 966.038, 5116), var_0B);
    }

    wait(randomfloatrange(var_5, var_6));
  }

  foreach(var_0F in scripts\mp\mp_agent::getactiveagentsofspecies("zombie")) {
    if(var_0F.agent_type != "dlc4_boss") {
      var_0F dodamage(var_0F.health * 10, self.arenacenter);
    }
  }

  wait(5);
  self.eclipseactive = 0;
}

shouldgointolaststand(var_0, var_1, var_2, var_3) {
  return level.fbd.bossstate == "LAST_STAND" && scripts\asm\dlc4\dlc4_asm::isanimdone(var_0, var_1, var_2, var_3);
}

shouldplaydeath(var_0, var_1, var_2, var_3) {
  return level.fbd.victory && scripts\asm\dlc4\dlc4_asm::isanimdone(var_0, var_1, var_2, var_3);
}

death_note_handler(var_0, var_1, var_2, var_3) {
  if(var_0 == "fadeout") {
    level thread meph_victory();
  }
}

death_ground_idle_note_handler(var_0, var_1, var_2, var_3) {
  if(var_0 == "idle_pain") {
    self playSound("final_meph_pain_teleport");
  }
}

meph_victory() {
  scripts\cp\maps\cp_final\cp_final::disablepas();
  scripts\cp\cp_vo::set_vo_system_busy(1);
  foreach(var_1 in level.players) {
    scripts\cp\maps\cp_final\cp_final_vo::clear_up_all_vo(var_1);
    var_1 func_82C0("bink_fadeout_amb", 0.66);
  }

  level notify("FINAL_BOSS_VICTORY");
  if(scripts\cp\zombies\direct_boss_fight::should_directly_go_to_boss_fight()) {
    foreach(var_1 in level.players) {
      var_1 thread scripts\cp\utility::player_black_screen(0.25, 20, 0.25, 0, 1);
    }

    level thread scripts\cp\zombies\direct_boss_fight::success_sequence(undefined, 6);
    return;
  }

  foreach(var_3 in level.players) {
    var_3 thread scripts\cp\utility::player_black_screen(0.25, 1, 0.25, 0, 1);
    var_3 scripts\cp\cp_merits::processmerit("mt_dlc4_troll2");
    var_3 setplayerdata("cp", "meritState", "mt_dc_camo", 1);
  }

  setomnvar("zm_boss_splash", 7);
  wait(0.55);
  scripts\cp\utility::play_bink_video("sysload_o3", 32, 0);
  wait(33);
  foreach(var_3 in level.players) {
    var_3 clearclienttriggeraudiozone(0.3);
  }

  level thread[[level.endgame]]("axis", level.end_game_string_index["win"]);
}

smallpain() {
  self.soulhealth = self.soulhealth - 1;
  if(self.soulhealth == 0) {
    self.soulhealth = 999;
    if(self.interruptable) {
      self notify("pain");
      self._blackboard.painnotifytime = 100;
      scripts\aitypes\dlc4_boss\behaviors::setnextaction("ground_vul");
      level notify(scripts\asm\dlc4\dlc4_asm::gettunedata().soul_health_depleted_notify);
      self notify("stop_blackhole");
      self.blackholetimer = undefined;
      return;
    }

    self.soulhealth = 1;
  }
}

shouldterminateaction() {
  if(isDefined(self.terminateaction) && self.terminateaction) {
    self.terminateaction = 0;
    return 1;
  }

  return 0;
}

choosepainmovinganim(var_0, var_1, var_2) {
  var_3 = self._blackboard.currentmovedirindex;
  return scripts\asm\asm::asm_lookupanimfromalias(var_1, var_3);
}

painterminate(var_0, var_1, var_2) {}

playpain(var_0, var_1, var_2, var_3) {
  self.terminateaction = 1;
  self.vulnerable = 1;
  lib_0F3C::func_CEA8(var_0, var_1, var_2, var_3);
}

playmovingpain(var_0, var_1, var_2, var_3) {
  self.terminateaction = 1;
  self.vulnerable = 1;
  playmoveexit(var_0, var_1, var_2, var_3);
}

playlaststandloop(var_0, var_1, var_2, var_3) {
  level.laststandfx = spawnfx(level._effect["soul_bomb"], self.arenacenter + (0, 0, 450));
  triggerfx(level.laststandfx);
  playsoundatpos(self.arenacenter + (0, 0, 450), "cp_final_meph_final_soul_bomb_start");
  level.dlc4_boss playLoopSound("cp_final_meph_final_soul_bomb_lp");
  thread laststandmonitor();
  lib_0F3C::func_B050(var_0, var_1, var_2, var_3);
}

laststandmonitor() {
  self endon("death");
  level endon("FINAL_BOSS_VICTORY");
  if(!isDefined(level.laststand_vo)) {
    level.laststand_vo = 1;
    level thread scripts\cp\maps\cp_final\cp_final_final_boss::play_meph_vo(level.dlc4_boss scripts\cp\utility::get_closest_living_player(), "nag_meph_damage", 1);
  }

  var_0 = scripts\asm\dlc4\dlc4_asm::gettunedata().last_stand_time;
  for(var_1 = scripts\asm\dlc4\dlc4_asm::gettunedata().last_stand_victory_min_time; var_0 > 0; var_1 = var_1 - 50) {
    scripts\engine\utility::waitframe();
    if(var_1 <= 0) {
      if(self.laststandhealth <= 0 && !level.fbd.victory) {
        scripts\cp\maps\cp_final\cp_final_final_boss::victory();
        return;
      }
    }

    var_0 = var_0 - 50;
  }

  self stoploopsound();
  self playSound("cp_final_meph_nuke");
  wait(1);
  playFX(level._effect["soul_bomb_exp"], self.arenacenter + (0, 0, 450));
  level.laststandfx delete();
  self.frenziedhealth = 999999;
  scripts\cp\maps\cp_final\cp_final::disablepas();
  level thread[[level.endgame]]("axis", level.end_game_string_index["kia"]);
}

fightending(var_0, var_1, var_2) {}

playanimandteleport(var_0, var_1, var_2, var_3) {
  thread teleportwhenanimdone(var_1, var_3);
  lib_0F3C::func_CEA8(var_0, var_1, var_2, var_3);
}

teleportnotehandler(var_0, var_1, var_2, var_3) {
  if(var_0 == "teleport_start") {
    self playSound("cp_final_teleport_build_and_out_lr");
    var_4 = self gettagorigin("tag_origin");
    var_5 = self gettagangles("tag_origin");
    playFX(level._effect["boss_teleport_start"], var_4, anglesToForward(var_5), (0, 0, 1));
    var_4 = self gettagorigin("tag_fx_clavicle_4_ri");
    var_5 = self gettagangles("tag_fx_clavicle_4_ri");
    playFX(level._effect["boss_teleport_start_left"], var_4, anglesToForward(var_5), (0, 0, 1));
    destroynavrepulsor("dlc4_boss_repulsor");
    if(isDefined(self.var_BE6F)) {
      destroynavobstacle(self.var_BE6F);
    }
  }
}

teleportendnotehandler(var_0, var_1, var_2, var_3) {
  if(var_0 == "teleport_end") {
    self playSound("cp_final_teleport_in_lr");
    var_4 = self gettagorigin("tag_origin");
    var_5 = self gettagangles("tag_origin");
    playFX(level._effect["boss_teleport_end"], var_4, anglesToForward(var_5), (0, 0, 1));
    var_4 = self gettagorigin("tag_fx_clavicle_4_ri");
    var_5 = self gettagangles("tag_fx_clavicle_4_ri");
    playFX(level._effect["boss_teleport_end_left"], var_4, anglesToForward(var_5), (0, 0, 1));
  }
}

teleportwhenanimdone(var_0, var_1) {
  self endon(var_0 + "_finished");
  for(;;) {
    if(scripts\asm\asm::func_232B(var_0, "end")) {
      if(var_1 == "center") {
        thread doteleporttocenter(var_0);
      } else {
        thread doteleporttodesirednode(var_0);
      }

      return;
    }

    wait(0.05);
  }
}

checkteleportdone(var_0, var_1, var_2, var_3) {
  var_4 = scripts\asm\asm::func_232B(var_1, "teleport_finished");
  return var_4;
}

doteleporttocenter(var_0) {
  self setethereal(1);
  wait(0.5);
  while(isDefined(self.doinggroundvul) && self.doinggroundvul && isDefined(self.claponarena) && self.claponarena) {
    scripts\engine\utility::waitframe();
  }

  func_11663(self.arenacenter);
  thread showlater();
  scripts\asm\asm::asm_fireevent(var_0, "teleport_finished");
}

doteleporttodesirednode(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  self setethereal(1);
  wait(0.5);
  teleporttodesirednode(var_1);
  facearenacenter();
  thread showlater();
  scripts\asm\asm::asm_fireevent(var_0, "teleport_finished");
}

teleporttodesirednode(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  var_1 = self._blackboard.nodes[self._blackboard.desirednode].origin;
  if(var_0) {
    var_1 = (var_1[0], var_1[1], self.origin[2]);
  }

  func_11663(var_1);
  self._blackboard.var_4BF7 = self._blackboard.desirednode;
}

func_11663(var_0) {
  self setorigin(var_0 - (0, 0, 1), 0);
  self._blackboard.var_4BF7 = self._blackboard.desirednode;
}

facearenacenter() {
  faceposition(self.arenacenter);
}

facedesirednode() {
  faceposition(self._blackboard.nodes[self._blackboard.desirednode].origin);
}

faceposition(var_0) {
  var_1 = var_0 - self.origin * (1, 1, 0);
  var_2 = vectortoangles(var_1);
  self orientmode("face angle abs", var_2);
}

showlater() {
  wait(0.5);
  self setethereal(0);
  if(level.fbd.bossstate == "LAST_STAND") {
    self.cantakedamage = 1;
  }
}

createmephblackhole() {
  var_0 = self.arenacenter + (0, 0, 85);
  if(!isDefined(level.blackhole_scriptable)) {
    level.blackhole_physics_vol = physics_volumecreate(var_0, 500);
    level.blackhole_physics_vol physics_volumesetasfocalforce(1, var_0, 500);
    level.blackhole_scriptable = spawn("script_model", var_0);
    level.blackhole_scriptable setModel("tag_origin_demon_blackhole");
  }

  var_1 = spawnimpulsefield(self, "demon_blackhole_zm", var_0);
  level.blackhole_physics_vol physics_volumeenable(1);
  level.blackhole_physics_vol physics_volumesetactivator(1);
  level.blackhole_scriptable setscriptablepartstate("vortexEnd", "neutral");
  level.blackhole_scriptable setscriptablepartstate("vortexUpdate", "active_cp", 0);
  level thread mephbhquake(var_0, self);
  self waittill("stop_blackhole");
  var_1 delete();
  level.blackhole_scriptable setscriptablepartstate("vortexStart", "neutral", 0);
  level.blackhole_scriptable setscriptablepartstate("vortexUpdate", "neutral", 0);
  level.blackhole_scriptable setscriptablepartstate("vortexEnd", "active", 0);
  level.blackhole_physics_vol physics_volumeenable(0);
  level.blackhole_physics_vol physics_volumesetactivator(0);
  wait(2);
  level.blackhole_scriptable setscriptablepartstate("vortexEnd", "neutral", 0);
}

mephbhquake(var_0, var_1) {
  var_1 endon("stop_blackhole");
  for(;;) {
    earthquake(0.3, 2, var_0, 500);
    playrumbleonposition("grenade_rumble", var_0);
    wait(0.25);
    foreach(var_3 in level.players) {
      if(!var_3 scripts\cp\utility::is_valid_player()) {
        continue;
      }

      if(distance2d(var_3.origin, var_0) <= 100) {
        var_3 dodamage(var_3.health + 100, var_0, var_1, var_1, "MOD_EXPLOSIVE");
        continue;
      }

      if(distance2d(var_3.origin, var_0) < 250) {
        var_3 shellshock("default_nosound", 0.5);
      }
    }
  }
}

spawnzombie(var_0, var_1) {
  var_2 = scripts\asm\dlc4\dlc4_asm::gettunedata();
  var_3 = spawnStruct();
  var_3.origin = var_1;
  var_3.angles = vectortoangles(self.arenacenter - var_3.origin);
  if(var_0 == "skeleton" || var_0 == "generic_zombie") {
    var_3.script_parameters = "ground_spawn_no_boards";
    var_3.script_animation = "spawn_ground";
    var_3.script_fxid = "dirt";
  } else if(var_0 == "alien_goon") {
    scripts\cp\zombies\cp_final_spawning::func_1B99(var_3);
  } else if(var_0 == "alien_phantom") {
    scripts\cp\zombies\cp_final_spawning::func_3115(var_3);
  } else if(var_0 == "alien_rhino" || var_0 == "zombie_clown" || var_0 == "karatemaster" || var_0 == "slasher") {
    scripts\cp\zombies\cp_final_spawning::func_3115(var_3);
  }

  var_4 = var_3 scripts\cp\zombies\zombies_spawning::spawn_wave_enemy(var_0, 1);
  if(!isDefined(var_4)) {
    return;
  }

  var_4.entered_playspace = 1;
  var_4.dont_cleanup = 1;
  var_4.dont_scriptkill = 1;
  if(var_0 == "skeleton" || var_0 == "generic_zombie") {
    var_4.maxhealth = var_2.skeleton_health;
    var_4.health = var_2.skeleton_health;
    var_4 thread setup_summoned_zombie(var_0);
  }

  if(var_0 == "alien_goon" || var_0 == "alien_phantom" || var_0 == "alien_rhino") {
    var_4 getrandomhovernodesaroundtargetpos(1, 1);
    if(var_0 == "alien_goon") {
      var_4.maxhealth = int(var_2.skeleton_health / 2);
      var_4.health = int(var_2.skeleton_health / 2);
    }
  }

  if(var_0 == "slasher") {
    level.slasher_level = 0;
    var_4.allowpain = 0;
  }

  if(var_0 == "zombie_clown" || var_0 == "karatemaster") {
    var_4.maxhealth = 3200;
    var_4.health = 3200;
  }
}

getspecialenemy() {
  if(randomfloat(1) > scripts\asm\dlc4\dlc4_asm::gettunedata().chance_to_target_charger) {
    var_0 = level.fbd.playerschargingcircle.size;
    if(var_0 > 0) {
      var_1 = level.fbd.playerschargingcircle[randomint(var_0)];
      self.myenemy = var_1;
    }
  }

  return scripts\asm\dlc4\dlc4_asm::getenemy();
}