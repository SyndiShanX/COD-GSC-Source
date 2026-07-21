/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: asm\seeker\melee.gsc
***********************************************/

seeker_getplayerriganims() {
  var_0 = [];
  return var_0;
}

seeker_evaluatesyncedmelee(var_0, var_1, var_2, var_3) {
  var_4 = self.melee.target;

  if(isPlayer(var_4))
    return 0;

  self.melee.winner = 1;
  var_4.melee.winner = 0;
  [self.melee.direction, self.melee.offset] = seeker_pickattachdirection(self, self.melee.target);
  var_4.melee.direction = self.melee.direction;
  var_6 = chooseanimmelee_seekerjump(var_0, var_2, self.melee.direction);
  var_7 = vectortoyaw(self.origin - self.melee.target.origin);
  var_8 = (0, self.melee.offset + var_7, 0);
  self.melee.startangles = self.angles;
  var_4.melee.startangles = var_8;
  var_4.ignoreme = 1;
  self.ignoreme = 1;
  self notify("meleegrab_start");
  self.bt.target_locked = 1;
  return 1;
}

seeker_pickattachdirection(var_0, var_1) {
  var_2 = var_1.angles;
  var_3 = var_1.origin;
  var_4 = var_0.origin;
  var_5 = vectortoangles(var_4 - var_3);
  var_6 = angleclamp(var_2[1] - var_5[1]);

  if(var_6 > 315 || var_6 < 45)
    return ["front", 0];
  else if(var_6 < 135)
    return ["right", 90];
  else if(var_6 > 225)
    return ["left", -90];
  else
    return ["back", 180];
}

chooseanimmelee_seekerjump(var_0, var_1, var_2) {
  return scripts\asm\asm::asm_lookupanimfromalias(var_1, "jump_" + var_2);
}

chooseanimmelee_seekerloop(var_0, var_1, var_2) {
  return scripts\asm\asm::asm_lookupanimfromalias(var_1, "loop_" + var_2);
}

seekermeleedetonate() {
  var_0 = 0.7071;

  for(;;) {
    wait 0.05;

    if(scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), self.origin, var_0)) {
      self notify("on_screen");
      return;
    }
  }
}

setseekerattached() {
  self.attached = 1;
}

valid_reaction_sound(var_0) {
  switch (var_0) {
    case "w2":
    case "w1":
    case "w0":
    case "5":
    case "4":
    case "3":
    case "omr":
    case "slt":
    case "2":
    case "0":
    case "1":
      return 1;
  }

  return 0;
}

playmeleeanim_seekerattack(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  self.melee.bstarted = 1;
  var_3 = self.melee.target;
  var_4 = chooseanimmelee_seekerjump(var_0, var_1, self.melee.direction);
  scripts\asm\asm::asm_fireephemeralevent("melee_attack", "begin");
  scripts\asm\soldier\melee::melee_synced_setup(var_1, 1);

  if(!isDefined(var_3.seenatseeker)) {
    var_3.seenatseeker = 1;

    if(isDefined(var_3.battlechatter.countryid) && isDefined(var_3.battlechatter.npcid) && (var_3.battlechatter.countryid == "UN" || var_3.battlechatter.countryid == "SD")) {
      if(valid_reaction_sound(var_3.battlechatter.npcid) && !isDefined(level.in_vr)) {
        var_5 = var_3.battlechatter.countryid + "_" + var_3.battlechatter.npcid + "_reaction_seeker_attack";
        var_3 playSound(var_5);
      }
    }
  }

  var_3 scripts\asm\asm::asm_setstate(var_1 + "_victim");
  createnavrepulsor("ent_" + self getentitynumber() + "_seeker_repulsor", -1, self, 250, 1, self.bt.enemy_team);
  self animmode("zonly_physics");
  self linktoblendtotag(self.melee.target, "tag_sync", 0, 0);
  self clearanim(scripts\asm\asm::asm_getbodyknob(), 0);
  self setflaggedanimrestart(var_1, var_4, 1, 0, 1);
  scripts\engine\utility::delaythread(0.25, ::setseekerattached);
  var_6 = scripts\asm\asm::asm_donotetracks(var_0, var_1, scripts\asm\soldier\melee::melee_handlenotetracks);
  var_7 = chooseanimmelee_seekerloop(var_0, var_1, self.melee.direction);
  self aisetanim(var_1, var_7);
  childthread seekermeleedetonate();
  scripts\engine\utility::waittill_notify_or_timeout("on_screen", 1.5);
  wait 0.4;
  playworldsound("seeker_expl_beep", self.origin);
  wait 0.6;
  destroynavrepulsor("ent_" + self getentitynumber() + "_seeker_repulsor");
  self.is_detonated = 1;
}

