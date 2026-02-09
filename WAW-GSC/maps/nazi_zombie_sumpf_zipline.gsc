/**********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\nazi_zombie_sumpf_zipline.gsc
**********************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_zombiemode_utility;

initZipline() {
  zipBuyTrigger = getEntArray("zipline_buy_trigger", "targetname");
  nonstatictrig = undefined;
  statictrig = undefined;
  level.direction = undefined;
  level.znodes = [];
  level.zrnodes = [];
  level.zipinuse = false;

  for(i = 0; i < zipBuyTrigger.size; i++) {
    zipBuyTrigger[i].zip = getent(zipBuyTrigger[i].target, "targetname");
    zipBuyTrigger[i].attachspot = getEntArray((zipBuyTrigger[i].zip).target, "targetname");
    zipBuyTrigger[i].blocker = getent("zipline_blocker", "targetname");
    zipBuyTrigger[i].aiblocker = getent("zipline_ai_blocker", "targetname");
    zipBuyTrigger[i].tempclip = getEntArray("zip_temp_clip", "targetname");
    zipBuyTrigger[i].handle = getent("zip_handle", "targetname");

    zipBuyTrigger[i].handlebox = getent("zip_handle_box", "targetname");
    zipBuyTrigger[i].lever = getent("zip_lever", "targetname");

    for(p = 0; p < (zipBuyTrigger[i].attachspot).size; p++) {
      if(isDefined((zipBuyTrigger[i].attachspot[p]).script_noteworthy) && (zipBuyTrigger[i].attachspot[p]).script_noteworthy == "main_spot") {
        zipBuyTrigger[i].volume = getent((zipBuyTrigger[i].attachspot[p]).target, "targetname");
        zipBuyTrigger[i].zipDamageTrigger = getent((zipBuyTrigger[i].volume).target, "targetname");
        zipBuyTrigger[i].zipDamageVolume = getent((zipBuyTrigger[i].zipDamageTrigger).target, "targetname");
        zipBuyTrigger[i].spline = getent((zipBuyTrigger[i].zipDamageVolume).target, "targetname");
      }
    }

    if(isDefined(zipBuyTrigger[i].script_noteworthy) && zipBuyTrigger[i].script_noteworthy == "nonstatic") {
      nonstatictrig = zipBuyTrigger[i];
    } else if(isDefined(zipBuyTrigger[i].script_noteworthy) && zipBuyTrigger[i].script_noteworthy == "static") {
      statictrig = zipBuyTrigger[i];
    }

    level.znodes = getEntArray("zipline_nodes", "script_noteworthy");
    level.zrnodes = [];

    zipBuyTrigger[i] SetCursorHint("HINT_NOICON");
  }

  nonstatictrig EnableLinkTo();
  nonstatictrig LinkTo(nonstatictrig.zip);

  statictrig trigger_off();

  zipBuyTrigger[0].volume EnableLinkTo();
  zipBuyTrigger[0].volume LinkTo(zipBuyTrigger[0].zip);

  zipBuyTrigger[0].zipDamageTrigger EnableLinkTo();
  zipBuyTrigger[0].zipDamageTrigger LinkTo(zipBuyTrigger[0].zip);

  zipBuyTrigger[0].zipDamageVolume EnableLinkTo();
  zipBuyTrigger[0].zipDamageVolume LinkTo(zipBuyTrigger[0].zip);

  for(i = 0; i < (zipBuyTrigger[0].attachspot).size; i++) {
    zipBuyTrigger[0].attachspot[i] LinkTo(zipBuyTrigger[0].zip);
  }

  for(i = 0; i < (zipBuyTrigger[0].tempclip).size; i++) {
    zipBuyTrigger[0].tempclip[i] LinkTo(zipBuyTrigger[0].zip);
  }

  zipBuyTrigger[0].handlebox LinkTo(zipBuyTrigger[0].zip);
  (zipBuyTrigger[0].handle).angles = (0, -19.6, 0);

  zipPowerTrigger = getent("zip_lever_trigger", "targetname");
  zipPowerTrigger.lever = getent(zipPowerTrigger.target, "targetname");
  zipPowerTrigger sethintstring(&"ZOMBIE_ZIPLINE_ACTIVATE");
  zipPowerTrigger SetCursorHint("HINT_NOICON");

  zipPowerTrigger waittill("trigger", who);

  zipHintDeactivated = getent("zipline_deactivated_hint_trigger", "targetname");
  zipHintDeactivated delete();

  zipPowerTrigger thread recallZipSwitch(180);
  zipPowerTrigger waittill("recallLeverDone");

  who thread play_zipline_dialog();

  zipPowerTrigger delete();

  statictrig thread activateZip(undefined);
  statictrig waittill("zipDone");
  statictrig playSound("platform_bang");

  zipBuyTrigger[0].blocker connectpaths();
  zipBuyTrigger[0].blocker notsolid();
  play_sound_at_pos("door_rotate_open", (zipBuyTrigger[0].blocker).origin);
  zipBuyTrigger[0].blocker rotateyaw(80, 1);
  zipBuyTrigger[0].blocker waittill("rotatedone");
  zipBuyTrigger[0].blocker thread objectSolid();

  waittime = 40;

  if(GetDVarInt("zombie_cheat") > 0) {
    waittime = 5;
  }

  wait(waittime);

  statictrig thread recallZipSwitch(-180);
  statictrig waittill("recallLeverDone");

  array_thread(zipBuyTrigger, ::zipThink);
}

zip_rope_audio() {
  zip_rope = getEntArray("zip_line_rope", "targetname");

  for(i = 0; i < zip_rope.size; i++) {
    if(isDefined(zip_rope[i].script_sound)) {
      zip_rope[i] thread rope_sounds();
    }
  }
}
zip_line_audio() {
  level thread zip_rope_audio();
  zip_audio = getEntArray("zip_line_wheel", "targetname");

  for(i = 0; i < zip_audio.size; i++) {
    if(isDefined(zip_audio[i].script_label)) {
      zip_audio[i] playSound(zip_audio[i].script_label);
    }
    if(isDefined(zip_audio[i].script_sound)) {
      zip_audio[i] playLoopSound(zip_audio[i].script_sound, 1);
    }
    zip_audio[i] thread zip_line_stopsound();
  }
}
rope_sounds() {
  level endon("machine_off");
  while(1) {
    wait(randomfloatrange(0.3, 0.8));
    self playSound(self.script_sound);
  }
}

zip_line_stopsound() {
  level waittill("machine_off");
  self stoploopsound(0.1);

  if(isDefined(self.script_label)) {
    self playSound("motor_stop_left");
  }
}

play_zipline_dialog() {
  waittime = 0.12;

  index = maps\_zombiemode_weapons::get_player_index(self);
  player_index = "plr_" + index + "_";

  if(!isDefined(self.vox_zipline)) {
    num_variants = maps\_zombiemode_spawner::get_number_variants(player_index + "vox_zipline");

    self.vox_zipline = [];
    for(i = 0; i < num_variants; i++) {
      self.vox_zipline[self.vox_zipline.size] = "vox_zipline_" + i;
    }
    self.vox_zipline_available = self.vox_zipline;
  }
  sound_to_play = random(self.vox_zipline_available);

  self maps\_zombiemode_spawner::do_player_playdialog(player_index, sound_to_play, waittime);
  self.vox_zipline_available = array_remove(self.vox_zipline_available, sound_to_play);

  if(self.vox_zipline_available.size < 1) {
    self.vox_zipline_available = self.vox_zipline;
  }
}

recallZipSwitch(dir) {
  self.lever rotatepitch(dir, .5);
  org = getent("zip_line_switch", "targetname");
  if(isDefined(org)) {
    playsoundatposition("purchase", org.origin);
    org playSound("switch");
  }

  self.lever waittill("rotatedone");

  self notify("recallLeverDone");
}

zipThink() {
  self sethintstring(&"ZOMBIE_ZIPLINE_USE");
  self SetCursorHint("HINT_NOICON");
  self.zombie_cost = 1500;
  zipBuyTrigger = getEntArray("zipline_buy_trigger", "targetname");

  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "nonstatic") {
    self.triggeron = true;

    self unlink();
    self thread monitorZipHint();
  }

  while(1) {
    self waittill("trigger", who);

    if(who in_revive_trigger()) {
      continue;
    }

    if(is_player_valid(who)) {
      if(who.score >= self.zombie_cost) {
        if(!level.zipinuse) {
          if(isDefined(self.script_noteworthy) && self.script_noteworthy == "nonstatic" && who IsTouching(self.volume) || isDefined(self.script_noteworthy) && self.script_noteworthy == "static") {
            level.zipinuse = true;

            for(i = 0; i < zipBuyTrigger.size; i++) {
              if(isDefined(zipBuyTrigger[i].script_noteworthy) && zipBuyTrigger[i].script_noteworthy == "nonstatic") {
                zipBuyTrigger[i] notify("stopstringmonitor");

                zipBuyTrigger[i] LinkTo(zipBuyTrigger[i].zip);
                zipBuyTrigger[i] sethintstring("");
              } else if(isDefined(zipBuyTrigger[i].script_noteworthy) && zipBuyTrigger[i].script_noteworthy == "static" && (!isDefined(level.direction))) {
                zipBuyTrigger[i] trigger_off();
              }
            }

            play_sound_at_pos("purchase", who.origin);

            if(isDefined(self.script_noteworthy) && self.script_noteworthy == "static") {
              self thread recallZipSwitch(180);
              self waittill("recallLeverDone");
            }

            who maps\_zombiemode_score::minus_to_player_score(self.zombie_cost);

            if(isDefined(self.script_noteworthy) && self.script_noteworthy == "nonstatic") {
              self thread activateZip(who);
            } else if(isDefined(self.script_noteworthy) && self.script_noteworthy == "static") {
              self thread activateZip(undefined);
            }

            self waittill("zipDone");

            if(isDefined(self.script_noteworthy) && self.script_noteworthy == "nonstatic") {
              self unlink();
              self triggerOff();
            }

            waittime = 40;

            if(GetDVarInt("zombie_cheat") > 0) {
              waittime = 5;
            }

            wait(waittime);

            if(isDefined(self.script_noteworthy) && self.script_noteworthy == "static") {
              self thread recallZipSwitch(-180);
              self waittill("recallLeverDone");
            }

            for(i = 0; i < zipBuyTrigger.size; i++) {
              if(isDefined(zipBuyTrigger[i].script_noteworthy) && zipBuyTrigger[i].script_noteworthy == "nonstatic") {
                zipBuyTrigger[i] sethintstring(&"ZOMBIE_ZIPLINE_USE");
                zipBuyTrigger[i] triggerOn();
                zipBuyTrigger[i] thread monitorZipHint();
              }

              if(isDefined(zipBuyTrigger[i].script_noteworthy) && zipBuyTrigger[i].script_noteworthy == "static" && (!isDefined(level.direction))) {
                zipBuyTrigger[i] trigger_on();
              }
            }

            level.zipinuse = false;
          }
        }
      }
    }
  }
}
triggerOn() {
  if(isDefined(self.triggeron) && !self.triggeron) {
    self.origin = (self.origin[0], self.origin[1], (self.origin[2] + 10000));
    self.triggeron = true;
  }
}

triggerOff() {
  if(isDefined(self.triggeron) && self.triggeron) {
    self.origin = (self.origin[0], self.origin[1], (self.origin[2] - 10000));
    self.triggeron = false;
  }
}

monitorZipHint() {
  self endon("stopstringmonitor");

  while(1) {
    players = get_players();
    downedplayers = [];
    aliveplayers = [];
    stoptrigger = false;

    for(i = 0; i < players.size; i++) {
      if(players[i] maps\_laststand::player_is_in_laststand() && players[i] IsTouching(self.volume)) {
        downedplayers = array_add(downedplayers, players[i]);
      } else if(isDefined(players[i]) && IsAlive(players[i])) {
        aliveplayers = array_add(aliveplayers, players[i]);
      }
    }

    if(aliveplayers.size > 0 && downedplayers.size > 0) {
      for(i = 0; i < aliveplayers.size; i++) {
        for(p = 0; p < downedplayers.size; p++) {
          if(aliveplayers[i] IsTouching(downedplayers[p].revivetrigger)) {
            stoptrigger = true;
            break;
          }
        }
        if(stoptrigger) {
          break;
        }
      }
    }

    if(stoptrigger) {
      self triggerOff();
    } else {
      self triggerOn();
    }

    wait(1);
  }
}

activateZip(rider) {
  zombs = getaispeciesarray("axis");
  self.riders = [];
  self.canshock = false;

  for(i = 0; i < zombs.size; i++) {
    if(isDefined(zombs[i]) && IsAlive(zombs[i]) && zombs[i] IsTouching(self.zipDamageVolume)) {
      if(zombs[i] enemy_is_dog()) {
        zombs[i].a.nodeath = true;
      } else {
        zombs[i] StartRagdoll();
      }

      zombs[i] dodamage(zombs[i].health + 600, zombs[i].origin);
    }
  }

  level thread zip_line_audio();

  attachspot = getEntArray((self.zip).target, "targetname");
  peeps = get_players();

  for(i = 0; i < peeps.size; i++) {
    if(is_player_valid(peeps[i]) && ((peeps[i] IsTouching(self.volume) || (isDefined(rider) && peeps[i] == rider)))) {
      self.riders = array_add(self.riders, peeps[i]);
      peeps[i] thread magic_bullet_shield(100000000, 0);

      peeps[i].on_zipline = true;
      peeps[i] setstance("stand");
      peeps[i] allowcrouch(false);
      peeps[i] allowprone(false);

      prevdist = undefined;
      playerspot = undefined;

      playerOrg = peeps[i] GetOrigin();

      for(p = 0; p < attachspot.size; p++) {
        attachOrg = attachspot[p] GetOrigin();

        dist = distance2d(playerOrg, attachOrg);
        if(!isDefined(prevdist)) {
          prevdist = dist;
          playerspot = attachspot[p];
        } else {
          if(dist <= prevdist) {
            prevdist = dist;
            playerspot = attachspot[p];
          }
        }
      }
      peeps[i] playerlinkto(playerspot, undefined, 0.0, 180, 180, 180, 180, true);

      attachspot = array_remove(attachspot, playerspot);
    }
  }

  for(i = 0; i < (self.tempclip).size; i++) {
    self.tempclip[i] notify("stopmonitorsolid");
  }

  wait(0.1);

  for(i = 0; i < (self.tempclip).size; i++) {
    self.tempclip[i] notsolid();
  }

  self.handle notify("stopmonitorsolid");

  self.handle notsolid();
  self.handle unlink();

  if((!(isDefined(level.direction)))) {
    self.handle rotateto((0, -19.6, -65), 0.5);
  } else {
    self.handle rotateto((0, -19.6, 65), 0.5);
  }

  self.handle waittill("rotatedone");
  self.handle thread objectSolid();

  self.handle LinkTo(self.zip);

  self.zipDamageTrigger thread zipDamage(self);
  self.zipActive = true;

  self thread spinZipPulleys();

  if((!(isDefined(level.direction)))) {
    self.aiblocker solid();
    self.aiblocker disconnectpaths();

    for(i = 0; i < (self.riders).size; i++) {
      self.riders[i] thread maps\_zombiemode::store_crumb((11216, 2883, -648));
    }

    curnode = self.spline;
    level.zrnodes[(((level.znodes).size) - 1)] = curnode;

    my_time = .3;
    for(i = 0; i < ((level.znodes).size - 1); i++) {
      curnode = getent(curnode.target, "targetname");
      level.zrnodes[((((level.znodes).size) - (i + 2)))] = curnode;
      self.zip moveto(curnode.origin, my_time);

      if(i == 3) {
        self.canshock = true;
      }

      if(i == 23) {
        self.canshock = false;
      }

      if(i > ((level.znodes).size * .666)) {
        my_time = my_time + .017;
      } else if(i < ((level.znodes).size * .333)) {
        my_time = my_time - .017;
      }
      wait(my_time - .022);
    }
    self.zip waittill("movedone");
    level notify("machine_done");
    level.direction = "back";
  } else {
    for(i = 0; i < (self.riders).size; i++) {
      self.riders[i] thread maps\_zombiemode::store_crumb((10750, 1516, -501));
    }
    my_time = .3;
    for(i = 1; i < ((level.zrnodes).size); i++) {
      curnode = level.zrnodes[i];
      self.zip moveto(curnode.origin, my_time);

      if(i == 4) {
        self.canshock = true;
      }

      if(i == 23) {
        self.canshock = false;
      }

      if(i > ((level.znodes).size * .666)) {
        my_time = my_time + .017;
      } else if(i < ((level.znodes).size * .333)) {
        my_time = my_time - .017;
      }
      wait(my_time - .022);
    }

    self.zip waittill("movedone");

    self.aiblocker connectpaths();
    self.aiblocker notsolid();

    level.direction = undefined;
  }

  for(i = 0; i < (self.tempclip).size; i++) {
    if((!(isDefined(level.direction))) && isDefined((self.tempclip[i]).script_noteworthy) && (self.tempclip[i]).script_noteworthy == "zip_base") {
      self.tempclip[i] solid();
    } else {
      self.tempclip[i] thread objectSolid();
    }
  }
  level notify("machine_off");
  self playSound("platform_bang");

  self.zipActive = false;

  wait(0.1);

  for(i = 0; i < (self.riders).size; i++) {
    self.riders[i] unlink();
    self.riders[i] stop_magic_bullet_shield();
    self.riders[i] thread maps\_zombiemode::store_crumb(self.origin);

    self.riders[i].on_zipline = false;
    self.riders[i] allowcrouch(true);
    self.riders[i] allowprone(true);
  }

  self.handle unlink();
  self.handle rotateto((0, -19.6, 0), 0.5);
  self.handle waittill("rotatedone");
  self.handle thread objectSolid();
  self.handle LinkTo(self.zip);

  self player_collision_fix();

  self notify("zipDone");
}

zipDamage(parent) {
  while(1) {
    self waittill("trigger", ent);

    if(parent.zipActive == true && isDefined(ent) && IsAlive(ent)) {
      if(isPlayer(ent)) {
        ent thread playerZipDamage(parent);
      } else {
        ent thread zombieZipDamage();
      }
    }
  }
}

playerZipDamage(parent) {
  self endon("death");
  self endon("disconnect");

  players = get_players();

  for(i = 0; i < (parent.riders).size; i++) {
    if(self == parent.riders[i]) {
      return;
    }
  }

  if(!isDefined(self.zipshock) && !self maps\_laststand::player_is_in_laststand() && parent.canshock == true) {
    self.zipshock = 1;

    self shellshock("death", 3);

    wait(2);

    self.zipshock = undefined;
  }
}

zombieZipDamage() {
  self endon("death");

  if(self enemy_is_dog()) {
    self.a.nodeath = true;
  } else {
    self StartRagdoll();
  }

  self dodamage(self.health + 600, self.origin);
}

objectSolid() {
  self endon("stopmonitorsolid");

  while(1) {
    players = get_players();
    player_touching = false;
    for(i = 0; i < players.size; i++) {
      if(players[i] IsTouching(self)) {
        player_touching = true;
        break;
      }
    }

    if(!player_touching) {
      self Solid();
      return;
    }

    wait(0.5);
  }
}

spinZipPulleys() {
  pulleys = getEntArray("zip_pulley", "targetname");

  for(i = 0; i < pulleys.size; i++) {
    pulleys[i] rotateyaw(1800, 4.8);
  }
}

player_collision_fix() {
  assert(isDefined(self));
  assert(isDefined(self.tempclip));

  if(isDefined(level.direction)) {
    return;
  }

  base = undefined;

  for(i = 0; i < self.tempclip.size; i++) {
    clip = self.tempclip[i];

    if(isDefined(clip.script_noteworthy) && clip.script_noteworthy == "zip_base") {
      base = clip;
      break;
    }
  }

  assert(isDefined(base));

  z = base.origin[2];

  players = get_players();

  for(i = 0; i < players.size; i++) {
    player = players[i];

    if(!is_player_valid(player)) {
      continue;
    }

    if(!player IsTouching(base)) {
      continue;
    }

    if(player.origin[2] < z) {
      offset = z + 6;
      origin = (player.origin[0], player.origin[1], offset);

      player SetOrigin(origin);
    }
  }
}