/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_sumpf_zipline.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\ai\zombie_utility;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\exploder_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\laststand_shared;
#using scripts\shared\scene_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm;
#using scripts\zm\_zm_audio;
#using scripts\zm\_zm_bgb;
#using scripts\zm\_zm_bgb_machine;
#using scripts\zm\_zm_equipment;
#using scripts\zm\_zm_laststand;
#using scripts\zm\_zm_score;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_weapons;
#namespace zm_sumpf_zipline;

function initzipline() {
  callback::on_connect(&function_3c93cd15);
  zipbuytrigger = getEntArray("zipline_buy_trigger", "targetname");
  nonstatictrig = undefined;
  statictrig = undefined;
  level.direction = undefined;
  level.znodes = [];
  level.zrnodes = [];
  level.zipinuse = 0;
  for(i = 0; i < zipbuytrigger.size; i++) {
    zipbuytrigger[i].zip = getent(zipbuytrigger[i].target, "targetname");
    zipbuytrigger[i].blocker = getent("zipline_blocker", "targetname");
    zipbuytrigger[i].aiblocker = getent("zipline_ai_blocker", "targetname");
    zipbuytrigger[i].tempclip = getEntArray("zip_temp_clip", "targetname");
    zipbuytrigger[i].handle = getent("zip_handle", "targetname");
    zipbuytrigger[i].lever = getent("zip_lever", "targetname");
    zipbuytrigger[i].volume = getent(zipbuytrigger[i].zip.target, "targetname");
    zipbuytrigger[i].zipdamagetrigger = getent(zipbuytrigger[i].volume.target, "targetname");
    zipbuytrigger[i].zipdamagevolume = getent(zipbuytrigger[i].zipdamagetrigger.target, "targetname");
    if(isDefined(zipbuytrigger[i].script_noteworthy) && zipbuytrigger[i].script_noteworthy == "nonstatic") {
      nonstatictrig = zipbuytrigger[i];
    } else if(isDefined(zipbuytrigger[i].script_noteworthy) && zipbuytrigger[i].script_noteworthy == "static") {
      statictrig = zipbuytrigger[i];
    }
    level.znodes = getEntArray("zipline_nodes", "script_noteworthy");
    level.zrnodes = [];
    zipbuytrigger[i] setcursorhint("HINT_NOICON");
  }
  nonstatictrig enablelinkto();
  nonstatictrig linkto(nonstatictrig.zip);
  statictrig triggerenable(0);
  zipbuytrigger[0].volume enablelinkto();
  zipbuytrigger[0].volume linkto(zipbuytrigger[0].zip);
  zipbuytrigger[0].zipdamagetrigger enablelinkto();
  zipbuytrigger[0].zipdamagetrigger linkto(zipbuytrigger[0].zip);
  zipbuytrigger[0].zipdamagevolume enablelinkto();
  zipbuytrigger[0].zipdamagevolume linkto(zipbuytrigger[0].zip);
  for(i = 0; i < zipbuytrigger[0].tempclip.size; i++) {
    zipbuytrigger[0].tempclip[i] linkto(zipbuytrigger[0].zip);
  }
  zippowertrigger = getent("zip_lever_trigger", "targetname");
  zippowertrigger.lever = getent(zippowertrigger.target, "targetname");
  zippowertrigger sethintstring(&"ZOMBIE_ZIPLINE_ACTIVATE");
  zippowertrigger setcursorhint("HINT_NOICON");
  zippowertrigger waittill("trigger", who);
  ziphintdeactivated = getent("zipline_deactivated_hint_trigger", "targetname");
  ziphintdeactivated delete();
  zippowertrigger thread recallzipswitch(180);
  zippowertrigger waittill("recallleverdone");
  who thread zm_audio::create_and_play_dialog("level", "zipline");
  zippowertrigger delete();
  statictrig thread activatezip(undefined);
  statictrig waittill("zipdone");
  zipbuytrigger[0].blocker connectpaths();
  zipbuytrigger[0].blocker notsolid();
  zm_utility::play_sound_at_pos("door_rotate_open", zipbuytrigger[0].blocker.origin);
  zipbuytrigger[0].blocker rotateyaw(80, 1);
  zipbuytrigger[0].blocker playSound("zmb_wooden_door");
  zipbuytrigger[0].blocker waittill("rotatedone");
  zipbuytrigger[0].blocker thread objectsolid();
  waittime = 40;
  if(getdvarint("") > 0) {
    waittime = 5;
  }
  wait(waittime);
  statictrig thread recallzipswitch(-180);
  statictrig waittill("recallleverdone");
  array::thread_all(zipbuytrigger, &zipthink);
}

