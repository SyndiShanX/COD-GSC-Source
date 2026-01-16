/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: animscripts\notetracks.gsc
********************************/

notetrack_playsound(var_0) {
  if(isdefined(self) && soundexists(var_0))
    self playsound(var_0);
  else {}
}

handledogfootstepnotetracks(var_0) {
  switch (var_0) {
    case "fs_bk_r_lg":
    case "fs_bk_l_lg":
    case "fs_fr_r_lg":
    case "fs_fr_l_lg":
    case "fs_bk_r_sm":
    case "fs_bk_l_sm":
    case "fs_fr_r_sm":
    case "fs_fr_l_sm":
    case "footstep_back_right_large":
    case "footstep_back_left_large":
    case "footstep_front_right_large":
    case "footstep_front_left_large":
    case "footstep_back_right_small":
    case "footstep_back_left_small":
    case "footstep_front_right_small":
    case "footstep_front_left_small":
      var_1 = undefined;

      if(isdefined(self.groundtype)) {
        var_1 = self.groundtype;
        self.lastgroundtype = var_1;
      } else if(isdefined(self.lastgroundtype))
        var_1 = self.lastgroundtype;
      else
        var_1 = "dirt";

      if(var_1 != "dirt" && var_1 != "concrete" && var_1 != "wood" && var_1 != "metal")
        var_1 = "dirt";

      if(var_1 == "concrete")
        var_1 = "cement";

      var_2 = self.moveanimtype;

      if(!isdefined(var_2))
        var_2 = "run";

      var_3 = self isdogbeingdriven() || isdefined(self.controlling_dog);

      if(var_3)
        self playsound("dogstep_plr_" + var_2 + "_" + var_1);
      else
        self playsound("dogstep_" + var_2 + "_" + var_1);

      if(!isdefined(self.bdisablegearsounds) || self.bdisablegearsounds) {
        if(issubstr(var_0, "front_left") || issubstr(var_0, "fr_l")) {
          var_4 = "anml_dog_mvmt_accent";
          var_5 = "anml_dog_mvmt_vest";

          if(var_3) {
            if(!isdefined(self.drivenmovemode) || self.drivenmovemode == "walk")
              var_6 = "_plr";
            else
              var_6 = "_run_plr";
          } else if(var_2 == "walk")
            var_6 = "_npc";
          else
            var_6 = "_run_npc";

          self playsound(var_4 + var_6);
          self playsound(var_5 + var_6);
        }
      }

      return 1;
  }

  return 0;
}

handledogsoundnotetracks(var_0) {
  if(handledogfootstepnotetracks(var_0))
    return 1;

  if(var_0 == "sound_dogstep_run_default") {
    notetrack_playsound("dogstep_run_default");
    return 1;
  }

  var_1 = getsubstr(var_0, 0, 5);

  if(var_1 != "sound")
    return 0;

  var_2 = "anml" + getsubstr(var_0, 5);

  if(soundexists(var_2)) {
    if(isalive(self))
      thread maps\_utility::play_sound_on_tag_endon_death(var_2, "tag_eye");
    else
      thread common_scripts\utility::play_sound_in_space(var_2, self geteye());
  }

  return 1;
}

