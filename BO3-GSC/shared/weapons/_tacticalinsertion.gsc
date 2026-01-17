/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\weapons\_tacticalinsertion.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\callbacks_shared;
#using scripts\shared\challenges_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\damagefeedback_shared;
#using scripts\shared\scoreevents_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\shared\weapons\_hacker_tool;
#using scripts\shared\weapons\_weaponobjects;
#namespace tacticalinsertion;

function init_shared() {
  if(level.gametype == "infect") {
    level.weapontacticalinsertion = getweapon("trophy_system");
  } else {
    level.weapontacticalinsertion = getweapon("tactical_insertion");
  }
  level._effect["tacticalInsertionFizzle"] = "_t6/misc/fx_equip_tac_insert_exp";
  clientfield::register("scriptmover", "tacticalinsertion", 1, 1, "int");
  callback::on_spawned(&on_player_spawned);
}

function on_player_spawned() {
  self thread begin_other_grenade_tracking();
}

function istacspawntouchingcrates(origin, angles) {
  crate_ents = getEntArray("care_package", "script_noteworthy");
  mins = (-17, -17, -40);
  maxs = (17, 17, 40);
  for(i = 0; i < crate_ents.size; i++) {
    if(crate_ents[i] istouchingvolume(origin + vectorscale((0, 0, 1), 40), mins, maxs)) {
      return true;
    }
  }
  return false;
}

function overridespawn(ispredictedspawn) {
  if(!isDefined(self.tacticalinsertion)) {
    return false;
  }
  origin = self.tacticalinsertion.origin;
  angles = self.tacticalinsertion.angles;
  team = self.tacticalinsertion.team;
  if(!ispredictedspawn) {
    self.tacticalinsertion destroy_tactical_insertion();
  }
  if(team != self.team) {
    return false;
  }
  if(istacspawntouchingcrates(origin)) {
    return false;
  }
  if(!ispredictedspawn) {
    self.tacticalinsertiontime = gettime();
    self spawn(origin, angles, "tactical insertion");
    self setspawnclientflag("SCDFL_DISABLE_LOGGING");
    self addweaponstat(level.weapontacticalinsertion, "used", 1);
  }
  return true;
}

function waitanddelete(time) {
  self endon("death");
  wait(0.05);
  self delete();
}

function watch(player) {
  if(isDefined(player.tacticalinsertion)) {
    player.tacticalinsertion destroy_tactical_insertion();
  }
  player thread spawntacticalinsertion();
  self waitanddelete(0.05);
}

function watchusetrigger(trigger, callback, playersoundonuse, npcsoundonuse) {
  self endon("delete");
  while(true) {
    trigger waittill("trigger", player);
    if(!isalive(player)) {
      continue;
    }
    if(!player isonground()) {
      continue;
    }
    if(isDefined(trigger.triggerteam) && player.team != trigger.triggerteam) {
      continue;
    }
    if(isDefined(trigger.triggerteamignore) && player.team == trigger.triggerteamignore) {
      continue;
    }
    if(isDefined(trigger.claimedby) && player != trigger.claimedby) {
      continue;
    }
    if(player usebuttonpressed() && !player.throwinggrenade && !player meleebuttonpressed()) {
      if(isDefined(playersoundonuse)) {
        player playlocalsound(playersoundonuse);
      }
      if(isDefined(npcsoundonuse)) {
        player playSound(npcsoundonuse);
      }
      self thread[[callback]](player);
    }
  }
}

function watchdisconnect() {
  self.tacticalinsertion endon("delete");
  self waittill("disconnect");
  self.tacticalinsertion thread destroy_tactical_insertion();
}

function destroy_tactical_insertion(attacker) {
  self.owner.tacticalinsertion = undefined;
  self notify("delete");
  self.owner notify("tactical_insertion_destroyed");
  self.friendlytrigger delete();
  self.enemytrigger delete();
  if(isDefined(attacker) && isDefined(attacker.pers["team"]) && isDefined(self.owner) && isDefined(self.owner.pers["team"])) {
    if(level.teambased) {
      if(attacker.pers["team"] != self.owner.pers["team"]) {
        attacker notify("destroyed_explosive");
        attacker challenges::destroyedequipment();
        attacker challenges::destroyedtacticalinsert();
        scoreevents::processscoreevent("destroyed_tac_insert", attacker);
      }
    } else if(attacker != self.owner) {
      attacker notify("destroyed_explosive");
      attacker challenges::destroyedequipment();
      attacker challenges::destroyedtacticalinsert();
      scoreevents::processscoreevent("destroyed_tac_insert", attacker);
    }
  }
  self delete();
}