function zip_rope_audio() {
  zip_rope = getEntArray("zip_line_rope", "targetname");
  for(i = 0; i < zip_rope.size; i++) {
    if(isDefined(zip_rope[i].script_sound)) {
      zip_rope[i] thread rope_sounds();
    }
  }
}

function zip_line_audio() {
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

function rope_sounds() {
  level endon("machine_off");
  while(true) {
    wait(randomfloatrange(0.5, 1.5));
    self playSound(self.script_sound);
  }
}

function zip_line_stopsound() {
  level waittill("machine_off");
  self stoploopsound(1);
  if(isDefined(self.script_label)) {
    self playSound("zmb_motor_stop_left");
  }
}

function recallzipswitch(dir) {
  self.lever rotatepitch(dir, 0.5);
  org = getent("zip_line_switch", "targetname");
  if(isDefined(org)) {
    if(dir == 180) {
      org playSound("zmb_switch_on");
    } else {
      org playSound("zmb_switch_off");
    }
  }
  self.lever waittill("rotatedone");
  self notify("recallleverdone");
}

function function_3c93cd15() {
  var_68782483 = getEntArray("zipline_buy_trigger", "targetname");
  foreach(e_trigger in var_68782483) {
    e_trigger setinvisibletoplayer(self);
  }
}

function function_73a6adde() {
  level endon("end_game");
  foreach(player in level.players) {
    self setinvisibletoplayer(player);
  }
  while(true) {
    foreach(player in level.players) {
      if(player istouching(self) && (!(isDefined(player.var_ff423fef) && player.var_ff423fef))) {
        player.var_ff423fef = 1;
        player thread function_d3655c8e(self);
      }
    }
    wait(0.05);
  }
}

function function_d3655c8e(e_trigger) {
  level endon("end_game");
  self endon("disconnect");
  while(self istouching(e_trigger)) {
    wait(0.05);
    if(self laststand::player_is_in_laststand() || self zm_utility::in_revive_trigger()) {
      e_trigger setinvisibletoplayer(self);
      continue;
    }
    if(isDefined(self.is_drinking) && self.is_drinking > 0) {
      e_trigger setinvisibletoplayer(self);
      continue;
    }
    if(self bgb::is_enabled("zm_bgb_disorderly_combat")) {
      e_trigger setinvisibletoplayer(self);
      continue;
    }
    initial_current_weapon = self getcurrentweapon();
    current_weapon = zm_weapons::get_nonalternate_weapon(initial_current_weapon);
    if(current_weapon.isheroweapon || current_weapon.isgadget) {
      e_trigger setinvisibletoplayer(self);
      continue;
    }
    if(zm_equipment::is_equipment(current_weapon)) {
      e_trigger setinvisibletoplayer(self);
      continue;
    }
    if(self.zombie_vars["zombie_powerup_minigun_on"] === 1) {
      e_trigger setinvisibletoplayer(self);
      continue;
    }
    e_trigger setvisibletoplayer(self);
  }
  e_trigger setinvisibletoplayer(self);
  self.var_ff423fef = 0;
}

function zipthink() {
  self sethintstring(&"ZOMBIE_ZIPLINE_USE");
  self setcursorhint("HINT_NOICON");
  self.zombie_cost = 1500;
  zipbuytrigger = getEntArray("zipline_buy_trigger", "targetname");
  self thread function_73a6adde();
  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "nonstatic") {
    self.triggeron = 1;
    self unlink();
    self thread monitorziphint();
  }
  while(true) {
    self waittill("trigger", who);
    if(who zm_utility::in_revive_trigger()) {
      continue;
    }
    if(zombie_utility::is_player_valid(who)) {
      if(who zm_score::can_player_purchase(self.zombie_cost)) {
        if(!level.zipinuse) {
          if(isDefined(self.script_noteworthy) && self.script_noteworthy == "nonstatic" && who istouching(self.volume) || (isDefined(self.script_noteworthy) && self.script_noteworthy == "static")) {
            level.zipinuse = 1;
            for(i = 0; i < zipbuytrigger.size; i++) {
              if(isDefined(zipbuytrigger[i].script_noteworthy) && zipbuytrigger[i].script_noteworthy == "nonstatic") {
                zipbuytrigger[i] notify("stopstringmonitor");
                zipbuytrigger[i] linkto(zipbuytrigger[i].zip);
                zipbuytrigger[i] sethintstring("");
                continue;
              }
              if(isDefined(zipbuytrigger[i].script_noteworthy) && zipbuytrigger[i].script_noteworthy == "static" && !isDefined(level.direction)) {
                zipbuytrigger[i] triggerenable(0);
              }
            }
            zm_utility::play_sound_at_pos("purchase", who.origin);
            if(isDefined(self.script_noteworthy) && self.script_noteworthy == "static") {
              self thread recallzipswitch(180);
              self waittill("recallleverdone");
            }
            who zm_score::minus_to_player_score(self.zombie_cost);
            if(isDefined(self.script_noteworthy) && self.script_noteworthy == "nonstatic") {
              self thread activatezip(who);
            } else if(isDefined(self.script_noteworthy) && self.script_noteworthy == "static") {
              self thread activatezip(undefined);
            }
            self waittill("zipdone");
            if(isDefined(self.script_noteworthy) && self.script_noteworthy == "nonstatic") {
              self unlink();
              self triggeroffsumpf();
            }
            waittime = 40;
            if(getdvarint("") > 0) {
              waittime = 5;
            }
            wait(waittime);
            if(isDefined(self.script_noteworthy) && self.script_noteworthy == "static") {
              self thread recallzipswitch(-180);
              self waittill("recallleverdone");
            }
            for(i = 0; i < zipbuytrigger.size; i++) {
              if(isDefined(zipbuytrigger[i].script_noteworthy) && zipbuytrigger[i].script_noteworthy == "nonstatic") {
                zipbuytrigger[i] sethintstring(&"ZOMBIE_ZIPLINE_USE");
                zipbuytrigger[i] setcursorhint("HINT_NOICON");
                zipbuytrigger[i] triggerenable(1);
                zipbuytrigger[i] thread monitorziphint();
              }
              if(isDefined(zipbuytrigger[i].script_noteworthy) && zipbuytrigger[i].script_noteworthy == "static" && !isDefined(level.direction)) {
                zipbuytrigger[i] triggerenable(1);
              }
            }
            level.zipinuse = 0;
          }
        }
      }
    }
  }
}