growling() {
  return isdefined(self.script_growl);
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
  anim.notetracks["anim_aiming = 1"] = ::notetrackalertnessaiming;
  anim.notetracks["anim_aiming = 0"] = ::notetrackalertnessalert;
  anim.notetracks["anim_alertness = causal"] = ::notetrackalertnesscasual;
  anim.notetracks["anim_alertness = alert"] = ::notetrackalertnessalert;
  anim.notetracks["anim_alertness = aiming"] = ::notetrackalertnessaiming;
  anim.notetracks["gunhand = (gunhand)_left"] = ::notetrackgunhand;
  anim.notetracks["anim_gunhand = \"left\""] = ::notetrackgunhand;
  anim.notetracks["gunhand = (gunhand)_right"] = ::notetrackgunhand;
  anim.notetracks["anim_gunhand = \"right\""] = ::notetrackgunhand;
  anim.notetracks["anim_gunhand = \"none\""] = ::notetrackgunhand;
  anim.notetracks["equip_secondary"] = ::notetracksecondaryguntorighthand;
  anim.notetracks["gun drop"] = ::notetrackgundrop;
  anim.notetracks["dropgun"] = ::notetrackgundrop;
  anim.notetracks["gun_2_chest"] = ::notetrackguntochest;
  anim.notetracks["gun_2_back"] = ::notetrackguntoback;
  anim.notetracks["pistol_pickup"] = ::notetrackpistolpickup;
  anim.notetracks["pistol_putaway"] = ::notetrackpistolputaway;
  anim.notetracks["drop clip"] = ::notetrackdropclip;
  anim.notetracks["refill clip"] = ::notetrackrefillclip;
  anim.notetracks["reload done"] = ::notetrackrefillclip;
  anim.notetracks["load_shell"] = ::notetrackloadshell;
  anim.notetracks["pistol_rechamber"] = ::notetrackpistolrechamber;
  anim.notetracks["gravity on"] = ::notetrackgravity;
  anim.notetracks["gravity off"] = ::notetrackgravity;
  anim.notetracks["footstep"] = ::notetrackfootstep;
  anim.notetracks["step"] = ::notetrackfootstep;
  anim.notetracks["footstep_right_large"] = ::notetrackfootstep;
  anim.notetracks["footstep_right_small"] = ::notetrackfootstep;
  anim.notetracks["footstep_left_large"] = ::notetrackfootstep;
  anim.notetracks["footstep_left_small"] = ::notetrackfootstep;
  anim.notetracks["footscrape"] = ::notetrackfootscrape;
  anim.notetracks["land"] = ::notetrackland;
  anim.notetracks["bodyfall large"] = ::notetrackbodyfall;
  anim.notetracks["bodyfall small"] = ::notetrackbodyfall;
  anim.notetracks["crouch_to_prone"] = ::notetrackcrouchtoprone;
  anim.notetracks["crouch_drop"] = ::notetrackcrouchdrop;
  anim.notetracks["pain_small"] = ::notetrackpain;
  anim.notetracks["pain_large"] = ::notetrackpain;
  anim.notetracks["meleeattack_eft"] = ::notetrackmeleeattackeft;
  anim.notetracks["code_move"] = ::notetrackcodemove;
  anim.notetracks["face_enemy"] = ::notetrackfaceenemy;
  anim.notetracks["laser_on"] = ::notetracklaser;
  anim.notetracks["laser_off"] = ::notetracklaser;
  anim.notetracks["start_ragdoll"] = ::notetrackstartragdoll;
  anim.notetracks["fire"] = ::notetrackfire;
  anim.notetracks["fire_spray"] = ::notetrackfirespray;
  anim.notetracks["bloodpool"] = animscripts\death::play_blood_pool;
  anim.notetracks["space_jet_top"] = ::notetrackspacejet;
  anim.notetracks["space_jet_top_1"] = ::notetrackspacejet;
  anim.notetracks["space_jet_top_2"] = ::notetrackspacejet;
  anim.notetracks["space_jet_bottom"] = ::notetrackspacejet;
  anim.notetracks["space_jet_bottom_1"] = ::notetrackspacejet;
  anim.notetracks["space_jet_bottom_2"] = ::notetrackspacejet;
  anim.notetracks["space_jet_left"] = ::notetrackspacejet;
  anim.notetracks["space_jet_left_1"] = ::notetrackspacejet;
  anim.notetracks["space_jet_left_2"] = ::notetrackspacejet;
  anim.notetracks["space_jet_right"] = ::notetrackspacejet;
  anim.notetracks["space_jet_right_1"] = ::notetrackspacejet;
  anim.notetracks["space_jet_right_2"] = ::notetrackspacejet;
  anim.notetracks["space_jet_front"] = ::notetrackspacejet;
  anim.notetracks["space_jet_front_1"] = ::notetrackspacejet;
  anim.notetracks["space_jet_front_2"] = ::notetrackspacejet;
  anim.notetracks["space_jet_back"] = ::notetrackspacejet;
  anim.notetracks["space_jet_back_1"] = ::notetrackspacejet;
  anim.notetracks["space_jet_back_2"] = ::notetrackspacejet;
  anim.notetracks["space_jet_back_3"] = ::notetrackspacejet;
  anim.notetracks["space_jet_back_4"] = ::notetrackspacejet;
  anim.notetracks["space_jet_random"] = ::notetrackspacejet;

  if(isdefined(level._notetrackfx)) {
    var_0 = getarraykeys(level._notetrackfx);

    foreach(var_2 in var_0)
    anim.notetracks[var_2] = ::customnotetrackfx;
  }
}