function fizzle(attacker) {
  if(isDefined(self.fizzle) && self.fizzle) {
    return;
  }
  self.fizzle = 1;
  playFX(level._effect["tacticalInsertionFizzle"], self.origin);
  self playSound("dst_tac_insert_break");
  if(isDefined(attacker) && attacker != self.owner) {
    if(isDefined(level.globallogic_audio_dialog_on_player_override)) {
      self.owner[[level.globallogic_audio_dialog_on_player_override]]("tact_destroyed", "item_destroyed");
    }
  }
  self destroy_tactical_insertion(attacker);
}

function pickup(attacker) {
  player = self.owner;
  self destroy_tactical_insertion();
  player giveweapon(level.weapontacticalinsertion);
  player setweaponammoclip(level.weapontacticalinsertion, 1);
}

function spawntacticalinsertion() {
  self endon("disconnect");
  trace = bulletTrace(self.origin, self.origin + (vectorscale((0, 0, -1), 30)), 0, self);
  trace["position"] = trace["position"] + (0, 0, 1);
  if(!self isonground() && bullettracepassed(self.origin, self.origin + (vectorscale((0, 0, -1), 30)), 0, self)) {
    self giveweapon(level.weapontacticalinsertion);
    self setweaponammoclip(level.weapontacticalinsertion, 1);
    return;
  }
  self.tacticalinsertion = spawn("script_model", trace["position"]);
  self.tacticalinsertion setModel("wpn_t7_trophy_system");
  self.tacticalinsertion.origin = self.origin + (0, 0, 1);
  self.tacticalinsertion.angles = self.angles;
  self.tacticalinsertion.team = self.team;
  self.tacticalinsertion setteam(self.team);
  self.tacticalinsertion.owner = self;
  self.tacticalinsertion setowner(self);
  self.tacticalinsertion setweapon(level.weapontacticalinsertion);
  self.tacticalinsertion endon("delete");
  self.tacticalinsertion hacker_tool::registerwithhackertool(level.equipmenthackertoolradius, level.equipmenthackertooltimems);
  triggerheight = 64;
  triggerradius = 128;
  self.tacticalinsertion.friendlytrigger = spawn("trigger_radius_use", self.tacticalinsertion.origin + vectorscale((0, 0, 1), 3));
  self.tacticalinsertion.friendlytrigger setcursorhint("HINT_NOICON", self.tacticalinsertion);
  self.tacticalinsertion.friendlytrigger sethintstring(&"MP_TACTICAL_INSERTION_PICKUP");
  if(level.teambased) {
    self.tacticalinsertion.friendlytrigger setteamfortrigger(self.team);
    self.tacticalinsertion.friendlytrigger.triggerteam = self.team;
  }
  self clientclaimtrigger(self.tacticalinsertion.friendlytrigger);
  self.tacticalinsertion.friendlytrigger.claimedby = self;
  self.tacticalinsertion.enemytrigger = spawn("trigger_radius_use", self.tacticalinsertion.origin + vectorscale((0, 0, 1), 3));
  self.tacticalinsertion.enemytrigger setcursorhint("HINT_NOICON", self.tacticalinsertion);
  self.tacticalinsertion.enemytrigger sethintstring(&"MP_TACTICAL_INSERTION_DESTROY");
  self.tacticalinsertion.enemytrigger setinvisibletoplayer(self);
  if(level.teambased) {
    self.tacticalinsertion.enemytrigger setexcludeteamfortrigger(self.team);
    self.tacticalinsertion.enemytrigger.triggerteamignore = self.team;
  }
  self.tacticalinsertion clientfield::set("tacticalinsertion", 1);
  self thread watchdisconnect();
  watcher = weaponobjects::getweaponobjectwatcherbyweapon(level.weapontacticalinsertion);
  self.tacticalinsertion thread watchusetrigger(self.tacticalinsertion.friendlytrigger, &pickup, watcher.pickupsoundplayer, watcher.pickupsound);
  self.tacticalinsertion thread watchusetrigger(self.tacticalinsertion.enemytrigger, &fizzle);
  if(isDefined(self.tacticalinsertioncount)) {
    self.tacticalinsertioncount++;
  } else {
    self.tacticalinsertioncount = 1;
  }
  self.tacticalinsertion setCanDamage(1);
  self.tacticalinsertion.health = 1;
  while(true) {
    self.tacticalinsertion waittill("damage", damage, attacker, direction, point, type, tagname, modelname, partname, weapon, idflags);
    if(level.teambased && (!isDefined(attacker) || !isplayer(attacker) || attacker.team == self.team) && attacker != self) {
      continue;
    }
    if(attacker != self) {
      attacker challenges::destroyedequipment(weapon);
      attacker challenges::destroyedtacticalinsert();
      scoreevents::processscoreevent("destroyed_tac_insert", attacker);
    }
    if(watcher.stuntime > 0 && weapon.dostun) {
      self thread weaponobjects::stunstart(watcher, watcher.stuntime);
    }
    if(weapon.dodamagefeedback) {
      if(level.teambased && self.tacticalinsertion.owner.team != attacker.team) {
        if(damagefeedback::dodamagefeedback(weapon, attacker)) {
          attacker damagefeedback::update();
        }
      } else if(!level.teambased && self.tacticalinsertion.owner != attacker) {
        if(damagefeedback::dodamagefeedback(weapon, attacker)) {
          attacker damagefeedback::update();
        }
      }
    }
    if(isDefined(attacker) && attacker != self) {
      if(isDefined(level.globallogic_audio_dialog_on_player_override)) {
        self[[level.globallogic_audio_dialog_on_player_override]]("tact_destroyed", "item_destroyed");
      }
    }
    self.tacticalinsertion thread fizzle();
  }
}

