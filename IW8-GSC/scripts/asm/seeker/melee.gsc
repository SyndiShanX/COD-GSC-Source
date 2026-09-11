/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\asm\seeker\melee.gsc
***********************************************/

function seeker_getplayerriganims() {
  var0 = [];
  return var0;
}

function seeker_evaluatesyncedmelee(var0, var1, var2, var3) {
  var4 = self.melee.target;

  if(isPlayer(var4)) {
    return false;
  }

  self.melee.winner = 1;
  var4.melee.winner = 0;
  var5 = seeker_pickattachdirection(self, self.melee.target);
  self.melee.direction = var5[0];
  self.melee.offset = var5[1];
  var5 = undefined;
  var4.melee.direction = self.melee.direction;
  var6 = chooseanimmelee_seekerjump(var0, var2, self.melee.direction);
  var7 = vectortoyaw(self.origin - self.melee.target.origin);
  var8 = (0, self.melee.offset + var7, 0);
  self.melee.startangles = self.angles;
  var4.melee.startangles = var8;
  var4.ignoreme = 1;
  self.ignoreme = 1;
  self notify("meleegrab_start");
  self.bt.target_locked = 1;
  return true;
}

function seeker_pickattachdirection(var0, var1) {
  var2 = var1.angles;
  var3 = var1.origin;
  var4 = var0.origin;
  var5 = vectortoangles(var4 - var3);
  var6 = angleclamp(var2[1] - var5[1]);

  if(var6 > 315 || var6 < 45) {
    return ["front", 0];
  }

  if(var6 < 135) {
    return ["right", 90];
  }

  if(var6 > 225) {
    return ["left", -90];
  }

  return ["back", 180];
}

function chooseanimmelee_seekerjump(var0, var1, var2) {
  return scripts\asm\asm::asm_lookupanimfromalias(var1, "jump_" + var2);
}

function chooseanimmelee_seekerloop(var0, var1, var2) {
  return scripts\asm\asm::asm_lookupanimfromalias(var1, "loop_" + var2);
}

function seekermeleedetonate() {
  var0 = 0.7071;

  for(;;) {
    wait 0.05;

    if(scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), self.origin, var0)) {
      self notify("on_screen");
      return;
    }
  }
}

function setseekerattached() {
  self.attached = 1;
}

function valid_reaction_sound(var0) {
  switch (var0) {
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
      return true;
  }

  return false;
}

function playmeleeanim_seekerattack(var0, var1, var2) {
  self endon(var1 + "_finished");
  self.melee.bstarted = 1;
  var3 = self.melee.target;
  var4 = chooseanimmelee_seekerjump(var0, var1, self.melee.direction);
  scripts\asm\asm::asm_fireephemeralevent("melee_attack", "begin");
  scripts\asm\soldier\melee::melee_synced_setup(var1, 1);

  if(!isDefined(var3.seenatseeker)) {
    var3.seenatseeker = 1;

    if(isDefined(var3.battlechatter.countryid) && isDefined(var3.battlechatter.npcid) && (var3.battlechatter.countryid == "UN" || var3.battlechatter.countryid == "SD")) {
      if(valid_reaction_sound(var3.battlechatter.npcid) && !isDefined(level.in_vr)) {
        var5 = var3.battlechatter.countryid + "_" + var3.battlechatter.npcid + "_reaction_seeker_attack";
        var3 playSound(var5);
      }
    }
  }

  var3 scripts\asm\asm::asm_setstate(var1 + "_victim");
  createnavrepulsor("ent_" + self getentitynumber() + "_seeker_repulsor", -1, self, 250, 1, self.bt.enemy_team);
  self animmode("zonly_physics");
  self linktoblendtotag(self.melee.target, "tag_sync", 0, 0);
  self clearanim(scripts\asm\asm::asm_getbodyknob(), 0);
  self setflaggedanimrestart(var1, var4, 1, 0, 1);
  scripts\engine\utility::delaythread(0.25, &setseekerattached);
  var6 = scripts\asm\asm::asm_donotetracks(var0, var1, &scripts\asm\soldier\melee::melee_handlenotetracks);
  var7 = chooseanimmelee_seekerloop(var0, var1, self.melee.direction);
  self aisetanim(var1, var7);
  GscBinSkip4(0x35);
}