notetrackfire(var_0, var_1) {
  if(!isdefined(self.script)) {
    return;
  }
  if(isdefined(anim.fire_notetrack_functions[self.script]))
    thread[[anim.fire_notetrack_functions[self.script]]]();
  else
    thread[[::shootnotetrack]]();
}

notetracklaser(var_0, var_1) {
  if(issubstr(var_0, "on"))
    self.a.laseron = 1;
  else
    self.a.laseron = 0;

  animscripts\shared::updatelaserstatus();
}

notetrackstopanim(var_0, var_1) {}

unlinknextframe() {
  wait 0.1;

  if(isdefined(self))
    self unlink();
}

notetrackstartragdoll(var_0, var_1) {
  if(isdefined(self.noragdoll)) {
    return;
  }
  if(isdefined(self.ragdolltime)) {
    return;
  }
  if(!isdefined(self.dont_unlink_ragdoll))
    self unlink();

  animscripts\shared::dropallaiweapons();
  self startragdoll();
}

notetrackmovementstop(var_0, var_1) {
  self.a.movement = "stop";
}

notetrackmovementwalk(var_0, var_1) {
  self.a.movement = "walk";
}

notetrackmovementrun(var_0, var_1) {
  self.a.movement = "run";
}

notetrackalertnessaiming(var_0, var_1) {}

notetrackalertnesscasual(var_0, var_1) {}

notetrackalertnessalert(var_0, var_1) {}

stoponback() {
  animscripts\utility::exitpronewrapper(1.0);
  self.a.onback = undefined;
}

setpose(var_0) {
  self.a.pose = var_0;

  if(isdefined(self.a.onback))
    stoponback();

  self notify("entered_pose" + var_0);
}

notetrackposestand(var_0, var_1) {
  if(self.a.pose == "prone") {
    self orientmode("face default");
    animscripts\utility::exitpronewrapper(1.0);
  }

  setpose("stand");
}

notetrackposecrouch(var_0, var_1) {
  if(self.a.pose == "prone") {
    self orientmode("face default");
    animscripts\utility::exitpronewrapper(1.0);
  }

  setpose("crouch");
}

#using_animtree("generic_human");

notetrackposeprone(var_0, var_1) {
  if(!issentient(self)) {
    return;
  }
  self setproneanimnodes(-45, 45, % prone_legs_down, % exposed_aiming, % prone_legs_up);
  animscripts\utility::enterpronewrapper(1.0);
  setpose("prone");

  if(isdefined(self.a.goingtoproneaim))
    self.a.proneaiming = 1;
  else
    self.a.proneaiming = undefined;
}

notetrackposecrawl(var_0, var_1) {
  if(!issentient(self)) {
    return;
  }
  self setproneanimnodes(-45, 45, % prone_legs_down, % exposed_aiming, % prone_legs_up);
  animscripts\utility::enterpronewrapper(1.0);
  setpose("prone");
  self.a.proneaiming = undefined;
}

notetrackposeback(var_0, var_1) {
  if(!issentient(self)) {
    return;
  }
  setpose("crouch");
  self.a.onback = 1;
  self.a.movement = "stop";
  self setproneanimnodes(-90, 90, % prone_legs_down, % exposed_aiming, % prone_legs_up);
  animscripts\utility::enterpronewrapper(1.0);
}

notetrackgunhand(var_0, var_1) {
  if(issubstr(var_0, "left")) {
    animscripts\shared::placeweaponon(self.weapon, "left");
    self notify("weapon_switch_done");
  } else if(issubstr(var_0, "right")) {
    animscripts\shared::placeweaponon(self.weapon, "right");
    self notify("weapon_switch_done");
  } else if(issubstr(var_0, "none"))
    animscripts\shared::placeweaponon(self.weapon, "none");
}

notetracksecondaryguntorighthand(var_0, var_1) {
  self notify("weapon_switch_done");
  thread placeweapononkillanimscript(self.secondaryweapon, "right");
  self.weapon = self.secondaryweapon;
}

placeweapononkillanimscript(var_0, var_1) {
  self endon("weapon_switch_done");
  self endon("death");
  self waittill("killanimscript");
  animscripts\shared::placeweaponon(var_0, var_1);
}