function triggeronsumpf() {
  if(isDefined(self.triggeron) && !self.triggeron) {
    self.origin = (self.origin[0], self.origin[1], self.origin[2] + 10000);
    self.triggeron = 1;
  }
}

function triggeroffsumpf() {
  if(isDefined(self.triggeron) && self.triggeron) {
    self.origin = (self.origin[0], self.origin[1], self.origin[2] - 10000);
    self.triggeron = 0;
  }
}

function monitorziphint() {
  self endon("stopstringmonitor");
  while(true) {
    players = getplayers();
    downedplayers = [];
    aliveplayers = [];
    stoptrigger = 0;
    for(i = 0; i < players.size; i++) {
      if(players[i] laststand::player_is_in_laststand() && players[i] istouching(self.volume)) {
        if(!isDefined(downedplayers)) {
          downedplayers = [];
        } else if(!isarray(downedplayers)) {
          downedplayers = array(downedplayers);
        }
        downedplayers[downedplayers.size] = players[i];
        continue;
      }
      if(isDefined(players[i]) && isalive(players[i])) {
        if(!isDefined(aliveplayers)) {
          aliveplayers = [];
        } else if(!isarray(aliveplayers)) {
          aliveplayers = array(aliveplayers);
        }
        aliveplayers[aliveplayers.size] = players[i];
      }
    }
    if(aliveplayers.size > 0 && downedplayers.size > 0) {
      for(i = 0; i < aliveplayers.size; i++) {
        for(p = 0; p < downedplayers.size; p++) {
          if(aliveplayers[i] istouching(downedplayers[p].revivetrigger)) {
            stoptrigger = 1;
            break;
          }
        }
        if(stoptrigger) {
          break;
        }
      }
    }
    if(stoptrigger) {
      self triggeroffsumpf();
    } else {
      self triggeronsumpf();
    }
    wait(1);
  }
}

