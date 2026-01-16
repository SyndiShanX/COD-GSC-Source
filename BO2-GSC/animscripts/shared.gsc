/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\shared.gsc
**************************************/

#include maps\_utility;
#include animscripts\utility;
#include animscripts\combat_utility;
#include animscripts\anims;
#include common_scripts\utility;
#include animscripts\init;
#include animscripts\shared;
#include animscripts\weaponlist;
#include maps\_dialog;
#include animscripts\cqb;
#include animscripts\debug;
#include maps\_gameskill;

placeweaponon(weapon, position) {
  self notify("weapon_position_change");

  if(!isDefined(self.weaponinfo[weapon]))
    self animscripts\init::initweapon(weapon);

  curposition = self.weaponinfo[weapon].position;
  assert(curposition == "none" || self.a.weaponpos[curposition] == weapon);

  if(position != "none" && self.a.weaponpos[position] == weapon) {
    return;
  }
  self detachallweaponmodels();

  if(curposition != "none")
    self detachweapon(weapon);

  if(position == "none") {
    self updateattachedweaponmodels();
    self setcurrentweapon("none");
    animscripts\init::setweapondist();
    return;
  }

  if(self.a.weaponpos[position] != "none")
    self detachweapon(self.a.weaponpos[position]);

  if(position == "left" || position == "right") {
    self attachweapon(weapon, position);
    self setcurrentweapon(weapon);
    self animscripts\anims::clearanimcache();
    self.aimthresholdyaw = 10;
    self.aimthresholdpitch = 20;

    if(weaponisgasweapon(self.weapon)) {
      self.aimthresholdyaw = 25;
      self.aimthresholdpitch = 25;
    }
  } else
    self attachweapon(weapon, position);

  self updateattachedweaponmodels();
  animscripts\init::setweapondist();
  assert(self.a.weaponpos["left"] == "none" || self.a.weaponpos["right"] == "none");
}

detachweapon(weapon) {
  self.a.weaponpos[self.weaponinfo[weapon].position] = "none";
  self.weaponinfo[weapon].position = "none";
}

attachweapon(weapon, position) {
  self.weaponinfo[weapon].position = position;
  self.a.weaponpos[position] = weapon;
}

detachallweaponmodels() {
  if(isDefined(self.weapon_positions)) {
    for(index = 0; index < self.weapon_positions.size; index++) {
      weapon = self.a.weaponpos[self.weapon_positions[index]];

      if(weapon == "none") {
        continue;
      }
      self setactorweapon("none");
    }
  }
}

updateattachedweaponmodels() {
  if(isDefined(self.weapon_positions)) {
    for(index = 0; index < self.weapon_positions.size; index++) {
      weapon = self.a.weaponpos[self.weapon_positions[index]];

      if(weapon == "none") {
        continue;
      }
      if(self.weapon_positions[index] != "right") {
        continue;
      }
      self setactorweapon(weapon);

      if(self.weaponinfo[weapon].useclip && !self.weaponinfo[weapon].hasclip)
        self hidepart("tag_clip");
    }
  }
}

gettagforpos(position) {
  switch (position) {
    case "chest":
      return "tag_weapon_chest";
    case "back":
      return "tag_stowed_back";
    case "left":
      return "tag_weapon_left";
    case "right":
      return "tag_weapon_right";
    case "hand":
      return "tag_inhand";
    default:

      assertmsg("unknown weapon placement position: " + position);

      break;
  }
}

dropaiweapon() {
  if(isDefined(self.a.dropping_weapons) && self.a.dropping_weapons) {
    return;
  }
  if(self.weapon == "none" || self.weapon == "") {
    return;
  }
  if(isDefined(self.script_nodropsecondaryweapon) && self.script_nodropsecondaryweapon && self.weapon == self.initial_secondaryweapon) {
    println("Not dropping secondary weapon '" + self.weapon + "'");

    return;
  } else if(isDefined(self.script_nodropsidearm) && self.script_nodropsidearm && self.weapon == self.sidearm) {
    println("Not dropping sidearm '" + self.weapon + "'");

    return;
  }

  self swapdropweapon();
  current_weapon = self.weapon;
  position = self.weaponinfo[current_weapon].position;

  if(isDefined(current_weapon) && current_weapon != "none") {
    animscripts\shared::placeweaponon(current_weapon, "none");

    if(current_weapon == self.primaryweapon)
      self setprimaryweapon("none");
    else if(current_weapon == self.secondaryweapon)
      self setsecondaryweapon("none");
  }

  if(self.dropweapon) {
    dropweaponname = player_weapon_drop(current_weapon);
    velocity = self getvelocity();
    speed = length(velocity) * 0.5;
    droppedweapon = self dropweapon(dropweaponname, position, speed);
  }

  self setcurrentweapon("none");
}

dropallaiweapons() {
  if(isDefined(self.a.dropping_weapons) && self.a.dropping_weapons) {
    return;
  }
  if(!self.dropweapon) {
    if(self.weapon != "none") {
      animscripts\shared::placeweaponon(self.weapon, "none");
      self setcurrentweapon("none");
    }

    return;
  }

  self.a.dropping_weapons = 1;
  self swapdropweapon();
  self detachallweaponmodels();
  droppedsidearm = 0;

  if(isDefined(self.weapon_positions)) {
    for(index = 0; index < self.weapon_positions.size; index++) {
      weapon = self.a.weaponpos[self.weapon_positions[index]];

      if(weapon != "none") {
        self.weaponinfo[weapon].position = "none";
        self.a.weaponpos[self.weapon_positions[index]] = "none";

        if(isDefined(self.script_nodropsecondaryweapon) && self.script_nodropsecondaryweapon && weapon == self.initial_secondaryweapon) {
          println("Not dropping secondary weapon '" + weapon + "'");

          continue;
        }

        if(isDefined(self.script_nodropsidearm) && self.script_nodropsidearm && weapon == self.sidearm) {
          println("Not dropping sidearm '" + weapon + "'");

          continue;
        }

        velocity = self getvelocity();
        speed = length(velocity) * 0.5;
        weapon = player_weapon_drop(weapon);
        droppedweapon = self dropweapon(weapon, self.weapon_positions[index], speed);

        if(isDefined(self.sidearm) && self.sidearm != "") {
          if(issubstr(weapon, self.sidearm))
            droppedsidearm = 1;
        }
      }
    }
  }

  if(!droppedsidearm && isDefined(self.sidearm) && self.sidearm != "") {
    if(randomint(100) <= 10) {
      velocity = self getvelocity();
      speed = length(velocity) * 0.5;
      droppedweapon = self dropweapon(self.sidearm, "chest", speed);
    }
  }

  self setcurrentweapon("none");
  self.a.dropping_weapons = undefined;
}

swapdropweapon() {
  if(has_script_drop_weapon()) {
    found_weapon = 0;

    for(i = 0; i < self.weapon_positions.size; i++) {
      weapon = self.a.weaponpos[self.weapon_positions[i]];
      weapon_toks = strtok(weapon, "_");
      drop_weapon_toks = strtok(self.script_dropweapon, "_");

      if(weapon_toks[0] == drop_weapon_toks[0]) {
        println("Swapping out weapon '" + weapon + "' for script_dropweapon '" + self.script_dropweapon + "'");

        self placeweaponon(weapon, "none");

        if(self.weapon == weapon)
          self setcurrentweapon(self.script_dropweapon);

        self placeweaponon(self.script_dropweapon, self.weapon_positions[i]);
        found_weapon = 1;
        break;
      }
    }

    if(!found_weapon)
      self swapdropweaponprimary();

    self.script_dropweapon = undefined;
  }
}