playmeleeanim_seekerattack_cleanup(var_0, var_1, var_2) {
  destroynavrepulsor("ent_" + self getentitynumber() + "_seeker_repulsor");

  if(isDefined(self.melee.target)) {
    if(isDefined(self.melee.target.melee))
      self.melee.target.melee.babort = 1;

    self.melee.target.ignoreme = 0;
  }
}

seeker_meleegrabplayer(var_0, var_1, var_2) {
  level.player.damageshield = 1;
  self.disableattack = 1;
  self.ignoreme = 1;
  scripts\engine\sp\utility::hudoutline_disable("default_seeker");
  scripts\asm\shared\sp\utility::meleegrab_common();
  scripts\asm\asm::asm_fireephemeralevent("melee_attack", "begin");
  thread seeker_playerrig_meleegrabplayer();
  scripts\asm\asm::asm_playanimstate(var_0, var_1);
}

seeker_playerrig_meleegrabplayer() {
  if(isDefined(self.forcemeleeyaw))
    var_0 = (0, self.forcemeleeyaw, 0);
  else {
    var_0 = vectortoangles(self.origin - level.player.origin);
    var_0 = (0, var_0[1], 0);
  }

  var_1 = scripts\asm\shared\sp\utility::spawnplayerrig();
  var_1.angles = var_0;
  self notify("jumped_on_player");
  playworldsound("seeker_expl_beep", self.origin);
  level.player.melee.partner = self;
  level.player.melee.rig = var_1;
  var_2 = seeker_getplayerriganims();
  var_3 = "meleeAnim";
  var_1 setflaggedanimknoballrestart(var_3, var_2["seekerMeleeGrab"], var_1.root, 1, 0.0, 1);
  thread seeker_playerrig_link(var_1);
  var_4 = getanimlength(var_2["seekerMeleeGrab"]);
  thread seeker_meleegrab_counterinput(1.25, 0.75);
  var_1 thread scripts\common\notetrack::start_notetrack_wait(var_1, var_3);
  var_1 scripts\anim\notetracks.gsc::donotetracks(var_3);
}

seeker_meleegrab_counterinput(var_0, var_1) {
  level.player notifyonplayercommand("bash_pressed", "+usereload");
  level.player notifyonplayercommand("bash_pressed", "+activate");
  scripts\engine\utility::waittill_notify_or_timeout_return("death", var_0);

  if(!isDefined(level.player.melee)) {
    return;
  }
  scripts\sp\player\cursor_hint::create_cursor_hint("j_body", undefined, undefined, undefined, 1000, 1000, 1, 1);
  var_2 = seeker_meleegrab_bash(var_1);

  if(!isDefined(level.player) || !isDefined(level.player.melee)) {
    return;
  }
  level.player.melee.countersuccess = var_2;
  scripts\sp\player\cursor_hint::remove_cursor_hint();
}

seeker_meleegrab_bash(var_0) {
  self endon("meleegrab_interupt");
  var_0 = var_0 * 1000;
  var_1 = 1.0;
  var_2 = 0.4;
  var_3 = var_1;
  var_4 = undefined;

  for(;;) {
    var_5 = level.player scripts\engine\utility::waittill_notify_or_timeout_return("bash_pressed", var_3);

    if(isDefined(var_5) && var_5 == "timeout") {
      break;
    }

    if(!isDefined(var_4))
      var_4 = gettime();

    if(gettime() - var_4 > var_0)
      return 1;

    var_3 = var_2;
  }

  return 0;
}

seeker_meleegrab_rumble() {
  self endon("meleegrab_interupt");

  for(;;) {
    level.player playRumbleOnEntity("damage_light");
    earthquake(0.15, 0.1, level.player.origin, 5000);
    wait 0.05;
  }
}

seeker_meleegrab_hint() {
  var_0 = spawn("script_model", self.origin);
  var_0 linkTo(self, "j_hip_le", (0, 0, 0), (0, 0, 0));
  var_0 scripts\sp\player\cursor_hint::create_cursor_hint(undefined, undefined, "", undefined, undefined, undefined, 1, 1);
  self waittill("meleegrab_interupt");
  var_0 scripts\sp\player\cursor_hint::remove_cursor_hint();
}