notetrackgundrop(var_0, var_1) {
  animscripts\shared::dropaiweapon();
  self.lastweapon = self.weapon;
}

notetrackguntochest(var_0, var_1) {
  animscripts\shared::placeweaponon(self.weapon, "chest");
}

notetrackguntoback(var_0, var_1) {
  animscripts\shared::placeweaponon(self.weapon, "back");
  self.weapon = animscripts\utility::getpreferredweapon();
  self.bulletsinclip = weaponclipsize(self.weapon);
}

notetrackpistolpickup(var_0, var_1) {
  animscripts\shared::placeweaponon(self.sidearm, "right");
  self.bulletsinclip = weaponclipsize(self.weapon);
  self notify("weapon_switch_done");
}

notetrackpistolputaway(var_0, var_1) {
  animscripts\shared::placeweaponon(self.weapon, "none");
  self.weapon = animscripts\utility::getpreferredweapon();
  self.bulletsinclip = weaponclipsize(self.weapon);
}

notetrackdropclip(var_0, var_1) {
  thread animscripts\shared::handledropclip(var_1);
}

notetrackrefillclip(var_0, var_1) {
  animscripts\weaponlist::refillclip();
  self.a.needstorechamber = 0;
}

notetrackloadshell(var_0, var_1) {
  notetrack_playsound("weap_reload_shotgun_loop_npc");
}

notetrackpistolrechamber(var_0, var_1) {
  notetrack_playsound("weap_reload_pistol_chamber_npc");
}

notetrackgravity(var_0, var_1) {
  if(issubstr(var_0, "on"))
    self animmode("gravity");
  else if(issubstr(var_0, "off"))
    self animmode("nogravity");
}

notetrackfootstep(var_0, var_1) {
  var_2 = issubstr(var_0, "left");
  var_3 = issubstr(var_0, "large");
  playfootstep(var_2, var_3);

  if(isdefined(level.play_additionnal_fs_sfx))
    soundscripts\_snd::snd_message("play_additionnal_fs_sfx");

  self.leftfootdown = var_2;
}

get_notetrack_movement() {
  var_0 = "run";

  if(isdefined(self.sprint))
    var_0 = "sprint";

  if(isdefined(self.a)) {
    if(isdefined(self.a.movement)) {
      if(self.a.movement == "walk")
        var_0 = "walk";
    }

    if(isdefined(self.a.pose)) {
      if(self.a.pose == "prone")
        var_0 = "prone";
    }
  }

  return var_0;
}

notetrackspacejet(var_0, var_1) {
  thread notetrackspacejet_proc(var_0, var_1);
}