function cancel_button_think() {
  if(!isDefined(self.tacticalinsertion)) {
    return;
  }
  text = cancel_text_create();
  self thread cancel_button_press();
  event = self util::waittill_any_return("tactical_insertion_destroyed", "disconnect", "end_killcam", "abort_killcam", "tactical_insertion_canceled", "spawned");
  if(event == "tactical_insertion_canceled") {
    self.tacticalinsertion destroy_tactical_insertion();
  }
  if(isDefined(text)) {
    text destroy();
  }
}

function canceltackinsertionbutton() {
  if(level.console) {
    return self changeseatbuttonpressed();
  }
  return self jumpbuttonpressed();
}

function cancel_button_press() {
  self endon("disconnect");
  self endon("end_killcam");
  self endon("abort_killcam");
  while(true) {
    wait(0.05);
    if(self canceltackinsertionbutton()) {
      break;
    }
  }
  self notify("tactical_insertion_canceled");
}

function cancel_text_create() {
  text = newclienthudelem(self);
  text.archived = 0;
  text.y = -100;
  text.alignx = "center";
  text.aligny = "middle";
  text.horzalign = "center";
  text.vertalign = "bottom";
  text.sort = 10;
  text.font = "small";
  text.foreground = 1;
  text.hidewheninmenu = 1;
  if(self issplitscreen()) {
    text.y = -80;
    text.fontscale = 1.2;
  } else {
    text.fontscale = 1.6;
  }
  text settext(&"PLATFORM_PRESS_TO_CANCEL_TACTICAL_INSERTION");
  text.alpha = 1;
  return text;
}

function gettacticalinsertions() {
  tac_inserts = [];
  foreach(player in level.players) {
    if(isDefined(player.tacticalinsertion)) {
      tac_inserts[tac_inserts.size] = player.tacticalinsertion;
    }
  }
  return tac_inserts;
}

function tacticalinsertiondestroyedbytrophysystem(attacker, trophysystem) {
  owner = self.owner;
  if(isDefined(attacker)) {
    attacker challenges::destroyedequipment(trophysystem.name);
    attacker challenges::destroyedtacticalinsert();
  }
  self thread fizzle();
  if(isDefined(owner)) {
    owner endon("death");
    owner endon("disconnect");
    wait(0.05);
    if(isDefined(level.globallogic_audio_dialog_on_player_override)) {
      owner[[level.globallogic_audio_dialog_on_player_override]]("tact_destroyed", "item_destroyed");
    }
  }
}

function begin_other_grenade_tracking() {
  self endon("death");
  self endon("disconnect");
  self notify("insertiontrackingstart");
  self endon("insertiontrackingstart");
  for(;;) {
    self waittill("grenade_fire", grenade, weapon, cooktime);
    if(grenade util::ishacked()) {
      continue;
    }
    if(weapon == level.weapontacticalinsertion) {
      if(level.gametype == "infect" && self.team == game["defenders"]) {
        return;
      }
      grenade thread watch(self);
    }
  }
}