function playmeleeanim_seekerattack_cleanup(var0, var1, var2) {
  destroynavrepulsor("ent_" + self getentitynumber() + "_seeker_repulsor");

  if(isDefined(self.melee.target)) {
    if(isDefined(self.melee.target.melee)) {
      self.melee.target.melee.babort = 1;
    }

    self.melee.target.ignoreme = 0;
    return;
  }
}

function seeker_meleegrabplayer(var0, var1, var2) {
  level.player.damageshield = 1;
  self.disableattack = 1;
  self.ignoreme = 1;
  scripts\engine\sp\utility::hudoutline_disable("default_seeker");
  scripts\asm\shared\sp\utility::meleegrab_common();
  scripts\asm\asm::asm_fireephemeralevent("melee_attack", "begin");
  thread seeker_playerrig_meleegrabplayer();
  scripts\asm\asm::asm_playanimstate(var0, var1);
}

function seeker_playerrig_meleegrabplayer() {
  if(isDefined(self.forcemeleeyaw)) {
    var0 = (0, self.forcemeleeyaw, 0);
  } else {
    var0 = vectortoangles(self.origin - level.player.origin);
    var0 = (0, var0[1], 0);
  }

  var1 = scripts\asm\shared\sp\utility::spawnplayerrig();
  var1.angles = var0;
  self notify("jumped_on_player");
  playworldsound("seeker_expl_beep", self.origin);
  level.player.melee.partner = self;
  level.player.melee.rig = var1;
  var2 = seeker_getplayerriganims();
  var3 = "meleeAnim";
  var1 setflaggedanimknoballrestart(var3, var2["seekerMeleeGrab"], var1.root, 1, 0, 1);
  thread seeker_playerrig_link(var1);
  var4 = getanimlength(var2["seekerMeleeGrab"]);
  thread seeker_meleegrab_counterinput(1.25, 0.75);
  var1 thread scripts\common\notetrack::start_notetrack_wait(var1, var3);
  var1 scripts\anim\notetracks::donotetracks(var3);
}

function seeker_meleegrab_counterinput(var0, var1) {
  level.player notifyonplayercommand("bash_pressed", "+usereload");
  level.player notifyonplayercommand("bash_pressed", "+activate");
  scripts\engine\utility::waittill_notify_or_timeout_return("death", var0);

  if(!isDefined(level.player.melee)) {
    return;
  }

  scripts\sp\player\cursor_hint::create_cursor_hint("j_body", undefined, undefined, undefined, 1000, 1000, 1, 1);
  var2 = seeker_meleegrab_bash(var1);

  if(!isDefined(level.player) || !isDefined(level.player.melee)) {
    return;
  }

  level.player.melee.countersuccess = var2;
  scripts\sp\player\cursor_hint::remove_cursor_hint();
}

function seeker_meleegrab_bash(var0) {
  self endon("meleegrab_interupt");
  var0 *= 1000;
  var1 = 1;
  var2 = 0.4;
  var3 = var1;
  var4 = undefined;

  for(;;) {
    var5 = level.player scripts\engine\utility::waittill_notify_or_timeout_return("bash_pressed", var3);

    if(isDefined(var5) && var5 == "timeout") {
      break;
    }

    if(!isDefined(var4)) {
      var4 = gettime();
    }

    if(gettime() - var4 > var0) {
      return true;
    }

    var3 = var2;
  }

  return false;
}

function seeker_meleegrab_rumble() {
  self endon("meleegrab_interupt");

  for(;;) {
    level.player playRumbleOnEntity("damage_light");
    earthquake(0.15, 0.1, level.player.origin, 5000);
    wait 0.05;
  }
}