notetrackspacejet_proc(var_0, var_1) {
  self endon("death");
  var_2 = [];
  var_3 = undefined;

  switch (var_0) {
    case "space_jet_bottom":
      var_2 = ["tag_jet_bottom_1", "tag_jet_bottom_2"];
      break;
    case "space_jet_bottom_1":
      var_2 = ["tag_jet_bottom_1"];
      break;
    case "space_jet_bottom_2":
      var_2 = ["tag_jet_bottom_2"];
      break;
    case "space_jet_top":
      var_2 = ["tag_jet_top_1", "tag_jet_top_2"];
      break;
    case "space_jet_top_1":
      var_2 = ["tag_jet_top_1"];
      break;
    case "space_jet_top_2":
      var_2 = ["tag_jet_top_2"];
      break;
    case "space_jet_left":
      var_2 = ["tag_jet_le_1", "tag_jet_le_2"];
      break;
    case "space_jet_left_1":
      var_2 = ["tag_jet_le_1"];
      break;
    case "space_jet_left_2":
      var_2 = ["tag_jet_le_2"];
      break;
    case "space_jet_right":
      var_2 = ["tag_jet_ri_1", "tag_jet_ri_2"];
      break;
    case "space_jet_right_1":
      var_2 = ["tag_jet_ri_1"];
      break;
    case "space_jet_right_2":
      var_2 = ["tag_jet_ri_2"];
      break;
    case "space_jet_front":
      var_2 = ["tag_jet_front_1", "tag_jet_front_2"];
      break;
    case "space_jet_front_1":
      var_2 = ["tag_jet_front_1"];
      break;
    case "space_jet_front_2":
      var_2 = ["tag_jet_front_2"];
      break;
    case "space_jet_back":
      var_2 = ["tag_jet_back_1", "tag_jet_back_2", "tag_jet_back_3", "tag_jet_back_4"];
      break;
    case "space_jet_back_1":
      var_2 = ["tag_jet_back_1"];
      break;
    case "space_jet_back_2":
      var_2 = ["tag_jet_back_2"];
      break;
    case "space_jet_back_3":
      var_2 = ["tag_jet_back_3"];
      break;
    case "space_jet_back_4":
      var_2 = ["tag_jet_back_4"];
      break;
    case "space_jet_random":
      var_2 = ["tag_jet_bottom_1", "tag_jet_bottom_2", "tag_jet_top_1", "tag_jet_top_2", "tag_jet_le_1", "tag_jet_le_2", "tag_jet_ri_1", "tag_jet_ri_2"];
      break;
  }

  if(common_scripts\utility::fxexists("space_jet_small") && isdefined(var_2)) {
    if(isdefined(var_2)) {
      if(var_0 == "space_jet_random") {
        for (var_4 = 0; var_4 < 6; var_4++) {
          var_5 = randomint(8);
          var_6 = var_2[var_5];

          if(maps\_utility::hastag(self.model, var_6)) {
            if(!isdefined(self.audio_jet_counter))
              self.audio_jet_counter = 0;

            self.audio_jet_counter++;

            if(self.audio_jet_counter > 5)
              self.audio_jet_counter = 0;

            if(self.audio_jet_counter == 1)
              self playsound("space_npc_jetpack_boost_ss");

            playfxontag(level._effect["space_jet_small"], self, var_6);
          }

          wait(randomfloatrange(0.1, 0.3));
        }
      } else {
        foreach(var_6 in var_2) {
          if(isdefined(var_6) && maps\_utility::hastag(self.model, var_6)) {
            if(!isdefined(self.audio_jet_counter))
              self.audio_jet_counter = 0;

            self.audio_jet_counter++;

            if(self.audio_jet_counter > 5)
              self.audio_jet_counter = 0;

            if(self.audio_jet_counter == 1)
              self playsound("space_npc_jetpack_boost_ss");

            playfxontag(level._effect["space_jet_small"], self, var_6);
            wait 0.1;
          }
        }
      }
    }
  }
}

customnotetrackfx(var_0, var_1) {
  if(isdefined(self.groundtype))
    var_2 = self.groundtype;
  else
    var_2 = "dirt";

  var_3 = undefined;

  if(isdefined(level._notetrackfx[var_0][var_2]))
    var_3 = level._notetrackfx[var_0][var_2];
  else if(isdefined(level._notetrackfx[var_0]["all"]))
    var_3 = level._notetrackfx[var_0]["all"];

  if(!isdefined(var_3)) {
    return;
  }
  if(isai(self) && isdefined(var_3.fx))
    playfxontag(var_3.fx, self, var_3.tag);

  if(!isdefined(var_3.sound_prefix) && !isdefined(var_3.sound_suffix)) {
    return;
  }
  var_4 = "" + var_3.sound_prefix + var_2 + var_3.sound_suffix;

  if(!soundexists(var_4))
    var_4 = "" + var_3.sound_prefix + "default" + var_3.sound_suffix;

  notetrack_playsound(var_4);
}

notetrackfootscrape(var_0, var_1) {
  if(isdefined(self.groundtype))
    var_2 = self.groundtype;
  else
    var_2 = "dirt";

  self playfoley("scrape", var_2);
}

notetrackland(var_0, var_1) {
  if(isdefined(self.groundtype))
    var_2 = self.groundtype;
  else
    var_2 = "dirt";

  self playfoley("land", var_2);
}

notetrackcodemove(var_0, var_1) {
  return "code_move";
}

notetrackfaceenemy(var_0, var_1) {
  if(self.script != "reactions")
    self orientmode("face enemy");
  else if(isdefined(self.enemy) && distancesquared(self.enemy.origin, self.reactiontargetpos) < 4096)
    self orientmode("face enemy");
  else
    self orientmode("face point", self.reactiontargetpos);
}

notetrackcrouchtoprone(var_0, var_1) {
  if(isdefined(self.groundtype))
    var_2 = self.groundtype;
  else
    var_2 = "default";

  var_3 = "step_prone_drop_" + var_2;

  if(!soundexists(var_3))
    var_3 = "step_prone_drop_default";

  notetrack_playsound(var_3);
}