swapdropweaponprimary() {
  if(has_script_drop_weapon()) {
    position = self.weaponinfo[self.primaryweapon].position;

    if(position != "none") {
      println("Swapping out weapon '" + self.primaryweapon + "' for script_dropweapon '" + self.script_dropweapon + "'");

      self placeweaponon(self.primaryweapon, "none");
      self placeweaponon(self.script_dropweapon, position);
    }
  }
}

addphysweapon() {
  self thread deleteatlimit();
}

has_script_drop_weapon() {
  if(isDefined(self.script_dropweapon) && isstring(self.script_dropweapon) && self.script_dropweapon != "")
    return true;

  return false;
}

player_weapon_drop(weapon_name) {
  if(issubstr(tolower(weapon_name), "usrpg"))
    return "usrpg_player_sp";
  else if(issubstr(tolower(weapon_name), "rpg"))
    return "rpg_player_sp";
  else if(issubstr(tolower(weapon_name), "panzerschreck"))
    return "panzerschreck_player_sp";

  return weapon_name;
}

deleteatlimit() {
  wait 30.0;
  self delete();
}

shownotetrack(note) {
  if(getdebugdvar("scr_shownotetracks") != "on" && getdebugdvarint("scr_shownotetracks") != self getentnum()) {
    return;
  }
  self endon("death");
  anim.shownotetrackspeed = 30;
  anim.shownotetrackduration = 30;

  if(!isDefined(self.a.shownotetrackoffset)) {
    thisoffset = 0;
    self.a.shownotetrackoffset = 10;
    self thread reduceshownotetrackoffset();
  } else {
    thisoffset = self.a.shownotetrackoffset;
    self.a.shownotetrackoffset = self.a.shownotetrackoffset + 10;
  }

  duration = anim.shownotetrackduration + int(20.0 * thisoffset / anim.shownotetrackspeed);
  color = (0.5, 0.75, 1);

  if(note == "end" || note == "finish")
    color = (0.25, 0.4, 0.5);
  else if(note == "undefined")
    color = (1, 0.5, 0.5);

  for(i = 0; i < duration; i++) {
    if(duration - i <= anim.shownotetrackduration)
      amnt = 1.0 * (i - (duration - anim.shownotetrackduration)) / anim.shownotetrackduration;
    else
      amnt = 0.0;

    time = 1.0 * i / 20;
    alpha = 1.0 - amnt * amnt;
    pos = self geteye() + (0, 0, 20 + anim.shownotetrackspeed * time - thisoffset);
    print3d(pos, note, color, alpha);
    wait 0.05;
  }

}

reduceshownotetrackoffset() {
  self endon("death");

  while(self.a.shownotetrackoffset > 0) {
    wait 0.05;
    self.a.shownotetrackoffset = self.a.shownotetrackoffset - anim.shownotetrackspeed * 0.05;
  }

  self.a.shownotetrackoffset = undefined;
}

handledogsoundnotetracks(note) {
  if(note == "sound_dogstep_run_default") {
    self playsound("fly_dog_step_run_default");
    return true;
  }

  prefix = getsubstr(note, 0, 5);

  if(prefix != "sound")
    return false;

  alias = "aml" + getsubstr(note, 5);

  if(isalive(self))
    self thread play_sound_on_tag_endon_death(alias, "tag_eye");
  else
    self thread play_sound_in_space(alias, self gettagorigin("tag_eye"));

  return true;
}