seeker_meleegrab_counterhint(var_0) {
  level.player endon("meleegrab_interupt");
  var_1 = 0.2;
  var_2 = 0.3;
  wait(var_0 - var_1 - 0.05);

  if(isDefined(self.melee.meleecounterhint))
    self.melee.meleecounterhint destroy();

  self.melee.meleecounterhint = newclienthudelem(level.player);
  self.melee.meleecounterhint.color = (1, 1, 1);
  self.melee.meleecounterhint settext(&"SCRIPT_PLATFORM/HINT_MELEE_TAP");
  self.melee.meleecounterhint.x = 0;
  self.melee.meleecounterhint.y = 20;
  self.melee.meleecounterhint.alignx = "center";
  self.melee.meleecounterhint.aligny = "middle";
  self.melee.meleecounterhint.horzalign = "center";
  self.melee.meleecounterhint.vertalign = "middle";
  self.melee.meleecounterhint.foreground = 1;
  self.melee.meleecounterhint.alpha = 0;
  self.melee.meleecounterhint.fontscale = 0.5;
  self.melee.meleecounterhint.hidewhendead = 1;
  self.melee.meleecounterhint.sort = -1;
  self.melee.meleecounterhint endon("death");
  self.melee.meleecounterhint fadeovertime(var_1);
  self.melee.meleecounterhint changefontscaleovertime(var_1);
  self.melee.meleecounterhint.fontscale = 1.3;
  self.melee.meleecounterhint.alpha = 1;
  wait(var_1);

  if(!isDefined(self.melee.meleecounterhint)) {
    return;
  }
  self.melee.meleecounterhint fadeovertime(var_2);
  self.melee.meleecounterhint changefontscaleovertime(var_2);
  self.melee.meleecounterhint.fontscale = 1.2;
}

seeker_playerrig_link(var_0) {
  var_1 = 0.3;
  var_0 thread seeker_meleegrab_interrupt(self);
  level.player playerlinktoblend(var_0, "tag_player", var_1, 0, var_1);
  level.player viewkick(5, self.origin);
  scripts\asm\shared\sp\utility::playergrabbed("seeker");
  self linktoblendtotag(var_0, "tag_sync", 0, 0);
  wait(var_1);

  if(!isalive(self)) {
    return;
  }
  level.player hidelegsandshadow();
  thread scripts\asm\shared\sp\utility::delayenabledof(0.5, 2, 20, 10, 5, 60, 10, 0.1);
  thread scripts\asm\shared\sp\utility::delayenabledof(1, 2, 20, 4, 50, 90, 10, 0.1);
  thread scripts\asm\shared\sp\utility::delaymodifybasefov(1, 50, 0.4);
  var_0 show();
  level.player thread scripts\asm\shared\sp\utility::playerhealth();
  level.player playerlinktodelta(var_0, "tag_player", 1, 0, 0, 0, 0, 1);
  level.player lerpviewangleclamp(0.4, 0, 0, 15, 20, 30, 0);
  thread seeker_playergrabbed_screenshake();
}

seeker_playergrabbed_screenshake() {
  wait 0.1;
  var_0 = level.player.origin + anglesToForward(level.player.angles) * -100;
  screenshake(var_0, 10, 2, 1, 0.4, 0.2, 0.2, 700, 0.2, 1, 1);
  wait 0.5;
  var_0 = level.player.origin + anglesToForward(level.player.angles) * 100;
  screenshake(var_0, 10, 2, 1, 0.6, 0.3, 0.3, 700, 0.2, 1, 1);
}

seeker_meleegrab_notetracks(var_0) {
  switch (var_0) {
    case "unlink":
      self unlink();
      break;
    case "disable_weapons":
      level.player disableweapons();
      level.player viewkick(10, self.origin);
      break;
  }
}

seeker_meleegrab_interrupt(var_0) {
  self endon("death");
  level.player endon("bt_stop_meleegrab");

  while(!seeker_meleegrab_checkinterrupt(var_0))
    wait 0.05;

  level.player notify("meleegrab_interupt");

  if(isDefined(level.player.melee) && isDefined(level.player.melee.meleecounterhint))
    level.player.melee.meleecounterhint destroy();

  thread scripts\asm\shared\sp\utility::delaydisabledof(0.2);
  thread scripts\asm\shared\sp\utility::delaymodifybasefov(0.25, 65, 0.4);
  scripts\asm\shared\sp\utility::playerletgo();
  level.player.damageshield = 0;
  level.player.ignoreme = 0;
  level.player setCanDamage(1);
  level.player unlink();
  self delete();
}