function activatezip(rider) {
  zombs = getaispeciesarray("axis");
  self.riders = [];
  self.var_5dbcd881 = 0;
  for(i = 0; i < zombs.size; i++) {
    if(isDefined(zombs[i]) && isalive(zombs[i]) && zombs[i] istouching(self.zipdamagevolume)) {
      if(zombs[i].isdog) {
        zombs[i].a.nodeath = 1;
      } else {
        zombs[i] startragdoll();
      }
      zombs[i] dodamage(zombs[i].health + 600, zombs[i].origin);
    }
  }
  level thread zip_line_audio();
  var_d496a1ae = array("link_player1", "link_player2", "link_player3", "link_player4");
  peeps = getplayers();
  for(i = 0; i < peeps.size; i++) {
    if(zombie_utility::is_player_valid(peeps[i]) && (peeps[i] istouching(self.volume) || (isDefined(rider) && peeps[i] == rider))) {
      prevdist = undefined;
      playerspot = undefined;
      playerorg = peeps[i] getorigin();
      foreach(var_bcd49665 in var_d496a1ae) {
        attachorg = self.zip gettagorigin(var_bcd49665);
        dist = distance2d(playerorg, attachorg);
        if(!isDefined(prevdist)) {
          prevdist = dist;
          playerspot = var_bcd49665;
          continue;
        }
        if(dist <= prevdist) {
          prevdist = dist;
          playerspot = var_bcd49665;
        }
      }
      if(!isDefined(self.riders)) {
        self.riders = [];
      } else if(!isarray(self.riders)) {
        self.riders = array(self.riders);
      }
      self.riders[self.riders.size] = peeps[i];
      peeps[i] freezecontrols(1);
      peeps[i] thread util::magic_bullet_shield();
      peeps[i].on_zipline = 1;
      peeps[i] setstance("stand");
      peeps[i] allowcrouch(0);
      peeps[i] allowprone(0);
      peeps[i] clientfield::set("player_legs_hide", 1);
      peeps[i] playerlinkto(self.zip, playerspot, 0, 180, 180, 180, 180, 1);
      arrayremovevalue(var_d496a1ae, playerspot);
    }
  }
  wait(0.1);
  if(var_d496a1ae.size > 0) {
    center = self.zip gettagorigin("link_zipline_jnt");
    physicsexplosionsphere(center, 128, 64, 2);
  }
  self thread function_58047fdd();
  if(!isDefined(level.direction)) {
    self.aiblocker solid();
    self.aiblocker disconnectpaths(0, 0);
    for(i = 0; i < self.riders.size; i++) {
      self.riders[i] thread zm::store_crumb((11216, 2883, -648));
    }
    level scene::play("p7_fxanim_zm_sumpf_zipline_down_bundle");
    level notify("machine_done");
    level.direction = "back";
  } else {
    for(i = 0; i < self.riders.size; i++) {
      self.riders[i] thread zm::store_crumb((10750, 1516, -501));
    }
    level scene::play("p7_fxanim_zm_sumpf_zipline_up_bundle");
    self.aiblocker notsolid();
    self.aiblocker connectpaths();
    level.direction = undefined;
  }
  self.zipactive = 0;
  wait(0.1);
  for(i = 0; i < self.riders.size; i++) {
    if(isDefined(self.riders[i])) {
      self.riders[i] unlink();
      self.riders[i] util::stop_magic_bullet_shield();
      self.riders[i] thread zm::store_crumb(self.origin);
      self.riders[i].on_zipline = 0;
      self.riders[i] allowcrouch(1);
      self.riders[i] allowprone(1);
      self.riders[i] freezecontrols(0);
      self.riders[i] clientfield::set("player_legs_hide", 0);
    }
  }
  self player_collision_fix();
  self notify("zipdone");
}

function function_58047fdd() {
  wait(0.5);
  self.zipdamagetrigger thread zipdamage(self);
  self.zipactive = 1;
}

function zipdamage(parent) {
  while(true) {
    self waittill("trigger", ent);
    if(parent.zipactive == 1 && isDefined(ent) && isalive(ent)) {
      if(isPlayer(ent)) {
        ent thread playerzipdamage(parent);
      } else {
        ent thread zombiezipdamage();
      }
    }
  }
}

function playerzipdamage(parent) {
  self endon("death");
  self endon("disconnect");
  players = getplayers();
  for(i = 0; i < parent.riders.size; i++) {
    if(self == parent.riders[i]) {
      return;
    }
  }
  if(!isDefined(self.zipshock) && !self laststand::player_is_in_laststand() && parent.var_5dbcd881 == 1) {
    self.zipshock = 1;
    self shellshock("death", 3);
    wait(2);
    self.zipshock = undefined;
  }
}

function zombiezipdamage() {
  self endon("death");
  if(self.isdog) {
    self.a.nodeath = 1;
  } else {
    self startragdoll();
  }
  self dodamage(self.health + 600, self.origin);
}

function objectsolid() {
  self endon("stopmonitorsolid");
  while(true) {
    players = getplayers();
    player_touching = 0;
    for(i = 0; i < players.size; i++) {
      if(players[i] istouching(self)) {
        player_touching = 1;
        break;
      }
    }
    if(!player_touching) {
      self solid();
      return;
    }
    wait(0.5);
  }
}

function player_collision_fix() {
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
  players = getplayers();
  for(i = 0; i < players.size; i++) {
    player = players[i];
    if(!zombie_utility::is_player_valid(player)) {
      continue;
    }
    if(!player istouching(base)) {
      continue;
    }
    if(player.origin[2] < z) {
      offset = z + 6;
      origin = (player.origin[0], player.origin[1], offset);
      player setorigin(origin);
    }
  }
}