registernotetracks() {
    anim.notetracks["anim_pose = \"stand\""] = ::notetrackposestand;
    anim.notetracks["anim_pose = \"crouch\""] = ::notetrackposecrouch;
    anim.notetracks["anim_pose = \"prone\""] = ::notetrackposeprone;
    anim.notetracks["anim_pose = \"crawl\""] = ::notetrackposecrawl;
    anim.notetracks["anim_pose = \"back\""] = ::notetrackposeback;
    anim.notetracks["anim_movement = \"stop\""] = ::notetrackmovementstop;
    anim.notetracks["anim_movement = \"walk\""] = ::notetrackmovementwalk;
    anim.notetracks["anim_movement = \"run\""] = ::notetrackmovementrun;
    anim.notetracks["gunhand = (gunhand)_left"] = ::notetrackgunhand;
    anim.notetracks["anim_gunhand = \"left\""] = ::notetrackgunhand;
    anim.notetracks["anim_gunhand = \"leftright\""] = ::notetrackgunhand;
    anim.notetracks["gunhand = (gunhand)_right"] = ::notetrackgunhand;
    anim.notetracks["anim_gunhand = \"right\""] = ::notetrackgunhand;
    anim.notetracks["anim_gunhand = \"none\""] = ::notetrackgunhand;
    anim.notetracks["gun drop"] = ::notetrackgundrop;
    anim.notetracks["dropgun"] = ::notetrackgundrop;
    anim.notetracks["gun_2_chest"] = ::notetrackguntochest;
    anim.notetracks["gun_2_back"] = ::notetrackguntoback;
    anim.notetracks["chest_2_back"] = ::notetrackchesttoback;
    anim.notetracks["pistol_pickup"] = ::notetrackpistolpickup;
    anim.notetracks["pistol_putaway"] = ::notetrackpistolputaway;
    anim.notetracks["drop clip"] = ::notetrackdropclip;
    anim.notetracks["refill clip"] = ::notetrackrefillclip;
    anim.notetracks["reload done"] = ::notetrackrefillclip;
    anim.notetracks["load_shell"] = ::notetrackloadshell;
    anim.notetracks["weapon_switch"] = ::notetrackweaponswitch;
    anim.notetracks["gravity on"] = ::notetrackgravity;
    anim.notetracks["gravity off"] = ::notetrackgravity;
    anim.notetracks["bodyfall large"] = ::notetrackbodyfall;
    anim.notetracks["bodyfall small"] = ::notetrackbodyfall;
    anim.notetracks["footstep"] = ::notetrackfootstep;
    anim.notetracks["step"] = ::notetrackfootstep;
    anim.notetracks["footstep_right_large"] = ::notetrackfootstep;
    anim.notetracks["footstep_right_small"] = ::notetrackfootstep;
    anim.notetracks["footstep_left_large"] = ::notetrackfootstep;
    anim.notetracks["footstep_left_small"] = ::notetrackfootstep;
    anim.notetracks["footscrape"] = ::notetrackfootscrape;
    anim.notetracks["land"] = ::notetrackland;
    anim.notetracks["start_ragdoll"] = ::notetrackstartragdoll;
    anim.notetracks["become_corpse"] = ::notetrackbecomecorpse;
    anim.notetracks["fire"] = ::notetrackfire;
    anim.notetracks["fire_spray"] = ::notetrackfirespray;
    anim.notetracks["fire spray"] = ::notetrackfirespray;
    anim.notetracks["lookat = \"player\""] = ::notetracklookatplayer;
    anim.notetracks["headlookat = \"player\""] = ::notetrackheadlookatplayer;
    anim.notetracks["lookat = \""
      "] = ::notetrackclearlookat;
      anim.notetracks["hide"] = ::notetrackhide; anim.notetracks["show"] = ::notetrackshow;
    }

    notetrackhide(note, flagname) {
      self hide();
      self notify("hide");
    }

    notetrackshow(note, flagname) {
      self show();
      self notify("show");
    }

    notetracklookatplayer(note, flagname) {
      if(!issentient(self)) {
        return;
      }
      relax_ik_headtracking_limits();
      setsaveddvar("ik_dvar_lookatentity_notorso", 0);
      self.lookat_set_in_anim = 1;
      self lookatentity(get_players()[0]);
    }

    notetrackheadlookatplayer(note, flagname) {
      if(!issentient(self)) {
        return;
      }
      relax_ik_headtracking_limits();
      setsaveddvar("ik_dvar_lookatentity_notorso", 1);
      self.lookat_set_in_anim = 1;
      self lookatentity(get_players()[0]);
    }

    notetrackclearlookat(note, flagname) {
      if(!issentient(self)) {
        return;
      }
      restore_ik_headtracking_limits();
      self.lookat_set_in_anim = 0;
      self lookatentity();
    }

    notetrackfire(note, flagname) {
      if(!issentient(self)) {
        return;
      }
      if(isDefined(anim.fire_notetrack_functions[self.a.script]))
        thread[[anim.fire_notetrack_functions[self.a.script]]]();
      else
        thread[[animscripts\shared::shootnotetrack]]();
    }

    notetrackstopanim(note, flagname) {
    }

    notetrackstartragdoll(note, flagname) {
      if(isDefined(self.noragdoll)) {
        return;
      }
      do_ragdoll_death();
    }

    notetrackbecomecorpse(note, flagname) {
      become_corpse();
    }

    setanimmode(animmode, waittime) {
      if(isDefined(waittime))
        wait(waittime);

      if(isDefined(self))
        self animmode(animmode);
    }

    notetrackmovementstop(note, flagname) {
      if(issentient(self))
        self.a.movement = "stop";
    }

    notetrackmovementwalk(note, flagname) {
      if(issentient(self))
        self.a.movement = "walk";
    }

    notetrackmovementrun(note, flagname) {
      if(issentient(self))
        self.a.movement = "run";
    }

    notetrackposestand(note, flagname) {
      if(issentient(self)) {
        if(self.a.pose == "prone") {
          self orientmode("face default");
          self exitpronewrapper(1.0);
        }

        self.a.pose = "stand";
        self notify("entered_pose" + "stand");
      }
    }

    notetrackposecrouch(note, flagname) {
      if(issentient(self)) {
        if(self.a.pose == "prone") {
          self orientmode("face default");
          self exitpronewrapper(1.0);
        }

        self.a.pose = "crouch";
        self notify("entered_pose" + "crouch");

        if(self.a.crouchpain) {
          self.a.crouchpain = 0;
          self.health = 150;
        }
      }
    }

    #using_animtree("generic_human");

    notetrackposeprone(note, flagname) {
      if(issentient(self)) {
        self setproneanimnodes(-45, 45, % prone_legs_down, % exposed_aiming, % prone_legs_up);
        self enterpronewrapper(1.0);
        self.a.pose = "prone";
        self notify("entered_pose" + "prone");
      }
    }

    notetrackposecrawl(note, flagname) {
      if(issentient(self)) {
        self setproneanimnodes(-45, 45, % prone_legs_down, % exposed_aiming, % prone_legs_up);
        self enterpronewrapper(1.0);
        self.a.pose = "prone";
        self notify("entered_pose" + "prone");
      }
    }

    notetrackposeback(note, flagname) {
      if(self.a.pose == "prone")
        self exitpronewrapper(1.0);

      self.a.pose = "back";
      self notify("entered_pose" + "back");
      self.a.movement = "stop";
    }

    notetrackgunhand(note, flagname) {
      if(issubstr(note, "leftright")) {
        animscripts\shared::placeweaponon(self.weapon, "left");
        self thread placeweapononrightoninterrupt();
      } else if(issubstr(note, "left")) {
        animscripts\shared::placeweaponon(self.weapon, "left");
        self notify("placed_weapon_on_left");
      } else if(issubstr(note, "right")) {
        animscripts\shared::placeweaponon(self.weapon, "right");
        self notify("placed_weapon_on_right");
      } else if(issubstr(note, "none"))
        animscripts\shared::placeweaponon(self.weapon, "none");
    }

    placeweapononrightoninterrupt() {
      self endon("death");
      self endon("placed_weapon_on_right");
      self waittill("killanimscript");

      if(aihasweapon(self.weapon))
        animscripts\shared::placeweaponon(self.weapon, "right");
    }

    notetrackgundrop(note, flagname) {
      self.lastweapon = self.weapon;
      primaryweapon = self.primaryweapon;
      secondaryweapon = self.secondaryweapon;
      pistolonlyai = aihasonlypistol();
      self animscripts\shared::dropaiweapon();

      if(self.lastweapon == primaryweapon)
        self setcurrentweapon(self.secondaryweapon);
      else if(self.lastweapon == secondaryweapon)
        self setcurrentweapon(self.primaryweapon);

      self animscripts\anims::clearanimcache();
    }

    notetrackguntochest(note, flagname) {
      animscripts\shared::placeweaponon(self.weapon, "chest");
    }

    notetrackguntoback(note, flagname) {
      animscripts\shared::placeweaponon(self.weapon, "back");
      self setcurrentweapon(self.primaryweapon);
      self.bulletsinclip = weaponclipsize(self.weapon);
      self animscripts\anims::clearanimcache();
    }

    notetrackchesttoback(note, flagname) {
      assert(hassecondaryweapon());
      animscripts\shared::placeweaponon(getsecondaryweapon(), "back");
    }

    notetrackpistolpickup(note, flagname) {
      if(self.sidearm != "" && self.sidearm != "none") {
        animscripts\shared::placeweaponon(self.sidearm, "right");
        self.bulletsinclip = weaponclipsize(self.weapon);
        self notify("weapon_switch_done");
      }
    }

    notetrackpistolputaway(note, flagname) {
      animscripts\shared::placeweaponon(self.weapon, "none");
      setcurrentweapon(self.primaryweapon);
      self.bulletsinclip = weaponclipsize(self.weapon);
      self animscripts\anims::clearanimcache();
    }

    notetrackweaponswitch(note, flagname) {
      assert(hassecondaryweapon(), "no secondary weapon available! check the aitype for this actor. ");

      if(self.weapon == self.primaryweapon) {
        if(self.weapon != "none")
          self animscripts\shared::placeweaponon(self.weapon, "back");

        self animscripts\shared::placeweaponon(self.secondaryweapon, "right");
      } else {
        if(self.weapon != "none")
          self animscripts\shared::placeweaponon(self.weapon, "back");

        self animscripts\shared::placeweaponon(self.primaryweapon, "right");
      }

      clipsize = weaponclipsize(self.weapon);

      if(needtoreload(0.5)) {
        if(clipsize > 1)
          self.bulletsinclip = int(clipsize * 0.5);
        else
          self.bulletsinclip = clipsize;
      } else if(self.bulletsinclip > clipsize)
        self.bulletsinclip = clipsize;

      self notify("complete_weapon_switch");
      self.lastweapon = self.weapon;
    }

    notetrackdropclip(note, flagname) {
    }

    notetrackrefillclip(note, flagname) {
      if(self.weaponclass == "rocketlauncher")
        self showrocket();

      self animscripts\weaponlist::refillclip();
    }

    notetrackloadshell(note, flagname) {
    }

    notetrackgravity(note, flagname) {
      if(issubstr(note, "on"))
        self animmode("gravity");
      else if(issubstr(note, "off"))
        self animmode("nogravity");
    }

    notetrackbodyfall(note, flagname) {
      if(isDefined(self.groundtype))
        groundtype = self.groundtype;
      else
        groundtype = "dirt";

      if(issubstr(note, "large"))
        self playsound("fly_bodyfall_large_" + groundtype);
      else if(issubstr(note, "small"))
        self playsound("fly_bodyfall_small_" + groundtype);
    }

    notetrackfootstep(note, flagname) {
    }

    notetrackfootscrape(note, flagname) {
      if(isDefined(self.groundtype))
        groundtype = self.groundtype;
      else
        groundtype = "dirt";

      self playsound("fly_step_scrape_" + groundtype);
    }

    notetrackland(note, flagname) {
      if(isDefined(self.groundtype))
        groundtype = self.groundtype;
      else
        groundtype = "dirt";

      if(isplayer(self))
        self playsound("fly_land_plr_" + groundtype);
      else
        self playsound("fly_land_npc_" + groundtype);
    }

    handlenotetrack(note, flagname, customfunction, var1) {
      self thread shownotetrack(note);

      if(isai(self) && self.isdog) {
        if(handledogsoundnotetracks(note))
          return;
      }

      if(!(isDefined(self.ignore_vo_notetracks) && self.ignore_vo_notetracks)) {
        a_vo_note = strtok(note, "#");

        if(a_vo_note[0] == "vox") {
          assert(isDefined(a_vo_note[1]), "VO alias not defined after a #vox notetrack");
          self thread maps\_dialog::say_dialog(a_vo_note[1], undefined, 1);
        }
      }

      notetrackfunc = anim.notetracks[note];

      if(isDefined(notetrackfunc))
        return [
          [notetrackfunc]
        ](note, flagname);

      switch (note) {
        case "end":
        case "finish":
        case "undefined":
          return note;
        case "swish small":
          self thread play_sound_in_space("wpn_melee_swing_large", self gettagorigin("TAG_WEAPON_RIGHT"));
          break;
        case "swish large":
          self thread play_sound_in_space("wpn_melee_swing_large", self gettagorigin("TAG_WEAPON_RIGHT"));
          break;
        case "no death":
          self.a.nodeath = 1;
          break;
        case "no pain":
          self disable_pain();
          break;
        case "allow pain":
          self enable_pain();
          break;
        case "swap taghelmet to tagleft":
          if(isDefined(self.hatmodel)) {
            if(isDefined(self.helmetsidemodel)) {
              self detach(self.helmetsidemodel, "TAG_HELMETSIDE");
              self.helmetsidemodel = undefined;
            }

            self detach(self.hatmodel, "");
            self attach(self.hatmodel, "TAG_WEAPON_LEFT");
            self.hatmodel = undefined;
          }

          break;
        case "stop anim":
          anim_stopanimscripted(0.2);
          return note;
        case "stop scene":
          anim_stopscene(0.2);
          return note;
        default:
          if(isDefined(customfunction)) {
            if(!isDefined(var1))
              return [
                [customfunction]
              ](note);
            else
              return [
                [customfunction]
              ](note, var1);
          }

          break;
      }
    }

    donotetracks(flagname, customfunction, debugidentifier, var1) {
      for(;;) {
        self waittill(flagname, note);

        if(!isDefined(note))
          note = "undefined";

        val = self handlenotetrack(note, flagname, customfunction, var1);

        if(isDefined(val))
          return val;
      }
    }

    donotetracksintercept(flagname, interceptfunction, debugidentifier) {
      assert(isDefined(interceptfunction));

      for(;;) {
        self waittill(flagname, note);

        if(!isDefined(note))
          note = "undefined";

        intercepted = [
          [interceptfunction]
        ](note);

        if(isDefined(intercepted) && intercepted) {
          continue;
        }
        val = self handlenotetrack(note, flagname);

        if(isDefined(val))
          return val;
      }
    }

    donotetrackspostcallback(flagname, postfunction) {
      assert(isDefined(postfunction));

      for(;;) {
        self waittill(flagname, note);

        if(!isDefined(note))
          note = "undefined";

        val = self handlenotetrack(note, flagname);
        [
          [postfunction]
        ](note);

        if(isDefined(val))
          return val;
      }
    }

    donotetracksforever(flagname, killstring, customfunction, debugidentifier) {
      donotetracksforeverproc(::donotetracks, flagname, killstring, customfunction, debugidentifier);
    }

    donotetracksforeverintercept(flagname, killstring, interceptfunction, debugidentifier) {
      donotetracksforeverproc(::donotetracksintercept, flagname, killstring, interceptfunction, debugidentifier);
    }

    donotetracksforeverproc(notetracksfunc, flagname, killstring, customfunction, debugidentifier) {
      if(isDefined(killstring))
        self endon(killstring);

      self endon("killanimscript");

      if(!isDefined(debugidentifier))
        debugidentifier = "undefined";

      for(;;) {
        time = gettime();
        returnednote = [
          [notetracksfunc]
        ](flagname, customfunction, debugidentifier);
        timetaken = gettime() - time;

        if(timetaken < 0.05) {
          time = gettime();
          returnednote = [
            [notetracksfunc]
          ](flagname, customfunction, debugidentifier);
          timetaken = gettime() - time;

          if(timetaken < 0.05) {
            println(gettime() + " " + debugidentifier + " animscriptsshared::DoNoteTracksForever is trying to cause an infinite loop on anim " + flagname + ", returned " + returnednote + ".");

            wait(0.05 - timetaken);
          }
        }
      }
    }

    donotetracksfortime(time, flagname, customfunction, debugidentifier) {
      ent = spawnstruct();
      ent thread donotetracksfortimeendnotify(time);
      donotetracksfortimeproc(::donotetracksforever, time, flagname, customfunction, debugidentifier, ent);
    }

    donotetracksfortimeintercept(time, flagname, interceptfunction, debugidentifier) {
      ent = spawnstruct();
      ent thread donotetracksfortimeendnotify(time);
      donotetracksfortimeproc(::donotetracksforeverintercept, time, flagname, interceptfunction, debugidentifier, ent);
    }

    donotetracksfortimeproc(donotetracksforeverfunc, time, flagname, customfunction, debugidentifier, ent) {
      ent endon("stop_notetracks");
      [
        [donotetracksforeverfunc]
      ](flagname, undefined, customfunction, debugidentifier);
    }

    donotetracksfortimeendnotify(time) {
      wait(time);
      self notify("stop_notetracks");
    }

    shootnotetrack() {
      waittillframeend;
      now = gettime();

      if(now > self.a.lastshoottime) {
        self.a.lastshoottime = now;
        self shootenemywrapper();
        self decrementbulletsinclip();

        if(self.weaponclass == "rocketlauncher")
          self.a.rockets--;
      }
    }

    fire_straight() {
      if(self.a.weaponpos["right"] == "none" && self.a.weaponpos["left"] == "none") {
        return;
      }
      if(isDefined(self.dontshootstraight)) {
        shootnotetrack();
        return;
      }

      weaporig = self gettagorigin("tag_weapon");
      dir = anglestoforward(self gettagangles("tag_weapon"));
      pos = weaporig + vectorscale(dir, 1000);
      self.a.lastshoottime = gettime();
      self shoot(1, pos);
      self decrementbulletsinclip();
    }

    notetrackfirespray(note, flagname) {
      if(self.a.weaponpos["right"] == "none") {
        return;
      }
      weaporig = self gettagorigin("tag_weapon");
      dir = anglestoforward(self gettagangles("tag_weapon"));
      hitenemy = 0;

      if(issentient(self.enemy) && isalive(self.enemy) && self canshoot(self.enemy getshootatpos())) {
        enemydir = vectornormalize(self.enemy geteye() - weaporig);

        if(vectordot(dir, enemydir) > cos(10))
          hitenemy = 1;
      }

      if(hitenemy)
        self shootenemywrapper();
      else {
        dir = dir + ((randomfloat(2) - 1) * 0.1, (randomfloat(2) - 1) * 0.1, (randomfloat(2) - 1) * 0.1);
        pos = weaporig + vectorscale(dir, 1000);
        self shootposwrapper(pos);
      }

      self decrementbulletsinclip();
    }

    getpredictedaimyawtoshootentorpos(time) {
      if(!isDefined(self.shootent)) {
        if(!isDefined(self.shootpos))
          return 0;

        return getaimyawtopoint(self.shootpos);
      }

      predictedpos = self.shootent.origin + vectorscale(self.shootentvelocity, time);
      return getaimyawtopoint(predictedpos);
    }

    getaimyawtoshootentorpos() {
      if(!isDefined(self.shootent)) {
        if(!isDefined(self.shootpos))
          return 0;

        return getaimyawtopoint(self.shootpos);
      }

      return getaimyawtopoint(self.shootent getshootatpos(self));
    }

    getaimpitchtoshootentorpos() {
      pitch = getpitchtoshootentorpos();

      if(self.a.script == "cover_crouch" && isDefined(self.a.covermode) && self.a.covermode == "lean")
        pitch = pitch - anim.covercrouchleanpitch;

      return pitch;
    }

    getpitchtoshootentorpos() {
      if(!isDefined(self.shootent)) {
        if(!isDefined(self.shootpos))
          return 0;

        return animscripts\combat_utility::getpitchtospot(self.shootpos);
      }

      return animscripts\combat_utility::getpitchtospot(self.shootent getshootatpos(self));
    }

    getaimyawtopoint(point) {
      yaw = getyawtospot(point);
      dist = distance(self.origin, point);

      if(dist > 3) {
        anglefudge = asin(-3 / dist);
        yaw = yaw + anglefudge;
      }

      yaw = angleclamp180(yaw);
      return yaw;
    }

    trackshootentorpos() {
      self animscripts\shared::setaiminganims( % aim_2, % aim_4, % aim_6, % aim_8);
      self animscripts\shared::trackloopstart();
    }

    stoptracking() {
      self notify("stop tracking");
    }

    trackloopstart() {
      self notify("trackLoopStart");
      self.pausetrackloop = 0;

      if(shoulddebugaiming())
        recordenttext("TrackLoop: Running", self, level.color_debug["red"], "Animscript");

    }

    tracklooppausethread() {
      self endon("death");

      while(true) {
        self waittill_any("killanimscript", "stop tracking", "melee");
        self.pausetrackloop = 1;

        if(shoulddebugaiming())
          recordenttext("TrackLoop: Paused", self, level.color_debug["red"], "Animscript");

      }
    }

    tracklooppacer() {
      self endon("death");
      wait 0.05;
      self notify("trackLoopStart");
    }

    scriptneedstagaim() {
      if(isDefined(self.a.script)) {
        if(self.a.script == "move" || self.a.script == "cover_right" || self.a.script == "cover_left" || self.a.script == "cover_pillar")
          return true;
      }

      if(isDefined(self.a.usetagaim) && self.a.usetagaim)
        return true;

      return false;
    }

    trackloopgetshootfrompos() {
      origin = undefined;

      if(scriptneedstagaim()) {
        origin = self gettagorigin("tag_aim");

        if(!isDefined(origin) && getdvarint(#"_id_5CBE6F6A"))
          println("no tag_aim in model " + self.model);

      }

      if(!isDefined(origin)) {
        eyeheight = self geteyeapprox()[2];

        if(self.a.pose == "crouch")
          eyeheight = self.origin[2] + (eyeheight - self.origin[2]) * 0.5;

        origin = (self.origin[0], self.origin[1], eyeheight);
      }

      return origin;
    }

    trackloopgetshootfromangles() {
      angles = undefined;

      if(scriptneedstagaim()) {
        angles = self gettagangles("tag_aim");

        if(!isDefined(angles) && getdvarint(#"_id_5CBE6F6A"))
          println("no tag_aim in model " + self.model);

      }

      if(!isDefined(angles))
        angles = self.angles;

      return angles;
    }

    shoulddebugaiming() {
      if(getdvarint(#"_id_5CBE6F6A")) {
        ai_entnum = getdvarint(#"ai_debugEntIndex");

        if(ai_entnum == -1 || ai_entnum == self getentitynumber())
          return true;
      }

      return false;

    }

    trackloop() {
      self endon("death");
      self waittill("trackLoopStart");
      prevyawdelta = 0;
      prevpitchdelta = 0;
      prevaim2 = self.a.aim_2;
      yawdelta = 0;
      pitchdelta = 0;

      if(self.isdog) {
        domaxanglecheck = 0;
        self.shootent = self.enemy;
      } else
        domaxanglecheck = 1;

      firstframe = 1;
      self.pausetrackloop = 0;
      self thread tracklooppausethread();
      shootfromangles = self trackloopgetshootfromangles();
      prevshootfromyawangle = shootfromangles[1];
      prevshootfrompitchangle = shootfromangles[0];

      for(;;) {
        debugaiming = 0;

        if(shoulddebugaiming())
          debugaiming = 1;

        rightaimlimit = self.rightaimlimit;
        leftaimlimit = self.leftaimlimit;
        upaimlimit = self.upaimlimit;
        downaimlimit = self.downaimlimit;

        if(prevyawdelta > rightaimlimit)
          prevyawdelta = rightaimlimit;
        else if(prevyawdelta < leftaimlimit)
          prevyawdelta = leftaimlimit;

        if(prevpitchdelta > upaimlimit)
          prevpitchdelta = upaimlimit;
        else if(prevpitchdelta < downaimlimit)
          prevpitchdelta = downaimlimit;

        aiminganimschanged = 0;
        aimblendtime = 0.05;

        if(prevaim2 != self.a.aim_2) {
          aiminganimschanged = 1;
          aimblendtime = 0;
          prevaim2 = self.a.aim_2;
        }

        incranimaimweight();
        shootfrompos = self trackloopgetshootfrompos();
        shootpos = self.shootpos;

        if(isDefined(self.shootent))
          shootpos = self.shootent getshootatpos();

        if(!isDefined(shootpos) && self animscripts\cqb::shouldcqb())
          shootpos = trackloopgetcqbshootpos(shootfrompos);

        shootfromangles = self trackloopgetshootfromangles();
        shootfromyawangle = shootfromangles[1];
        shootfrompitchangle = shootfromangles[0];
        shootfromyawdelta = angleclamp180(shootfromyawangle - prevshootfromyawangle);
        shootfrompitchdelta = angleclamp180(shootfrompitchangle - prevshootfrompitchangle);

        if(debugaiming) {
          tempangles = (shootfrompitchangle, self.desiredangle, shootfromangles[2]);
          tempvector = anglestoforward(tempangles);
          recordline(shootfrompos, shootfrompos + vectorscale(tempvector, 100), level.color_debug["white"], "Animscript", self);
        }

        if(absangleclamp180(self.angles[1] - self.desiredangle) > 1 && absangleclamp180(self.angles[1] - shootfromangles[1]) < 1) {
          desireddelta = angleclamp180(self.desiredangle - shootfromangles[1]);
          newangledelta = min(11 * 2, abs(desireddelta));
          newangledelta = newangledelta * sign(desireddelta);
          shootfromyawangle = angleclamp180(shootfromangles[1] + newangledelta);
        } else if(abs(shootfromyawdelta) > 11)
          shootfromyawangle = prevshootfromyawangle + 11 * sign(shootfromyawdelta);

        if(abs(shootfrompitchdelta) > 11)
          shootfrompitchangle = prevshootfrompitchangle + 11 * sign(shootfrompitchdelta);

        if(debugaiming) {
          recordenttext("actualAngle: " + shootfromangles[0] + " shootFromPitchAngle: " + shootfrompitchangle + " shootFromPitchDelta: " + shootfrompitchdelta, self, level.color_debug["cyan"], "Animscript");
          recordenttext("actualAngle: " + shootfromangles[1] + " shootFromYawAngle: " + shootfromyawangle + " shootFromYawDelta: " + shootfromyawdelta, self, level.color_debug["orange"], "Animscript");
          facingvector = anglestoforward(shootfromangles);
          recordline(shootfrompos, shootfrompos + vectorscale(facingvector, 100), level.color_debug["blue"], "Animscript", self);
        }

        shootfromangles = (shootfrompitchangle, shootfromyawangle, shootfromangles[2]);

        if(debugaiming) {
          facingvector = anglestoforward(shootfromangles);
          recordline(shootfrompos, shootfrompos + vectorscale(facingvector, 100), level.color_debug["green"], "Animscript", self);

          if(isDefined(shootpos))
            recordline(shootfrompos, shootpos, level.color_debug["red"], "Animscript", self);
        }

        if(!isDefined(shootpos)) {
          assert(!isDefined(self.shootent));

          if(isDefined(self.node) && isDefined(anim.iscombatscriptnode[self.node.type]) && distancesquared(self.origin, self.node.origin) < 256) {
            yawdelta = angleclamp180(shootfromyawangle - self.node.angles[1]);
            pitchdelta = 0;
          } else {
            likelyenemydir = self getanglestolikelyenemypath();

            if(isDefined(likelyenemydir)) {
              yawdelta = angleclamp180(shootfromyawangle - likelyenemydir[1]);
              pitchdelta = angleclamp180(360 - likelyenemydir[0]);
            } else {
              yawdelta = 0;
              pitchdelta = 0;
            }
          }
        } else {
          vectortoshootpos = shootpos - shootfrompos;
          anglestoshootpos = vectortoangles(vectortoshootpos);
          yawdelta = shootfromyawangle - anglestoshootpos[1];
          yawdelta = angleclamp180(yawdelta);
          pitchdelta = shootfrompitchangle - anglestoshootpos[0];
          pitchdelta = angleclamp180(pitchdelta);
        }

        if(domaxanglecheck && !aiminganimschanged && (abs(yawdelta) > 60 || abs(pitchdelta) > 60)) {
          yawdelta = 0;
          pitchdelta = 0;
        } else {
          if(self.gunblockedbywall)
            yawdelta = clamp(yawdelta, -10, 10);

          if(yawdelta > rightaimlimit)
            yawdelta = rightaimlimit;
          else if(yawdelta < leftaimlimit)
            yawdelta = leftaimlimit;

          if(pitchdelta > upaimlimit)
            pitchdelta = upaimlimit;
          else if(pitchdelta < downaimlimit)
            pitchdelta = downaimlimit;
        }

        if(firstframe) {
          firstframe = 0;
          yawdelta = 0;
          pitchdelta = 0;
        } else {
          adjustedmaxyawdeltachange = 5 + abs(shootfromyawdelta);
          adjustedmaxpitchdeltachange = 5 + abs(shootfrompitchdelta);
          yawdeltachange = yawdelta - prevyawdelta;

          if(abs(yawdeltachange) > adjustedmaxyawdeltachange)
            yawdelta = prevyawdelta + adjustedmaxyawdeltachange * sign(yawdeltachange);

          pitchdeltachange = pitchdelta - prevpitchdelta;

          if(abs(pitchdeltachange) > adjustedmaxpitchdeltachange)
            pitchdelta = prevpitchdelta + adjustedmaxpitchdeltachange * sign(pitchdeltachange);
        }

        if(debugaiming) {
          recordenttext("pitchDelta: " + pitchdelta, self, level.color_debug["cyan"], "Animscript");
          recordenttext("yawDelta: " + yawdelta, self, level.color_debug["orange"], "Animscript");
        }

        prevshootfromyawangle = shootfromyawangle;
        prevshootfrompitchangle = shootfrompitchangle;
        prevyawdelta = yawdelta;
        prevpitchdelta = pitchdelta;

        if(yawdelta > 0) {
          assert(yawdelta <= rightaimlimit);
          weight = yawdelta / rightaimlimit * self.a.aimweight;
          self setanimlimited(self.a.aim_4, 0, aimblendtime);
          self setanimlimited(self.a.aim_6, weight, aimblendtime);
        } else if(yawdelta < 0) {
          assert(yawdelta >= leftaimlimit);
          weight = yawdelta / leftaimlimit * self.a.aimweight;
          self setanimlimited(self.a.aim_6, 0, aimblendtime);
          self setanimlimited(self.a.aim_4, weight, aimblendtime);
        }

        if(pitchdelta > 0) {
          assert(pitchdelta <= upaimlimit);
          weight = pitchdelta / upaimlimit * self.a.aimweight;
          self setanimlimited(self.a.aim_2, 0, aimblendtime);
          self setanimlimited(self.a.aim_8, weight, aimblendtime);
        } else if(pitchdelta < 0) {
          assert(pitchdelta >= downaimlimit);
          weight = pitchdelta / downaimlimit * self.a.aimweight;
          self setanimlimited(self.a.aim_8, 0, aimblendtime);
          self setanimlimited(self.a.aim_2, weight, aimblendtime);
        }

        wait 0.05;
        waittillframeend;

        if(self.pausetrackloop) {
          self waittill("trackLoopStart");
          self.pausetrackloop = 0;
          firstframe = 1;
          prevyawdelta = 0;
          prevpitchdelta = 0;
          shootfromangles = self trackloopgetshootfromangles();
          prevshootfromyawangle = shootfromangles[1];
          prevshootfrompitchangle = shootfromangles[0];
        }
      }
    }

    trackloopgetcqbshootpos(shootfrompos) {
      shootpos = undefined;
      selfforward = anglestoforward(self.angles);

      if(isDefined(self.cqb_target)) {
        shootpos = self.cqb_target getshootatpos();
        dir = shootpos - shootfrompos;
        vdot = vectordot(dir, selfforward);

        if(vdot < 0.0 || vdot * vdot < 0.413449 * lengthsquared(dir))
          shootpos = undefined;
      }

      if(!isDefined(shootpos) && isDefined(self.cqb_point_of_interest)) {
        shootpos = self.cqb_point_of_interest;
        dir = shootpos - shootfrompos;
        vdot = vectordot(dir, selfforward);

        if(vdot < 0.0 || vdot * vdot < 0.413449 * lengthsquared(dir))
          shootpos = undefined;
      }

      return shootpos;
    }

    setanimaimweight(goalweight, goaltime) {
      if(!isDefined(goaltime) || goaltime <= 0) {
        self.a.aimweight = goalweight;
        self.a.aimweight_start = goalweight;
        self.a.aimweight_end = goalweight;
        self.a.aimweight_transframes = 0;
      } else {
        if(!isDefined(self.a.aimweight))
          self.a.aimweight = 0;

        self.a.aimweight_start = self.a.aimweight;
        self.a.aimweight_end = goalweight;
        self.a.aimweight_transframes = int(goaltime * 20);
      }

      self.a.aimweight_t = 0;
    }

    incranimaimweight() {
      if(self.a.aimweight_t < self.a.aimweight_transframes) {
        self.a.aimweight_t++;
        t = 1.0 * self.a.aimweight_t / self.a.aimweight_transframes;
        self.a.aimweight = self.a.aimweight_start * (1 - t) + self.a.aimweight_end * t;
      }
    }

    decidenumshotsforburst() {
      numshots = 0;

      if(animscripts\weaponlist::usingsemiautoweapon())
        numshots = anim.semifirenumshots[randomint(anim.semifirenumshots.size)];
      else if(self.fastburst)
        numshots = anim.fastburstfirenumshots[randomint(anim.fastburstfirenumshots.size)];
      else
        numshots = anim.burstfirenumshots[randomint(anim.burstfirenumshots.size)];

      if(numshots <= self.bulletsinclip)
        return numshots;

      assert(self.bulletsinclip >= 0, self.bulletsinclip);

      if(self.bulletsinclip <= 0)
        return 1;

      return self.bulletsinclip;
    }

    decidenumshotsforfull() {
      numshots = self.bulletsinclip;

      if(self.weaponclass == "mg") {
        choice = randomfloat(10);

        if(choice < 3)
          numshots = randomintrange(2, 6);
        else if(choice < 8)
          numshots = randomintrange(6, 12);
        else
          numshots = randomintrange(12, 20);
      }

      return numshots;
    }

    handledropclip(flagname) {
      self endon("killanimscript");
      self endon("abort_reload");

      if(!issentient(self)) {
        return;
      }
      clipmodel = undefined;

      if(self.weaponinfo[self.weapon].useclip)
        clipmodel = getweaponclipmodel(self.weapon);

      if(self.weaponinfo[self.weapon].hasclip) {
        if(isDefined(clipmodel)) {
          self hidepart("tag_clip");
          self thread dropclipmodel(clipmodel, "tag_clip");
          self.weaponinfo[self.weapon].hasclip = 0;
          self thread resetcliponabort(clipmodel);
        }
      }

      for(;;) {
        self waittill(flagname, notetrack);

        switch (notetrack) {
          case "attach clip left":
          case "attach clip right":
            if(isDefined(clipmodel)) {
              self attach(clipmodel, "tag_inhand");
              self hidepart("tag_clip");
              self.a.reloadclipinhand = 1;
              self thread resetcliponabort(clipmodel, "tag_inhand");
            }

            self animscripts\weaponlist::refillclip();
            break;
          case "detach clip left":
          case "detach clip right":
            if(isDefined(clipmodel) && (isDefined(self.a.reloadclipinhand) && self.a.reloadclipinhand)) {
              self.a.reloadclipinhand = 0;
              self detach(clipmodel, "tag_inhand");
              self showpart("tag_clip");
              self notify("clip_detached");
              self.weaponinfo[self.weapon].hasclip = 1;
            }

            return;
        }
      }
    }

    resetcliponabort(clipmodel, currenttag) {
      self notify("clip_detached");
      self endon("clip_detached");
      self waittill_any("killanimscript", "abort_reload");

      if(!isDefined(self)) {
        return;
      }
      self.a.reloadclipinhand = 0;

      if(isDefined(currenttag))
        self detach(clipmodel, currenttag);

      if(isalive(self)) {
        self showpart("tag_clip");
        self.weaponinfo[self.weapon].hasclip = 1;
      } else if(isDefined(currenttag))
        dropclipmodel(clipmodel, currenttag);
    }

    dropclipmodel(clipmodel, tagname) {
      if(isDefined(level.dontdropaiclips)) {
        return;
      }
      origin = self gettagorigin(tagname);
      angles = self gettagangles(tagname);
      dir = anglestoup((0, 0, angles[2])) * -1;
      createdynentandlaunch(clipmodel, origin, angles, origin + vectorscale((0, 0, -1), 70.0), dir);
    }

    movetooriginovertime(origin, time) {
      self endon("killanimscript");
      distsq = distancesquared(self.origin, origin);

      if(distsq > 256 && !self maymovetopoint(origin)) {
        dist = distance(self.origin, origin);

        println("^1Warning: AI starting behavior for node at " + origin + " but could not move to that point. dist= " + dist);

        return;
      }

      self.keepclaimednodeifvalid = 1;
      offset = self.origin - origin;
      frames = int(time * 20);
      offsetreduction = vectorscale(offset, 1.0 / frames);

      for(i = 0; i < frames; i++) {
        offset = offset - offsetreduction;
        self teleport(origin + offset);
        wait 0.05;
      }

      self.keepclaimednodeifvalid = 0;
    }

    returntrue() {
      return true;
    }

    playlookanimation(lookanim, looktime, canstopcallback) {
      if(!isDefined(canstopcallback))
        canstopcallback = ::returntrue;

      for(i = 0; i < looktime * 10; i++) {
        if(isalive(self.enemy)) {
          if(self canseeenemy() && [
              [canstopcallback]
            ]())
            return;
        }

        if(self issuppressedwrapper() && [
            [canstopcallback]
          ]()) {
          return;
        }
        self setanimknoball(lookanim, % body, 1, 0.1);
        wait 0.1;
      }
    }

    getsecondaryweapon() {
      if(isDefined(self.weapon)) {
        if(self.weapon == self.primaryweapon && aihasweapon(self.secondaryweapon) && self.secondaryweaponclass != "pistol")
          return self.secondaryweapon;
        else if(self.weapon == self.secondaryweapon && aihasweapon(self.primaryweapon) && self.secondaryweaponclass != "pistol")
          return self.primaryweapon;
      }

      return undefined;
    }

    hassecondaryweapon() {
      weapon = getsecondaryweapon();
      return isDefined(weapon) && weapon != "none";
    }

    shouldthrowdownweapon() {
      if(!hassecondaryweapon())
        return false;

      if(getdvarint(#"_id_5F9CD874"))
        return true;

      if(self.weaponclass == "none")
        return false;

      if(isDefined(self.secondaryweapon) && self.weapon == self.secondaryweapon)
        return false;

      if(isDefined(self.shootpos)) {
        distsqtoshootpos = lengthsquared(self.origin - self.shootpos);

        if(self.weaponclass == "rocketlauncher" && (distsqtoshootpos < 262144 || self.a.rockets < 1))
          return true;
      }

      return false;
    }

    throwdownweapon() {
      self endon("killanimscript");
      swapanim = animarray("throw_down_weapon");

      if(!isDefined(swapanim) || swapanim == % void) {
        return;
      }
      self thread throwdownweaponfallback();

      self animscripts\debug::debugpushstate("throwdownWeapon");

      self animmode("angle deltas");
      self setflaggedanimknoballrestart("weapon swap", swapanim, % body, 1, 0.1, 1);
      note = "";

      while(note != "end") {
        self waittill("weapon swap", note);

        if(note == "dropgun" || note == "gun drop")
          dropaiweapon();

        if(note == "anim_gunhand = \"right\"") {
          assert(hassecondaryweapon(), "self.secondaryweapon not defined! check the aitype for this actor. ");
          self animscripts\shared::placeweaponon(self.secondaryweapon, "right");
        }
      }

      if(self.bulletsinclip > weaponclipsize(self.weapon))
        self.bulletsinclip = weaponclipsize(self.weapon);

      self notify("throw_down_weapon_done");
      self maps\_gameskill::didsomethingotherthanshooting();

      self animscripts\debug::debugpopstate();

    }

    throwdownweaponfallback() {
      self endon("throw_down_weapon_done");
      self waittill("killanimscript");
      self animscripts\shared::placeweaponon(self.secondaryweapon, "right");

      self animscripts\debug::debugpopstate();

    }

    shouldswitchweapons() {
      if(!hassecondaryweapon())
        return false;

      if(self.a.atpillarnode)
        return false;

      if(self.a.pose == "prone")
        return false;

      if(isDefined(self.a.weapon_switch_asap) && self.a.weapon_switch_asap) {
        assert(hassecondaryweapon(), "self.secondaryweapon not defined! check the aitype for this actor. ");
        self.a.weapon_switch_asap = 0;
        return true;
      } else if(!(isDefined(level.supportsaiweaponswitching) && level.supportsaiweaponswitching))
        return false;

      if(gettime() - self.a.weapon_switch_time < 6000)
        return false;

      curweaponclass = weaponanims();

      if(curweaponclass == "none")
        return true;

      if(shouldswitchweaponfordistance())
        return true;

      if(shouldforcebehavior("switchWeapons"))
        return true;

      return false;
    }

    shouldswitchweaponfordistance() {
      if(isDefined(self.shootpos)) {
        distsqtoshootpos = lengthsquared(self.origin - self.shootpos);
        shoulduseweapon = undefined;

        assert(isDefined(self.primaryweapon_fightdist_minsq));
        assert(isDefined(self.secondaryweapon_fightdist_minsq));
        withinprimaryrange = self.primaryweapon_fightdist_minsq < distsqtoshootpos && distsqtoshootpos < self.primaryweapon_fightdist_maxsq;
        withinsecondaryrange = self.secondaryweapon_fightdist_minsq < distsqtoshootpos && distsqtoshootpos < self.secondaryweapon_fightdist_maxsq;

        if(withinprimaryrange && withinsecondaryrange || !withinprimaryrange && !withinsecondaryrange) {
          if(isDefined(self.enemy)) {
            println("getweaponaccuracy for:" + self.primaryweapon);

            primaryweapon_accuracy = getweaponaccuracy(self, self.primaryweapon);

            println("getweaponaccuracy for:" + self.secondaryweapon);

            secondaryweapon_accuracy = getweaponaccuracy(self, self.secondaryweapon);

            if(primaryweapon_accuracy > secondaryweapon_accuracy)
              shoulduseweapon = self.primaryweapon;
            else
              shoulduseweapon = self.secondaryweapon;
          } else
            shoulduseweapon = self.weapon;
        } else if(withinprimaryrange)
          shoulduseweapon = self.primaryweapon;
        else if(withinsecondaryrange)
          shoulduseweapon = self.secondaryweapon;

        assert(isDefined(shoulduseweapon));

        if(self.weapon != shoulduseweapon) {
          if(self.a.weapon_switch_for_distance_time < 0)
            self.a.weapon_switch_for_distance_time = gettime() + randomfloatrange(2, 4) * 1000;

          if(isexposed() && gettime() < self.a.weapon_switch_for_distance_time)
            return false;

          return true;
        }

        self.a.weapon_switch_for_distance_time = -1;
        return false;
      }

      self.a.weapon_switch_for_distance_time = -1;
      return false;
    }

    isexposed() {
      if(self.a.script == "cover_crouch" || self.a.script == "cover_stand") {
        if(isDefined(self.a.covermode) && self.a.covermode == "Hide")
          return false;
      } else if(self.a.script == "cover_left" || self.a.script == "cover_right" || self.a.script == "cover_pillar") {
        if(!isDefined(self.corneraiming) || !self.corneraiming)
          return false;
      }

      return true;
    }

    getweaponswitchanim() {
      animname = "weapon_switch";

      if(!isexposed()) {
        animname = "weapon_switch_cover";

        if(getdvarint(#"_id_D2DF7981") == 1)
          animname = "weapon_switch_quadrants_cover";
        else if(getdvarint(#"_id_D2DF7981") == 2)
          animname = "weapon_putaway_cover";
      } else if(getdvarint(#"_id_D2DF7981") == 1)
        animname = "weapon_switch_quadrants";
      else if(getdvarint(#"_id_D2DF7981") == 2)
        animname = "weapon_putaway";

      if(isarray(animarray(animname)))
        return animarraypickrandom(animname);

      return animarray(animname);
    }

    getweaponpulloutanim() {
      animname = "weapon_pullout";

      if(!isexposed())
        animname = "weapon_pullout_cover";

      assert(animarrayexist(animname));

      if(isarray(animarray(animname)))
        return animarraypickrandom(animname);

      return animarray(animname);
    }

    switchweapons() {
      swapanim = getweaponswitchanim();

      if(!isDefined(swapanim)) {
        return;
      }
      self animscripts\debug::debugpushstate("switchWeapons");

      self animmode("angle deltas");
      self setflaggedanimknoballrestart("weapon swap", swapanim, % body, 1, 0.1, 1);
      self donotetracks("weapon swap");

      if(getdvarint(#"_id_D2DF7981") == 2) {
        pulloutanim = getweaponpulloutanim();

        if(isDefined(swapanim)) {
          self setflaggedanimknoballrestart("weapon swap", pulloutanim, % body, 1, 0.1, 1);
          self donotetracks("weapon swap");
        }
      }

      self clearanim( % weapon_switch, 0.2);
      self.a.weapon_switch_time = gettime();
      self.a.weapon_switch_for_distance_time = -1;
      self notify("weapon_switched");
      self maps\_gameskill::didsomethingotherthanshooting();

      self animscripts\debug::debugpopstate();

    }

    isenemyinexplodablevolume() {
      if(!isDefined(self.enemy))
        return false;

      if(isDefined(self.enemy._explodable_targets)) {
        for(i = 0; i < self.enemy._explodable_targets.size; i++) {
          if(isDefined(self.enemy._explodable_targets[i]) && self cansee(self.enemy._explodable_targets[i]))
            return true;
        }
      } else if(isDefined(self.enemy.script_exploder) || self.enemy is_destructible())
        return true;

      return false;
    }

    isenemyvulnerablebyrpg() {
      if(isDefined(self.enemy)) {
        isbigdog = isDefined(self.enemy.isbigdog) && self.enemy.isbigdog;
        isasd = isDefined(self.enemy.vehicletype) && issubstr(self.enemy.vehicletype, "metalstorm");
        issentryturret = isDefined(self.enemy.vehicletype) && issubstr(self.enemy.vehicletype, "turret_sentry");

        if(isbigdog || isasd || issentryturret)
          return true;
      }

      return false;
    }

    shouldswitchweaponforsituation() {
      self endon("death");
      secondaryweaponclass = weaponclass(self getsecondaryweapon());
      favorrpgagainstenemy = isenemyinexplodablevolume() || isenemyvulnerablebyrpg();

      if(favorrpgagainstenemy && secondaryweaponclass == "rocketlauncher" && self.weaponclass != "rocketlauncher")
        return true;

      if(!favorrpgagainstenemy && self.weaponclass == "rocketlauncher")
        return true;

      return false;
    }

    setaiminganims(aim_2, aim_4, aim_6, aim_8) {
      assert(isDefined(aim_2));
      assert(isDefined(aim_4));
      assert(isDefined(aim_6));
      assert(isDefined(aim_8));
      self.a.aim_2 = aim_2;
      self.a.aim_4 = aim_4;
      self.a.aim_6 = aim_6;
      self.a.aim_8 = aim_8;
    }

    updatelaserstatus(toggle, skipaimcheck) {
      if(isDefined(toggle) && toggle)
        self.a.laseron = 1;
      else
        self.a.laseron = 0;

      isaimingatenemy = isDefined(skipaimcheck) && skipaimcheck || animscripts\combat_utility::aimedatshootentorpos();

      if(self.a.laseron && canuselaser() && isaimingatenemy)
        self laseron();
      else
        self laseroff();
    }

    canuselaser() {
      if(!(isDefined(self.has_ir) && self.has_ir))
        return 0;

      if(self.a.weaponpos["right"] == "none") {
        return;
      }
      if(weaponanims() != "rifle" && weaponanims() != "mg" && weaponanims() != "smg")
        return 0;

      return isalive(self);
    }