notetrackcrouchdrop(var_0, var_1) {
  var_2 = "gear_rattle_crouch_drop";
  notetrack_playsound(var_2);
}

notetrackbodyfall(var_0, var_1) {
  var_2 = "_small";

  if(issubstr(var_0, "large"))
    var_2 = "_large";

  if(isdefined(self.groundtype))
    var_3 = self.groundtype;
  else
    var_3 = "dirt";

  var_4 = "bodyfall_" + var_3 + var_2;

  if(!soundexists(var_4))
    var_4 = "bodyfall_default" + var_2;

  notetrack_playsound(var_4);
}

notetrackpain(var_0, var_1) {
  var_2 = "_small";

  if(issubstr(var_0, "large"))
    var_2 = "";

  animscripts\face::saygenericdialogue("pain" + var_2);
}

notetrackmeleeattackeft(var_0, var_1) {
  animscripts\face::saygenericdialogue("meleeattack");
}

handlerocketlauncherammoondeath() {
  self endon("detached");
  common_scripts\utility::waittill_any("death", "killanimscript");

  if(isdefined(self.rocketlauncherammo))
    self.rocketlauncherammo delete();
}

notetrackrocketlauncherammoattach() {
  self.rocketlauncherammo = spawn("script_model", self.origin);

  if(issubstr(tolower(self.weapon), "panzerfaust"))
    self.rocketlauncherammo setmodel("weapon_panzerfaust3_missle");
  else
    self.rocketlauncherammo setmodel("projectile_rpg7");

  self.rocketlauncherammo linkto(self, "tag_inhand", (0, 0, 0), (0, 0, 0));
  thread handlerocketlauncherammoondeath();
}

notetrackrocketlauncherammodelete() {
  self notify("detached");

  if(isdefined(self.rocketlauncherammo))
    self.rocketlauncherammo delete();

  self.a.rocketvisible = 1;

  if(isai(self) && !isalive(self)) {
    return;
  }
  if(maps\_utility::hastag(getweaponmodel(self.weapon), "tag_rocket"))
    self showpart("tag_rocket");
}

handlenotetrack(var_0, var_1, var_2, var_3) {
  if(isai(self) && self.type == "dog") {
    if(handledogsoundnotetracks(var_0))
      return;
  }

  var_4 = anim.notetracks[var_0];

  if(isdefined(var_4))
    return [
      [var_4]
    ](var_0, var_1);

  if(!isdefined(var_3) || !var_3) {
    var_5 = getsubstr(var_0, 0, 3);

    if(var_5 == "ps_") {
      var_6 = getsubstr(var_0, 3);
      notetrack_playsound(var_6);
    }
  }

  switch (var_0) {
    case "undefined":
    case "end":
    case "finish":
      return var_0;
    case "finish early":
      if(isdefined(self.enemy))
        return var_0;

      break;
    case "swish small":
      thread common_scripts\utility::play_sound_in_space("melee_swing_small", self gettagorigin("TAG_WEAPON_RIGHT"));
      break;
    case "swish large":
      thread common_scripts\utility::play_sound_in_space("melee_swing_large", self gettagorigin("TAG_WEAPON_RIGHT"));
      break;
    case "torso_mvmnt":
      thread common_scripts\utility::play_sound_in_space("foly_mvmnt_cloth_npc", self.origin);
      break;
    case "rechamber":
      if(animscripts\utility::weapon_pump_action_shotgun())
        notetrack_playsound("weap_reload_shotgun_pump_npc");

      self.a.needstorechamber = 0;
      break;
    case "no death":
      self.a.nodeath = 1;
      break;
    case "no pain":
      self.allowpain = 0;
      break;
    case "allow pain":
      self.allowpain = 1;
      break;
    case "anim_melee = \"right\"":
    case "anim_melee = right":
      self.a.meleestate = "right";
      break;
    case "anim_melee = \"left\"":
    case "anim_melee = left":
      self.a.meleestate = "left";
      break;
    case "swap taghelmet to tagleft":
      if(isdefined(self.hatmodel)) {
        if(isdefined(self.helmetsidemodel)) {
          self detach(self.helmetsidemodel, "TAG_HELMETSIDE");
          self.helmetsidemodel = undefined;
        }

        self detach(self.hatmodel, "");
        self attach(self.hatmodel, "TAG_WEAPON_LEFT");
        self.hatmodel = undefined;
      }

      break;
    case "stop anim":
      maps\_utility::anim_stopanimscripted();
      return var_0;
    case "break glass":
      level notify("glass_break", self);
      break;
    case "break_glass":
      level notify("glass_break", self);
      break;
    case "attach clip left":
      if(animscripts\utility::usingrocketlauncher())
        notetrackrocketlauncherammoattach();

      break;
    case "detach clip left":
      if(animscripts\utility::usingrocketlauncher())
        notetrackrocketlauncherammodelete();
    default:
      if(isdefined(var_2))
        return [
          [var_2]
        ](var_0);

      break;
  }
}