seeker_meleegrab_checkinterrupt(var_0) {
  if(!isalive(var_0))
    return 1;

  if(isDefined(var_0.antigravtag))
    return 1;

  return 0;
}

seeker_meleegrabplayercounter(var_0, var_1, var_2) {
  var_3 = seeker_getplayerriganims();
  var_4 = var_3["seekerMeleeGrab_win"];
  var_5 = level.player.melee.rig;
  thread scripts\asm\shared\sp\utility::delaydisabledof(0.2);
  thread scripts\asm\shared\sp\utility::delaymodifybasefov(0.2, 65, 0.4);
  var_5 setflaggedanimknoballrestart("meleeCounter", var_4, var_5.root, 1, 0.2, 1);
  var_5 thread scripts\common\notetrack::start_notetrack_wait(var_5, "meleeCounter");
  var_5 thread scripts\anim\notetracks.gsc::donotetracks("meleeCounter", ::seeker_meleegrab_notetracks);
  var_6 = scripts\asm\asm::asm_getanim(var_0, var_1);
  playworldsound("seeker_expl_beep", self.origin);
  thread seeker_collide();
  self aisetanim(var_1, var_6);
  thread scripts\common\notetrack::start_notetrack_wait(self, var_1);
  scripts\asm\asm::asm_donotetracks(var_0, var_1, scripts\asm\asm::asm_getnotehandler(var_0, var_1));
  seeker_meleeexplode();
}

seeker_meleeexplode(var_0) {
  if(isDefined(self.is_detonated) && self.is_detonated) {
    return;
  }
  level.player viewkick(50, self.origin);
  level.player enableinvulnerability();
  self.is_detonated = 1;
  level.player thread post_meleeexplode();
}

post_meleeexplode() {
  wait 0.1;
  self disableinvulnerability();
}

seeker_collide() {
  self endon("death");

  for(;;) {
    var_0 = self gettagorigin("j_body");
    wait 0.05;
    var_1 = scripts\engine\trace::create_solid_ai_contents(1);
    var_2 = scripts\engine\trace::ray_trace(var_0, self gettagorigin("j_body"), self, var_1);

    if(var_2["hittype"] != "hittype_none") {
      seeker_meleeexplode(var_2["position"]);
      return;
    }
  }
}

seeker_meleegrabkillplayer(var_0, var_1, var_2) {
  level.player thread scripts\asm\shared\sp\utility::counterhintdestroy();
  var_3 = seeker_getplayerriganims();
  var_4 = var_3["seekerMeleeGrab_lose"];
  var_5 = level.player.melee.rig;
  wait 0.8;

  if(isDefined(self))
    self.is_detonated = 1;
}

playmeleeanim_seekerattack_victim(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  self.melee.bstarted = 1;
  self animmode("zonly_physics");
  self orientmode("face angle", self.melee.startangles[1]);
  scripts\asm\soldier\melee::melee_synced_setup(var_1, 0);
  thread scripts\asm\soldier\melee::melee_waitfordroppedweapon(var_1);
  var_3 = chooseanimmelee_seekerjump(var_0, var_1, self.melee.direction);
  self aisetanim(var_1, var_3);
  scripts\asm\asm::asm_playfacialanim(var_0, var_1, var_3);
  scripts\anim\face.gsc::saygenericdialogue("pain");
  var_4 = scripts\asm\asm::asm_donotetracks(var_0, var_1, scripts\asm\soldier\melee::melee_handlenotetracks);
  var_5 = chooseanimmelee_seekerloop(var_0, var_1, self.melee.direction);
  self aisetanim(var_1, var_5);
  childthread seekerattack_victim_checkattacker();
  scripts\asm\asm::asm_donotetracks(var_0, var_1, scripts\asm\soldier\melee::melee_handlenotetracks);
}

seekerattack_victim_checkattacker() {
  var_0 = self.melee.partner;

  for(;;) {
    if(!isDefined(self.melee)) {
      break;
    }

    if(!isDefined(self.melee.partner) || !isalive(self.melee.partner)) {
      self.melee.babort = 1;
      break;
    }

    wait 0.05;
  }
}