function seeker_meleegrab_hint() {
  var0 = spawn("script_model", self.origin);
  var0 linkTo(self, "j_hip_le", (0, 0, 0), (0, 0, 0));
  var0 scripts\sp\player\cursor_hint::create_cursor_hint(undefined, undefined, "", undefined, undefined, undefined, 1, 1);
  self waittill("meleegrab_interupt");
  var0 scripts\sp\player\cursor_hint::remove_cursor_hint();
}

function seeker_meleegrab_counterhint(var0) {
  level.player endon("meleegrab_interupt");
  var1 = 0.2;
  var2 = 0.3;
  wait var0 - var1 - 0.05;

  if(isDefined(self.melee.meleecounterhint)) {
    self.melee.meleecounterhint destroy();
  }

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
  self.melee.meleecounterhint fadeovertime(var1);
  self.melee.meleecounterhint changefontscaleovertime(var1);
  self.melee.meleecounterhint.fontscale = 1.3;
  self.melee.meleecounterhint.alpha = 1;
  wait var1;

  if(!isDefined(self.melee.meleecounterhint)) {
    return;
  }

  self.melee.meleecounterhint fadeovertime(var2);
  self.melee.meleecounterhint changefontscaleovertime(var2);
  self.melee.meleecounterhint.fontscale = 1.2;
}

function seeker_playerrig_link(var0) {
  var1 = 0.3;
  thread seeker_meleegrab_interrupt(var0);
  level.player playerlinktoblend(var0, "tag_player", var1, 0, var1);
  level.player viewkick(5, self.origin);
  scripts\asm\shared\sp\utility::playergrabbed("seeker");
  self linktoblendtotag(var0, "tag_sync", 0, 0);
  wait var1;

  if(!isalive(self)) {
    return;
  }

  level.player hidelegsandshadow();
  thread scripts\asm\shared\sp\utility::delayenabledof(0.5, 2, 20, 10, 5, 60, 10, 0.1);
  thread scripts\asm\shared\sp\utility::delayenabledof(1, 2, 20, 4, 50, 90, 10, 0.1);
  thread scripts\asm\shared\sp\utility::delaymodifybasefov(1, 50, 0.4);
  var0 show();
  level.player thread scripts\asm\shared\sp\utility::playerhealth();
  level.player playerlinktodelta(var0, "tag_player", 1, 0, 0, 0, 0, 1);
  level.player lerpviewangleclamp(0.4, 0, 0, 15, 20, 30, 0);
  thread seeker_playergrabbed_screenshake();
}

function seeker_playergrabbed_screenshake() {
  wait 0.1;
  var0 = level.player.origin + anglesToForward(level.player.angles) * -100;
  screenshake(var0, 10, 2, 1, 0.4, 0.2, 0.2, 700, 0.2, 1, 1);
  wait 0.5;
  var0 = level.player.origin + anglesToForward(level.player.angles) * 100;
  screenshake(var0, 10, 2, 1, 0.6, 0.3, 0.3, 700, 0.2, 1, 1);
}

function seeker_meleegrab_notetracks(var0) {
  switch (var0) {
    case "unlink":
      self unlink();
      break;
    case "disable_weapons":
      level.player disableweapons();
      level.player viewkick(10, self.origin);
      break;
  }
}

function seeker_meleegrab_interrupt(var0) {
  self endon("death");
  level.player endon("bt_stop_meleegrab");

  while(!seeker_meleegrab_checkinterrupt(var0)) {
    wait 0.05;
  }

  level.player notify("meleegrab_interupt");

  if(isDefined(level.player.melee) && isDefined(level.player.melee.meleecounterhint)) {
    level.player.melee.meleecounterhint destroy();
  }

  thread scripts\asm\shared\sp\utility::delaydisabledof(0.2);
  thread scripts\asm\shared\sp\utility::delaymodifybasefov(0.25, 65, 0.4);
  scripts\asm\shared\sp\utility::playerletgo();
  level.player.damageshield = 0;
  level.player.ignoreme = 0;
  level.player setCanDamage(1);
  level.player unlink();
  self delete();
}