donotetracksintercept(var_0, var_1, var_2) {
  for (;;) {
    self waittill(var_0, var_3);

    if(!isdefined(var_3))
      var_3 = "undefined";

    var_4 = [
      [var_1]
    ](var_3);

    if(isdefined(var_4) && var_4) {
      continue;
    }
    var_5 = handlenotetrack(var_3, var_0);

    if(isdefined(var_5))
      return var_5;
  }
}

donotetrackspostcallback(var_0, var_1) {
  for (;;) {
    self waittill(var_0, var_2);

    if(!isdefined(var_2))
      var_2 = "undefined";

    var_3 = handlenotetrack(var_2, var_0);
    [
      [var_1]
    ](var_2);

    if(isdefined(var_3))
      return var_3;
  }
}

donotetracksfortimeout(var_0, var_1, var_2, var_3) {
  animscripts\shared::donotetracks(var_0, var_2, var_3);
}

donotetracksforever(var_0, var_1, var_2, var_3) {
  donotetracksforeverproc(animscripts\shared::donotetracks, var_0, var_1, var_2, var_3);
}

donotetracksforeverintercept(var_0, var_1, var_2, var_3) {
  donotetracksforeverproc(::donotetracksintercept, var_0, var_1, var_2, var_3);
}

donotetracksforeverproc(var_0, var_1, var_2, var_3, var_4) {
  if(isdefined(var_2))
    self endon(var_2);

  self endon("killanimscript");

  if(!isdefined(var_4))
    var_4 = "undefined";

  for (;;) {
    var_5 = gettime();
    var_6 = [
      [var_0]
    ](var_1, var_3, var_4);
    var_7 = gettime() - var_5;

    if(var_7 < 0.05) {
      var_5 = gettime();
      var_6 = [
        [var_0]
      ](var_1, var_3, var_4);
      var_7 = gettime() - var_5;

      if(var_7 < 0.05)
        wait(0.05 - var_7);
    }
  }
}

donotetrackswithtimeout(var_0, var_1, var_2, var_3) {
  var_4 = spawnstruct();
  var_4 thread donotetracksfortimeendnotify(var_1);
  donotetracksfortimeproc(::donotetracksfortimeout, var_0, var_2, var_3, var_4);
}

donotetracksfortime(var_0, var_1, var_2, var_3) {
  var_4 = spawnstruct();
  var_4 thread donotetracksfortimeendnotify(var_0);
  donotetracksfortimeproc(::donotetracksforever, var_1, var_2, var_3, var_4);
}

donotetracksfortimeintercept(var_0, var_1, var_2, var_3) {
  var_4 = spawnstruct();
  var_4 thread donotetracksfortimeendnotify(var_0);
  donotetracksfortimeproc(::donotetracksforeverintercept, var_1, var_2, var_3, var_4);
}

donotetracksfortimeproc(var_0, var_1, var_2, var_3, var_4) {
  var_4 endon("stop_notetracks");
  [[var_0]](var_1, undefined, var_2, var_3);
}

donotetracksfortimeendnotify(var_0) {
  wait(var_0);
  self notify("stop_notetracks");
}