function seeker_meleegrab_checkinterrupt(var0) {
  if(!isalive(var0)) {
    return true;
  }

  if(isDefined(var0.antigravtag)) {
    return true;
  }

  return false;
}

function seeker_meleegrabplayercounter(var0, var1, var2) {
  var3 = seeker_getplayerriganims();
  var4 = var3["seekerMeleeGrab_win"];
  var5 = level.player.melee.rig;
  thread scripts\asm\shared\sp\utility::delaydisabledof(0.2);
  thread scripts\asm\shared\sp\utility::delaymodifybasefov(0.2, 65, 0.4);
  var5 setflaggedanimknoballrestart("meleeCounter", var4, var5.root, 1, 0.2, 1);
  var5 thread scripts\common\notetrack::start_notetrack_wait(var5, "meleeCounter");
  var5 thread scripts\anim\notetracks::donotetracks("meleeCounter", &seeker_meleegrab_notetracks);
  var6 = scripts\asm\asm::asm_getanim(var0, var1);
  playworldsound("seeker_expl_beep", self.origin);
  thread seeker_collide();
  self aisetanim(var1, var6);
  thread scripts\common\notetrack::start_notetrack_wait(self, var1);
  scripts\asm\asm::asm_donotetracks(var0, var1, scripts\asm\asm::asm_getnotehandler(var0, var1));
  seeker_meleeexplode();
}

function seeker_meleeexplode(var0) {
  if(isDefined(self.is_detonated) && self.is_detonated) {
    return;
  }

  level.player viewkick(50, self.origin);
  level.player enableinvulnerability();
  self.is_detonated = 1;
  thread post_meleeexplode();
}

function post_meleeexplode() {
  wait 0.1;
  self disableinvulnerability();
}

function seeker_collide() {
  self endon("death");

  for(;;) {
    var0 = self gettagorigin("j_body");
    wait 0.05;
    var1 = scripts\engine\trace::create_solid_ai_contents(1);
    var2 = scripts\engine\trace::ray_trace(var0, self gettagorigin("j_body"), self, var1);

    if(var2["hittype"] != "hittype_none") {
      seeker_meleeexplode(var2["position"]);
      return;
    }
  }
}

function seeker_meleegrabkillplayer(var0, var1, var2) {
  level.player thread scripts\asm\shared\sp\utility::counterhintdestroy();
  var3 = seeker_getplayerriganims();
  var4 = var3["seekerMeleeGrab_lose"];
  var5 = level.player.melee.rig;
  wait 0.8;

  if(isDefined(self)) {
    self.is_detonated = 1;
    return;
  }
}

function playmeleeanim_seekerattack_victim(var0, var1, var2) {
  self endon(var1 + "_finished");
  self.melee.bstarted = 1;
  self animmode("zonly_physics");
  self orientmode("face angle", self.melee.startangles[1]);
  scripts\asm\soldier\melee::melee_synced_setup(var1, 0);
  thread scripts\asm\soldier\melee::melee_waitfordroppedweapon(var1);
  var3 = chooseanimmelee_seekerjump(var0, var1, self.melee.direction);
  self aisetanim(var1, var3);
  scripts\asm\asm::asm_playfacialanim(var0, var1, var3);
  scripts\anim\face::saygenericdialogue("pain");
  var4 = scripts\asm\asm::asm_donotetracks(var0, var1, &scripts\asm\soldier\melee::melee_handlenotetracks);
  var5 = chooseanimmelee_seekerloop(var0, var1, self.melee.direction);
  self aisetanim(var1, var5);
  GscBinSkip4(0x35);
}

function seekerattack_victim_checkattacker() {
  var0 = self.melee.partner;

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