playfootstep(var_0, var_1) {
  if(isdefined(self.playfootstepoverride))
    self thread[[self.playfootstepoverride]](var_0, var_1);
  else {
    if(!isai(self)) {
      notetrack_playsound("step_run_dirt");
      return;
    }

    var_2 = get_notetrack_movement();
    var_3 = undefined;

    if(!isdefined(self.groundtype)) {
      if(!isdefined(self.lastgroundtype)) {
        self playfoley(var_2, "dirt");
        return;
      }

      var_3 = self.lastgroundtype;
    } else {
      var_3 = self.groundtype;
      self.lastgroundtype = self.groundtype;
    }

    var_4 = "J_Ball_RI";

    if(var_0)
      var_4 = "J_Ball_LE";

    var_5 = self gettagorigin(var_4);
    var_6 = bullettrace(var_5 + (0, 0, 16), var_5 + (0, 0, -4), 0);

    if(var_6["fraction"] < 1 && var_6["fraction"] > 0 && var_6["surfacetype"] != "none") {
      var_3 = var_6["surfacetype"];
      var_5 = var_6["position"];
    }

    self playfoley(var_2, var_3);

    if(var_1) {
      if(![
          [anim.optionalstepeffectfunction]
        ](var_4, var_3, var_5)) {
        playfootstepeffectsmall(var_4, var_3, var_5);
        return;
      }

      return;
    }

    if(![
        [anim.optionalstepeffectsmallfunction]
      ](var_4, var_3, var_5))
      playfootstepeffect(var_4, var_3, var_5);
  }
}

playfootstepeffect(var_0, var_1, var_2) {
  if(!isdefined(anim.optionalstepeffects[var_1]))
    return 0;

  if(!isdefined(var_2))
    var_2 = self gettagorigin(var_0);

  var_3 = self.angles;
  var_4 = anglestoforward(var_3);
  var_5 = var_4 * -1;
  var_6 = anglestoup(var_3);
  playfx(level._effect["step_" + var_1], var_2, var_6, var_5);
  return 1;
}

playfootstepeffectsmall(var_0, var_1, var_2) {
  if(!isdefined(anim.optionalstepeffectssmall[var_1]))
    return 0;

  if(!isdefined(var_2))
    var_2 = self gettagorigin(var_0);

  var_3 = self.angles;
  var_4 = anglestoforward(var_3);
  var_5 = var_4 * -1;
  var_6 = anglestoup(var_3);
  playfx(level._effect["step_small_" + var_1], var_2, var_6, var_5);
  return 1;
}

shootnotetrack() {
  waittillframeend;

  if(isdefined(self) && gettime() > self.a.lastshoottime) {
    animscripts\utility::shootenemywrapper();
    animscripts\combat_utility::decrementbulletsinclip();

    if(weaponclass(self.weapon) == "rocketlauncher")
      self.a.rockets--;
  }
}

fire_straight() {
  if(self.a.weaponpos["right"] == "none") {
    return;
  }
  if(isdefined(self.dontshootstraight)) {
    shootnotetrack();
    return;
  }

  var_0 = self getmuzzlepos();
  var_1 = anglestoforward(self getmuzzleangle());
  var_2 = var_0 + var_1 * 1000;
  self shoot(1, var_2);
  animscripts\combat_utility::decrementbulletsinclip();
}

notetrackfirespray(var_0, var_1) {
  if(!isalive(self) && self isbadguy()) {
    if(isdefined(self.changed_team)) {
      return;
    }
    self.changed_team = 1;
    var_2["axis"] = "team3";
    var_2["team3"] = "axis";
    self.team = var_2[self.team];
  }

  if(!issentient(self)) {
    self notify("fire");
    return;
  }

  if(self.a.weaponpos["right"] == "none") {
    return;
  }
  var_3 = self getmuzzlepos();
  var_4 = anglestoforward(self getmuzzleangle());
  var_5 = 10;

  if(isdefined(self.isrambo))
    var_5 = 20;

  var_6 = 0;

  if(isalive(self.enemy) && issentient(self.enemy) && self canshootenemy()) {
    var_7 = vectornormalize(self.enemy geteye() - var_3);

    if(vectordot(var_4, var_7) > cos(var_5))
      var_6 = 1;
  }

  if(var_6)
    animscripts\utility::shootenemywrapper();
  else {
    var_4 = var_4 + ((randomfloat(2) - 1) * 0.1, (randomfloat(2) - 1) * 0.1, (randomfloat(2) - 1) * 0.1);
    var_8 = var_3 + var_4 * 1000;
    self[[anim.shootposwrapper_func]](var_8);
  }

  animscripts\combat_utility::decrementbulletsinclip();
}